.global _start
_start:

.global _start
_start:

//Descomposicion de punto flotante
mov r11, #0x4f0
mov r12, #0x500		//direccion de memoria

mov r1, #0b00100000	// 0.100000 --> 0.5
str r1, [r11]
add r11, r11, #4

mov r1, #0b10001101	// 0.001101 -->  0.203125
str r1, [r11]
add r11, r11, #4

mov r11, #0x4f0
mov r10, #0			//contador

fixedpoint:
ldr r1, [r11]			//obtengo el primer numero

mov r2, r1, lsr #6		//tengo los bits mas significativos signo y entero
mov r2, r2, lsl #6		//corriento a la izquierda de 6 bits
str r2, [r12]			//se almacena en r12
add r12, r12, #4		//se suma 4 a r12, siguiente pos de memoria

mov r3, r1				//en r3 se almacena lo de r1
and r3, r3, #0b00111111	//and para obtener la parte fraccionaria	
str r3, [r12]			//se almacena en r12
add r12, r12, #4		//se suma 4 a r12, siguiente pos de memoria

add r11, r11, #4		//suma a direccion de memoria donde estan los numeros del stream
add r10, r10, #1		//suma al contador
cmp r10, #2				//comparador para el salto condicional
beq sumaFp

b fixedpoint

//Suma en punto flotante para dos numeros seguidos (se tiene que arreglar para que siga la formula)
sumaFp:
//suma de signo y parte entera
mov r12, #0x500		//direccion de memoria 
ldr r1, [r12]		
add r12, r12, #8
ldr r2, [r12]
add r1, r1, r2		//suma en r1 falta
add r12, r12, #8
str r1, [r12]

//suma de parte fraccionaria
mov r12, #0x500		//direccion de memoria
add r12, r12, #4
ldr r2, [r12]
add r12, r12, #8
ldr r3, [r12]
add r2, r2, r3		//suma en r2
add r12, r12, #8
str r2, [r12]

//union de sumas
mov r12, #0x510		//direccion de memoria
ldr r1, [r12]
add r12, r12, #4
ldr r2, [r12]
orr r3, r1, r2
add r12, r12, #4
str r3, [r12]

//Multiplicacion en punto flotante
mulFP:
//Multiplicacion de parte entera y bit de signo
mov r11, #0x520
mov r12, #0x500		//direccion de memoria 
ldr r1, [r12]		
add r12, r12, #8
ldr r2, [r12]
mul r1, r1, r2		//multiplicacion en r1
str r1, [r11]

add r11, r11, #4
mov r12, #0x500		//direccion de memoria
add r12, r12, #4
ldr r2, [r12]
add r12, r12, #8
ldr r3, [r12]
mul r2, r2, r3		//multiplicacion en r2

mov r2, r2, lsr #6	//el lsr debe de ser la suma de la cantidad de numeros que tienen los binarios entre 2
add r12, r12, #8
str r2, [r11]
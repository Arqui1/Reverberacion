_start:

//Descomposicion de punto flotante
mov r11, #0x4f0
mov r12, #0x500			//direccion de memoria

mov r1, #0b101100000	// 0.100000 --> 0.5
str r1, [r11]
add r11, r11, #4

mov r1, #0b000001101	// 0.001101 -->  0.203125
str r1, [r11]
add r11, r11, #4

mov r11, #0x4f0
mov r10, #0			//contador

fixedpoint:
ldr r1, [r11]			//obtengo el primer numero

mov r2, r1, lsr #8		//tengo los bits mas significativos signo
//mov r2, r2, lsl #8		//corriento a la izquierda de 6 bits
str r2, [r12]			//se almacena en r12
add r12, r12, #4		//se suma 4 a r12, siguiente pos de memoria

mov r3, r1				//en r3 se almacena lo de r1
and r3, r3, #0b01111111	//and para obtener la parte entera y fraccionaria	
str r3, [r12]			//se almacena en r12
add r12, r12, #4		//se suma 4 a r12, siguiente pos de memoria

add r11, r11, #4		//suma a direccion de memoria donde estan los numeros del stream
add r10, r10, #1		//suma al contador
cmp r10, #2				//comparador para el salto condicional
beq sumaFp

b fixedpoint

//Suma en punto flotante para dos numeros seguidos (se tiene que arreglar para que siga la formula)
sumaFp:
mov r12, #0x500		//direccion de memoria 
add r12, r12, #4
ldr r1, [r12]		
add r12, r12, #8
ldr r2, [r12]
add r1, r1, r2		//suma en r1
//str r1, [r12]

mov r12, #0x500		//direccion de memoria 
ldr r2, [r12]		
add r12, r12, #8
ldr r3, [r12]
add r2, r2, r3		//parte esta mal hay que verificar el signo de cada numero por aparte
mov r2, r2, lsl #8
add r1, r1, r2		//suma en r1
mov r12, #0x510		//direccion de memoria donde se almacena la suma
str r1, [r12]
b mulFP				//QUITARLO



resta1:
cmp r2, #1
beq restaNegativos

//resta1 parte entera
mov r12, #0x500		//direccion de memoria 
ldr r1, [r12]	
and r1, #0b011111111
add r12, r12, #8
ldr r2, [r12]
and r2, #0b011111111
sub r1, r1, r2		//resta en r1
add r12, r12, #8
str r1, [r12]

restaNegativos:


//Multiplicacion en punto flotante
mulFP:
mov r12, #0x500		//direccion de memoria 
add r12, r12, #4	//se le suma a la direccion de memoria para obtener la parte entera y decimal
ldr r1, [r12]		//se guarda el primer numero en el registo r1
add r12, r12, #8	//se suma 8 para acceder al siguiente numero 
ldr r2, [r12]		//segundo numero en r2
mul r1, r1, r2		//multiplicacion almacenada en r1
mov r1, r1, lsr #6	//corrimiento a la derecho para mantener el numero de bits de entero y decimal

mov r12, #0x500		//direccion de memoria 
ldr r2, [r12]		//
add r12, r12, #8
ldr r3, [r12]
add r2, r2, r3		
mov r2, r2, lsl #8
orr r1, r1, r2		//suma en r1
mov r12, #0x520		//direccion de memoria donde se almacena la suma
str r1, [r12]




//***********************Buffer Circular*******************************
mov r1, #0			//contador
mov r2, #100		//numero de iteraciones
mov r3, #0x1000		//pos de memoria original
add r4, r3, #16		//DEFINIR EL TAMANO DEL BUFFER, este caso es de 4
cBuff:
cmp r1, r2			//si llego al numero de interaciones deseadas
beq finish

cmp r3, r4			//para devolverse a la pos originar y seguir con el Buff circular
beq cBuffAux

//Buffer para suma de r5, aumenta 1 en 1
str r1, [r3]
add r1, r1, #1
add r3, r3, #4
b cBuff

//Devolverse a la pos original
cBuffAux:
mov r3, #0x1000
b cBuff

finish:
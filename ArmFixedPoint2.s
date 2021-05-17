.global _start
_start:

//Descomposicion de punto flotante
mov r11, #0x4f0
mov r12, #0x500			//direccion de memoria

mov r1, #0b000100000	// 0.100000 --> 0.5
str r1, [r11]
add r11, r11, #4

mov r1, #0b000001101	// 0.001101 -->  0.203125
str r1, [r11]
add r11, r11, #4

mov r11, #0x4f0
mov r10, #0				//contador

fixedpoint:
ldr r1, [r11]			//obtengo el primer numero

mov r2, r1, lsr #8		//tengo los bits mas significativos signo
str r2, [r12]			//se almacena en r12
add r12, r12, #4		//se suma 4 a r12, siguiente pos de memoria

mov r3, r1				//en r3 se almacena lo de r1
and r3, r3, #0b01111111	//and para obtener la parte entera y fraccionaria	
str r3, [r12]			//se almacena en r12
add r12, r12, #4		//se suma 4 a r12, siguiente pos de memoria

add r11, r11, #4		//suma a direccion de memoria donde estan los numeros del stream
add r10, r10, #1		//suma al contador
//cmp r10, #2				//comparador para el salto condicional
//beq rever
//b fixedpoint



//*****************Insercion-Reverberacion**************************************************
//k=2205 alpha = 0.6 
//y(n) = (1-alpha)x(n) + alpha * y(n-k)

mov r8, #0			//n VALOR ES CERO INICIAL
mov r9, #2000			//K
add r9, r9, #205
mov r10, #0b000100110	//alpha
mov r11, #0x500			//aca empieza el audio en memoria
mov r12, #0x1000

rever:
//cmp r9	//comparar el numero de iteraciones ME FALTAN DOS REGISTROS PARA COMPARAR 441000*6

cmp r8, r9			//para devolverse a la pos originar y seguir con el Buff circular
beq cBuffAux

mov r1, #0b001000000
sub r1, r1, r10			//(1-alpha)

add r11, r11, #4		//se le suma 4 para obtener el numero, sino solo tendria el signo
ldr r2, [r11] 			//x(n)

mul r3, r1, r2			//(1-alpha) * x(n)
mov r3, r3, lsr #6		//para mantener el numero de bits necesarios

cmp r8, r9
blt masZeroCon

sub r4, r8, r9			//(n-k)
mov r1, #4				//para pc+4
mul r4, r4, r1
mov r11, #0x500	
add r4, r4, r11			//(n-k) + 0x500
add r4, r4, #8
ldr r5, [r4]			//y(n-k)
mul r6, r5, r10			//alpha * y(n-k)
mov r6, r6, lsr #6

add r7, r6, r3			//(1-alpha)x(n) + alpha * y(n-k)

str r7, [r12]
add r12, r12, #4
add r8, r8, #1
b rever

masZeroCon:
str r3, [r12]
add r12, r12, #4
add r8, r8, #1
b rever


//**************************Reducion-Reverberacion***************
mov r8, #0			//n VALOR ES CERO INICIAL
mov r9, #2000			//K
add r9, r9, #205
mov r10, #0b000100110	//alpha
mov r11, #0x500			//aca empieza el audio en memoria
mov r12, #0x1000


sinRever:
cmp r8, r9			//para devolverse a la pos originar y seguir con el Buff circular
beq cBuffAux
//PRIMERO TIENE QUE IR LA MULTIPLICACION CON 1/(1-alpha) FALTAAAAA

add r11, r11, #4		//se le suma 4 para obtener el numero, sino solo tendria el signo
ldr r2, [r11] 			//x(n)

cmp r8, r9
blt masZero

sub r4, r8, r9			//(n-k)
mov r1, #4				//para pc+4
mul r4, r4, r1
mov r11, #0x500	
add r4, r4, r12			//(n-k) + 0x1000
add r4, r4, #8
ldr r5, [r4]			//x(n-k)

masZeroSin:
str r3, [r12]
add r12, r12, #4
add r8, r8, #1
b SinRever

//Devolverse a la pos original
cBuffAux:
mov r12, #0x1000
b rever


//para pasarlo al txt
txtFile:
//aka ace algo

//Suma en punto flotante para dos numeros seguidos (se tiene que arreglar para que siga la formula)
sumaFp:
mov r12, #0x500		//direccion de memoria 
add r12, r12, #4
ldr r1, [r12]		
add r12, r12, #8
ldr r2, [r12]
add r1, r1, r2		//suma en r1

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
mov r11, #0x500

mov r1, #0b001100000	// 0.100000 --> 0.5
str r1, [r11]
add r11, r11, #4

mov r1, #0b000001101	// 0.001101 -->  0.203125
str r1, [r11]

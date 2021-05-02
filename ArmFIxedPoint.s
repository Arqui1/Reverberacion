.global _start
_start:

//Descomposicion de punto flotante
mov r11, #0x4f0
mov r12, #0x500		//direccion de memoria

mov r1, #0b00100000	// 0.100000 --> 0.5
mov r1, r1, lsl #2
str r1, [r11]
add r11, r11, #4

mov r1, #0b10001101	// 0.001101 -->  0.203125
mov r1, r1, lsl #2
str r1, [r11]
add r11, r11, #4

mov r11, #0x4f0
mov r10, #0			//contador
fixedpoint:

ldr r1, [r11]

mov r2, r1, lsr #9	//bit de signo
str r2, [r12]
add r12, r12, #4

mov r3, r1, lsr #8	
and r3, r3, #1		//bit de entero 
str r3, [r12]
add r12, r12, #4

add r4, r2, r3
mov r5, #0b1000000000
//mul r5, r5, r5
mul r4, r5, r4
sub r4, r1, r4		//bits decimales
str r4, [r12]
add r12, r12, #4

add r11, r11, #4
add r10, r10, #1
cmp r10, #2
beq sumaFp

b fixedpoint

//Suma en punto flotante
sumaFp:
//suma de signo
mov r12, #0x500		//direccion de memoria
ldr r1, [r12]
add r12, r12, #12
ldr r2, [r12]
add r1, r1, r2		//suma en r1


//suma de parte entera
mov r12, #0x500		//direccion de memoria
add r12, r12, #4
ldr r2, [r12]
add r12, r12, #12
ldr r3, [r12]
add r2, r2, r3		//suma en r2

//suma de parte decimal
mov r12, #0x500		//direccion de memoria
add r12, r12, #8
ldr r3, [r12]
add r12, r12, #12
ldr r4, [r12]
add r3, r3, r4		//suma en r3


//Multiplicacion en punto flotante
_start:

mov r11, #0x4f0
mov r12, #0x500		

mov r1, #0b101100000	
str r1, [r11]
add r11, r11, #4

mov r1, #0b000001101	
str r1, [r11]
add r11, r11, #4

mov r11, #0x4f0
mov r10, #0

fixedpoint:
ldr r1, [r11]

lsr r2, r1, #8		
str r2, [r12]			
add r12, r12, #4		

mov r3, r1			
and r3, r3, #0b01111111		
str r3, [r12]			
add r12, r12, #4		

add r11, r11, #4		
add r10, r10, #1		
cmp r10, #2			
beq sumaFp

b fixedpoint

sumaFp:
mov r12, #0x500	
add r12, r12, #4
ldr r1, [r12]		
add r12, r12, #8
ldr r2, [r12]
add r1, r1, r2

mov r12, #0x500		
ldr r2, [r12]		
add r12, r12, #8
ldr r3, [r12]
add r2, r2, r3
lsl r2, r2, #8
add r1, r1, r2		
mov r12, #0x510		
str r1, [r12]
b mulFP				


resta1:
cmp r2, #1
beq restaNegativos

mov r12, #0x500		
ldr r1, [r12]	
and r1, r1, #0b011111111
add r12, r12, #8
ldr r2, [r12]
and r2, r2, #0b011111111
sub r1, r1, r2		
add r12, r12, #8
str r1, [r12]

restaNegativos:

mulFP:
mov r12, #0x500		
add r12, r12, #4	
ldr r1, [r12]		
add r12, r12, #8	
ldr r2, [r12]		
mul r1, r1, r2
lsr r1, r1, #6		

mov r12, #0x500		
ldr r2, [r12]		
add r12, r12, #8
ldr r3, [r12]
add r2, r2, r3		
lsl r2, r2, #8
orr r1, r1, r2		
mov r12, #0x520		
str r1, [r12]


mov r1, #0			
mov r2, #100		
mov r3, #0x1000		
add r4, r3, #16		
cBuff:
cmp r1, r2			
beq finish

cmp r3, r4
beq cBuffAux

str r1, [r3]
add r1, r1, #1
add r3, r3, #4
b cBuff

cBuffAux:
mov r3, #0x1000
b cBuff

finish:
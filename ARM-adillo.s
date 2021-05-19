mov r7, #210
mul r7, r7, r7
mul r7, r7, #6
mov r8, #0
mov r9, #2000
add r9, r9, #205
mov r10, #0b000100110
mov r4, #0
mov r12, #64000
mul r12, r12, #4
add r12, r12, #9000
rever: 
cmp r7, r8
beq finish
cmp r4, r9
beq cBuffAux
mov r1, #0b001000000
sub r1, r1, r10	
ldr r2, [r8]
and r6, r2, #0b100000000
and r2, r2, #0b011111111
mul r3, r1, r2
lsr r3, r3, #6
cmp r8, r9
blt masZeroCon
sub r5, r8, r9
ldr r5, [r5]
mul r5, r5, r10
lsr r5, r5, #6
add r3, r5, r3
add r3, r3, r6
str r3, [r12]
stxt r3
add r4, r4, #1
add r12, r12, #1
add r8, r8, #1
b rever
masZeroCon: 
add r3, r3, r6
str r3, [r12]
stxt r3
add r4, r4, #1
add r12, r12, #1
add r8, r8, #1
b rever
cBuffAux: 
mov r12, #64000
mul r12. r12, #4
add r12, r12, #9000
mov r4, #0
b rever
finish:


mov r7, #210
mul r7, r7, r7
mul r7, r7, #6
mov r8, #0
mov r9, #2000
add r9, r9, #205
mov r10, #0b000100110
mov r4, #0
mov r12, #64000
mul r12, r12, #4
add r12, r12, #9000
sinRever:
cmp r7, r8
beq finish
cmp r4, r9
beq cBuffAux

mov r1, #0b001010000  // 1/(1-alpha)
ldr r2, [r8]          //x(n) 

cmp r8, r9              //n-k < 0 evita la resta
blt masZeroSin

sub r3, r8, r9       //n-k
ldr r3, [r3]         //x(n-k)
mul r3, r10, r3     //alpha * x(n-k)
lsr r3, r3, #6

sub r3, r2, r3     //x(n) - alpha * x(n-k)

mul r3, r1, r3
lsr r3, r3, #6
add r3, r3, r6
str r3, [r12]
stxt r3
add r4, r4, #1
add r12, r12, #1
add r8, r8, #1
b sinRever

masZeroCon: 
mul r3, r1, r2 // 1/(1-alpha) * x(n)
lsr r3, r3, #6
add r3, r3, r6
str r3, [r12]
stxt r3
add r4, r4, #1
add r12, r12, #1
add r8, r8, #1
b sinRever

cBuffAux: 
mov r12, #64000
mul r12. r12, #4
add r12, r12, #9000
mov r4, #0
b sinRever

finish:
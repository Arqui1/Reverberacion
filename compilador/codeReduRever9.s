mov r7, #210
mul r7, r7, r7
mul r7, r7, #6 
mov r8, #0 
mov r9, #2205 
mov r10, #0b000100110 
mov r11, #0b010100000 
redurever:
cmp r7, r8
beq finish
ldr r2, [r8]
and r6, r2, #0b100000000 
and r2, r2, #0b011111111  
cmp r8, r9
blt masZeroCon
sub r5, r8, r9  
ldr r5, [r5]  
and r4, r5, #0b100000000
and r5, r5, #0b011111111
mul r5, r5, r10
lsr r5, r5, #6

cmp r6, r4 
bgt suma
blt suma
resta:
cmp r2, r5
bgt restaAux
sub r3, r5, r2
cmp r6, #0
beq positivo
b continue
positivo:
add r3, r3, #0b100000000
b continue
restaAux:
sub r3, r2, r5
add r3, r3, r6
b continue
suma:
add r3, r2, r5
add r3, r3, r6

continue:
and r4, r3, #0b100000000  
and r3, r3, #0b011111111  
mul r3, r3, r11
lsr r3, r3, #6 
stxt r3
add r8, r8, #1
b redurever
masZeroCon: 
mul r3, r11, r2      
lsr r3, r3, #6
add r3, r3, r6   
stxt r3   
add r8, r8, #1
b redurever
finish:
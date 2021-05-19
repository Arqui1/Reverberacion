mov r7, #210
mul r7, r7, r7
mul r7, r7, #6                      //Tamaño audio
mov r8, #0                          //contador k
mov r9, #2205                       //k
mov r10, #0b000100110               //alpha
mov r11, #0b010100000               //1/(1-alpha)
redurever:
cmp r7, r8
beq finish
ldr r2, [r8]                        //x(n)
and r6, r2, #0b100000000            //signo x(n)
and r2, r2, #0b011111111            //numero x(n)
cmp r8, r9
blt masZeroCon
sub r5, r8, r9                      //n-k
ldr r5, [r5]                        //x(n-k)
and r4, r5, #0b100000000            //signo x(n-k)
and r5, r5, #0b011111111            //numero x(n-k)
mul r5, r5, r10                     //alpha*x(n-k)
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
and r4, r3, #0b100000000            //signo [x(n) − αx(n − k)]
and r3, r3, #0b011111111            //numero [x(n) − αx(n − k)]
mul r3, r3, r11
lsr r3, r3, #6                      //y(n)
stxt r3
add r8, r8, #1
b redurever
masZeroCon: 
mul r3, r11, r2                 //(1/(1-alpha))*x(n)
lsr r3, r3, #6
add r3, r3, r6                  //suma signo            
stxt r3                         //se gurda en txt
add r8, r8, #1
b redurever
finish:
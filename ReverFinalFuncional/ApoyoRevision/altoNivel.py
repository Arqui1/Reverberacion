#Audio a bits
import numpy as np

posMemory = 260500 #pos de memoria 1
contBuffer = 0      #contador del buffer 2
k = 0.05    #se multiplica por el frameRate 3
a = 0.6     #alpha 4
fs = 44100  #frecuencia 44,1Khz 5
k = k * fs  #retardo
print(k)

x = open("stream.txt",'r').read().split('\n') #stream del sonido
print(x)
y = []                      #6
for i in range(len(x)-1):   #7 y 8 (i=contador y len(x)=tamano del stream)
    if(k > i):              
        y.append((1-a)*float(x[i])) #insercion de reverberacion
        #y = donde se almacena la suma 9
    elif((i-k) < k):
        y[int(i-k)] = ((1-a)*float(x[i]) + a*y[int(i-k)])   #suma del buffer circular

#10 resta en 1-alpha
#11 almacena el bit de signo
#12 almacena los bits de entero y decimal


print(len(x))
print(y)
#total de 14 registros contando al zero R0
#0.026250000000000002
#reducir a 6 decimales



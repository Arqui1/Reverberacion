#Audio a bits
import numpy as np

k = 0.05    #se multiplica por el frameRate 1
a = 0.6     #alpha 2
fs = 44100  #frecuencia 44,1Khz 3
k = k * fs  #retardo 
print(k)

x = open("stream.txt",'r').read().split('\n') #stream del sonido
print(x)
y = []                      #4
for i in range(len(x)-1):   #5 y 6 (i=contador y len(x)=tamano del stream)
    if(k > i):              
        y.append((1-a)*float(x[i]))
    elif((i-k) < k):
        y[int(i-k)] = ((1-a)*float(x[i]) + a*y[int(i-k)])
        

print(len(x))
print(y)
#total de 7 registros contando al zero R0
#0.026250000000000002

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
#reducir a 6 decimales




# Python program to convert float
# decimal to binary number
  
# Function returns octal representation
def float_bin(number, places = 3):
  
    # split() seperates whole number and decimal 
    # part and stores it in two seperate variables
    whole, dec = str(number).split(".")
  
    # Convert both whole number and decimal  
    # part from string type to integer type
    whole = int(whole)
    dec = int (dec)
  
    # Convert the whole number part to it's
    # respective binary form and remove the
    # "0b" from it.
    res = bin(whole).lstrip("0b") + "."
  
    # Iterate the number of times, we want
    # the number of decimal places to be
    for x in range(places):
  
        # Multiply the decimal value by 2 
        # and seperate the whole number part
        # and decimal part
        whole, dec = str((decimal_converter(dec)) * 2).split(".")
  
        # Convert the decimal part
        # to integer again
        dec = int(dec)
  
        # Keep adding the integer parts 
        # receive to the result variable
        res += whole
  
    return res
  
# Function converts the value passed as
# parameter to it's decimal representation
def decimal_converter(num): 
    while num > 1:
        num /= 10
    return num
  
# Driver Code
  
# Take the user input for 
# the floating point number
n = input("Enter your floating point value : \n")
  
# Take user input for the number of
# decimal places user want result as
p = int(input("Enter the number of decimal places of the result : \n"))
  
print(float_bin(n, places = p))

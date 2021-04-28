#instalar soundfile y sounddevice con los siguientes comandos en el cmd de windows
#pip install soundfile
#pip install sounddevice
import soundfile as sf
import sounddevice as sd
# Python program to convert float
# decimal to binary number
  
# Function returns octal representation
def float_bin(number, places = 3):
    #print("BBB")
    print(number)
    number=float(number)
    na=int(number)
    #print(na)
    if ((na>=1) or (na<=-1)):
        return '00000000'
    signo=''
    if (number<0):
        signo='1'
    else:
        signo='0'
    number=abs(number)
    number=str(number)
    #print("---")
    #print(number)
    #print(type(number))
    
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
    res = bin(whole).lstrip("0b") #+ "."
  
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
  
    return signo+res
  
# Function converts the value passed as
# parameter to it's decimal representation
def decimal_converter(num): 
    while num > 1:
        num /= 10
    return num

#se carga el nombre del archivo, CAMBIAR EL NOMBRE DEL ARCHIVO
nombre_archivo='emergency001.wav'
data, freq = sf.read(nombre_archivo)

#se crean lista
derecha=[]
izquierda=[]
mono=[]


if (data.ndim > 1):
    #se divide el canal derecho e izquierdo de la variable data de audio
    for i in range(len(data)):
        izquierda.append(data[i][0])
        derecha.append(data[i][1])
    #se suma ambas listas, las de canal derecho e izquierdo y se divide entre dos
    for j in range(len(data)):
        suma=(izquierda[j]+derecha[j])/2
        mono.append(round(suma, 6))
    #se escribe el canal mono en una lista
    with open('audio_original.txt', 'w') as archivo:
        for item in mono:
            archivo.write(float_bin(float(round(item,4)), places=6)+"\n")#"%.6f\n" % item)
#para MONO
else:
    with open('audio_original.txt', 'w') as archivo:
        for item in data:
            #print(type(item))
            #print(type(item.item()))
            #print(item)
            archivo.write(float_bin(float(round(item,4)), places = 6)+"\n")#"%.6f\n" % item)

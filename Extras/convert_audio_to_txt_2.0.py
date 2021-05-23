#instalar soundfile y sounddevice con los siguientes comandos en el cmd de windows
#pip install soundfile
#pip install sounddevice
import soundfile as sf
import sounddevice as sd
#Decimal floating point number to binary
def dectbin(num):
    # Determine whether it is a floating point number
    na=int(num)
    if ((na>=1) or (na<=-1)):
        return '00000000'
    signo=''
    if (num<0):
        signo='1'
    else:
        signo='0'
    num=abs(num)
    
    if num == int(num):
        # If it is an integer
        integer = '{:b}'.format(int(num))
        return integer
    else:
        # If it is a floating point number
        # Take the integer part
        integer_part = int(num)
        # Take the decimal part
        decimal_part = num - integer_part
        # Integer part conversion
        integercom = '{:b}'.format(integer_part)  #{:b}.foemat where b is binary
        # Decimal conversion
        tem = decimal_part
        tmpflo = []
        # for i in range(accuracy):
        A = True
        while A:
            tem *= 2
            tmpflo += str(int(tem))  #If the integer part is 0, the binary part is 0, if the integer part is 1, the binary part is 1 #Put 1 or 0 into the list
            if tem > 1 :   #If multiplied by 2 is a decimal greater than 1, then the integer part must be subtracted
                tem -= int(tem)
            elif tem < 1:  #If it is still a decimal number less than 1, after multiplying by 2, continue to use this number to multiply by 2 to convert the base
                pass
            else:    #When multiplied by 2 it happens to be 1, then the base conversion stops
                break
        flocom = tmpflo
        #print("signo: "+ signo + " entera: " +integercom  + " coma: " + ''.join(flocom))
        return signo + integercom  + ''.join(flocom)
def aux(num):
    n=dectbin(num)
    largo=len(n)
    l=[]
    if largo<8:
        for i in range(largo, 8):
            #print(i)
            l.append('0')
        p=listToString(l)
        nz=''.join((n,p))
        return nz
    elif largo>8:
       h=Convert(n)
       r=h[0:8]
       p=listToString(r)
       nz=''.join(p)
       return nz
    else:
        return n

def listToString(s): 
    str1 = "" 
    return (str1.join(s))

def Convert(string):
    list1=[]
    list1[:0]=string
    return list1


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
            archivo.write(aux(item)+"\n")#"%.6f\n" % item)
#para MONO
else:
    with open('audio_original.txt', 'w') as archivo:
        for item in data:
            #print(type(item))
            #print(type(item.item()))
            #print(item)
            archivo.write(aux(item)+"\n")#"%.6f\n" % item)

#instalar soundfile y sounddevice con los siguientes comandos en el cmd de windows
#pip install soundfile
#pip install sounddevice
import soundfile as sf
import sounddevice as sd
import math
#Decimal floating point number to binary
def dectbin(num):
    # Determine whether it is a floating point number
    na=int(num)
    if ((na>=4) or (na<=-4)):
        return '000000000'
    signo=''
    if (num<0):
        signo='1'
    else:
        signo='0'
    num=abs(num)
    
    if num == int(num):
        # If it is an integer
        integer = mod_entero(num)#'{:b}'.format(int(num))
        return integer
    else:
        # If it is a floating point number
        # Take the integer part
        integer_part = int(num)
        # Take the decimal part
        decimal_part = num - integer_part
        # Integer part conversion
        integercom = mod_entero(num) #'{:b}'.format(integer_part)  #{:b}.foemat where b is binary
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
    if largo<9:
        for i in range(largo, 9):
            #print(i)
            l.append('0')
        p=listToString(l)
        nz=''.join((n,p))
        return nz
    elif largo>9:
       h=Convert(n)
       r=h[0:9]
       p=listToString(r)
       nz=''.join(p)
       return nz
    else:
        return n
def mod_entero(num):
    integer = '{:b}'.format(int(num))
    if len(integer)<=1:
        completar="0"
        inte = completar + integer
        return inte
    else:
        return integer

def listToString(s): 
    str1 = "" 
    return (str1.join(s))

def Convert(string):
    list1=[]
    list1[:0]=string
    return list1

def reverb(x, fs):
    k = 0.05    #se multiplica por el frameRate 1
    a = 0.6     #alpha 2
    #fs = 44100  #frecuencia 44,1Khz 3
    k = math.floor(k * fs)  #retardo 
    y = []
    for n in range(len(x)):
        if(n < k):
            y.append((1-a)*float(x[n]))
        else:
            y.append((1-a)*float(x[n]) + a*y[int(n-k)])        
    return y


#se carga el nombre del archivo, CAMBIAR EL NOMBRE DEL ARCHIVO
nombre_archivo='audio_sin_reverb.wav'
data, freq = sf.read(nombre_archivo)

nombre_archivo2='audio_con_reverb.wav'
data2, freq2 = sf.read(nombre_archivo2)

def conversion(nombre_archivo, data):
    #ruta = "C:/QuartusProjects/Files/"
    ruta = ""
    freq=44100
    #se crean lista
    derecha=[]
    izquierda=[]
    mono=[]
    if nombre_archivo == "audio_sin_reverb.wav":
        path1 = ruta + "RAMDatos1.txt"
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
            with open(path1, 'w') as archivo:
                for item in mono:
                    archivo.write(aux(item)+"\n")
        else:
            with open(path1, 'w') as archivo:
                for item in data:
                    archivo.write(aux(item)+"\n")
    elif nombre_archivo == "audio_con_reverb.wav":
        #audio con rever conocida
        path2 = ruta + "RAMDatos2.txt"
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
            reverberacion= reverb(mono, freq)
            with open(path2, 'w') as archivo:
                for item in reverberacion:
                    archivo.write(aux(item)+"\n")
        else:
            reverberacion= reverb(data.tolist(), freq)
            with open(path2, 'w') as archivo:
                for item in reverberacion:
                    archivo.write(aux(item)+"\n")

conversion(nombre_archivo, data)
conversion(nombre_archivo2, data2)

print("Fin")

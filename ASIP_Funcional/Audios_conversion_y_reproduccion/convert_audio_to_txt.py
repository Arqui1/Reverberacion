#instalar soundfile y sounddevice con los siguientes comandos en el cmd de windows, en caso de no tenerlos
#pip install soundfile
#pip install sounddevice
import soundfile as sf
import sounddevice as sd
import math

#Variables globales de control
#------------------------------------
ruta = "C:/Users/danie/OneDrive/Documentos/TEC/Arqui 1/Proyectos/Proyecto Grupal/Files/" #-
#ruta = "" #--------------------------
#------------------------------------
#Precision, es el para limitar el largo de los datos convertidos a binario
precision=7

#Funcion auxiliar encargada de pasar el punto decimal a binario
def punto_decimal_to_bin(num):
    #Pasa la parte entera a binario
    #----------------------------
    #na=int(num)
    #if ((na>=4) or (na<=-4)):
     #   return '0000000'
    #----------------------------
    signo=''
    #Se verifica el signo
    if (num<0):
        signo='1'
    else:
        signo='0'
    num=abs(num)
    #Se verifica si es un entero y no un float
    if num == int(num):
        integer = '0000000' #modificacion_entero(num)
        return integer
    else:
        #Se pasa la parte despues de punto a binario
        integer_part = int(num)
        decimal_part = num - integer_part
        #integercom = modificacion_entero(num) 
        tem = decimal_part
        tmpflo = []
        A = True
        while A:
            tem *= 2
            tmpflo += str(int(tem))  
            if tem > 1 :
                tem -= int(tem)
            elif tem < 1:
                pass
            else:    
                break
        flocom = tmpflo
        return signo + ''.join(flocom)
#Funcion principal encargada de pasar float a binario
def float_a_binario(num):
    n=punto_decimal_to_bin(num)
    largo=len(n)
    l=[]
    if largo<precision:
        for i in range(largo, precision):
            l.append('0')
        p=lista_a_string(l)
        nz=''.join((n,p))
        return nz
    elif largo>precision:
       h=string_a_lista(n)
       r=h[0:precision]
       p=lista_a_string(r)
       nz=''.join(p)
       return nz
    else:
        return n
#Funcion que pasa la parte entera a binario y completa ceros a la izquierda si es necesario.
def modificacion_entero(num):
    integer = '{:b}'.format(int(num))
    if len(integer)<=1:
        completar="0"
        inte = completar + integer
        return inte
    else:
        return integer
#Funcion utilitaria que pasa de lista a string
def lista_a_string(s): 
    str1 = "" 
    return (str1.join(s))
#Funcion utilitaria que pasa string a lista
def string_a_lista(string):
    list1=[]
    list1[:0]=string
    return list1
#Funcion para insertar rerverberacion a un audio en alto nivel, para aplicar una reverb conocida
def reverb(x, fs):
    k = 0.05    #se multiplica por el frameRate 1
    a = 0.6     #alpha 2
    k = math.floor(k * fs)  #retardo 
    y = [] #Buffer circular
    for n in range(len(x)):
        if(n < k):
            y.append((1-a)*float(x[n]))
        else:
            y.append((1-a)*float(x[n]) + a*y[int(n-k)])        
    return y


#se carga el nombre del archivo, y se convierten los audios a lista y se obtiene su frecuencia
nombre_archivo='audio_sin_reverb.wav'
data, freq = sf.read(nombre_archivo)

nombre_archivo2='audio_con_reverb.wav'
data2, freq2 = sf.read(nombre_archivo2)

#Funcion encargada de escribir el audio a txt una vez pasada el archivo a lista
#Se considera si el archivo es mono o tiene canales izquierda y derecha
def escritura_en_archivos(nombre_archivo, data):   
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
                mono.append(round(suma, 9))
            #se escribe el canal mono en una lista
            with open(path1, 'w') as archivo:
                for item in mono:
                    archivo.write(float_a_binario(item)+"\n")
        else:
            with open(path1, 'w') as archivo:
                for item in data:
                    archivo.write(float_a_binario(item)+"\n")
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
                mono.append(round(suma, 9))
            #se escribe el canal mono en una lista
            reverberacion= reverb(mono, freq)
            with open(path2, 'w') as archivo:
                for item in reverberacion:
                    archivo.write(float_a_binario(item)+"\n")
        else:
            reverberacion= reverb(data.tolist(), freq)
            with open(path2, 'w') as archivo:
                for item in reverberacion:
                    archivo.write(float_a_binario(item)+"\n")

#Se hace el llamado a la funcion escritura
escritura_en_archivos(nombre_archivo, data)
escritura_en_archivos(nombre_archivo2, data2)

print("Fin")


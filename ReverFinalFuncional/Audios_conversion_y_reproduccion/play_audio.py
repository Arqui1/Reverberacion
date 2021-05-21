import soundfile as sf
import sounddevice as sd
import os
import time

#Variables Globales
#----------------------------------------------------
ruta = "C:/Users/danie/OneDrive/Documentos/TEC/Arqui 1/Proyectos/Proyecto Grupal/Files/"
#ruta = ""

entrada1 = "RAMDatos1.txt"
entrada2 = "RAMDatos2.txt"
salida1 = "OUT1.txt"
salida2 = "OUT2.txt"

audio_sin_reverb = ruta + entrada1
audio_con_reverb_aplicada = ruta + salida1
audio_con_reverb_conocida= ruta + entrada2
audio_sin_reverb_aplicada = ruta + salida2

freq = 44100
precision=7
#----------------------------------------------------

#Funcion encargada de pasar el txt con binarios a lista
def txt_to_list(txt):
    
    if os.path.isfile(txt):
        with open(txt, "r") as f:
            data = f.read()
            f.close()
            data = data.split('\n')
            for i in range(0, len(data)):
                data[i] = str(data[i])
            del data[-1]
        return data
    else:
        return ["0"]
#Funcion encargada de pasar el txt con decimal base 10 a lista    
def txt_to_list_decimal_bin(txt):
    
    if os.path.isfile(txt):
        with open(txt, "r") as f:
            data = f.read()
            f.close()
            data = data.split('\n')
            for i in range(0, len(data)):
                data[i] = str(data[i]).lstrip()
            del data[-1]
        return data
    else:
        return ["0"]
#Funcion encargada de pasar decimal a binario    
def binarizar(decimal):
    decimal=int(decimal)
    binario = ''
    while decimal // 2 != 0:
        binario = str(decimal % 2) + binario
        decimal = decimal // 2
    return str(decimal) + binario
#Funcion para agregar ceros a la izquierda faltantes
def agregar_cero(tam):
    a=""
    for i in range(tam):
        a="0"+a
    return a
#Funcion encargada de pasar decimal puro a binario
def decimal_puro_a_binario(numero_decimal_puro):
    n = binarizar(numero_decimal_puro)
    largo=len(n)
    faltante=(7-largo)-1
    if largo<=7:
        n = agregar_cero(faltante)+n
        return n
#Funcion encargada de string a lista     
def Convert(string):
    list1=[]
    list1[:0]=string
    return list1
#Funcion encargada de pasar punto decimal a flotante
def punto_dec_to_float(dec):
    num=0
    i=2
    for i in range(len(dec)):
        if dec[i]=='1':
            num=num+2**(-i-1)
    return str(num)
#Funcion para pasar parte entera a binario
def decbin_to_float(entero):
    num=0
    entero= entero[::-1]
    for i in range(len(entero)):
        if entero[i]=='1':
            num=num+2**(i)
    return str(num)
#funcion principal encargada de pasar binario a flotante
def binary_to_float(lista, tipo):
    if (tipo == "RAMDatos1.txt") or (tipo == "RAMDatos2.txt"):
        lis_float=[]
        for i in range(len(lista)):
            conv = Convert(lista[i])
            signo= conv[0]
            signx=""
            if signo=='1':
                signx='-'
            entero=decbin_to_float(['0', '0'])
            decimal=conv[1:precision]
            punto_dec = punto_dec_to_float(decimal)
            nuevo_num=float(signx+str(float(entero)+float(punto_dec)))
            
            lis_float.append(round(nuevo_num,9))

        return lis_float
            
    elif (tipo == "OUT1.txt") or (tipo == "OUT2.txt"):
        lis_float=[]
        for i in range(len(lista)):
            decimal_a_bin = decimal_puro_a_binario(int(lista[i]))
            conv = Convert(decimal_a_bin)
            signo= conv[0]
            signx=""
            if signo=='1':
                signx='-'
            entero=decbin_to_float(['0', '0'])
            decimal=conv[1:precision]
            punto_dec = punto_dec_to_float(decimal)
            nuevo_num=float(signx+str(float(entero)+float(punto_dec)))
            
            lis_float.append(round(nuevo_num,9))

        return lis_float      
#Cargado de lista respectivas para posteriormente escucharlas en la aplicacion de consola
lista_sin_reverb = binary_to_float(txt_to_list(audio_sin_reverb), entrada1)
lista_con_reverb_aplicada = binary_to_float(txt_to_list_decimal_bin(audio_con_reverb_aplicada), salida1)
lista_con_reverb_conocida = binary_to_float(txt_to_list(audio_con_reverb_conocida), entrada2)
lista_sin_reverb_aplicada = binary_to_float(txt_to_list_decimal_bin(audio_sin_reverb_aplicada), salida2)
#Funcion encargada de pedir opciones al usuario
def pedirOpcion():
    correcto=False
    num=0
    while(not correcto):
        try:
            num = int(input())
            correcto=True
        except ValueError:
            print('Error, introduce una opcion')
     
    return num
 
salir = False
opcion = 0
#Aplicacion de consola 
while not salir:
    time.sleep(2)
    print ("----------------------------------------------------------------------------------")
    print ("Presione 1, para escuchar los audios sin rerverberación y con reverberación aplicada en bajo nivel")
    print ("Presione 2, para escuchar los audio con rerverberación conocida y sin reverberación aplicada en bajo nivel")
    print ("Presione 3, para salir \n")
     
    print ("Elige una opcion")
 
    opcion = pedirOpcion()
 
    if opcion == 1:
        if len(lista_sin_reverb) == 1:
            print("Error el archivo no existe")
        else:
            if len(lista_sin_reverb)==0:
                print("No hay contenido en el archivo, audio sin rerverberación \n")
            else:
                print("Audio sin reverberación \n")
                sd.play(lista_sin_reverb, freq)
                status = sd.wait()

                print("Espere 3 segundo para escuchar el audio con reverberación aplicada en bajo nivel")
                time.sleep(3)

                if lista_con_reverb_aplicada == "Error":
                    print("Error el archivo no existe \n")
                else:
                    if len(lista_con_reverb_aplicada)==0:
                        print("No hay contenido en el archivo, audio con reverberación aplicada en bajo nivel \n")
                    else:
                        print("Audio con reverberación aplicada en bajo nivel\n")
                        sd.play(lista_con_reverb_aplicada, freq)
                        status = sd.wait()
    elif opcion == 2:
        if len(lista_con_reverb_conocida) == 1:
            print("Error el archivo no existe")
        else:
            if len(lista_con_reverb_conocida)==0:
                print("No hay contenido en el archivo, audio con rerverberación conocida \n")
            else:
                print("Audio con rerverberación conocida \n")
                sd.play(lista_con_reverb_conocida, freq)
                status = sd.wait()

                print("Espere 3 segundo para escuchar el audio sin reverberación aplicada en bajo nivel")
                time.sleep(3)
                
                if lista_sin_reverb_aplicada == "Error":
                    print("Error el archivo no existe \n")
                else:
                    if len(lista_sin_reverb_aplicada)==0:
                        print("No hay contenido en el archivo, audio sin reverberación aplicada en bajo nivel \n")
                    else:
                        print("Audio sin reverberación aplicada en bajo nivel \n")
                        sd.play(lista_sin_reverb_aplicada, freq)
                        status = sd.wait()
    elif opcion == 3:
        salir = True
    else:
        print("Introduce un opcion de entre 1 y 2")
 
print("Fin")

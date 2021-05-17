import soundfile as sf
import sounddevice as sd
import os
import time

#fileName = r"C:\Test\test.txt"

#ruta = "C:/QuartusProjects/Files/"
ruta = ""
audio_sin_reverb = ruta + "RAMDatos1.txt"
audio_con_reverb_aplicada = ruta + "OUT1.txt"
audio_con_reverb_conocida= ruta + "RAMDatos2.txt"
audio_sin_reverb_aplicada = ruta + "OUT2.txt"

freq = 44100


#CAMBIAR EL NOMBRE DEL ARCHIVO con reverberacion o sin reverberacion
#audio_salida = audio_sin_reverb #'audio_original.txt'
#Aqui se deberia leer el archivo de salida luego de que se le realice la reverberacion o se le quite la reverberacion
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
        #print("aqui")
        return ["0"]
#print(data[0:10])

def Convert(string):
    list1=[]
    list1[:0]=string
    return list1

def punto_dec_to_float(dec):
    num=0
    i=2
    for i in range(len(dec)):
        if dec[i]=='1':
            num=num+2**(-i-1)
    return str(num)
def decbin_to_float(entero):
    num=0
    entero= entero[::-1]
    for i in range(len(entero)):
        if entero[i]=='1':
            num=num+2**(i)
    return str(num)

def binary_to_float(lista):
    lis_float=[]
    for i in range(len(lista)):
        conv = Convert(lista[i])
        signo= conv[0]
        signx=""
        if signo=='1':
            signx='-'
        entero=decbin_to_float(conv[1:3])
        decimal=conv[3:9]
        punto_dec = punto_dec_to_float(decimal)
        nuevo_num=float(signx+str(float(entero)+float(punto_dec)))
        
        lis_float.append(round(nuevo_num,6))
    return lis_float
        
        

lista_sin_reverb = binary_to_float(txt_to_list(audio_sin_reverb))
lista_con_reverb_aplicada = binary_to_float(txt_to_list(audio_con_reverb_aplicada))
lista_con_reverb_conocida = binary_to_float(txt_to_list(audio_con_reverb_conocida))
lista_sin_reverb_aplicada = binary_to_float(txt_to_list(audio_sin_reverb_aplicada))
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

while not salir:
    time.sleep(2)
    print ("----------------------------------------------------------------------------------")
    print ("Presione 1, para escuchar el audio sin rerverberación y con reverberación aplicada")
    print ("Presione 2, para escuchar el audio con rerverberación conocida y sin reverberación aplicada")
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

                time.sleep(2)

                if lista_con_reverb_aplicada == "Error":
                    print("Error el archivo no existe \n")
                else:
                    if len(lista_con_reverb_aplicada)==0:
                        print("No hay contenido en el archivo, audio con reverberación aplicada \n")
                    else:
                        print("Audio con reverberación aplicada \n")
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

                time.sleep(2)

                if lista_sin_reverb_aplicada == "Error":
                    print("Error el archivo no existe \n")
                else:
                    if len(lista_sin_reverb_aplicada)==0:
                        print("No hay contenido en el archivo, audio sin reverberación aplicada \n")
                    else:
                        print("Audio sin reverberación aplicada \n")
                        sd.play(lista_sin_reverb_aplicada, freq)
                        status = sd.wait()
    elif opcion == 3:
        salir = True
    else:
        print("Introduce un opcion de entre 1 y 2")
 
print("Fin")

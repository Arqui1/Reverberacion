#instalar soundfile y sounddevice con los siguientes comandos en el cmd de windows
#pip install soundfile
#pip install sounddevice
import soundfile as sf
import sounddevice as sd

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
            archivo.write("%.6f\n" % item)
#para MONO
else:
    with open('audio_original.txt', 'w') as archivo:
        for item in data:
            archivo.write("%.6f\n" % item)



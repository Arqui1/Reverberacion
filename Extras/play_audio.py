#instalar soundfile y sounddevice con los siguientes comandos en el cmd de windows
#pip install soundfile
#pip install sounddevice
import soundfile as sf
import sounddevice as sd

#se carga el nombre del archivo, CAMBIAR EL NOMBRE DEL ARCHIVO
nombre_archivo='intput.wav'
data, freq = sf.read(nombre_archivo)

#se reproduce el audio original
print("Audio dos canales")
sd.play(data, freq)
status = sd.wait() 

#se crean lista
derecha=[]
izquierda=[]
mono=[]
#se divide el canal derecho e izquierdo de la variable data de audio
for i in range(len(data)):
    izquierda.append(data[i][0])
    derecha.append(data[i][1])
#se suma ambas listas, las de canal derecho e izquierdo y se divide entre dos
for j in range(len(data)):
    suma=(izquierda[j]+derecha[j])/2
    mono.append(round(suma, 6))

#CAMBIAR EL NOMBRE DEL ARCHIVO con reverberacion o sin reverberacion
audio_salida = 'audio_original.txt'
#Aqui se deberia leer el archivo de salida luego de que se le realice la reverberacion o se le quite la reverberacion
with open(audio_salida, "r") as f:
    data = f.read()
    f.close()
    data = data.split('\n')
    for i in range(0, len(data)):
        data[i] = str(data[i])
    del data[-1]
dataw = [float(i) for i in data]

#se reproduce el audio con reverberacion o sin reverberacion dependiendo de la formula que se le aplique al audio original         
print("Audio Mono, solo un canal")
sd.play(dataw, freq)
status = sd.wait()

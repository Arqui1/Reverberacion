# Diseño e implementación de una aplicación de un ASIP para reverberación de audio

Este proyecto consiste en la implementación en conjunto de un ISA, microarquitectura y programa en alto nivel, para la modificación de audios, dónde puede aplicarsele o quitarsele reverberación, según se desee.

## Primeros pasos

### Pre-requisitos

Es necesario tener instalado Quartus Prime Lite Modelsim. También es necesario tener Python 3.8

### Librerias utilizadas
Las librerías utilizadas son:
* sounddevice
* soundfile
* os
* time
* math
* numpy

## Uso
* Clonar el git: https://github.com/Arqui1/Reverberacion y ingresar a la carpeta "ASIP_Funcional".

* Colocar dos audios en la Carpeta "Audios_conversion_y_reproduccion" con los siguientes nombre "audio_sin_reverb" y "audio con reverb", ambos de formato ".wav". Importante los audios deben ser de maximo 6 segundos con una frecuencia de 44100kHz) en la carpeta:
* Una vez hecho esto, correr el archivo "convert_audio_to_txt.py", posteriormente se crearan dos archivos de texto plano el cual contendrá la conversión del audio a binario(de 7 bits, donde 1 bit es para signo y 6 bits para la parte de punto fijo).

* Posteriormente vaya a la carpeta "CompiladorFuncional" y ejecute el archivo py llamado: "compiler.py". Este archivo le generará dos archivos con la instrucciones en hexadecimal de los codigos emsambladores de insertar y quitar reverb utilizados posteriomente en Quartus.

* Luego vaya carpeta "Procesador" donde tendra el procesador, abralo con Quartus y realice análisis y síntesis. Cambie el modoSelector de archivo "Procesador_tb.sv" a 0 ó 1 según se si desea insertar o quitar reverberación(0 sería insertar reverb y 1 sería quitar reverb). Por último vaya a ModelSim y ejecute la simulación esto creará un archivo con el resultado de insertar o quitar reverb.

* Finalmente para escuchar el resultado del proceso de insertar o quitar reverb, diríjase a la carperta "Audios_conversion_y_reproduccion" y ejecute el archivo py llamado "play_audio.py" y elija la opción 1 para escuchar los audios sin rerverberación y con reverberación aplicada en bajo nivel. Y la opción dos para escuchar los audio con rerverberación conocida y sin reverberación aplicada en bajo nivel.


#########################################

## Herramientas utilizadas
* Quartus Prime Lite 18.0
* Python 3.8








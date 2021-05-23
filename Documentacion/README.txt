Para el desarrollo del Proyecto se utilizó Python para la creación de los archivos de la ROM, la compilación del código LDDS (Ensamblador) a hexadecimal y para la reproducción de audios ya procesados con y sin reverberación. 
También se utilizó la herramienta Quartus con el fin de crear un procesador capaz de crear streams de audio con y sin reverberación. Al no poder usar la tarjeta Terasic DE1-SoC-M TL2 se opta por realizar una simulación utilizando ModelSim. 
El flujo es el siguiente:
1.	Se accede a la carpeta audios_conversion_y_reproduccion, se corre el archivo convert_audio_to_txt.py para crear las RAMs de datos.
2.	Se accede a la carpeta CompiladorFucional, se corre el archivo compiler.py para crear las ROMs de instrucciones.
3.	Se procede a abrir la herramienta Quartus, con la cual se abre que el proyecto que se encuentra dentro de la carpeta llama Procesador, se realiza el análisis y síntesis del proyecto y se continua por realizar la simulación con ModelSim.
4.	Una vez finalizada la simulación, dentro de la carpeta audios_conversion_y_reproduccion se encuentra un archivo Python llamado play_audio.py el cual utiliza los datos generados en la simulación para reproducir los nuevos audios procesados

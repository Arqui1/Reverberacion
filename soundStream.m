clear
clc

[archivo, fs] = audioread('emergency001.wav');
display(num2str(archivo(1,1)))


filename = 'stream.txt';
fid = fopen(filename, "w+");


for i=1:size(archivo, 1)
    fprintf(fid, '%f ', archivo(i,:));
    fprintf(fid, '\n');
end

fclose (fid);
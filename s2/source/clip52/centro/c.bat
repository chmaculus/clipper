@Echo off
del inicio.exe
del inicio.obj

echo error  * no darle pelota>inicio.log
clipper inicio /w >>inicio.log
rtlink file inicio >>inicio.log
edit inicio.log
mode 80
pause
inicio

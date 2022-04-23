@Echo off
echo error  * no darle pelota>inicio.log
clipper inicio /w >>inicio.log
rtlink file inicio, FUNCTION LIBRARY CT52>>inicio.log
rem edit log.txt
mode 80
pause
inicio

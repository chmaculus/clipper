@Echo off
echo error  * no darle pelota>VENTAS.log
clipper VENTAS /w >>VENTAS.log
rtlink file VENTAS >>VENTAS.log
edit VENTAS.log
mode 80
pause
VENTAS

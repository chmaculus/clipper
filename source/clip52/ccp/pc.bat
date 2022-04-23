@Echo off
echo error  * no darle pelota>log.txt
clipper FISCAL /w >>log.txt
rtlink file FISCAL, FUNCTION LIBRARY CT52>>log.txt
edit log.txt
mode 80
pause
FISCAL

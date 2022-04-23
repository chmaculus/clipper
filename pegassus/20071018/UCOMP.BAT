@Echo off
echo error  * no darle pelota>%1.log
clipper %1 /w >>%1.log
rtlink file %1 >>%1.log
edit %1.log
mode 80
pause
%1

@Echo off
echo error ** no darle pelota>%1.log
clipper %1>>%1.log
rtlink file %1>>%1.log
edit %1.prg %1.log
pause
%1


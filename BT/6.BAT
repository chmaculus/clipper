@Echo off
del *.obj
echo error  * no darle pelota>pegassus.log
clipper PEGASSUS /w >>pegassus.log
clipper MOD1A /w >>pegassus.log
clipper MOD1B /w >>pegassus.log
clipper MOD1C /w >>pegassus.log
clipper MOD1D /w >>pegassus.log
clipper MOD1E /w >>pegassus.log
clipper MOD1F /w >>pegassus.log
clipper MOD1F /w >>pegassus.log
clipper BOX_FUNC.PRG /w >>pegassus.log
clipper MODULO5.PRG /w >>pegassus.log
clipper MODULO.PRG /w >>pegassus.log
clipper INITHAND.PRG /w >>pegassus.log
clipper MODULO2.PRG /w >>pegassus.log
rtlink file PEGASSUS.obj,MOD1A.obj,MOD1B.obj,MOD1C.obj,MOD1D.obj,MOD1E.obj,MOD1F.obj,BOX_FUNC.obj,modulo.obj,modulo2.obj,modulo5.obj,INITHAND.obj output pegassus >>pegassus.log

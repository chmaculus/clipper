use producto
set printer to producto.php
set device to printer

#define comilla chr(39)

@prow(),0 say '<?php'


DO WHILE .T.

	 store nomprod to vreg1
     store idcat to vreg2
     store cantxun to vreg3
     store precixun to vreg4


     store str(vreg2) to vreg2
     store str(vreg4) to vreg4

     store rtrim(vreg1) to vreg1
     store rtrim(vreg2) to vreg2
     store rtrim(vreg3) to vreg3
     store rtrim(vreg4) to vreg4


     store ltrim(vreg1) to vreg11
     store ltrim(vreg2) to vreg22
     store ltrim(vreg3) to vreg33
     store ltrim(vreg4) to vreg44



     @ prow()+1,0 say '$var1='+comilla+vreg11+comilla+';'
     @ prow()+1,0 say '$var2='+comilla+vreg22+comilla+';'
     @ prow()+1,0 say '$var3='+comilla+vreg33+comilla+';'
     @ prow()+1,0 say '$var4='+comilla+vreg44+comilla+';'
     @ prow()+1,0 say "require('./insert.php')"+';'


     if eof()=.T.
         exit
     endif
     skip   
     loop
ENDDO

@prow()+1,0 say '?>'
set device to screen

use detped

set printer to detped.php
set device to printer

#define comilla chr(39)

@prow(),0 say '<?php'


DO WHILE .T.

	 store idped to vreg1
     store idprod to vreg2
     store precioun to vreg3
     store cantidad to vreg4
     store descuent to vreg5

     store str(vreg1) to vreg1
     store str(vreg2) to vreg2
     store str(vreg3) to vreg3
     store str(vreg4) to vreg4
     store str(vreg5) to vreg5

     store rtrim(vreg1) to vreg1
     store rtrim(vreg2) to vreg2
     store rtrim(vreg3) to vreg3
     store rtrim(vreg4) to vreg4
     store rtrim(vreg5) to vreg5


     store ltrim(vreg1) to vreg11
     store ltrim(vreg2) to vreg22
     store ltrim(vreg3) to vreg33
     store ltrim(vreg4) to vreg44
     store ltrim(vreg5) to vreg55



     @ prow()+1,0 say '$var1='+comilla+vreg11+comilla+';'
     @ prow()+1,0 say '$var2='+comilla+vreg22+comilla+';'
     @ prow()+1,0 say '$var3='+comilla+vreg33+comilla+';'
     @ prow()+1,0 say '$var4='+comilla+vreg44+comilla+';'
     @ prow()+1,0 say '$var5='+comilla+vreg55+comilla+';'
     @ prow()+1,0 say "require('./insert.php')"+';'


     if eof()=.T.
         exit
     endif
     skip   
     loop
ENDDO

@prow()+1,0 say '?>'

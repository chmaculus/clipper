use clientes

set printer to php2.php
set device to printer

#define comilla chr(39)

@prow(),0 say '<?php'

store 0 to sale

DO WHILE .T.

	 store apellido to vreg1
     store direcc to vreg2
     store ciudad to vreg3
     store codpost to vreg4
     store telefono to vreg5
     store fax to vreg6


     store rtrim(vreg1) to vreg1
     store rtrim(vreg2) to vreg2
     store rtrim(vreg3) to vreg3
     store rtrim(vreg4) to vreg4
     store rtrim(vreg5) to vreg5
     store rtrim(vreg6) to vreg6


     store ltrim(vreg1) to vreg11
     store ltrim(vreg2) to vreg22
     store ltrim(vreg3) to vreg33
     store ltrim(vreg4) to vreg44
     store ltrim(vreg5) to vreg55
     store ltrim(vreg6) to vreg66



     @ prow()+1,0 say '$var1='+comilla+vreg11+comilla+';'
     @ prow()+1,0 say '$var2='+comilla+vreg22+comilla+';'
     @ prow()+1,0 say '$var3='+comilla+vreg33+comilla+';'
     @ prow()+1,0 say '$var4='+comilla+vreg44+comilla+';'
     @ prow()+1,0 say '$var5='+comilla+vreg55+comilla+';'
     @ prow()+1,0 say '$var6='+comilla+vreg66+comilla+';'
     @ prow()+1,0 say "require('./insert.php')"+';'


     if eof()=.T.
         exit
     endif
     skip   
     loop
ENDDO

@prow()+1,0 say '?>'

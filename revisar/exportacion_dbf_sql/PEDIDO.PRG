use pedidos
set century on
set date to ymd
set printer to pedido.php
set device to printer

#define comilla chr(39)

@prow(),0 say '<?php'


DO WHILE .T.

	 store idped to vreg1
     store fechaped to vreg2
     store destinat to vreg3

     store str(vreg1) to vreg1
*     store str(vreg2) to vreg2
*     store str(vreg3) to vreg3

     store rtrim(vreg1) to vreg1
*     store rtrim(vreg2) to vreg2
     store rtrim(vreg3) to vreg3


     store ltrim(vreg1) to vreg11
*     store ltrim(vreg2) to vreg22
     store ltrim(vreg3) to vreg33

	? vreg2



     @ prow()+1,0 say '$var1='+comilla+vreg11+comilla+';'
     @ prow()+1,0 say '$var2='
     @ prow(),6 say '"'
     @ prow(),7 say vreg2
     @ prow(),17 say '";'
     @ prow()+1,0 say '$var3='+comilla+vreg33+comilla+';'
     @ prow()+1,0 say "require('./insert.php')"+';'


     if eof()=.T.
         exit
     endif
     skip   
     loop
ENDDO

@prow()+1,0 say '?>'
set device to screen

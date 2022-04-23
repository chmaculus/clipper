use rubro
set printer to rubro.php
set device to printer

#define comilla chr(39)

@prow(),0 say '<?php'


DO WHILE .T.

	 store nomcat to vreg1

     store rtrim(vreg1) to vreg1

     store ltrim(vreg1) to vreg11

     @ prow()+1,0 say '$var1='+comilla+vreg11+comilla+';'
     @ prow()+1,0 say "require('./insert.php')"+';'


     if eof()=.T.
         exit
     endif
     skip   
     loop
ENDDO

@prow()+1,0 say '?>'
set device to screen

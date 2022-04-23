
CREA_VTASTMP()
CREA_VENTAS()
DATOS_VTAS()

FUNCTION CREA_VTASTMP
?
? "CREA BASE"
?
DECLARE CAMP[11]
CAMP[1]='FECHA'
CAMP[2]='HORA'
CAMP[3]='CODIGO'
CAMP[4]='CANTIDAD'
CAMP[5]='DETALLE'
CAMP[6]='CODIGBARRA'
CAMP[7]='PRECIO'
CAMP[8]='SUBTOTAL'
CAMP[9]='TOTAL'
CAMP[10]='OPERADOR'
CAMP[11]='IDCLASIFIC'

DECLARE TIPO[11]
TIPO[1]='D'
TIPO[2]='C'
TIPO[3]='N'
TIPO[4]='N'
TIPO[5]='C'
TIPO[6]='N'
TIPO[7]='N'
TIPO[8]='N'
TIPO[9]='N'
TIPO[10]='C'
TIPO[11]='N'

DECLARE LON[11]
LON[1]=8
LON[2]=8
LON[3]=6
LON[4]=5
LON[5]=60
LON[6]=14
LON[7]=8
LON[8]=8
LON[9]=8
LON[10]=10
LON[11]=5

DECLARE DECI[11]
DECI[1]=0
DECI[2]=0
DECI[3]=0
DECI[4]=0
DECI[5]=0
DECI[6]=0
DECI[7]=2
DECI[8]=2
DECI[9]=2
DECI[10]=0
DECI[11]=0


ERASE SWAP.DBF
ERASE TEMP.DBF

CREATE TEMP
store 1 to I

do while .t.
   APPEND BLANK
   REPLACE field_name with CAMP[I]
   REPLACE field_type with tipo[I]
   REPLACE field_len with lon[I]
   REPLACE field_dec with deci[I]

   if i=11
     exit
   endif

   store i+1 to i
   loop
enddo

CREATE .\NEW\VTASTMP FROM TEMP
ERASE TEMP.DBF
RETURN NIL



FUNCTION CREA_VENTAS
?
? "CREA BASE"
?
DECLARE CAMP[12]
CAMP[1]='FECHA'
CAMP[2]='HORA'
CAMP[3]='CODIGO'
CAMP[4]='CANTIDAD'
CAMP[5]='DETALLE'
CAMP[6]='CODIGBARRA'
CAMP[7]='PRECIO'
CAMP[8]='SUBTOTAL'
CAMP[9]='TOTAL'
CAMP[10]='OPERADOR'
CAMP[11]='NUMEROCAJA'
CAMP[12]='IDCLASIFIC'

DECLARE TIPO[12]
TIPO[1]='D'
TIPO[2]='C'
TIPO[3]='N'
TIPO[4]='N'
TIPO[5]='C'
TIPO[6]='N'
TIPO[7]='N'
TIPO[8]='N'
TIPO[9]='N'
TIPO[10]='C'
TIPO[11]='N'
TIPO[12]='N'

DECLARE LON[12]
LON[1]=8
LON[2]=8
LON[3]=6
LON[4]=5
LON[5]=60
LON[6]=14
LON[7]=8
LON[8]=8
LON[9]=8
LON[10]=10
LON[11]=6
LON[12]=5

DECLARE DECI[12]
DECI[1]=0
DECI[2]=0
DECI[3]=0
DECI[4]=0
DECI[5]=0
DECI[6]=0
DECI[7]=2
DECI[8]=2
DECI[9]=2
DECI[10]=0
DECI[11]=0
DECI[12]=0


ERASE SWAP.DBF
ERASE TEMP.DBF

CREATE TEMP
store 1 to I

do while .t.
   APPEND BLANK
   REPLACE field_name with CAMP[I]
   REPLACE field_type with tipo[I]
   REPLACE field_len with lon[I]
   REPLACE field_dec with deci[I]

   if i=12
     exit
   endif

   store i+1 to i
   loop
enddo

CREATE .\NEW\VENTAS FROM TEMP
ERASE TEMP.DBF
USE .\NEW\VENTAS
COPY TO .\NEW\VTASPEND
CLOSE DATABASES
RETURN NIL



FUNCTION DATOS_VTAS
?
? "DATOS SWAP"
?

STORE 0 TO fecha
STORE SPACE(10) TO hora
STORE 0 TO codigo
STORE 0 TO cantidad
STORE SPACE(60) TO detalle
STORE 0 TO codigbarra
STORE 0 TO precio
STORE 0 TO subtotal
STORE 0 TO total
STORE SPACE(10) TO operador
STORE 0 TO numerocaja



USE VENTAS
INDEX ON CODIGO TO AA

STORE 1 TO IR
STORE 0 TO SALE

DO WHILE .T.


  USE VENTAS
  SET INDEX TO AA
  GO IR

  IF EOF()
    STORE 1 TO SALE
  ENDIF

STORE fecha TO Vfecha
STORE hora TO Vhora
STORE codigo TO Vcodigo
STORE cantidad TO Vcantidad
STORE detalle TO Vdetalle
STORE codigbarra TO Vcodigbarra
STORE precio TO Vprecio
STORE subtotal TO Vsubtotal
STORE total TO Vtotal
STORE operador TO Voperador
STORE numerocaja TO Vnumerocaja

  USE .\NEW\VENTAS
  APPEND BLANK

REPLACE fecha WITH Vfecha
REPLACE hora WITH Vhora
REPLACE codigo WITH Vcodigo
REPLACE cantidad WITH Vcantidad
REPLACE detalle WITH Vdetalle
REPLACE codigbarra WITH Vcodigbarra
REPLACE precio WITH Vprecio
REPLACE subtotal WITH Vsubtotal
REPLACE total WITH Vtotal
REPLACE operador WITH Voperador
REPLACE numerocaja WITH Vnumerocaja


  STORE IR+1 TO IR
? IR
  IF SALE=1
     EXIT
  ENDIF
  LOOP
ENDDO

RETURN NIL




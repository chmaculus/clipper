#include "colores.ch"
SAVE SCREEN TO BARRASCR
USE MERCA INDEX ORDBARRA
GO TOP
SEEK VBARRA
IF EOF()
   SET CURSOR OFF
   SET COLOR TO COLOR0
   @11,30 TO 13,52
   SET COLOR TO COLOR9
   @12,32 SAY 'CODIGO NO EXISTENTE'
   SET COLOR TO COLOR0
   TONE(1200,1)
   INKEY(3)
   STORE 0 TO VBARRA
   RESTORE SCREEN FROM BARRASCR
   RETURN
ENDIF

STORE CODIGO TO VCODIGO
STORE DETALLE TO VDETALLE
STORE CONIVA TO VCONIVA

USE STOCK
INDEX ON CODIGO TO ORDCODST
GO TOP

SEEK VCODIGO
IF EOF().OR.CANTIDAD=0
   SET CURSOR OFF
   SET COLOR TO COLOR0
   @11,30 TO 13,53
   SET COLOR TO COLOR9
   @12,32 SAY 'MERCADERIA SIN STOCK'
   SET COLOR TO COLOR0
   TONE(1200,1)
   INKEY(3)
   STORE 0 TO VBARRA
   RESTORE SCREEN FROM BARRASCR
   RETURN
ENDIF

STORE CANTIDAD TO ENSTOCK,STACTUAL

SET COLOR TO COLOR3
@3,48 SAY VCODIGO PICTURE '@!'
SET COLOR TO COLOR0
@LINEA,5 SAY '�'
@LINEA,6 SAY LEFT(VDETALLE,50)
@LINEA,61 SAY '�'
@LINEA,62 SAY VCONIVA PICTURE '9999.999'
@LINEA,70 SAY '�'
SET COLOR TO COLOR3
@3,74 SAY STACTUAL PICTURE '9999'

SET COLOR TO COLOR0
DO WHILE .T.
   STORE 0 TO VCANT
   SET CURSOR ON
   @LINEA,0 SAY ''GET VCANT PICTURE '999'
   READ

   IF LASTKEY()=27
      RESTORE SCREEN FROM BARRASCR
      RETURN
   ENDIF

   IF VCANT=0
      TONE(1200,1)
      LOOP
   ENDIF

   IF ENSTOCK<VCANT
      SET CURSOR OFF
      SAVE SCREEN TO YAMA
      SET COLOR TO COLOR0
      @11,20 TO 13,59
      @12,22 SAY 'La cantidad es SUPERIOR al stock'
      SET COLOR TO COLOR9
      @12,37 SAY 'SUPERIOR'
      SET COLOR TO COLOR0
      TONE(1200,1)
      INKEY(3)
      RESTORE SCREEN FROM YAMA
      LOOP
   ENDIF
   EXIT
ENDDO

STORE VCANT*VCONIVA TO VSUBTOT
@LINEA,72 SAY VSUBTOT PICTURE '9999.99'
STORE VTOTAL+VSUBTOT TO VTOTAL
SET COLOR TO COLOR3
@22,72 SAY VTOTAL PICTURE '9999.99'
SET COLOR TO COLOR0
LINEA=LINEA+1
@3,0 CLEAR TO 3,79

USE VTASTMP
APPEND BLANK
REPLACE FECHA WITH DATE()
REPLACE HORA WITH TIME()
REPLACE CODIGO WITH VCODIGO
REPLACE CANTIDAD WITH VCANT
REPLACE DETALLE WITH VDETALLE
REPLACE CODIGBARRA WITH VBARRA
REPLACE PRECIO WITH VCONIVA
REPLACE SUBTOTAL WITH VSUBTOT
REPLACE TOTAL WITH VTOTAL
REPLACE OPERADOR WITH NOMBOPER
RETURN

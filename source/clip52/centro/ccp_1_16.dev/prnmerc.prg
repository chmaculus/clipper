#include "colores.ch"
SET CURSOR OFF
SET COLOR TO COLOR0
SALE=0
DO WHILE .T.
   @22,16 CLEAR TO 24,61 
   SET COLOR TO COLOR0
   @22,16 TO 24,61 
   @23,21 SAY 'Prepare la Impresora y pulse <ENTER>'
   SET COLOR TO COLOR6
   @23,50 SAY '<ENTER>'
   SET COLOR TO COLOR0
   INKEY(0)
   IF LASTKEY()=27
      SALE=1
      EXIT
   ENDIF
   SET COLOR TO COLOR0
   IF ISPRINTER()
      EXIT
   ELSE
      TONE(500,2)
      @23,17 CLEAR TO 23,60 
      set color to COLOR0
      @23,20 SAY 'La Impresora NO ESTA LISTA...'
      set color to COLOR8
      @23,49 SAY 'PELOTUDA!'
      INKEY(3)
      SET COLOR TO COLOR0
      LOOP
   ENDIF
ENDDO
IF SALE=1
   RETURN
ENDIF
numero=LEFT(DTOC(DATE()),2)
DIA=TDIAS(cdow(DATE()))
MES=TMES(CMONTH(DATE()))
ANIO=ALLTRIM(STR(YEAR(DATE())))
VFECHA=DIA+' '+numero+' de '+MES+' de '+ANIO
SET COLOR TO COLOR0
@23,17 CLEAR TO 23,60
SET CURSOR OFF
SET COLOR TO COLOR9
@23,24 SAY 'ESTOY IMPRIMIENDO....� ESPERATE !'
SET COLOR TO COLOR0
SET DEVICE TO PRINT
@0,0 SAY 'ESTACION DE SERVICIO CENTRO'
LL=79-LEN(VFECHA)
@0,LL-7 SAY 'Fecha: '
@0,LL SAY VFECHA
@2,33 SAY 'LISTADO DE STOCK'
@3,0 SAY REPLICATE('�',80)
@4,0 SAY '� Codigo �                 Detalle                  �P. Costo� S/ Iva � C/ Iva �'
@5,0 SAY REPLICATE('�',80)
LINEA=6
DO WHILE .T.
   IF EOF()
      EXIT
   ENDIF
   @LINEA,0 SAY '�'
   @LINEA,1 SAY CODIGO
   @LINEA,9 SAY '�'
   @LINEA,10 SAY LEFT(DETALLE,42)
   @LINEA,52 SAY '�'
   @LINEA,53 SAY PCOSTO PICTURE '9999.99'
   @LINEA,61 SAY '�'
   @LINEA,62 SAY SINIVA PICTURE '9999.99'
   @LINEA,70 SAY '�'
   @LINEA,71 SAY CONIVA PICTURE '9999.99'
   @LINEA,79 SAY '�'
   LINEA=LINEA+1
   SKIP
   LOOP
ENDDO
@LINEA,0 SAY REPLICATE('�',80)
EJECT
SET DEVICE TO SCREEN
CLOSE ALL
RETURN

SET CURSOR OFF
SALE=0
DO WHILE .T.
   SET COLOR TO W+/B
   @22,16 CLEAR TO 24,61 
   @22,16 TO 24,61 
   @23,21 SAY 'Prepare la Impresora y pulse <ENTER>'
   SET COLOR TO BG+/B
   @23,50 SAY '<ENTER>'
   SET COLOR TO W+/B
   INKEY(0)
   IF LASTKEY()=27
      SALE=1
      EXIT
   ENDIF
   SET COLOR TO
   IF ISPRINTER()
      EXIT
   ELSE
      SET COLOR TO W+/B
      TONE(500,2)
      @23,17 CLEAR TO 23,60 
      @23,20 SAY 'La Impresora NO ESTA LISTA...'
      set color to *RG+/B
      @23,49 SAY 'VERIFIQUE'
      INKEY(3)
      SET COLOR TO W+/B
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
SET COLOR TO W+/B
@23,17 CLEAR TO 23,60
SET CURSOR OFF
SET COLOR TO *RG+/B
@23,25 SAY 'ESTOY IMPRIMIENDO....� ESPERE !'
SET COLOR TO W+/B
SET DEVICE TO PRINT
@0,0 SAY '* * * CENTRO PLASTICO * * *'
LL=79-LEN(VFECHA)
@0,LL-7 SAY 'Fecha: '
@0,LL SAY VFECHA
TITULO='LISTADO DE MERCADERIA'+ESTEMEN
LT=39-LEN(TITULO)/2
@2,LT SAY TITULO
@3,1 SAY REPLICATE('�',78)
@4,0 SAY '�                        Detalle                         � P. Costo �P. P�blico�'
@5,1 SAY REPLICATE('�',78)
LINEA=6
DO WHILE .T.
   IF EOF()
      EXIT
   ENDIF
   @LINEA,0 SAY '�'
   @LINEA,2 SAY DETALLE
   @LINEA,57 SAY '�'
   @LINEA,59 SAY COSTO PICTURE '99999.99'
   @LINEA,68 SAY '�'
   @LINEA,70 SAY PUBLICO PICTURE '99999.99'
   @LINEA,79 SAY '�'
   LINEA=LINEA+1
   SKIP
   LOOP
ENDDO
@LINEA,1 SAY REPLICATE('�',78)
EJECT
SET COLOR TO W+/B
SET DEVICE TO SCREEN
CLOSE ALL
RETURN

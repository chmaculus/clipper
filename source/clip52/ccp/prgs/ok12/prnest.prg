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
@23,25 SAY 'ESTOY IMPRIMIENDO....­ ESPERE !'
SET COLOR TO W+/B
SET DEVICE TO PRINT
@0,0 SAY '* * * CENTRO PLASTICO * * *'
LL=79-LEN(VFECHA)
@0,LL-7 SAY 'Fecha: '
@0,LL SAY VFECHA
TITULO='ESTADO BANCARIO DESDE '+DTOC(DESDE)+' HASTA '+DTOC(HASTA)
LT=39-LEN(TITULO)/2
@2,LT SAY TITULO
@3,1 SAY REPLICATE('Ä',78)
@4,0 SAY '³ Fechas ³  Mov.  ³                  Detalles                ³ $ Deb. ³ $ Cre. ³'
@5,1 SAY REPLICATE('Ä',78)
LINEA=6
STORE 0 TO TOTDEB,TOTHAB
DO WHILE .T.
   IF EOF()
      @LINEA,1 SAY REPLICATE('Ä',78)
      LINEA=LINEA+1
      IF VICUO<>0
         STORE 'CUOTA '+ALLTRIM(VDETCUO)+' ' TO VDETCUO
         LD=LEN(VDETCUO)
         IF LD=27
            STORE VDETCUO+'ÄÄÄ>' TO VDETCUO
         ELSE
            STORE '' TO SUMAR
            FOR X=1 TO 30-LD
               STORE SUMAR+'Ä' TO SUMAR
            NEXT
            STORE VDETCUO+SUMAR+'>' TO VDETCUO
         ENDIF
         @LINEA,0 SAY '³'
         @LINEA,28 SAY VDETCUO
         @LINEA,61 SAY '³'
         @LINEA,63 SAY VICUO*(-1) PICTURE '9999.99'
         @LINEA,70 SAY '³'
         @LINEA,79 SAY '³'
         LINEA=LINEA+1
         @LINEA,0 SAY '³'
         @LINEA,28 SAY 'PAGO TARJETA ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'
         @LINEA,61 SAY '³'
         @LINEA,63 SAY VITAR*(-1) PICTURE '9999.99'
         @LINEA,70 SAY '³'
         @LINEA,79 SAY '³'
         LINEA=LINEA+1
         @LINEA,0 SAY '³'
         @LINEA,28 SAY 'GASTOS GENERALES ÄÄÄÄÄÄÄÄÄÄÄÄÄ>'
         @LINEA,61 SAY '³'
         @LINEA,63 SAY VIGG*(-1) PICTURE '9999.99'
         @LINEA,70 SAY '³'
         @LINEA,79 SAY '³'
      ELSE
         @LINEA,0 SAY '³'
         @LINEA,28 SAY 'PAGO TARJETA ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'
         @LINEA,61 SAY '³'
         @LINEA,63 SAY VITAR*(-1) PICTURE '9999.99'
         @LINEA,70 SAY '³'
         @LINEA,79 SAY '³'
         LINEA=LINEA+1
         @LINEA,0 SAY '³'
         @LINEA,28 SAY 'GASTOS GENERALES ÄÄÄÄÄÄÄÄÄÄÄÄÄ>'
         @LINEA,61 SAY '³'
         @LINEA,63 SAY VIGG*(-1) PICTURE '9999.99'
         @LINEA,70 SAY '³'
         @LINEA,79 SAY '³'
      ENDIF
      LINEA=LINEA+1
      @LINEA,0 SAY '³'
      @LINEA,28 SAY 'SALDO POTENCIAL ÄÄÄÄÄ>'
      SALDO_P=TOTHAB-TOTDEB-VICUO-VITAR-VIGG
      GO TOP
      SUM IMPORTE,TER_IMP TO ID1,ID2 FOR DEPOSITO='#'
      GO TOP
      SUM IMPORTE TO IC1 FOR CHEQUE='#'
      SALDO_R=ID1+ID2-IC1-VICUO-VITAR-VIGG
      IF SALDO_P<0
         @LINEA,51 SAY 'NEGATIVO'
         @LINEA,61 SAY '³'
         @LINEA,62 SAY SALDO_P PICTURE '99999.99'
         @LINEA,70 SAY '³'
      ELSE
         @LINEA,51 SAY 'POSITIVO'
         @LINEA,61 SAY '³'
         @LINEA,70 SAY '³'
         @LINEA,71 SAY SALDO_P PICTURE '99999.99'
      ENDIF
      @LINEA,79 SAY '³'
      LINEA=LINEA+1
      @LINEA,0 SAY '³'
      @LINEA,28 SAY 'SALDO REAL ÄÄÄÄÄÄÄÄÄÄ>'
      IF SALDO_R<0
         @LINEA,51 SAY 'NEGATIVO'
         @LINEA,61 SAY '³'
         @LINEA,62 SAY SALDO_R PICTURE '99999.99'
         @LINEA,70 SAY '³'
      ELSE
         @LINEA,51 SAY 'POSITIVO'
         @LINEA,61 SAY '³'
         @LINEA,70 SAY '³'
         @LINEA,71 SAY SALDO_R PICTURE '99999.99'
      ENDIF
      @LINEA,79 SAY '³'
      EXIT
   ENDIF
   @LINEA,0 SAY '³'
   @LINEA,1 SAY FECHA
   @LINEA,9 SAY '³'
   IF CATEGORIA='C'
      CATEG=' CHEQUE '
   ELSE
      CATEG='DEPOSITO'
   ENDIF
   @LINEA,10 SAY CATEG
   @LINEA,18 SAY '³'
   IF CATEGORIA='C'
      @LINEA,19 SAY 'N§: '+ALLTRIM(NUMCHEQUE)+' - VTO: '+DTOC(F_VTO)
   ELSE
      IF IMPORTE<>0
         @LINEA,19 SAY 'EFECTIVO'
      ELSE
         @LINEA,19 SAY 'CH N§: '+ALLTRIM(TER_NUM)+' - '+LEFT(ALLTRIM(TER_BAN),15)
      ENDIF
   ENDIF
   @LINEA,61 SAY '³'
   IF CATEGORIA='C'
      IF CHEQUE='#'
         @LINEA,62 SAY IMPORTE PICTURE '99999.99'
         @LINEA,62 SAY 'ÄÄÄÄÄÄÄÄ'
      ELSE
         @LINEA,62 SAY IMPORTE PICTURE '99999.99'
      ENDIF
      @LINEA,70 SAY '³'
      TOTDEB=TOTDEB+IMPORTE
   ELSE
      @LINEA,70 SAY '³'
      IF IMPORTE<>0
         IF DEPOSITO='#'
            @LINEA,71 SAY IMPORTE PICTURE '99999.99'
            @LINEA,71 SAY 'ÄÄÄÄÄÄÄÄ'
         ELSE
            @LINEA,71 SAY IMPORTE PICTURE '99999.99'
         ENDIF
         TOTHAB=TOTHAB+IMPORTE
      ELSE
         IF DEPOSITO='#'
            @LINEA,71 SAY TER_IMP PICTURE '99999.99'
            @LINEA,71 SAY 'ÄÄÄÄÄÄÄÄ'
         ELSE
            @LINEA,71 SAY TER_IMP PICTURE '99999.99'
         ENDIF
         TOTHAB=TOTHAB+TER_IMP
      ENDIF
   ENDIF
   @LINEA,79 SAY '³'
   LINEA=LINEA+1
   SKIP
   LOOP
ENDDO
LINEA=LINEA+1
@LINEA,1 SAY REPLICATE('Ä',78)
LINEA=LINEA+1
@LINEA,1 SAY 'Lo TACHADO corresponde a CHEQUES DEBITADOS y/o DEPOSITOS ACREDITADOS'
EJECT
SET COLOR TO W+/B
SET DEVICE TO SCREEN
CLOSE ALL
RETURN

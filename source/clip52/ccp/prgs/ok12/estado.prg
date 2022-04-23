SAVE SCREEN TO AAA
DO WHILE .T.
   SET COLOR TO BG/B
   @16,15 TO 20,65
   @17,16 CLEAR TO 19,64
   SET COLOR TO W+/B
   @17,18 SAY 'Desde Fecha:            Hasta Fecha:'
   @19,28 SAY 'Pulse <ENTER> para tomar todo'
   SET COLOR TO B/W
   @17,55 SAY '  /  /  '
   SET COLOR TO *BG+/B
   @19,35 SAY 'ENTER'
   SET CURSOR ON
   STORE CTOD('  /  /  ') TO DESDE,HASTA
   SET COLOR TO BG/B,B/W
   @17,30 SAY ''GET DESDE PICTURE '99/99/99'
   READ
   IF LASTKEY()=27
      RETURN
   ENDIF
   IF DESDE=CTOD('  /  /  ')
      SET CURSOR OFF
      STORE CTOD('01/01/80') TO DESDE
      STORE DATE() TO HASTA
      @19,16 CLEAR TO 19,64
      SET COLOR TO *BG+/B
      @19,34 SAY 'Tomando TODO'
      SET COLOR TO
   ELSE
      @19,16 CLEAR TO 19,64
      SET COLOR TO *BG+/B
      @19,32 SAY 'Tomando FRACCION'
      SET COLOR TO BG/B,B/W
      @17,54 SAY ''GET HASTA PICTURE '99/99/99'
      READ
      IF HASTA=CTOD('  /  /  ')
         STORE DATE() TO HASTA
      ENDIF
   ENDIF
   SET CURSOR OFF
   IF DESDE>HASTA
      TONE(1200,1)
      SET COLOR TO *R+/B
      @19,16 CLEAR TO 19,64
      @19,34 SAY 'Mal Ingresado'
      SET COLOR TO W+/B
      SET CURSOR OFF
      INKEY(1)
      @19,16 CLEAR TO 19,64
      LOOP
   ENDIF
   EXIT
ENDDO
USE BANCOS
INDEX ON FECHA TO ORDFEC
SET FILTER TO FECHA>=DESDE.AND.FECHA<=HASTA
GO TOP
IF EOF()
   TONE(1200,1)
   SET CURSOR OFF
   SET COLOR TO W+/B
   @20,15 TO 22,65
   @21,16 CLEAR TO 21,64
   SET COLOR TO *R+/B
   @21,27 SAY 'NO EXISTEN DATOS EN ESE RANGO'
   SET COLOR TO W+/B
   INKEY(3)
   RETURN
ENDIF
RESTORE SCREEN FROM AAA

DO WHILE .T.
   SET COLOR TO BG+/B
   @10,5 TO 20,74
   @11,6 CLEAR TO 19,73
   SET COLOR TO W+/B
   @15,22 SAY '¨ Est  Pagando Cuotas de algo (S/N) ?'
   SET COLOR TO *R+/B
   @15,53 SAY 'S'
   @15,55 SAY 'N'
   SET COLOR TO W+/B
   DO WHILE .T.
      INKEY(0)
      IF LASTKEY()=27
         RETURN
      ENDIF
      IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
         TONE(500,1)
         LOOP
      ENDIF
      EXIT
   ENDDO
   SET CURSOR ON
   @15,16 CLEAR TO 15,64
   IF LASTKEY()=83.OR.LASTKEY()=115
      STORE SPACE(20) TO VDETCUO
      STORE 0 TO VICUO,VITAR,VIGG
      SET COLOR TO W+/B,B/W
      @12,9 SAY 'Detalle Cuota:'GET VDETCUO PICTURE '@!'
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
      @12,49 SAY 'Importe Cuota:'GET VICUO PICTURE '9999.99'
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
      @14,9 SAY 'Importe de la Tarjeta ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>:'GET VITAR PICTURE '9999.99'
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
      @16,9 SAY 'Importe de Gastos Generales ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>:'GET VIGG PICTURE '9999.99'
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
   ELSE
      STORE 0 TO VITAR,VIGG
      SET COLOR TO W+/B,B/W
      @13,9 SAY 'Importe de la Tarjeta ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>:'GET VITAR PICTURE '9999.99'
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
      @15,9 SAY 'Importe de Gastos Generales ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>:'GET VIGG PICTURE '9999.99'
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
      STORE 0 TO VICUO
      STORE '' TO VDETCUO
   ENDIF
   SET CURSOR OFF
   SET COLOR TO W+/B
   @18,26 SAY '¨ Est  Todo Correcto (S/N) ?'
   SET COLOR TO *R+/B
   @18,48 SAY 'S'
   @18,50 SAY 'N'
   DO WHILE .T.
      INKEY(0)
      IF LASTKEY()=27
         RETURN
      ENDIF
      IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
         TONE(500,1)
         LOOP
      ENDIF
      EXIT
   ENDDO
   RESTORE SCREEN FROM AAA
   IF LASTKEY()=83.OR.LASTKEY()=115
      EXIT
   ENDIF
   LOOP
ENDDO
SAVE SCREEN TO ROMINA
SET COLOR TO W+/B
@18,20 TO 20,60 DOUBLE
@19,21 CLEAR TO 19,59
@19,26 SAY 'Por pantalla o impresora (P/I)'
SET COLOR TO *R+/B
@19,52 SAY 'P'
@19,54 SAY 'I'
SET COLOR TO W+/B
DO WHILE .T.
   INKEY(0)
   IF LASTKEY()=27
      RETURN
   ENDIF
   IF LASTKEY()<>80.AND.LASTKEY()<>112.AND.LASTKEY()<>73.AND.LASTKEY()<>105
      TONE(1200,2)
      LOOP
   ENDIF
   EXIT
ENDDO
IF LASTKEY()=73.OR.LASTKEY()=105
   SET COLOR TO R/B
   @19,52 SAY 'P'
   SET COLOR TO *R+/B
   @19,54 SAY 'I'
   DO PRNEST
   RETURN
ENDIF
SET COLOR TO BG/B
@8,0 TO 23,79
@9,1 CLEAR TO 22,78
@10,1 TO 10,78
@9,1 SAY ' Fechas ³  Mov.  ³                  Detalles                ³ $ Deb. ³ $ Cre. '
SET COLOR TO
STORE 11 TO LINEA
STORE 21 TO FINLIN
STORE 0 TO TOTDEB,TOTHAB
DO WHILE .T.
   IF EOF()
      SET COLOR TO BG/B
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
         SET COLOR TO BG/B
         @LINEA,28 SAY VDETCUO
         SET COLOR TO W+/B
         @LINEA,63 SAY VICUO*(-1) PICTURE '9999.99'
         LINEA=LINEA+1
         SET COLOR TO BG/B
         @LINEA,28 SAY 'PAGO TARJETA ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'
         SET COLOR TO W+/B
         @LINEA,63 SAY VITAR*(-1) PICTURE '9999.99'
         LINEA=LINEA+1
         SET COLOR TO BG/B
         @LINEA,28 SAY 'GASTOS GENERALES ÄÄÄÄÄÄÄÄÄÄÄÄÄ>'
         SET COLOR TO W+/B
         @LINEA,63 SAY VIGG*(-1) PICTURE '9999.99'
      ELSE
         SET COLOR TO BG/B
         @LINEA,28 SAY 'PAGO TARJETA ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'
         SET COLOR TO W+/B
         @LINEA,63 SAY VITAR*(-1) PICTURE '9999.99'
         LINEA=LINEA+1
         SET COLOR TO BG/B
         @LINEA,28 SAY 'GASTOS GENERALES ÄÄÄÄÄÄÄÄÄÄÄÄÄ>'
         SET COLOR TO W+/B
         @LINEA,63 SAY VIGG*(-1) PICTURE '9999.99'
      ENDIF
      LINEA=LINEA+1
      SET COLOR TO BG/B
      @LINEA,28 SAY 'SALDO POTENCIAL ÄÄÄÄÄ>'
      SALDO_P=TOTHAB-TOTDEB-VICUO-VITAR-VIGG
      GO TOP
      SUM IMPORTE,TER_IMP TO ID1,ID2 FOR DEPOSITO='#'
      GO TOP
      SUM IMPORTE TO IC1 FOR CHEQUE='#'
      SALDO_R=ID1+ID2-IC1-VICUO-VITAR-VIGG
      IF SALDO_P<0
         SET COLOR TO *R+/B
         @LINEA,51 SAY 'NEGATIVO'
         SET COLOR TO W+/B
         @LINEA,62 SAY SALDO_P PICTURE '99999.99'
      ELSE
         SET COLOR TO *G+/B
         @LINEA,51 SAY 'POSITIVO'
         SET COLOR TO W+/B
         @LINEA,71 SAY SALDO_P PICTURE '99999.99'
      ENDIF
      LINEA=LINEA+1
      SET COLOR TO BG/B
      @LINEA,28 SAY 'SALDO REAL ÄÄÄÄÄÄÄÄÄÄ>'
      IF SALDO_R<0
         SET COLOR TO *R+/B
         @LINEA,51 SAY 'NEGATIVO'
         SET COLOR TO W+/B
         @LINEA,62 SAY SALDO_R PICTURE '99999.99'
      ELSE
         SET COLOR TO *G+/B
         @LINEA,51 SAY 'POSITIVO'
         SET COLOR TO W+/B
         @LINEA,71 SAY SALDO_R PICTURE '99999.99'
      ENDIF
      @24,0 CLEAR TO 24,79
      SET COLOR TO BG/B
      @24,1 SAY '  Debitado/Acreditado -   Pendiente'
      SET COLOR TO W/B
      @24,25 SAY '$'
      SET COLOR TO W+/B
      @24,1 SAY '$'
      SET COLOR TO *R+/B
      @24,45 SAY 'Fin del fichero'
      SET COLOR TO W+/B
      @24,62 SAY 'Pulse <ENTER>'
      SET COLOR TO BG+/B
      @24,69 SAY 'ENTER'
      SET COLOR TO
      DO WHILE .T.
         INKEY(0)
         IF LASTKEY()<>13
            TONE(1200,1)
            LOOP
         ENDIF
         EXIT
      ENDDO
      RETURN
   ENDIF
   SET COLOR TO W+/B
   @LINEA,1 SAY FECHA
   SET COLOR TO BG/B
   @LINEA,9 SAY '³'
   SET COLOR TO W+/B
   IF CATEGORIA='C'
      CATEG=' CHEQUE '
   ELSE
      CATEG='DEPOSITO'
   ENDIF
   @LINEA,10 SAY CATEG
   SET COLOR TO BG/B
   @LINEA,18 SAY '³'
   SET COLOR TO W+/B
   IF CATEGORIA='C'
      @LINEA,19 SAY 'N§: '+ALLTRIM(NUMCHEQUE)+' - VTO: '+DTOC(F_VTO)
   ELSE
      IF IMPORTE<>0
         @LINEA,19 SAY 'EFECTIVO'
      ELSE
         @LINEA,19 SAY 'CH N§: '+ALLTRIM(TER_NUM)+' - '+LEFT(ALLTRIM(TER_BAN),15)
      ENDIF
   ENDIF
   SET COLOR TO BG/B
   @LINEA,61 SAY '³'
   @LINEA,70 SAY '³'
   SET COLOR TO W+/B
   IF CATEGORIA='C'
      IF CHEQUE='#'
         SET COLOR TO W+/B
      ELSE
         SET COLOR TO W/B
      ENDIF
      @LINEA,62 SAY IMPORTE PICTURE '99999.99'
      TOTDEB=TOTDEB+IMPORTE
   ELSE
      IF IMPORTE<>0
         IF DEPOSITO='#'
            SET COLOR TO W+/B
         ELSE
            SET COLOR TO W/B
         ENDIF
         @LINEA,71 SAY IMPORTE PICTURE '99999.99'
         TOTHAB=TOTHAB+IMPORTE
      ELSE
         IF DEPOSITO='#'
            SET COLOR TO W+/B
         ELSE
            SET COLOR TO W/B
         ENDIF
         @LINEA,71 SAY TER_IMP PICTURE '99999.99'
         TOTHAB=TOTHAB+TER_IMP
      ENDIF
   ENDIF
   SET COLOR TO W+/B
   LINEA=LINEA+1
   SKIP
   IF EOF().AND.LINEA>=21
      STORE LINEA TO FINLIN
   ELSE
      STORE 23 TO FINLIN
   ENDIF
   IF LINEA>=FINLIN
      @24,0 CLEAR TO 24,79
      SET COLOR TO BG/B
      @24,1 SAY '  Debitado/Acreditado -   Pendiente'
      SET COLOR TO W/B
      @24,25 SAY '$'
      SET COLOR TO W+/B
      @24,1 SAY '$'
      @24,42 SAY '<ENTER> Continuar    <ESC> Cancelar'
      SET COLOR TO BG+/B
      @24,43 SAY 'ENTER'
      @24,64 SAY 'ESC'
      DO WHILE .T.
         INKEY(0)
         IF LASTKEY()<>13.AND.LASTKEY()<>27
            TONE(1200,1)
            LOOP
         ENDIF
         EXIT
      ENDDO
      IF LASTKEY()=27
         RETURN
      ENDIF
      SET COLOR TO BG/B
      @24,0 CLEAR TO 24,79
      @9,1 CLEAR TO 22,78
      @9,1 SAY ' Fechas ³  Mov.  ³                  Detalles                ³Imp. De.³Imp. Ac.'
      @10,1 TO 10,78
      STORE 11 TO LINEA
   ENDIF
   LOOP
ENDDO

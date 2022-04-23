

         DO WHILE .T.
            INKEY(0)
            IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
               TONE(500,1)
               LOOP
            ENDIF

            EXIT
         ENDDO

         RESTORE SCREEN FROM CODIGSCR
         IF LASTKEY()=83.OR.LASTKEY()=115
            IF HAY=0
               APPEND BLANK
            ENDIF

            VCANT=VCANT*1000
            REPLACE CODIGO WITH VCODIGO,DETALLE WITH VDETALLE,PUBLICO WITH VPUBLICO
            REPLACE COSTO WITH VCOSTO,CANTIDAD WITH VCANT,LIMITE WITH VLIMI
            VCANT=VCANT/1000
         ELSE
            STORE 0 TO SINO
            RETURN SINO
            *LOOP
         ENDIF
      STORE CANTIDAD-STOCKTEMP TO STACTUAL

   SET COLOR TO B/W

   @LINEA,1 SAY VCANT PICTURE '9999.99'
   @LINEA,72 SAY VSUBTOT PICTURE '99999.99'
   SET COLOR TO RG+/B
   @22,72 SAY VTOTAL PICTURE '99999.99'
   SET COLOR TO W+/B
   LINEA=LINEA+1

STORE 1 TO SINO
RETURN SINO

PROCEDURE FINVTA
            @24,18
            SET CURSOR OFF
            SET WRAP ON
            SET COLOR TO W+/B,B/W
            @24,20 SAY 'Elija forma de pago Ä>'
            @24,43 PROMPT 'CONTADO'
            @24,53 PROMPT 'CTA CTE'
            MENU TO ELIGE
            SET COLOR TO W+/B,B/W
            DO CASE
               CASE ELIGE=1
                  FORMA='CDO'
               CASE ELIGE=2
                  FORMA='CCT'
               OTHERWISE
                  FORMA='CDO'
            ENDCASE
            SET CURSOR OFF
            SET COLOR TO *RG+/B
            @24,28  SAY '...UN MOMENTO POR FAVOR...'
            SET COLOR TO W+/B
            IF VIVA='RI'
               STORE NUMFA TO NUM_FACT
            ELSE
               STORE NUMFB TO NUM_FACT
            ENDIF

            STORE 'COMPRA - FACTURA N§ '+ALLTRIM(STR(NUM_FACT)) TO VDESC
            IF FORMA='CCT'
               USE CTASCTES
               APPEND BLANK
               REPLACE FECHA WITH DATE(),NOMBRE WITH VNOMBRE,DOMICILIO WITH VDOMI
               REPLACE TELEFONO WITH VTELE,DNI WITH VDOCU,CUIT WITH VCUIT
               REPLACE SITUIVA WITH VIVA,DEBE WITH VTOTAL,DESCRIP WITH VDESC
               GO TOP
               SUM DEBE,HABER TO TTDEBE,TTHABER FOR DNI=VDOCU
               SALDO=TTHABER-TTDEBE
               GO TOP
               USE CLIENTES
               INDEX ON DNI TO ORDDOCU
               GO TOP
               SEEK VDOCU
               REPLACE SUSALDO WITH SALDO
            ENDIF

            USE STOCK
            COUNT TO HAS ALL FOR STOCKTEMP<>0
            INDEX ON STOCKTEMP TO ORDTEMP
            GO BOTTOM
            SKIP -(HAS-1)
            FOR HH=1 TO HAS
               STORE CANTIDAD-STOCKTEMP TO ST
               REPLACE CANTIDAD WITH ST, STOCKTEMP WITH 0
               SKIP
            NEXT
            IF VIVA='RI'
               USE FACT_A
               APPEND FROM VTASTMP
               USE NFA
               GO TOP
               REPLACE NUMERO WITH NUMFA
            ELSE
               USE FACT_B
               APPEND FROM VTASTMP
               USE NFB
               GO TOP
               REPLACE NUMERO WITH NUMFB
            ENDIF

            @24,0
            SET CURSOR OFF
            SET COLOR TO W+/B
            @24,28  SAY '¨ Imprimir Factura (S/N) ?'
            SET COLOR TO *R+/B
            @24,48  SAY 'S'
            @24,50  SAY 'N'
            SET COLOR TO W+/B
            TONE(1200,1)
            DO WHILE .T.
               INKEY(0)
               IF LASTKEY()<>83.AND.LASTKEY()<>115.AND.LASTKEY()<>78.AND.LASTKEY()<>110
                  TONE(1200,1)
                  LOOP
               ENDIF

               EXIT
            ENDDO
            @24,0
            IF LASTKEY()=83.OR.LASTKEY()=115
               DO PRNFACTU
            ENDIF

            STORE 7 TO LINEA
            STORE 0 TO VTOTAL
            USE VTASTMP
            ZAP
   *         RETURN
RETURN


















FUNCTION NOESVAR
         SET CURSOR OFF
         SET COLOR TO W+/B
         @11,30 TO 13,53
         SET COLOR TO *R+/B
         @12,32 SAY 'MERCADERIA SIN STOCK'
         SET COLOR TO W+/B
         TONE(1200,1)
         INKEY(3)
         SET COLOR TO W+/B
         CLEAR
         PASO=0
         STORE 0 TO VCANT,VLIMI
         @0,0 TO 2,32
         SET COLOR TO W+/B
         @1,2 SAY 'CENTRO COMERCIAL DEL PLASTICO'
         numero=LEFT(DTOC(DATE()),2)
         DIA=TDIAS(cdow(DATE()))
         MES=TMES(CMONTH(DATE()))
         ANIO=ALLTRIM(STR(YEAR(DATE())))
         VFECHA=DIA+' '+numero+' de '+MES+' de '+ANIO
         LL=79-LEN(VFECHA)
         @1,LL-7 SAY 'Fecha: '
         SET COLOR TO BG+/B
         @1,LL SAY VFECHA
         SET CURSOR ON
         SET COLOR TO BG/B
         @6,0 SAY REPLICATE('Ä',79)
         SET CONFIRM OFF
         @7,1 SAY 'Detalle:'
         @9,1 SAY 'Precio de Venta:'
         @11,1 SAY 'Stock actual:'
         @13,1 SAY 'Cantidad a reponer:'
         @15,1 SAY 'L¡mite de reposicion:'
         SET COLOR TO W+/B
         @7,10 SAY VDETALLE
         @9,18 SAY VPUBLICO
         SET COLOR TO *RG+/B
         @11,15 SAY '0' PICTURE '99999.99'
         SET COLOR TO BG/B
         @8,0 SAY REPLICATE('Ä',79)
         @10,0 SAY REPLICATE('Ä',79)
         @12,0 SAY REPLICATE('Ä',79)
         @14,0 SAY REPLICATE('Ä',79)
         @16,0 SAY REPLICATE('Ä',79)
         SET COLOR TO W+/B,B/W
         @13,20 SAY ''GET VCANT PICTURE '9999.99'
         @15,22 SAY ''GET VLIMI PICTURE '99999.99'
         READ
         IF LASTKEY()=27.OR.VCANT=0
            RETURN
         ENDIF

         SET CURSOR OFF
         SET COLOR TO W+/B
         @23,25 SAY '¨ Grabar este ingreso (S/N) ?'
         SET COLOR TO *R+/B
         @23,48 SAY 'S'
         @23,50 SAY 'N'
         SET COLOR TO W+/B
         DO WHILE .T.
            INKEY(0)
            IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
               TONE(500,1)
               LOOP
            ENDIF

            EXIT
         ENDDO
         RESTORE SCREEN FROM CODIGSCR
         IF LASTKEY()=83.OR.LASTKEY()=115
            IF HAY=0
               APPEND BLANK
            ENDIF

            VCANT=VCANT*1000
            REPLACE CODIGO WITH VCODIGO,DETALLE WITH VDETALLE,PUBLICO WITH VPUBLICO
            REPLACE COSTO WITH VCOSTO,CANTIDAD WITH VCANT,LIMITE WITH VLIMI
            VCANT=VCANT/1000
         ELSE
            STORE 0 TO SINO
            RETURN SINO
            *LOOP
         ENDIF
      STORE CANTIDAD-STOCKTEMP TO STACTUAL

   SET COLOR TO B/W

   @LINEA,1 SAY VCANT PICTURE '9999.99'
   @LINEA,72 SAY VSUBTOT PICTURE '99999.99'
   SET COLOR TO RG+/B
   @22,72 SAY VTOTAL PICTURE '99999.99'
   SET COLOR TO W+/B
   LINEA=LINEA+1

STORE 1 TO SINO
RETURN SINO

PROCEDURE ESVAR
      SAVE SCREEN TO MARIELA
      STORE SPACE(60) TO VDETALLE
      STORE 0 TO VPUBLICO,STACTUAL
      SET COLOR TO BG+/B
      SET CURSOR ON
      @11,0 SAY REPLICATE('Ä',79)
      @13,0 SAY REPLICATE('Ä',79)
      @15,0 SAY REPLICATE('Ä',79)
      @17,0 SAY REPLICATE('Ä',79)
      SET COLOR TO W+/B,B/W
      @12,5 SAY 'Detalle:'GET VDETALLE PICTURE '@!K'
      @16,5 SAY 'Precio  P£blico:'GET VPUBLICO PICTURE '99999.99'
      READ
      SET COLOR TO W+/B
      SET CURSOR OFF
      RESTORE SCREEN FROM MARIELA
   @LINEA,0 SAY ''GET VCANT PICTURE '9999.99'
   SET COLOR TO B/W
   @LINEA,1 SAY VCANT PICTURE '9999.99'
   SET COLOR TO W+/B
   STORE VCANT*VPUBLICO TO VSUBTOT
   SET COLOR TO BG+/B
   @LINEA,72 SAY VSUBTOT PICTURE '99999.99'
   STORE VTOTAL+VSUBTOT TO VTOTAL
   SET COLOR TO RG+/B
   @22,72 SAY VTOTAL PICTURE '99999.99'
   SET COLOR TO W+/B
   LINEA=LINEA+1
STORE 1 TO SINO
RETURN


FUNCTION DB_MERC
   SAVE SCREEN TO CODIGSCR
   USE MERCA INDEX ORDDET
   GO TOP
   SAVE SCREEN TO JERI
   SET COLOR TO BG/B
   @8,0 TO 23,79
   @9,1 CLEAR TO 22,78
   @21,1 TO 21,78
   @19,1 TO 19,78
   @20,1 CLEAR TO 20,78
   @22,1 CLEAR TO 22,78
   SET COLOR TO W+/B
   @22,11 SAY '        Tomar'
   @22,58 SAY '      Salir'
   SET COLOR TO BG+/B
   @20,28 SAY 'Fichero de Art¡culos'
   @22,11 SAY '<ENTER>'
   @22,58 SAY '<ESC>'
   DECLARE CAMP[2]
   CAMP[1]='DETALLE'
   CAMP[2]='PUBLICO'
   DECLARE CABEZ[2]
   CABEZ[1]='                       Detalle'
   CABEZ[2]='Precios'
   DECLARE SEPAR[2]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   DBEDIT(9,1,18,78,CAMP,'FUNALE','',CABEZ,SEPAR)
   RESTORE SCREEN FROM CODIGSCR

   IF LASTKEY()=27
      STORE 0 TO ST_DB
      STORE 0 TO VCANT
      STORE 0 TO VPUBLICO
      STORE SPACE(30) TO VDET
      STORE 0 TO SINO
      *LOOP
      RETURN
   ENDIF

   IF ALLTRIM(DETALLE)='VARIOS'
      ESVARIOS=1
   ELSE
      ESVARIOS=0
   ENDIF

*   STORE COSTO TO VCOSTO
   STORE DETALLE TO VDETALLE
   STORE PUBLICO TO VPUBLICO
   STORE CODIGO TO VCODIGO
         
STORE 1 TO SINO
RETURN NIL


PROCEDURE NEW_ITEM
STORE 0 TO VCANT
STORE 0 TO VPUBLICO
    SAVE SCREEN TO CODIGSCR
    DO WHILE .T.
        STORE 0 TO VPUBLICO
        STORE 0 TO VCANT
        SET CURSOR ON
        SET COLOR TO BG+/B
*        @16,4 SAY ''GET VCANT PICTURE '9999.99'
        @20,5 SAY 'Precio  P£blico:'GET VPUBLICO PICTURE '99999.99'
        READ
        IF LASTKEY()=27
            STORE 0 TO SINO
            RETURN
            STORE SPACE(30) TO VDET
        ENDIF
          STORE 1 TO SINO
        EXIT
    ENDDO

STORE VDET TO VDETALLE
STORE 1523 TO VCODIGO

* VARIOS VUELE ( ACA ) DENTRO DE ESTE DO WHILE
*         IF VCANT=0
*            TONE(1200,1)
*            LOOP
*            *EXIT
*         ENDIF
RETURN

FUNCTION VARSINO
   IF ESVARIOS=0
      STORE 0 TO VVAR1
      REPLACE STOCKTEMP WITH STOCKTEMP+VCANT
   ENDIF
VSUBTOT=VCANT*VPUBLICO
STORE 1 TO VVAR1
RETURN VVAR


PROCEDURE ITEMLIST
   @LINEA,9 SAY LEFT(VDETALLE,47)
   @LINEA,62 SAY VPUBLICO PICTURE '99999.99'
   SET COLOR TO BG+/B
   @24,29 SAY LEFT(VDETALLE,33)
   @24,72 SAY STACTUAL PICTURE '99999.99'
   SET COLOR TO W+/B
   SET COLOR TO BG/B
   @LINEA,8 SAY '³'
   @LINEA,61 SAY '³'
   @LINEA,70 SAY '³'
   SET COLOR TO W+/B
      DO WHILE .T.
         STORE 0 TO VCANT
         SET CURSOR ON
         SET COLOR TO W+/B,B/W
         @LINEA,0 SAY ''GET VCANT PICTURE '9999.99'
         READ
         IF LASTKEY()=27
            RESTORE SCREEN FROM CODIGSCR
            RETURN
         ENDIF
         IF VCANT=0
            TONE(1200,1)
            LOOP
         ENDIF
         EXIT
      ENDDO

   SET COLOR TO B/W
   STORE VCANT*VPUBLICO TO VSUBTOT
   @LINEA,1 SAY VCANT PICTURE '9999.99'
   SET COLOR TO BG+/B
   @LINEA,72 SAY VSUBTOT PICTURE '99999.99'
   STORE VTOTAL+VSUBTOT TO VTOTAL
   SET COLOR TO RG+/B
   @22,72 SAY VTOTAL PICTURE '99999.99'
   SET COLOR TO W+/B
   LINEA=LINEA+1

VSUBTOT=VCANT*VPUBLICO
   USE VTASTMP
   APPEND BLANK
   IF VIVA='RI'
      STORE NUMFA TO NUM_FACT
   ELSE
      STORE NUMFB TO NUM_FACT
   ENDIF

   VCANT=VCANT*1000
   REPLACE NUMERO WITH NUM_FACT,FECHA WITH DATE(),CLIENTE WITH VNOMBRE
   REPLACE DOMICILIO WITH VDOMI,TELEFONO WITH VTELE,DNI WITH VDOCU
   REPLACE NCUIT WITH VCUIT,SITUIVA WITH VIVA,CODIGO WITH VCODIGO
   REPLACE DETALLE WITH VDETALLE,CANTIDAD WITH VCANT,PRECIO WITH VPUBLICO
   REPLACE TOTAL WITH VSUBTOT
   VCANT=VCANT/1000
   IF LINEA>=17
      KEYBOARD CHR(27)
   ENDIF
RETURN


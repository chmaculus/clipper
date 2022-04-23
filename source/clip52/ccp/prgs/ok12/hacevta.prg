PUBLIC CODIGSCR
PUBLIC ESVARIOS
PUBLIC LINEA
PUBLIC STACTUAL
PUBLIC SINO
PUBLIC VCANT
PUBLIC VCOSTO
PUBLIC VCODIGO
PUBLIC VDETALLE
PUBLIC VPUBLICO
PUBLIC VSUBTOT
PUBLIC VVAR
PUBLIC VDET

USE VTASTMP
ZAP

CLEAR
SET KEY -2 TO BORRALIN
SET COLOR TO W+/B
@1,0 SAY 'CENTRO COMERCIAL DEL PLASTICO'
*NUMDIA=LEFT(DTOC(DATE()),2)
DIA=TDIAS(cdow(DATE()))
MES=TMES(CMONTH(DATE()))
ANIO=ALLTRIM(STR(YEAR(DATE())))
VFECHA=DIA+' '+NUMDIA+' de '+MES+' de '+ANIO
LL=79-LEN(VFECHA)
@1,LL SAY VFECHA
SET COLOR TO BG/B
@2,0 SAY REPLICATE('Ä',29)
@2,LL SAY REPLICATE('Ä',LEN(VFECHA))
@0,34 TO 2,43
SET COLOR TO *W+/B
@1,36 SAY 'VENTAS'
SET COLOR TO BG/B
@5,0 SAY '  Cant.                       Detalle                         P.Unit.   P.Total'
@5,8 SAY '³'
@5,61 SAY '³'
@5,70 SAY '³'
@4,0 SAY REPLICATE('Ä',79)
@6,0 SAY REPLICATE('Ä',79)
STORE 7 TO LINEA
STORE 0 TO VTOTAL
@21,0 SAY REPLICATE('Ä',79)
SET COLOR TO W+/B
@22,26 SAY 'Borra rengl¢n  ³'
@22,48 SAY 'TOTAL VENTA'
@23,0 SAY REPLICATE('Ä',79)
@22,2 SAY '<ESC> Sale/Guarda'
@3,1 SAY 'Cliente:                                                CUIT:'
SET COLOR TO BG+/B
@3,10 SAY LEFT(VNOMBRE,45)
IF VCUIT=0
   @3,63 SAY '  -        - '
ELSE
   @3,63 SAY VCUIT PICTURE '99-99999999-9'
ENDIF
@22,21 SAY '<F3>'
@22,2 SAY '<ESC>'
SET COLOR TO RG+/B
@24,1 SAY CARTEL
SET COLOR TO W+/B
SAVE SCREEN TO INICIO






*****************************************************
DO WHILE .T.
   SET COLOR TO BG+/B
   @24,17 SAY '³'
   @24,63 SAY '³'
   SET COLOR TO W+/B
   SET CURSOR ON
   SET COLOR TO W+/B,B/W
   IF LASTKEY()=27
      IF LINEA>7
         @24,18
         SET CURSOR OFF
         SET COLOR TO W+/B
         @24,27  SAY '¨ Est  todo correcto (S/N) ?'
         SET COLOR TO *R+/B
         @24,49  SAY 'S'
         @24,51  SAY 'N'
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
      ENDIF
      SET KEY -2 TO
      RETURN
   ENDIF
     DO NEW_ITEM
     EXIT
ENDDO
DO FINVTA

PROCEDURE BORRALIN
SAVE SCREEN TO TATYANA
STORE 1 TO AGAST
SET COLOR TO W+/B
@16,0 TO 23,79
@24,0 CLEAR TO 24,79
@24,31 SAY '<ENTER> para borrar'
SET COLOR TO BG+/B
@24,31 SAY '<ENTER>'
SET COLOR TO W+/B
USE VTASTMP
GO TOP
DECLARE CAMP[4]
CAMP[1]='CANTIDAD'
CAMP[2]='DETALLE'
CAMP[3]='PRECIO'
CAMP[4]='TOTAL'
DECLARE CABEZ[4]
CABEZ[1]='Cant'
CABEZ[2]='         Detalle'
CABEZ[3]='Precio'
CABEZ[4]='SubTot'
DECLARE SEPAR[4]
SEPAR[1]='Ä'
SEPAR[2]='Ä'
SEPAR[3]='Ä'
SEPAR[4]='Ä'
SET CURSOR OFF
CLEAR TYPEAHEAD
SET COLOR TO BG/B,B/W
DBEDIT(17,1,22,78,CAMP,'','',CABEZ,SEPAR)
RESTORE SCREEN FROM TATYANA
SET COLOR TO W+/B
IF LASTKEY()=13
   STORE LINEA-1 TO LINEA
   STORE RECNO() TO NUMLIN
   STORE TOTAL TO VSUB
   STORE CODIGO TO VCODIGO
   DELETE
   PACK
   STORE LASTREC() TO CUANTOS
   GO TOP
   @7,0 CLEAR TO 20,79
   STORE 0 TO VTOTAL
   FOR FGH=1 TO CUANTOS
      SET COLOR TO B/W
      @6+FGH,1 SAY CANTIDAD PICTURE '99999.99'
      SET COLOR TO W+/B
      @6+FGH,9 SAY LEFT(DETALLE,47)
      @6+FGH,62 SAY PRECIO PICTURE '99999.99'
      SET COLOR TO BG+/B
      @6+FGH,72 SAY TOTAL PICTURE '99999.99'
      SET COLOR TO BG/B
      @6+FGH,8 SAY '³'
      @6+FGH,61 SAY '³'
      @6+FGH,70 SAY '³'
      SET COLOR TO W+/B
      STORE VTOTAL+TOTAL TO VTOTAL
      REPLACE TOTAL WITH VTOTAL
      SKIP
   NEXT
   SET COLOR TO W+/B
   @22,72 CLEAR TO 22,79
   SET COLOR TO RG+/B
   @22,72 SAY VTOTAL PICTURE '99999.99'
   SET COLOR TO W+/B
   USE STOCK
   INDEX ON CODIGO TO ORDCOD
   GO TOP
   SEEK VCODIGO
   REPLACE STOCKTEMP WITH 0
ENDIF
SET CURSOR ON
RETURN


FUNCTION FUNALE
PARAMETERS MODE
PUBLIC INTER
DO CASE
    CASE MODE=3
        TONE(500,2)
        SET COLOR TO W+/B
        @13,29 TO 15,48
        @14,30 CLEAR TO 14,47
        SET COLOR TO *R+/B
        @14,31 SAY 'NO EXISTEN DATOS'
        SET COLOR TO W+/B
        INKEY(3)
        RETURN(0)
    CASE MODE=1
        TONE(500,2)
        RETURN(1)
    CASE MODE=2
        TONE(500,2)
        RETURN(1)
    CASE MODE=0
        RETURN(1)
    CASE LASTKEY()=13
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=27
        STORE '' TO KK
        RETURN(0)
    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO B+/B
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO
           GO TOP
           RETURN(1)
        ENDIF

        SET CURSOR OFF
        SET COLOR TO B+/B
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+UPPER(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO W+/B
        GO TOP
        SEEK KK
        IF .NOT. FOUND()
            STORE '' TO KK
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
ENDCASE
        RETURN(1)

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
RETURN

PROCEDURE NEW_ITEM
STORE 0 TO VCODIGO
STORE 7 TO LINEA
SAVE SCREEN TO CODIGSCR
DO WHILE .T.
  IF LASTKEY()=27
   EXIT
   ELSE
    STORE 0 TO VCANT
    STORE 0 TO VPUBLICO
    STORE SPACE(30) TO VDET
    @LINEA,0 SAY ''GET VCANT PICTURE '99999.99'
    @LINEA,10 SAY ''GET VDET PICTURE '@!K'
    @LINEA,61 SAY ''GET VPUBLICO PICTURE '99999.99'
 ENDIF
    read
    STORE VCANT*VPUBLICO TO VSUBTOT
    SET COLOR TO BG+/B
    @LINEA,72 SAY VSUBTOT PICTURE '99999.99'
    STORE VTOTAL+VSUBTOT TO VTOTAL
    SET COLOR TO RG+/B
    @22,72 SAY VTOTAL PICTURE '99999.99'
    SET COLOR TO W+/B
 IF VCANT=0
 ELSE
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
    REPLACE DETALLE WITH VDET,CANTIDAD WITH VCANT,PRECIO WITH VPUBLICO
    REPLACE TOTAL WITH VSUBTOT
    VCANT=VCANT/1000
LINEA=LINEA+1
 ENDIF
LOOP
ENDDO
RETURN


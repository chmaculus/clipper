CLEAR
SET KEY -2 TO BORRALIN
SET COLOR TO W+/B
@1,0 SAY 'CENTRO COMERCIAL DEL PLASTICO'
NUMDIA=LEFT(DTOC(DATE()),2)
DIA=TDIAS(cdow(DATE()))
MES=TMES(CMONTH(DATE()))
ANIO=ALLTRIM(STR(YEAR(DATE())))
VFECHA=DIA+' '+NUMDIA+' de '+MES+' de '+ANIO
LL=79-LEN(VFECHA)
@1,LL SAY VFECHA
SET COLOR TO BG/B
@2,0 SAY REPLICATE('�',29)
@2,LL SAY REPLICATE('�',LEN(VFECHA))
@0,34 TO 2,43
SET COLOR TO *W+/B
@1,36 SAY 'FACTURAR REMITOS'
SET COLOR TO BG/B
@5,0 SAY 'Cant.                         Detalle                         P.Unit.   P.Total'
@5,7 SAY '�'
@5,61 SAY '�'
@5,70 SAY '�'
@4,0 SAY REPLICATE('�',79)
@6,0 SAY REPLICATE('�',79)
STORE 7 TO LINEA
STORE 0 TO VTOTAL
@21,0 SAY REPLICATE('�',79)
SET COLOR TO W+/B
@22,26 SAY 'Borra rengl�n  �'
@22,48 SAY 'TOTAL VENTA'
@23,0 SAY REPLICATE('�',79)
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
@24,1 SAY 'FACT REMITOS'
SET COLOR TO W+/B
SAVE SCREEN TO INICIO

DO WHILE .T.
   SET COLOR TO BG+/B
   @24,17 SAY '�'
   @24,65 SAY '�'
   SET COLOR TO W+/B
   @24,19 SAY 'Art�culo:'
   @24,67 SAY 'Stock:'
   STORE SPACE(35) TO VDET
   SET CURSOR ON
   SET COLOR TO W+/B,B/W
   @24,28 SAY ''GET VDET PICTURE '@!'
   READ
   IF LASTKEY()=27
      IF LINEA>7
         @24,18
         SET CURSOR OFF
         SET COLOR TO W+/B
         @24,27  SAY '� Est� todo correcto (S/N) ?'
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
         IF LASTKEY()=83.OR.LASTKEY()=115
            @24,18
            SET CURSOR OFF
            SET WRAP ON
            SET COLOR TO W+/B,B/W
            @24,20 SAY 'Elija forma de pago �>'
            @24,43 PROMPT 'CONTADO'
            @24,53 PROMPT 'CTA CTE'
            MENU TO ELIGE
            SET COLOR TO W+/B,B/W
            DO CASE
               CASE ELIGE=1
                  SUPAGO=0
               CASE ELIGE=2
                  SUPAGO=0
                  @24,18
                  SET CURSOR ON
                  SET COLOR TO W+/B,B/W
                  @24,27 SAY 'Ingrese entrega:'GET SUPAGO PICTURE '9999.99'
                  READ
                  SET CURSOR OFF
                  SET COLOR TO W+/B
                  @24,18
               OTHERWISE
                  SUPAGO=0
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
            STORE 'COMPRA - FACTURA N� '+ALLTRIM(STR(NUM_FACT)) TO VDESC
            USE CTASCTES
            APPEND BLANK
            REPLACE FECHA WITH DATE(),NOMBRE WITH VNOMBRE,DOMICILIO WITH VDOMI
            REPLACE TELEFONO WITH VTELE,DNI WITH VDOCU,CUIT WITH VCUIT
            REPLACE SITUIVA WITH VIVA,DEBE WITH VTOTAL,DESCRIP WITH VDESC
            IF SUPAGO<>0
               APPEND BLANK
               REPLACE FECHA WITH DATE(),NOMBRE WITH VNOMBRE,DOMICILIO WITH VDOMI
               REPLACE TELEFONO WITH VTELE,DNI WITH VDOCU,CUIT WITH VCUIT
               REPLACE SITUIVA WITH VIVA,HABER WITH SUPAGO,DESCRIP WITH 'SU ENTREGA'
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
            @24,28  SAY '� Imprimir Factura (S/N) ?'
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
            RETURN
         ENDIF
         STORE 7 TO LINEA
         STORE 0 TO VTOTAL
         USE STOCK
         REPLACE ALL STOCKTEMP WITH 0
         USE VTASTMP
         ZAP
         RESTORE SCREEN FROM INICIO
         LOOP
      ENDIF
      SET KEY -2 TO
      RETURN
   ENDIF
   SAVE SCREEN TO CODIGSCR
   USE MERCA
   INDEX ON DETALLE TO ORDDET
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
   @20,28 SAY 'Fichero de Art�culos'
   @22,11 SAY '<ENTER>'
   @22,58 SAY '<ESC>'
   DECLARE CAMP[2]
   CAMP[1]='DETALLE'
   CAMP[2]='PUBLICO'
   DECLARE CABEZ[2]
   CABEZ[1]='                       Detalle'
   CABEZ[2]='Precios'
   DECLARE SEPAR[2]
   SEPAR[1]='�'
   SEPAR[2]='�'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   DBEDIT(9,1,18,78,CAMP,'FUNMOD','',CABEZ,SEPAR)
   RESTORE SCREEN FROM CODIGSCR
   IF LASTKEY()=27
      LOOP
   ENDIF
   STORE CODIGO TO VCODIGO
   STORE DETALLE TO VDETALLE
   STORE PUBLICO TO VPUBLICO
   STORE COSTO TO VCOSTO
   USE STOCK
   INDEX ON CODIGO TO ORDCODIG
   GO TOP
   SEEK VCODIGO
   IF EOF().OR.CANTIDAD=0
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
      @6,0 SAY REPLICATE('�',79)
      SET CONFIRM OFF
      @7,1 SAY 'Detalle:'
      @9,1 SAY 'Precio de Venta:'
      @11,1 SAY 'Stock actual:'
      @13,1 SAY 'Cantidad a reponer:'
      @15,1 SAY 'L�mite de reposicion:'
      SET COLOR TO W+/B
      @7,10 SAY VDETALLE
      @9,18 SAY VPUBLICO
      SET COLOR TO *RG+/B
      @11,15 SAY '0' PICTURE '9999.99'
      SET COLOR TO BG/B
      @8,0 SAY REPLICATE('�',79)
      @10,0 SAY REPLICATE('�',79)
      @12,0 SAY REPLICATE('�',79)
      @14,0 SAY REPLICATE('�',79)
      @16,0 SAY REPLICATE('�',79)
      SET COLOR TO W+/B,B/W
      @13,20 SAY ''GET VCANT PICTURE '9999.99'
      @15,22 SAY ''GET VLIMI PICTURE '9999.99'
      READ
      IF LASTKEY()=27.OR.VCANT=0
         RETURN
      ENDIF
      SET CURSOR OFF
      SET COLOR TO W+/B
      @23,25 SAY '� Grabar este ingreso (S/N) ?'
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
         REPLACE CODIGO WITH VCODIGO,DETALLE WITH VDETALLE,PUBLICO WITH VPUBLICO
         REPLACE COSTO WITH VCOSTO,CANTIDAD WITH VCANT,LIMITE WITH VLIMI
      ELSE
         LOOP
      ENDIF
   ENDIF
   STORE CANTIDAD-STOCKTEMP TO STACTUAL
   SET COLOR TO BG/B
   @LINEA,7 SAY '�'
   @LINEA,61 SAY '�'
   @LINEA,70 SAY '�'
   SET COLOR TO W+/B
   @LINEA,8 SAY LEFT(VDETALLE,48)
   @LINEA,62 SAY VPUBLICO PICTURE '9999.99'
   SET COLOR TO BG+/B
   @24,29 SAY LEFT(VDETALLE,33)
   @24,70 SAY STACTUAL PICTURE '9999.99'
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
      USE STOCK
      INDEX ON CODIGO TO ORDCOD
      GO TOP
      SEEK VCODIGO
      STORE CANTIDAD TO ENSTOCK
      IF ENSTOCK<VCANT
         SET CURSOR OFF
         SAVE SCREEN TO YAMA
         SET COLOR TO W+/B
         @11,20 TO 13,59
         @12,22 SAY 'La cantidad es SUPERIOR al stock'
         SET COLOR TO *R+/B
         @12,37 SAY 'SUPERIOR'
         SET COLOR TO W+/B
         TONE(1200,1)
         INKEY(3)
         RESTORE SCREEN FROM YAMA
         LOOP
      ENDIF
      EXIT
   ENDDO
   STORE VCANT*VPUBLICO TO VSUBTOT
   SET COLOR TO BG+/B
   @LINEA,72 SAY VSUBTOT PICTURE '9999.99'
   STORE VTOTAL+VSUBTOT TO VTOTAL
   SET COLOR TO RG+/B
   @22,72 SAY VTOTAL PICTURE '9999.99'
   SET COLOR TO W+/B
   LINEA=LINEA+1
   REPLACE STOCKTEMP WITH STOCKTEMP+VCANT
   USE VTASTMP
   APPEND BLANK
   IF VIVA='RI'
      STORE NUMFA TO NUM_FACT
   ELSE
      STORE NUMFB TO NUM_FACT
   ENDIF
   REPLACE NUMERO WITH NUM_FACT,FECHA WITH DATE(),CLIENTE WITH VNOMBRE
   REPLACE DOMICILIO WITH VDOMI,TELEFONO WITH VTELE,DNI WITH VDOCU
   REPLACE NCUIT WITH VCUIT,SITUIVA WITH VIVA,CODIGO WITH VCODIGO
   REPLACE DETALLE WITH VDETALLE,CANTIDAD WITH VCANT,PRECIO WITH VPUBLICO
   REPLACE TOTAL WITH VSUBTOT
   LOOP
ENDDO

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
CAMP[4]='SUBTOTAL'
DECLARE CABEZ[4]
CABEZ[1]='Cant'
CABEZ[2]='         Detalle'
CABEZ[3]='Precio'
CABEZ[4]='SubTot'
DECLARE SEPAR[4]
SEPAR[1]='�'
SEPAR[2]='�'
SEPAR[3]='�'
SEPAR[4]='�'
SET CURSOR OFF
CLEAR TYPEAHEAD
SET COLOR TO BG/B,B/W
DBEDIT(17,1,22,78,CAMP,'','',CABEZ,SEPAR)
RESTORE SCREEN FROM TATYANA
SET COLOR TO W+/B
IF LASTKEY()=13
   STORE LINEA-1 TO LINEA
   STORE RECNO() TO NUMLIN
   STORE SUBTOTAL TO VSUB
   STORE CODIGO TO VCODIGO
   DELETE
   PACK
   GO TOP
   STORE LASTREC() TO CUANTOS
   @7,0 CLEAR TO 20,79
   STORE 0 TO VTOTAL
   FOR FGH=1 TO CUANTOS
      SET COLOR TO B/W
      @6+FGH,1 SAY CANTIDAD PICTURE '9999.99'
      SET COLOR TO W+/B
      @6+FGH,8 SAY LEFT(DETALLE,48)
      @6+FGH,62 SAY PRECIO PICTURE '9999.99'
      SET COLOR TO BG+/B
      @6+FGH,72 SAY SUBTOTAL PICTURE '9999.99'
      SET COLOR TO BG/B
      @6+FGH,8 SAY '�'
      @6+FGH,61 SAY '�'
      @6+FGH,70 SAY '�'
      SET COLOR TO W+/B
      STORE VTOTAL+SUBTOTAL TO VTOTAL
      REPLACE TOTAL WITH VTOTAL
      SKIP
   NEXT
   SET COLOR TO W+/B
   @22,72 CLEAR TO 22,79
   SET COLOR TO RG+/B
   @22,72 SAY VTOTAL PICTURE '9999.99'
   SET COLOR TO W+/B
   USE STOCK
   INDEX ON CODIGO TO ORDCOD
   GO TOP
   SEEK VCODIGO
   REPLACE STOCKTEMP WITH 0
ENDIF
SET CURSOR ON
** KEYBOARD CHR(13)
RETURN

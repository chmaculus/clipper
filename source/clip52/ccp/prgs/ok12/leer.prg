***  RUTINA DE LECTURA DE BASES DE UN DISKETTE ***

SET COLOR TO W+/B
CLEAR
SET CURSOR OFF
@3,10 TO 23,69 DOUBLE 
@6,11 to 6,68
@17,11 to 17,68
@4,11 CLEAR to 5,68
@18,11 CLEAR to 22,68
SET COLOR TO BG+/B
@4,30 SAY 'LEER DATOS ANTERIORES' 
@5,20 SAY '*** CENTRO PLASTICO  GENERAL ALVEAR ***'
SAVE SCREEN TO PANPAN
DO WHILE .T. 
   SET COLOR TO W+/B
   @18,11 CLEAR to 22,68
   IF LASTKEY()=27
      RETURN
   ENDIF
   SET COLOR TO W+/B
   @18,11 CLEAR to 22,68
   SET COLOR TO *RG+/B
   @20,35 SAY 'UN MOMENTO'
   SET COLOR TO W+/B
   KKK=FCREATE('BASES.RA0',0)
   MANI='123'
   FWRITE(KKK,MANI)
   FCLOSE(KKK)
   IF FERROR()<>0
      SET COLOR TO W+/B
      @18,11 CLEAR to 22,68
      SET COLOR TO *R+/B
      @20,33 SAY ' NO HAY DISCO '
      SET COLOR TO W+/B
      INKEY(3)
      RESTORE SCREEN FROM PANPAN
      LOOP
   ENDIF
   EXIT
ENDDO
SAVE SCREEN TO PANPAN
DO WHILE .T.
*   SET DEFAULT TO CCP
*   SET PATH TO CCP
   SET COLOR TO W+/B
   @18,11 CLEAR to 22,68
   SET COLOR TO *RG+/B
   @20,35 SAY 'UN MOMENTO'
   SET COLOR TO W+/B
   PUBLIC TABLA1
   TABLA1=DIRECTORY('IVA\*.DBF')
   A1=LEN(TABLA1)
   USE DISKET
   ZAP
   FOR T1=1 TO A1
      APPEND BLANK
      REPLACE BASES WITH TABLA1[T1,1]
   NEXT
   GO TOP
   DECLARE CAMP[1]
   CAMP[1]='BASES'
   DECLARE CABEZ[1]
   CABEZ[1]='  Ficheros'
   DECLARE SEPAR[1]
   SEPAR[1]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   @18,11 CLEAR to 22,68
   SET COLOR TO RG+/B
   @18,20 SAY 'INTERPRETACION DEL NOMBRE DEL FICHERO'
   SET COLOR TO W+/B
   @20,15 SAY 'FA significa facturas A y FB significa facturas B'
   @21,17 SAY '08 el mes AGOSTO de Facturaci¢n, por ejemplo.'
   @22,16 SAY '1999 Es el a¤o 1999 de Facturaci¢n, por ejemplo.'
   SET COLOR TO BG+/B
   @20,15 SAY 'FA'
   @20,41 SAY 'FB'
   @21,17 SAY '08'
   @22,16 SAY '1999'
   SET COLOR TO BG/B,B/W
   DBEDIT(7,11,16,68,CAMP,'FUNMIA','',CABEZ,SEPAR)
   IF LASTKEY()=13
      SET DEFAULT TO IVA\
      SET PATH TO IVA\
      STORE ALLTRIM(BASES) TO ESBASE
      PUBLIC WMES,WANIO,MENSA
      STORE SUBSTR(ALLTRIM(BASES),3,2) TO WMES
      STORE SUBSTR(ALLTRIM(BASES),5,4) TO WANIO
      STORE LEFT(ALLTRIM(BASES),2) TO CUAL
      IF CUAL='FA'
         MENSA='de Facturaciones en A'
      ELSE
         MENSA='de Facturaciones en B'
      ENDIF
      USE &ESBASE
      GO TOP
      SET COLOR TO W+/B
      @7,11 CLEAR TO 16,68
      @18,11 CLEAR to 22,68
      @21,24 SAY '<   > Salir         <  > Imprimir'
      SET COLOR TO BG+/B
      @19,21 SAY 'Datos de Ventas '+MENSA
      @21,25 SAY 'ESC'
      @21,45 SAY 'F5'
      DECLARE CAMP[12]
      CAMP[1]='NUMERO'
      CAMP[2]='FECHA'
      CAMP[3]='CLIENTE'
      CAMP[4]='DOMICILIO'
      CAMP[5]='TELEFONO'
      CAMP[6]='DNI'
      CAMP[7]='CUIT'
      CAMP[8]='SITUIVA'
      CAMP[9]='DETALLE'
      CAMP[10]='CANTIDAD'
      CAMP[11]='PRECIO'
      CAMP[12]='TOTAL'
      DECLARE CABEZ[13]
      CABEZ[1]='N§ factura'
      CABEZ[2]='Fecha'
      CABEZ[3]='Nombre del Cliente'
      CABEZ[4]='Domicilio del Cliente'
      CABEZ[5]='Tel‚fono'
      CABEZ[6]='Documento'
      CABEZ[7]='N§ de CUIT'
      CABEZ[8]='Iva'
      CABEZ[9]='Detalle de la Mercader¡a'
      CABEZ[10]='Cantidad'
      CABEZ[11]='Precio Unit'
      CABEZ[12]='Precio Total'
      DECLARE SEPAR[12]
      SEPAR[1]='Ä'
      SEPAR[2]='Ä'
      SEPAR[3]='Ä'
      SEPAR[4]='Ä'
      SEPAR[5]='Ä'
      SEPAR[6]='Ä'
      SEPAR[7]='Ä'
      SEPAR[8]='Ä'
      SEPAR[9]='Ä'
      SEPAR[10]='Ä'
      SEPAR[11]='Ä'
      SEPAR[12]='Ä'
      SET CURSOR OFF
      CLEAR TYPEAHEAD
      SET COLOR TO BG/B,B/W
      DBEDIT(7,11,16,68,CAMP,'FUNMIA','',CABEZ,SEPAR)
      RESTORE SCREEN FROM PANPAN
      LOOP
   ENDIF
   EXIT
ENDDO
*SET DEFAULT TO CCP
*SET PATH TO CCP
RETURN

FUNCTION FUNMIA
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
        RETURN(0)
    CASE LASTKEY()=27
        RETURN(0)
    CASE LASTKEY()=-4
        SAVE SCREEN TO PATO
        SET CURSOR OFF
        DO WHILE .T.
           SET COLOR TO W+/B
           @22,16 CLEAR TO 24,61 
           @22,16 TO 24,61 
           @23,21 SAY 'Prepare la Impresora y pulse <ENTER>'
           SET COLOR TO BG+/B
           @23,51 SAY 'ENTER'
           SET COLOR TO W+/B
           INKEY(0)
           IF LASTKEY()=27
              RESTORE SCREEN FROM PATO
              RETURN(1)
           ENDIF
           IF ISPRINTER()
              EXIT
           ELSE
              TONE(500,2)
              @23,17 CLEAR TO 23,60 
              SET COLOR TO W+/B
              @23,20 SAY 'La Impresora NO ESTA LISTA...'
              SET COLOR TO *R+/B
              @23,49 SAY 'VERIFIQUE'
              INKEY(3)
              SET COLOR TO W+/B
              LOOP
           ENDIF
        ENDDO
        SET COLOR TO W+/B
        @23,17 CLEAR TO 23,60
        SET CURSOR OFF
        SET COLOR TO *RG+/B
        @23,24 SAY 'ESTOY IMPRIMIENDO....­ ESPERATE !'
        SET COLOR TO W+/B
        SET DEVICE TO PRINT
        GO TOP
        INICIO=chr(15)
        FINAL=chr(28)
        @0,0 SAY INICIO
        @0,50 SAY 'Datos de Ventas '+MENSA
        CUANDO='MES '+WMES+' - A¥O '+WANIO
        XLX=68-(LEN(CUANDO)/2)
        @1,XLX SAY CUANDO
        @3,21 SAY REPLICATE('Ä',89)
        @4,20 SAY '³ Fechas ³ N§ Fact. ³            Cliente            ³   C.U.I.T.  ³NetGrav³  IVA  ³ Total ³'
        @5,21 SAY REPLICATE('Ä',89)
        STORE 6 TO LINEA
        DO WHILE .T.
           IF EOF()
              EXIT
           ENDIF
           @LINEA,20 SAY '³'
           @LINEA,21 SAY FECHA PICTURE '99/99/99'
           @LINEA,29 SAY '³'
           @LINEA,30 SAY NUMERO PICTURE '9999999999'
           @LINEA,40 SAY '³'
           @LINEA,41 SAY CLIENTE
           @LINEA,72 SAY '³'
           @LINEA,73 SAY CUIT PICTURE '99-99999999-9'
           @LINEA,86 SAY '³'
           NETOGRAV=TOTAL/1.21
           IVA=TOTAL-NETOGRAV
           @LINEA,87 SAY NETOGRAV PICTURE '9999.99'
           @LINEA,94 SAY '³'
           @LINEA,95 SAY IVA PICTURE '9999.99'
           @LINEA,102 SAY '³'
           @LINEA,103 SAY NETOGRAV+IVA PICTURE '9999.99'
           @LINEA,110 SAY '³'
           LINEA=LINEA+1
           IF LINEA>=61
              @LINEA,21 SAY REPLICATE('Ä',89)
              EJECT
              @0,50 SAY 'Datos de Ventas '+MENSA
              @1,XLX SAY CUANDO
              @3,21 SAY REPLICATE('Ä',89)
              @4,20 SAY '³ Fechas ³ N§ Fact. ³            Cliente            ³   C.U.I.T.  ³NetGrav³  IVA  ³ Total ³'
              @5,21 SAY REPLICATE('Ä',89)
              STORE 6 TO LINEA
           ENDIF
           SKIP
           LOOP
        ENDDO
        @LINEA,21 SAY REPLICATE('Ä',89)
        @LINEA+1,0 SAY FINAL
        EJECT
        SET DEVICE TO SCREEN
        RESTORE SCREEN FROM PATO
        GO TOP
        RETURN(1)
    OTHERWISE
        RETURN(1)
ENDCASE

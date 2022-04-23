DO WHILE .T.
   CLEAR
   SET KEY -2 TO BORRALIN
   SET COLOR TO W+/B
   @1,0 SAY 'CENTRO COMERCIAL DEL PLASTICO'
   NUMDIA=LEFT(DTOC(DATE()),2)
   DIA=TDIAS(CDOW(DATE()))
   MES=TMES(CMONTH(DATE()))
   ANIO=ALLTRIM(STR(YEAR(DATE())))
   VFECHA=DIA+' '+NUMDIA+' de '+MES+' de '+ANIO
   LL=79-LEN(VFECHA)
   @1,LL SAY VFECHA
   SET COLOR TO BG/B
   @2,0 SAY REPLICATE('Ä',29)
   @2,LL SAY REPLICATE('Ä',LEN(VFECHA))
   @0,30 TO 2,43
   SET COLOR TO W+/B
   @1,31 SAY 'FACT REMITOS'
   SET COLOR TO W+/B
   USE REMITOS
   INDEX ON DNI TO ORDDNI UNIQUE
   GO TOP
   IF EOF()
      TONE(500,2)
      SET COLOR TO W+/B
      @13,22 TO 15,56
      @14,23 CLEAR TO 14,55
      SET COLOR TO *R+/B
      @14,24 SAY 'NO EXISTEN CLIENTES CON REMITOS'
      SET COLOR TO W+/B
      INKEY(5)
      RETURN
   ENDIF
   SET COLOR TO BG/B
   @6,0 TO 21,79
   @7,1 CLEAR TO 20,78
   @19,1 TO 19,78
   @17,1 TO 17,78
   @18,1 CLEAR TO 18,78
   @20,1 CLEAR TO 20,78
   SET COLOR TO W+/B
   @20,17 SAY '        Tomar'
   @20,50 SAY '      Salir'
   SET COLOR TO BG+/B
   @18,30 SAY 'Datos de Clientes'
   @20,17 SAY '<ENTER>'
   @20,50 SAY '<ESC>'
   DECLARE CAMP[3]
   CAMP[1]='NOMBRE'
   CAMP[2]='DOMICILIO'
   CAMP[3]='SITUIVA'
   DECLARE CABEZ[3]
   CABEZ[1]='     Apellido y Nombres'
   CABEZ[2]='          Domicilio'
   CABEZ[3]='Sit. IVA'
   DECLARE SEPAR[3]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   DBEDIT(7,1,16,78,CAMP,'FUNREM1','',CABEZ,SEPAR)
   IF LASTKEY()=27
      RETURN
   ENDIF
   STORE DNI TO VDOCU
   STORE NOMBRE TO VNOMBRE
   STORE DOMICILIO TO VDOMI
   STORE TELEFONO TO VTELE
   STORE CUIT TO VCUIT
   STORE SITUIVA TO VIVA
   INDEX ON DNI TO ORDDNI
   GO TOP
   COPY TO TMPREMI FOR DNI=VDOCU
   DELETE FOR DNI=VDOCU
   IF VIVA='RI'
      STORE 'A' TO FACTURACION
      USE NFA
      GO TOP
      STORE NUMERO+1 TO NUMFA
      CARTEL='Fact '+FACTURACION+' '+ALLTRIM(STR(NUMFA))
   ELSE
      STORE 'B' TO FACTURACION
      USE NFB
      GO TOP
      STORE NUMERO+1 TO NUMFB
      CARTEL='Fact '+FACTURACION+' '+ALLTRIM(STR(NUMFB))
   ENDIF
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
   @2,0 SAY REPLICATE('Ä',29)
   @2,LL SAY REPLICATE('Ä',LEN(VFECHA))
   @0,32 TO 2,45
   SET COLOR TO *W+/B
   @1,33 SAY 'FACT REMITOS'
   SET COLOR TO BG/B
   @5,0 SAY 'Cant.                         Detalle                         P.Unit.   P.Total'
   @5,7 SAY '³'
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
   @4,0 CLEAR TO 24,79
   USE TMPREMI
   INDEX ON FECHA TO ORDFEC
   GO TOP
   SET COLOR TO BG/B
   @8,0 TO 19,79
   @9,1 CLEAR TO 18,78
   @17,1 TO 17,78
   @15,1 TO 15,78
   @16,1 CLEAR TO 16,78
   @18,1 CLEAR TO 18,78
   SET COLOR TO W+/B
   @18,15 SAY '        Marcar'
   @18,32 SAY '     Facturar'
   @18,52 SAY '      Salir'
   SET COLOR TO BG+/B
   @16,30 SAY 'Datos de Remitos'
   @18,15 SAY '<ENTER>'
   @18,32 SAY '<F5>'
   @18,52 SAY '<ESC>'
   DECLARE CAMP[4]
   CAMP[1]='MARCA'
   CAMP[2]='FECHA'
   CAMP[3]='DESCRIP'
   CAMP[4]='IMPORTE'
   DECLARE CABEZ[4]
   CABEZ[1]='M'
   CABEZ[2]=' Fechas'
   CABEZ[3]='N£mero de Remito'
   CABEZ[4]='Importe'
   DECLARE SEPAR[4]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   DBEDIT(9,1,14,78,CAMP,'FUNREM2','',CABEZ,SEPAR)
   RESTORE SCREEN FROM INICIO
   IF LASTKEY()=27
      USE REMITOS
      RECALL ALL
      RETURN
   ENDIF
   DO FACRM2
   LOOP
ENDDO

FUNCTION FUNREM1
PARAMETERS MODE
DO CASE
    CASE MODE=1
        TONE(500,2)
        RETURN(1)
    CASE MODE=2
        TONE(500,2)
        RETURN(1)
    CASE MODE=0
        RETURN(1)
    CASE MODE=3
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
        LOCATE FOR LEFT(NOMBRE,LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION FUNREM2
PARAMETERS MODE
DO CASE
    CASE MODE=1
        TONE(500,2)
        RETURN(1)
    CASE MODE=2
        TONE(500,2)
        RETURN(1)
    CASE MODE=0
        RETURN(1)
    CASE MODE=3
        RETURN(1)
    CASE LASTKEY()=13
        STORE '' TO KK
        IF MARCA=' '
           REPLACE MARCA WITH '*'
           DELETE
        ELSE
           REPLACE MARCA WITH ' '
           RECALL
        ENDIF
        RETURN(2)
    CASE LASTKEY()=-4
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=27
        STORE '' TO KK
        RETURN(0)
    OTHERWISE
        RETURN(1)
ENDCASE

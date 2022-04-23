DO WHILE .T.
   CLEAR
   USE CLIENTES
   INDEX ON NOMBRE TO ORDNOM
   GO TOP
   @0,0 TO 2,30
   SET COLOR TO BG+/B
   @1,2 SAY '* * * CENTRO PLASTICO * * *'
   numero=LEFT(DTOC(DATE()),2)
   DIA=TDIAS(cdow(DATE()))
   MES=TMES(CMONTH(DATE()))
   ANIO=ALLTRIM(STR(YEAR(DATE())))
   VFECHA=DIA+' '+numero+' de '+MES+' de '+ANIO
   LL=79-LEN(VFECHA)
   SET COLOR TO W+/B
   @1,LL-7 SAY 'Fecha: '
   @3,0 TO 5,23
   SET COLOR TO BG+/B
   @4,2 SAY 'PANTALLA DE CLIENTES'
   @1,LL SAY VFECHA
   SAVE SCREEN TO MILI
   SET COLOR TO W+/B
   @6,20 TO 15,59
   @7,21 CLEAR TO 14,58
   @16,16 SAY '        Tomar'
   @16,33 SAY '     Nuevo'
   @16,47 SAY '     Eliminar'
   SET COLOR TO BG+/B
   @16,16 SAY '<ENTER>'
   @16,33 SAY '<F5>'
   @16,47 SAY '<SUP>'
   DECLARE CAMP[1]
   CAMP[1]='NOMBRE'
   DECLARE CABEZ[1]
   CABEZ[1]='   Clientes de Ctas. Ctes.'
   DECLARE SEPAR[1]
   SEPAR[1]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO BG/B
   @23,1 TO 23,78
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   DBEDIT(7,21,14,58,CAMP,'FCTACTE','',CABEZ,SEPAR)
   SAVE SCREEN TO PANLISTO
   IF LASTKEY()=27
      SET FILTER TO
      RETURN
   ENDIF
   STORE DNI TO VDOCU
   STORE NOMBRE TO VNOMBRE
   STORE DOMICILIO TO VDOMI
   STORE TELEFONO TO VTELE
   STORE CUIT TO VCUIT
   STORE SITUIVA TO VIVA
   RESTORE SCREEN FROM MILI
   SET KEY -2 TO
   DO WHILE .T.
      @3,0 CLEAR TO 5,44
      @3,0 TO 5,33
      SET COLOR TO BG+/B
      @4,2 SAY 'PANTALLA DE CUENTAS CORRIENTES'
      USE CTASCTES
      INDEX ON FECHA TO ORDFEC
      SET FILTER TO NOMBRE=VNOMBRE
      GO TOP
      SUM DEBE,HABER TO TTDEBE,TTHABER
      SALDO=TTHABER-TTDEBE
      GO TOP
      SET COLOR TO BG/B
      @17,47 SAY 'SALDO: '
      SET COLOR TO BG+/B
      @3,46 SAY VNOMBRE
      @4,46 SAY VCUIT PICTURE '99-99999999-9'
      @5,46 SAY VDOMI
      @6,46 SAY VTELE
      IF SALDO<=0
         SET COLOR TO R+/B
         @17,57 SAY SALDO PICTURE '99999.99'
      ELSE
         SET COLOR TO G+/B
         @17,69 SAY SALDO PICTURE '99999.99'
      ENDIF
      SET COLOR TO W+/B
      @3,35 SAY 'Cliente  : '
      @4,35 SAY 'CUIT N§  : '
      @5,35 SAY 'Domicilio: '
      @6,35 SAY 'Tel‚fono : '
      @7,0 TO 16,79
      @8,1 CLEAR TO 15,78
      @22,2 SAY '<F2> Debe  <F3> Haber  <F4> Imprime  <F5> Borra por fecha  <SUP> Borra linea'
      SET COLOR TO BG+/B
      @22,3 SAY 'F2'
      @22,14 SAY 'F3'
      @22,26 SAY 'F4'
      @22,40 SAY 'F5'
      @22,62 SAY 'SUP'
      DECLARE CAMP[4]
      CAMP[1]='FECHA'
      CAMP[2]='DESCRIP'
      CAMP[3]='DEBE'
      CAMP[4]='HABER'
      DECLARE CABEZ[4]
      CABEZ[1]=' Fechas'
      CABEZ[2]='       Descripci¢n del Movimiento       '
      CABEZ[3]='  Debe   '
      CABEZ[4]='  Haber  '
      DECLARE SEPAR[4]
      SEPAR[1]='Ä'
      SEPAR[2]='Ä'
      SEPAR[3]='Ä'
      SEPAR[4]='Ä'
      SET CURSOR OFF
      CLEAR TYPEAHEAD
      SET COLOR TO BG/B
      @23,1 TO 23,78
      SET COLOR TO B+/B
      @24,1 SAY 'Buscar:                                                                       '
      SET COLOR TO BG/B,B/W
      DBEDIT(8,1,15,78,CAMP,'FSALDOS','',CABEZ,SEPAR)
      IF LASTKEY()=27
         EXIT
      ENDIF
      IF LASTKEY()=-4
         SET CURSOR OFF
         SAVE SCREEN TO PIMP
         DO WHILE .T.
            SET COLOR TO BG/B
            @17,15 TO 21,65
            @18,16 CLEAR TO 20,64
            SET COLOR TO W+/B
            @18,18 SAY 'Desde Fecha:            Hasta Fecha:'
            @20,28 SAY 'Pulse <ENTER> para tomar todo'
            SET COLOR TO B/W
            @18,55 SAY '  /  /  '
            SET COLOR TO *BG+/B
            @20,35 SAY 'ENTER'
            SET CURSOR ON
            STORE CTOD('  /  /  ') TO DESDE,HASTA
            SET COLOR TO BG/B,B/W
            @18,30 SAY ''GET DESDE PICTURE '99/99/99'
            READ
            IF LASTKEY()=27
               EXIT
            ENDIF
            IF DESDE=CTOD('  /  /  ')
               SET CURSOR OFF
               STORE CTOD('01/01/80') TO DESDE
               STORE DATE() TO HASTA
               @20,16 CLEAR TO 20,64
               SET COLOR TO *BG+/B
               @20,34 SAY 'Tomando TODO'
               SET COLOR TO
            ELSE
               @20,16 CLEAR TO 20,64
               SET COLOR TO *BG+/B
               @20,32 SAY 'Tomando FRACCION'
               SET COLOR TO BG/B,B/W
               @18,54 SAY ''GET HASTA PICTURE '99/99/99'
               READ
               IF HASTA=CTOD('  /  /  ')
                  STORE DATE() TO HASTA
               ENDIF
            ENDIF
            SET CURSOR OFF
            IF DESDE>HASTA
               TONE(1200,1)
               SET COLOR TO *R+/B
               @20,16 CLEAR TO 20,64
               @20,34 SAY 'Mal Ingresado'
               SET COLOR TO W+/B
               SET CURSOR OFF
               INKEY(1)
               @20,16 CLEAR TO 20,64
               LOOP
            ENDIF
            EXIT
         ENDDO
         IF LASTKEY()=27
            RESTORE SCREEN FROM MILI
            LOOP
         ENDIF
         INDEX ON FECHA TO ORDFEC
         SET FILTER TO FECHA>=DESDE.AND.FECHA<=HASTA.AND.DNI=VDOCU
         GO TOP
         DO WHILE .T.
            @6,0 CLEAR TO 22,79
            @6,0 TO 15,79
            @22,18 SAY '<F8> Borra Todo           <SUP> Borra linea'
            SET COLOR TO BG+/B
            @22,19 SAY 'F8'
            @22,45 SAY 'SUP'
            DECLARE CAMP[4]
            CAMP[1]='FECHA'
            CAMP[2]='DESCRIP'
            CAMP[3]='DEBE'
            CAMP[4]='HABER'
            DECLARE CABEZ[4]
            CABEZ[1]=' Fechas'
            CABEZ[2]='       Descripci¢n del Movimiento       '
            CABEZ[3]='  Debe   '
            CABEZ[4]='  Haber  '
            DECLARE SEPAR[4]
            SEPAR[1]='Ä'
            SEPAR[2]='Ä'
            SEPAR[3]='Ä'
            SEPAR[4]='Ä'
            SET CURSOR OFF
            CLEAR TYPEAHEAD
            SET COLOR TO BG/B
            @23,1 TO 23,78
            SET COLOR TO B+/B
            @24,1 SAY 'Buscar:                                                                       '
            SET COLOR TO BG/B,B/W
            DBEDIT(7,1,14,78,CAMP,'KAKA','',CABEZ,SEPAR)
            IF LASTKEY()=27
               EXIT
            ENDIF
         ENDDO
         SET FILTER TO
         RESTORE SCREEN FROM PIMP
      ENDIF
      RESTORE SCREEN FROM MILI
      LOOP
   ENDDO
   RESTORE SCREEN FROM PANLISTO
   LOOP
ENDDO

FUNCTION FCTACTE
PARAMETERS MODE
SAVE SCREEN TO KOLA
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
        RESTORE SCREEN FROM KOLA
        RETURN(1)
    CASE MODE=1
        TONE(500,2)
        RETURN(1)
    CASE MODE=2
        TONE(500,2)
        RETURN(1)
    CASE MODE=0
        RETURN(1)
    CASE LASTKEY()=-4
        STORE '' TO KK
        SAVE SCREEN TO ANDRES
        INDEX ON DNI TO ORDDOCU
        GO TOP
        DO WHILE .T.
           SET COLOR TO B+/B
           @14,0 TO 23,79
           @15,1 CLEAR TO 22,78
           STORE SPACE(30) TO VNOMBRE,VDOMI
           STORE SPACE(15) TO VTELE
           STORE SPACE(2) TO VIVA
           STORE 0 TO VDOCU,VCUIT,VDEBE,VHABER
           SET CURSOR ON
           SET COLOR TO BG/B,B/W
           @16,2 SAY 'Ingrese D.N.I.:'GET VDOCU PICTURE '99,999,999'
           READ
           IF LASTKEY()=27.OR.VDOCU=0
              RESTORE SCREEN FROM ANDRES
              EXIT
           ENDIF
           SEEK VDOCU
           IF .NOT. EOF()
               TONE(1200,1)
               SET COLOR TO W+/B
               @22,2 CLEAR TO 22,77
               SET COLOR TO *R+/B
               @22,30 SAY 'CLIENTE EXISTENTE'
               INKEY(3)
               RESTORE SCREEN FROM ANDRES
               LOOP
           ENDIF
           @16,31 SAY 'Ingrese Cliente:'GET VNOMBRE PICTURE '@!'
           @18,2 SAY 'Ingrese Domicilio:'GET VDOMI PICTURE '@!'
           @18,53 SAY 'Tel‚fono:'GET VTELE PICTURE '@!'
           READ
           IF LASTKEY()=27
              RESTORE SCREEN FROM ANDRES
              EXIT
           ENDIF
           @20,2 SAY 'Situaci¢n frente al IVA:'
           SAVE SCREEN TO HIJO
           @19,30 TO 21,73
           SET WRAP ON
           SET COLOR TO W+/B,B/W
           @20,32 PROMPT '  RI  '
           @20,40 PROMPT '  NR  '
           @20,48 PROMPT '  MT  '
           @20,56 PROMPT '  EX  '
           @20,64 PROMPT '  CF  '
           MENU TO STIV
           SET COLOR TO W+/B,B/W
           DO CASE
              CASE STIV=1
                 VIVA='RI'
                 VVI='RESPONSABLE INSCRIPTO'
              CASE STIV=2
                 VIVA='NR'
                 VVI='NO RESPONSABLE'
              CASE STIV=3
                 VIVA='MT'
                 VVI='MONOTRIBUTISTA'
              CASE STIV=4
                 VIVA='EX'
                 VVI='EXENTO'
              CASE STIV=5
                 VIVA='CF'
                 VVI='CONSUMIDOR FINAL'
              OTHERWISE
                 VIVA='EX'
                 VVI='EXENTO'
           ENDCASE
           RESTORE SCREEN FROM HIJO
           SET COLOR TO B/W
           @20,27 SAY VVI
           SET COLOR TO BG/B,B/W
           @20,53 SAY 'C.U.I.T.:'GET VCUIT PICTURE '99-99999999-9'
           READ
           IF LASTKEY()=27
              RESTORE SCREEN FROM ANDRES
              EXIT
           ENDIF
           SET COLOR TO W+/B
           SET CURSOR OFF
           TONE(500,1)
           SET COLOR TO W+/B
           @22,25 SAY '¨ Guarda Este Cliente (S/N) ?'
           SET COLOR TO *R+/B
           @22,48 SAY 'S'
           @22,50 SAY 'N'
           SET COLOR TO W+/B
           DO WHILE .T.
              INKEY(0)
              IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
                 TONE(500,1)
                 LOOP
              ENDIF
              EXIT
           ENDDO
           IF LASTKEY()=83.OR.LASTKEY()=115
              APPEND BLANK
              REPLACE NOMBRE WITH VNOMBRE,DOMICILIO WITH VDOMI,DNI WITH VDOCU,TELEFONO WITH VTELE
              REPLACE CUIT WITH VCUIT,SITUIVA WITH VIVA
           ENDIF
           SET COLOR TO W+/B
           RESTORE SCREEN FROM ANDRES
           EXIT
        ENDDO
        INDEX ON NOMBRE TO ORDNOM
        GO TOP
        RETURN (2)
    CASE LASTKEY()=7
        STORE '' TO KK
        STORE DNI TO VDOCU
        SAVE SCREEN TO ANDRES
        TONE(1200,1)
        DO WHILE .T.
           SET COLOR TO B+/B
           @16,0 TO 22,79
           @17,1 CLEAR TO 21,78
           SET COLOR TO BG+/B,B/W
           SET COLOR TO R+/B
           @17,8 SAY 'ESTA POR BORRAR TODOS LOS DATOS DE CUENTA CORRIENTE DEL CLIENTE'
           SET COLOR TO *RG+/B
           @19,39-LEN(ALLTRIM(NOMBRE))/2 SAY ALLTRIM(NOMBRE)
           SET COLOR TO W+/B
           @21,28 SAY '¨ Est  Seguro (S/N) ?'
           SET COLOR TO *R+/B
           @21,43 SAY 'S'
           @21,45 SAY 'N'
           SET COLOR TO W+/B
           INKEY(0)
           IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
              TONE(500,1)
              LOOP
           ENDIF
           IF LASTKEY()=83.OR.LASTKEY()=115
              DELETE
              PACK
              USE CTASCTES
              INDEX ON DNI TO ORDDNI
              DELETE ALL FOR DNI=VDOCU
              PACK
              USE CLIENTES
           ENDIF
           EXIT
        ENDDO
        RESTORE SCREEN FROM ANDRES
        INDEX ON NOMBRE TO ORDNOM UNIQUE
        GO TOP
        RETURN(2)
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

FUNCTION FSALDOS
PARAMETERS MODE
SAVE SCREEN TO KOLA
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
        RESTORE SCREEN FROM KOLA
        RETURN(1)
    CASE MODE=1
        TONE(500,2)
        RETURN(1)
    CASE MODE=2
        TONE(500,2)
        RETURN(1)
    CASE MODE=0
        RETURN(1)
    CASE LASTKEY()=-1
        STORE '' TO KK
        SET CURSOR ON
        STORE 'COMPRA MERCADERIA        ' TO VDESC
        STORE 0 TO VDEBE,VHABER
        STORE DATE() TO VFEC
        SAVE SCREEN TO ENFUN
        SET COLOR TO *W+/B
        @17,1 SAY 'A COBRAR'
        SET COLOR TO BG/B
        @18,0 TO 22,79
        @19,1 CLEAR TO 21,78
        SET COLOR TO BG/B,B/W
        @19,7 SAY 'Ingrese Descripci¢n del Movimiento Ä>:'GET VDESC PICTURE '@!K'
        @21,7 SAY 'Ingrese Importe Ä>:'GET VDEBE PICTURE '99999.99'
        @21,45 SAY 'Ingrese Fecha Ä>:'GET VFEC PICTURE '99/99/99'
        READ
        IF LASTKEY()=27
           RESTORE SCREEN FROM ENFUN
           RETURN(2)
        ENDIF
        SET COLOR TO W+/B
        SET CURSOR OFF
        APPEND BLANK
        REPLACE NOMBRE WITH VNOMBRE,DOMICILIO WITH VDOMI,DNI WITH VDOCU,TELEFONO WITH VTELE
        REPLACE FECHA WITH VFEC,DEBE WITH VDEBE,HABER WITH VHABER,DESCRIP WITH VDESC

        RESTORE SCREEN FROM ENFUN
        GO TOP
        SUM DEBE,HABER TO TTDEBE,TTHABER
        SALDO=TTHABER-TTDEBE
        GO TOP
        USE CLIENTES
        INDEX ON DNI TO ORDDNI
        GO TOP
        SEEK VDOCU
        REPLACE SUSALDO WITH SALDO
        RETURN(0)
    CASE LASTKEY()=-2
        STORE '' TO KK
        SET CURSOR ON
        STORE 'RECIBO N§                ' TO VDESC
        STORE 0 TO VDEBE,VHABER
        STORE DATE() TO VFEC
        SAVE SCREEN TO ENFUN
        SET COLOR TO *W+/B
        @17,1 SAY 'COBRADO'
        SET COLOR TO BG/B
        @18,0 TO 22,79
        @19,1 CLEAR TO 21,78
        SET COLOR TO BG/B,B/W
        @19,7 SAY 'Ingrese Descripci¢n del Movimiento Ä>:'GET VDESC PICTURE '@!K'
        @21,7 SAY 'Ingrese Importe Ä>:'GET VHABER PICTURE '99999.99'
        @21,45 SAY 'Ingrese Fecha Ä>:'GET VFEC PICTURE '99/99/99'
        READ
        IF LASTKEY()=27
           RESTORE SCREEN FROM ENFUN
           RETURN(2)
        ENDIF
        SET COLOR TO W+/B
        SET CURSOR OFF
        APPEND BLANK
        REPLACE NOMBRE WITH VNOMBRE,DOMICILIO WITH VDOMI,DNI WITH VDOCU,TELEFONO WITH VTELE
        REPLACE FECHA WITH VFEC,DEBE WITH VDEBE,HABER WITH VHABER,DESCRIP WITH VDESC

        RESTORE SCREEN FROM ENFUN
        GO TOP
        SUM DEBE,HABER TO TTDEBE,TTHABER
        SALDO=TTHABER-TTDEBE
        GO TOP
        USE CLIENTES
        INDEX ON DNI TO ORDDOCU
        GO TOP
        SEEK VDOCU
        REPLACE SUSALDO WITH SALDO,FUE WITH VFEC
        RETURN(0)
    CASE LASTKEY()=-3
        STORE '' TO KK
        SET CURSOR OFF
        SALE=0
        SAVE SCREEN TO PIMP
        DO WHILE .T.
           SET COLOR TO W+/B
           @22,0 CLEAR TO 24,79 
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
           RESTORE SCREEN FROM PIMP
           RETURN(2)
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
        MENSA='ESTADO DE CUENTA DE '+ALLTRIM(VNOMBRE)
        CC=39-(LEN(MENSA)/2)
        @2,CC SAY 'ESTADO DE CUENTA DE '+ALLTRIM(VNOMBRE)
        MENSA2=ALLTRIM(VDOMI)+'   -   Tel: '+ALLTRIM(VTELE)
        CC2=39-(LEN(MENSA2)/2)
        @3,CC2 SAY MENSA2
        @4,1 SAY REPLICATE('Ä',78)
        @5,0 SAY '³ Fechas ³               Descripci¢n                  ³    Debe    ³   Haber   ³'
        @6,1 SAY REPLICATE('Ä',78)
        LINEA=7
        STORE 0 TO TDEBE,THABER
        DO WHILE .T.
           IF EOF()
              EXIT
           ENDIF
           @LINEA,0 SAY '³'
           @LINEA,1 SAY FECHA PICTURE '99/99/99'
           @LINEA,9 SAY '³'
           @LINEA,10 SAY DESCRIP PICTURE '@!'
           @LINEA,54 SAY '³'
           @LINEA,56 SAY DEBE PICTURE '99999.99'
           @LINEA,67 SAY '³'
           @LINEA,69 SAY HABER PICTURE '99999.99'
           @LINEA,79 SAY '³'
           STORE DEBE+TDEBE TO TDEBE
           STORE HABER+THABER TO THABER
           LINEA=LINEA+1
           SKIP
           LOOP
        ENDDO
        @LINEA,1 SAY REPLICATE('Ä',78)
        LINEA=LINEA+1
        @LINEA,47 SAY 'SALDO:'
        TSALDO=THABER-TDEBE
        IF TSALDO<=0
           @LINEA,56 SAY TSALDO PICTURE '99999.99'
        ELSE
           @LINEA,69 SAY TSALDO PICTURE '99999.99'
        ENDIF
        EJECT
        SET COLOR TO W+/B
        SET DEVICE TO SCREEN
        RESTORE SCREEN FROM PIMP
        RETURN(0)
    CASE LASTKEY()=-4
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=7
        STORE '' TO KK
        TONE(1200,1)
        SAVE SCREEN TO PIMP
        DO WHILE .T.
           SET COLOR TO *R+/B
           @ROW()-1,COL()-1 TO ROW()+1,78
           SET COLOR TO W+/B
           @22,0 CLEAR TO 24,79 
           @22,16 TO 24,61 
           @23,26 SAY '¨ Borrar este Movimiento (S/N) ?'
           SET COLOR TO *R+/B
           @23,52 SAY 'S'
           @23,54 SAY 'N'
           SET COLOR TO W+/B
           INKEY(0)
           IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
              TONE(500,1)
              LOOP
           ENDIF
           IF LASTKEY()=83.OR.LASTKEY()=115
              DELETE
              PACK
           ELSE
              RECALL ALL
           ENDIF
           EXIT
        ENDDO
        RESTORE SCREEN FROM PIMP
        GO TOP
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
        TC=CHR(LASTKEY())
        IF TC<>'0'.AND.TC<>'1'.AND.TC<>'2'.AND.TC<>'3'.AND.TC<>'4'.AND.TC<>'5'.AND.TC<>'6'.AND.TC<>'7'.AND.TC<>'8'.AND.TC<>'9'.AND.TC<>'/'
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO B+/B
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+CHR(LASTKEY()) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO W+/B
        GO TOP
        LOCATE FOR LEFT(DTOC(FECHA),LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION KAKA
PARAMETERS MODE
SAVE SCREEN TO KOLA
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
        RESTORE SCREEN FROM KOLA
        RETURN(1)
    CASE MODE=1
        TONE(500,2)
        RETURN(1)
    CASE MODE=2
        TONE(500,2)
        RETURN(1)
    CASE MODE=0
        RETURN(1)
    CASE LASTKEY()=7
        STORE '' TO KK
        DELETE
        PACK
        GO TOP
        RETURN(2)
    CASE LASTKEY()=-7
        STORE '' TO KK
        DELETE ALL FOR FECHA>=DESDE.AND.FECHA<=HASTA
        PACK
        GO TOP
        RETURN(2)
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
        TC=CHR(LASTKEY())
        IF TC<>'0'.AND.TC<>'1'.AND.TC<>'2'.AND.TC<>'3'.AND.TC<>'4'.AND.TC<>'5'.AND.TC<>'6'.AND.TC<>'7'.AND.TC<>'8'.AND.TC<>'9'.AND.TC<>'/'
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO B+/B
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+CHR(LASTKEY()) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO W+/B
        GO TOP
        LOCATE FOR LEFT(DTOC(FECHA),LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE

DO WHILE .T.
   CLEAR
   USE CLIENTES
   INDEX ON NOMBRE TO ORDNOM
   REPLACE ALL MARCA WITH ' '
   SET FILTER TO SUSALDO<0
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
   @3,0 TO 5,44
   SET COLOR TO BG+/B
   @4,2 SAY 'PANTALLA DE CLIENTES CON CUENTA CORRIENTE'
   @1,LL SAY VFECHA
   SAVE SCREEN TO MILI
   SET COLOR TO W+/B
   @6,5 TO 15,74
   @7,6 CLEAR TO 14,73
   @16,16 SAY '        Marcar'
   @16,33 SAY '     Imprimir los clientes marcados'
   SET COLOR TO BG+/B
   @16,16 SAY '<ENTER>'
   @16,33 SAY '<F5>'
   DECLARE CAMP[4]
   CAMP[1]='MARCA'
   CAMP[2]='NOMBRE'
   CAMP[3]='SUSALDO'
   CAMP[4]='FUE'
   DECLARE CABEZ[4]
   CABEZ[1]='Marca'
   CABEZ[2]='   Clientes de Ctas. Ctes.'
   CABEZ[3]=' Saldos'
   CABEZ[4]=' F.U.E.'
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
   DBEDIT(7,6,14,73,CAMP,'PRNCTA','',CABEZ,SEPAR)
   SAVE SCREEN TO PANLISTO
   IF LASTKEY()=27
      SET FILTER TO
      REPLACE ALL MARCA WITH ' '
      GO TOP
      RETURN
   ENDIF
   RESTORE SCREEN FROM PANLISTO
   LOOP
ENDDO

FUNCTION PRNCTA
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
    CASE LASTKEY()=13
        STORE '' TO KK
        IF MARCA=' '
           REPLACE MARCA WITH '*'
        ELSE
           REPLACE MARCA WITH ' '
        ENDIF
        RETURN(2)
    CASE LASTKEY()=-4
        STORE '' TO KK
        SET CURSOR OFF
        SALE=0
        SAVE SCREEN TO PIMP
        USE CLIENTES
        SORT ON NOMBRE TO TMPCLIE FOR MARCA='*'
        USE TMPCLIE
        GO TOP
        IF EOF()
           TONE(500,2)
           SET COLOR TO W+/B
           @11,29 TO 13,49
           @12,30 CLEAR TO 12,48
           SET COLOR TO *R+/B
           @12,31 SAY 'NO EXISTEN MARCAS'
           SET COLOR TO W+/B
           INKEY(5)
           USE CLIENTES
           INDEX ON NOMBRE TO ORDNOM
           SET FILTER TO SUSALDO<0
           GO TOP
           RESTORE SCREEN FROM PIMP
           RETURN(1)
        ENDIF
        STORE RECNO() TO REGISTRO
        STORE LASTREC() TO SONREG
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
           USE CLIENTES
           SET FILTER TO
           REPLACE ALL MARCA WITH ' '
           GO TOP
           RETURN(0)
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
        PASO=0
        LINEA=0
        SET DEVICE TO PRINT
        @LINEA,0 SAY '* * * CENTRO PLASTICO * * *'
        LL=79-LEN(VFECHA)
        @LINEA,LL-7 SAY 'Fecha: '
        @LINEA,LL SAY VFECHA
        LINEA=LINEA+1
        DO WHILE .T.
           USE TMPCLIE
           GO TOP
           GO REGISTRO
           STORE DNI TO VDOCU
           STORE NOMBRE TO VNOMBRE
           STORE DOMICILIO TO VDOMI
           STORE TELEFONO TO VTELE
           @LINEA,1 SAY REPLICATE('Ä',78)
           MENSA='ESTADO DE CUENTA DE '+ALLTRIM(VNOMBRE)
           CC=39-(LEN(MENSA)/2)
           LINEA=LINEA+2
           @LINEA,CC SAY MENSA
           MENSA2=ALLTRIM(VDOMI)+'   -   Tel: '+ALLTRIM(VTELE)
           CC2=39-(LEN(MENSA2)/2)
           LINEA=LINEA+1
           @LINEA,CC2 SAY MENSA2
           LINEA=LINEA+1
           @LINEA,1 SAY REPLICATE('Ä',78)
           LINEA=LINEA+1
           @LINEA,0 SAY '³ Fechas ³               Descripci¢n                  ³    Debe    ³   Haber   ³'
           LINEA=LINEA+1
           @LINEA,1 SAY REPLICATE('Ä',78)
           LINEA=LINEA+1
           STORE 0 TO TDEBE,THABER
           USE CTASCTES
           INDEX ON DNI TO ORDDOCU
           GO TOP
           SEEK VDOCU
           DO WHILE DNI=VDOCU
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
           REGISTRO=REGISTRO+1
           IF REGISTRO>SONREG
              EXIT
           ENDIF
           IF PASO=1
              EJECT
              STORE 0 TO LINEA
              PASO=0
              @LINEA,0 SAY '* * * CENTRO PLASTICO * * *'
              LL=79-LEN(VFECHA)
              @LINEA,LL-7 SAY 'Fecha: '
              @LINEA,LL SAY VFECHA
              LINEA=LINEA+1
           ELSEIF LINEA>32.AND.PASO=0
              EJECT
              STORE 0 TO LINEA
              @LINEA,0 SAY '* * * CENTRO PLASTICO * * *'
              LL=79-LEN(VFECHA)
              @LINEA,LL-7 SAY 'Fecha: '
              @LINEA,LL SAY VFECHA
              LINEA=LINEA+1
           ELSE
              STORE 32-LINEA TO FGH
              LINEA=LINEA+FGH
              @LINEA,0 SAY REPLICATE('.',80)
              LINEA=LINEA+1
              @LINEA,0 SAY '* * * CENTRO PLASTICO * * *'
              LL=79-LEN(VFECHA)
              @LINEA,LL-7 SAY 'Fecha: '
              @LINEA,LL SAY VFECHA
              LINEA=LINEA+1
              PASO=1
           ENDIF
           LOOP
        ENDDO
        EJECT
        SET COLOR TO W+/B
        SET DEVICE TO SCREEN
        USE CLIENTES
        INDEX ON NOMBRE TO ORDNOM
        SET FILTER TO SUSALDO<0
        GO TOP
        REPLACE ALL MARCA WITH ' '
        GO TOP
        RESTORE SCREEN FROM PIMP
        RETURN(1)
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
        STORE KK+CHR(LASTKEY()) TO KK
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

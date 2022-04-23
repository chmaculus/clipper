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
@3,0 TO 5,44
SET COLOR TO BG+/B
@4,2 SAY 'PANTALLA DE CLIENTES CON CUENTA CORRIENTE'
@1,LL SAY VFECHA
SAVE SCREEN TO MILI
SET COLOR TO W+/B
@6,20 TO 15,59
@7,21 CLEAR TO 14,58
@16,31 SAY '        Tomar'
SET COLOR TO BG+/B
@16,31 SAY '<ENTER>'
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
DBEDIT(7,21,14,58,CAMP,'MODIFCTA','',CABEZ,SEPAR)
SAVE SCREEN TO PANLISTO
IF LASTKEY()=27
   SET FILTER TO
   RETURN
ENDIF

FUNCTION MODIFCTA
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
        SAVE SCREEN TO ANDRES
        STORE NOMBRE TO VNOMBRE
        STORE DOMICILIO TO VDOMI
        STORE TELEFONO TO VTELE
        STORE DNI TO VDOCU,OLDOCU
        STORE CUIT TO VCUIT
        STORE SITUIVA TO VIVA
        STORE RECNO() TO REGISTRO
        DO WHILE .T.
           SET COLOR TO B+/B
           @14,0 TO 23,79
           @15,1 CLEAR TO 22,78
           SET CURSOR ON
           SET COLOR TO BG/B,B/W
           @16,2 SAY 'Ingrese D.N.I.:'GET VDOCU PICTURE '99,999,999'
           READ
           IF LASTKEY()=27.OR.VDOCU=0
              RESTORE SCREEN FROM ANDRES
              EXIT
           ENDIF
           SEEK VDOCU
           IF .NOT. EOF().AND.DNI<>OLDOCU
               TONE(1200,1)
               SET COLOR TO W+/B
               @22,2 CLEAR TO 22,77
               SET COLOR TO *R+/B
               @22,30 SAY 'CLIENTE EXISTENTE'
               INKEY(3)
               STORE OLDOCU TO VDOCU
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
           SET COLOR TO B+/B
           @22,29 TO 24,50
           @23,30 CLEAR TO 23,49
           SET COLOR TO BG/B
           @23,31 SAY 'Actualmente es: '
           SET COLOR TO *W+/B
           @23,47 SAY VIVA
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
           @22,25 SAY '¨ Guardar este cambio (S/N) ?'
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
              GO TOP
              GO REGISTRO
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

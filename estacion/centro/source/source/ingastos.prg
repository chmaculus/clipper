#include "colores.ch"
DO WHILE .T.
   CLEAR
   STORE SPACE(30) TO VDET,VOBS
   STORE 0 TO VPRECIO
   @0,0 TO 2,30
   SET COLOR TO COLOR3
   @1,2 SAY 'ESTACION DE SERVICIO CENTRO'
   numero=LEFT(DTOC(DATE()),2)
   DIA=TDIAS(cdow(DATE()))
   MES=TMES(CMONTH(DATE()))
   ANIO=ALLTRIM(STR(YEAR(DATE())))
   VFECHA=DIA+' '+numero+' de '+MES+' de '+ANIO
   LL=79-LEN(VFECHA)
   SET COLOR TO COLOR0
   @1,LL-7 SAY 'Fecha: '
   @3,28 TO 5,51
   LAROPER=LEN(ALLTRIM(NOMBOPER))
   LAOP=INT((LAROPER+19)/2)
   @6,40-LAOP SAY 'Operador de turno:'
   SET COLOR TO COLOR3
   @6,40-LAOP+19 SAY NOMBOPER
   @4,31 SAY 'PANTALLA DE GASTOS'
   @1,LL SAY VFECHA
   SET COLOR TO COLOR0
   @12,0 SAY REPLICATE('Ä',79)
   @13,8 SAY '<ENTER> para ingresar datos - <F9> para ver una lista de gastos'
   @14,0 SAY REPLICATE('Ä',79)
   SET COLOR TO COLOR3
   @13,9 SAY 'ENTER'
   @13,39 SAY 'F9'
   SET COLOR TO COLOR0
   SET CURSOR OFF
   DO WHILE .T.
      INKEY(0)
      IF LASTKEY()<>13.AND.LASTKEY()<>-8.AND.LASTKEY()<>27
         TONE(1200,1)
         LOOP
      ENDIF
      EXIT
   ENDDO
   @12,0 CLEAR TO 14,79
   IF LASTKEY()=27
      RETURN
   ENDIF
   IF LASTKEY()=13
      SET COLOR TO COLOR0
      @3,2 CLEAR TO 5,77
      @3,22 TO 5,57
      SET COLOR TO COLOR3
      @4,25 SAY 'PANTALLA DE INGRESOS DE GASTOS'
      SET CURSOR ON
      SET COLOR TO COLOR0
      @10,0 SAY REPLICATE('Ä',79)
      @12,0 SAY REPLICATE('Ä',79)
      @14,0 SAY REPLICATE('Ä',79)
      @16,0 SAY REPLICATE('Ä',79)
      SET COLOR TO SELECT1
      @11,1 SAY 'Ingrese detalle del gasto :'GET VDET PICTURE '@!'
      @13,1 SAY 'Ingrese importe del gasto :'GET VPRECIO PICTURE '9999.99'
      @15,1 SAY 'Ingrese alguna Observacion:'GET VOBS PICTURE '@!'
      READ
      IF LASTKEY()=27
         LOOP
      ENDIF
      SET CURSOR OFF
      @18,25 SAY '¨ Graba este registro (S/N) ?'
      SET COLOR TO COLOR3
      @18,48 SAY 'S'
      @18,50 SAY 'N'
      SET COLOR TO COLOR0
      DO WHILE .T.
         INKEY(0)
         IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
            TONE(500,1)
            LOOP
         ENDIF
         EXIT
      ENDDO
      IF LASTKEY()=83.OR.LASTKEY()=115
         USE GASTOS
         APPEND BLANK
         REPLACE DETALLE WITH VDET,VALOR WITH VPRECIO
         REPLACE FECHA WITH DATE(),HORA WITH TIME(),OBSERVA WITH VOBS
         REPLACE OPERADOR WITH NOMBOPER,PASWORD WITH CLOP,NUMEROCAJA WITH NUMACT
   
      ENDIF
      LOOP
   ELSE
      SET COLOR TO COLOR0
      @3,2 CLEAR TO 5,77
      @3,22 TO 5,57
      SET COLOR TO COLOR3
      @4,25 SAY 'PANTALLA DE LISTADOS DE GASTOS'
      USE GASTOS
      INDEX ON FECHA TO ORDFEC
      GO TOP
      SET COLOR TO COLOR4
      @8,0 TO 23,79
      @9,1 CLEAR TO 22,78
      @21,1 TO 21,77
      @19,1 TO 19,77
      @20,1 CLEAR TO 20,78
      @22,1 CLEAR TO 22,78
      @22,45 SAY '      Salir'
      @22,25 SAY '      Borra'
      SET COLOR TO COLOR10
      @20,32 SAY 'Fichero de Gastos'
      @22,45 SAY '<ESC>'
      @22,25 SAY '<SUP>'

      DECLARE CAMP[6]
      CAMP[1]='FECHA'
      CAMP[2]='DETALLE'
      CAMP[3]='VALOR'
      CAMP[4]='OBSERVA'
      CAMP[5]='OPERADOR'
      CAMP[6]='NUMEROCAJA'

      DECLARE MASCARA[6]
      MASCARA[1]='99/99'
      MASCARA[2]='9999999999999999999999999999'
      MASCARA[3]='9999.99'
      MASCARA[4]='9999999999999999999999999999'
      MASCARA[5]='9999999999999999999999999999'
      MASCARA[6]='9999999999'

      DECLARE CABEZ[6]
      CABEZ[1]=' Fecha'
      CABEZ[2]='         Detalle'
      CABEZ[3]='Importe'
      CABEZ[4]='         Observacion'
      CABEZ[5]='         Operador de turno'
      CABEZ[6]=' N§ de Caja'

      DECLARE SEPAR[6]
      SEPAR[1]='Ä'
      SEPAR[2]='Ä'
      SEPAR[3]='Ä'
      SEPAR[4]='Ä'
      SEPAR[5]='Ä'
      SEPAR[6]='Ä'
      SET CURSOR OFF
      CLEAR TYPEAHEAD
      SET COLOR TO COLOR7
      DBEDIT(9,1,18,78,CAMP,'FUNGAS',MASCARA,CABEZ,SEPAR)
      IF LASTKEY()=27
         LOOP
      ENDIF
      LOOP
   ENDIF
ENDDO

FUNCTION FUNGAS
PARAMETERS MODE
PUBLIC INTER

DO CASE
    CASE MODE=3
        TONE(500,2)
        SET COLOR TO COLOR4
        @13,29 TO 15,48
        @14,30 CLEAR TO 14,47
        SET COLOR TO COLOR8
        @14,31 SAY 'NO EXISTEN DATOS'
        SET COLOR TO COLOR0
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
        RETURN(1)
    CASE LASTKEY()=27
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=7
        SAVE SCREEN TO ANDRES
        TONE(1200,1)
        SET COLOR TO COLOR9
        @21,24 TO 23,56
        SET COLOR TO COLOR0
        @22,25 CLEAR TO 22,55
        @22,26 SAY '¨ Borra este registro (S/N) ?'
        SET COLOR TO COLOR3
        @22,49 SAY 'S'
        @22,51 SAY 'N'
        SET COLOR TO COLOR0
        DO WHILE .T.
           INKEY(0)
           IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
              TONE(500,1)
              LOOP
           ENDIF
           EXIT
        ENDDO
        IF LASTKEY()=83.OR.LASTKEY()=115
           DELETE
           PACK
        ENDIF
        RESTORE SCREEN FROM ANDRES
        RETURN (2)
    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO COLOR6
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO COLOR0
           GO TOP
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO COLOR6
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+UPPER(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO COLOR0
        GO TOP
        SEEK KK
        IF .NOT. FOUND()
            STORE '' TO KK
            SET COLOR TO COLOR6
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO COLOR13
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO COLOR0
        ENDIF
        RETURN(1)
ENDCASE





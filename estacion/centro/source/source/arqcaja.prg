#include "colores.ch"
DO WHILE .T.
   TODOS=0
   SET COLOR TO COLOR0
   @16,15 TO 20,65
   @17,16 CLEAR TO 19,64
   @17,18 SAY 'Desde Fecha:            Hasta Fecha:'
   @19,28 SAY 'Pulse <ENTER> para tomar todo'
   SET COLOR TO COLOR6
   @17,55 SAY '  /  /    '
   SET COLOR TO COLOR3
   @19,35 SAY 'ENTER'
   SET COLOR TO COLOR0
   SET CURSOR ON
   STORE DATE() TO DESDE,HASTA
   @17,30 SAY ''GET DESDE PICTURE '99/99/9999'
   READ
   IF LASTKEY()=27
      RETURN
   ENDIF
   IF DESDE=CTOD('  /  /    ')
      STORE CTOD('01/01/1990') TO DESDE
      STORE DATE() TO HASTA
      @19,16 CLEAR TO 19,64
      SET COLOR TO COLOR9
      @19,34 SAY 'Tomando TODO'
      SET COLOR TO COLOR0
      SET CURSOR OFF
      TODOS=1
      INKEY(1)
   ELSE
      @19,16 CLEAR TO 19,64
      SET COLOR TO COLOR9
      @19,32 SAY 'Tomando FRACCION'
      SET COLOR TO COLOR0
      @17,54 SAY ''GET HASTA PICTURE '99/99/9999'
      READ
      IF HASTA=CTOD('  /  /    ')
         STORE DATE() TO HASTA
      ENDIF
   ENDIF
   IF DESDE>HASTA
      TONE(1200,1)
      @19,16 CLEAR TO 19,64
      SET COLOR TO COLOR9
      @19,34 SAY 'Mal Ingresado'
      SET COLOR TO COLOR0
      SET CURSOR OFF
      INKEY(1)
      @19,16 CLEAR TO 19,64
      LOOP
   ENDIF
   EXIT
ENDDO
USE GASTOS
INDEX ON FECHA TO ORDFEC
GO TOP
COPY TO TEMPO FOR FECHA>=DESDE.AND.FECHA<=HASTA
GO TOP
SUM VALOR TO VTGASTOS
GO TOP
USE CAJAS
INDEX ON FECHA TO ORDFEC
GO TOP
COPY TO TEMPO FOR FECHA>=DESDE.AND.FECHA<=HASTA
USE TEMPO
GO TOP
STORE LASTREC() TO VCAJAS
SUM TOTVENTAS,ENCAJA,DEBERIA TO VTVENTAS,VTENCAJA,VTDEBERIA
GO TOP
CLEAR
SET COLOR TO COLOR3
@1,0 SAY 'ESTACION DE SERVICIO CENTRO'
numero=LEFT(DTOC(DATE()),2)
DIA=TDIAS(cdow(DATE()))
MES=TMES(CMONTH(DATE()))
ANIO=ALLTRIM(STR(YEAR(DATE())))
VFECHA=DIA+' '+numero+' de '+MES+' de '+ANIO
LL=79-LEN(VFECHA)
SET COLOR TO COLOR0
@1,LL SAY VFECHA
@2,0 SAY REPLICATE('�',27)
@2,LL SAY REPLICATE('�',LEN(VFECHA))
@0,30 TO 2,45
SET COLOR TO COLOR9
@1,32 SAY 'ARQUEOS CAJA'
SET COLOR TO COLOR0
@7,1 SAY REPLICATE('�',78)
@8,0 SAY '�Cant Cajas�Total Ventas�Total Gastos�Deber�a Haber�Dinero Existente�Diferencia�'
@9,1 SAY REPLICATE('�',78)
@10,0 SAY '�'
@10,11 SAY '�'
@10,24 SAY '�'
@10,37 SAY '�'
@10,51 SAY '�'
@10,68 SAY '�'
@10,79 SAY '�'
SET COLOR TO COLOR3
@10,7 SAY VCAJAS PICTURE '999'
@10,16 SAY VTVENTAS PICTURE '9999.999'
@10,29 SAY VTGASTOS PICTURE '9999.999'
@10,43 SAY VTDEBERIA PICTURE '9999.999'
@10,59 SAY VTENCAJA PICTURE '9999.999'
VDIFERENCIA=VTENCAJA-VTDEBERIA
@10,71 SAY VDIFERENCIA PICTURE '9999.999'
SET COLOR TO COLOR0
@11,1 SAY REPLICATE('�',78)
SET CURSOR OFF
SET COLOR TO COLOR0
@14,15 TO 16,65
@15,16 CLEAR TO 15,64
@15,28 SAY '� Quiere Grabar Arqueo (S/N)'
SET COLOR TO COLOR9
@15,52 SAY 'S'
@15,54 SAY 'N'
SET COLOR TO COLOR0
DO WHILE .T.
   INKEY(0)
   IF LASTKEY()=27
      EXIT
   ENDIF
   IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
      TONE(500,1)
      LOOP
   ENDIF
   EXIT
ENDDO
IF LASTKEY()=83.OR.LASTKEY()=115
   USE ARQUEOS
   APPEND BLANK
   REPLACE FECHA WITH DATE(),TOTVENTAS WITH VTVENTAS,TOTGASTOS WITH VTGASTOS
   REPLACE DEBERIA WITH VTDEBERIA,ENCAJA WITH VTENCAJA

ELSE
   RETURN
ENDIF
SET COLOR TO COLOR0
@18,15 TO 20,65
@19,16 CLEAR TO 19,64
@19,27 SAY '� Quiere Imprimir Arqueo (S/N)'
SET COLOR TO COLOR9
@19,53 SAY 'S'
@19,55 SAY 'N'
SET COLOR TO COLOR0
DO WHILE .T.
   INKEY(0)
   IF LASTKEY()=27
      EXIT
   ENDIF
   IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
      TONE(500,1)
      LOOP
   ENDIF
   EXIT
ENDDO
IF LASTKEY()=83.OR.LASTKEY()=115
   SET COLOR TO COLOR0
   @19,53 SAY 'P'
   SET COLOR TO COLOR9
   @19,55 SAY 'I'
   SET COLOR TO COLOR0
   STORE 0 TO TODOS
   DO PRNARQ
   RETURN
ENDIF

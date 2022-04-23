#include "colores.ch"
SET CENTURY ON
SET DATE TO FRENCH
CLEAR

set color to B

@0,0, 25,79 box 'ллллллллл'

store 0 to ttotz,ttottik,tCANTIKEM,ttotcaja,tdevolucio,tdifer
store date() to desde,hasta
store 0 to ncaja
store 'P' to destino

*CLEAR

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
@2,0 SAY REPLICATE('Ф',27)
@2,LL SAY REPLICATE('Ф',LEN(VFECHA))
@0,30 TO 2,45

SET COLOR TO COLOR9
@1,32 SAY 'LISTADO CAJA'


SET COLOR TO GET01
DO WHILE .T.
set cursor on
   @3,10 say 'Desde:' get desde picture '99/99/9999'
   @4,10 say 'Hasta:' get hasta picture '99/99/9999'
   @08,10 say 'Pantalla/Impresora P/I:' get destino picture '!' valid destino$'PI'
  read
 if lastkey()=27
    return
 endif
EXIT
ENDDO

SET COLOR TO COLOR0

USE .\esc\CAJAS
INDEX ON FECHA TO O_CAJFEC
GO TOP

SET FILTER TO FECHA>=DESDE.AND.FECHA<=HASTA


IF DESTINO='P' .OR. DESTINO='p'
   SAVE SCREEN TO AA
   pantalla()
   RESTORE SCREEN FROM AA
   RETURN
ENDIF

IF DESTINO='I' .OR. DESTINO='i'
   SAVE SCREEN TO AA
   imprime()
   RESTORE SCREEN FROM AA
   RETURN
ENDIF


function pantalla
SET COLOR TO COLOR4
@5,0 TO 24,79
@6,1 CLEAR TO 23,78
@18,1 TO 20,77
@20,0 TO 22,79
@23,35 SAY '      Salir'

SET COLOR TO COLOR10
@23,35 SAY '<ESC>'

SUM VENTAS TO VTOTVENTAS

set color to w/b
@21,2 SAY 'Total Ventas Desde:'
set color to w+/b
@21,22 SAY desde
set color to w/b
@21,34 SAY 'hasta Fecha:'
set color to w+/b
@21,47 SAY hasta
set color to w/b
@21,58 SAY 'Total:'
set color to w+/b
@21,65 SAY VTOTVENTAS

DECLARE CAMP[8]
CAMP[1]='FECHA'
CAMP[2]='HORACI'
CAMP[3]='OPERADOR'
CAMP[4]='VENTAS'
CAMP[5]='GASTOS'
CAMP[6]='INICIAL'
CAMP[7]='TOTCAJA'
CAMP[8]='NUMEROCAJA'

DECLARE CABEZ[8]
CABEZ[1]='Fecha'
CABEZ[2]='H. Cierre'
CABEZ[3]='Operador'
CABEZ[4]='Tot. Ventas'
CABEZ[5]='Gastos'
CABEZ[6]='Din.Inicial'
CABEZ[7]='Tot.Caja'
CABEZ[8]='NЇ Caja'

DECLARE SEPAR[8]
SEPAR[1]='Ф'
SEPAR[2]='Ф'
SEPAR[3]='Ф'
SEPAR[4]='Ф'
SEPAR[5]='Ф'
SEPAR[6]='Ф'
SEPAR[7]='Ф'
SEPAR[8]='Ф'

SET CURSOR OFF
CLEAR TYPEAHEAD

SET COLOR TO COLOR7
go top
DBEDIT(6,1,19,78,CAMP,'','',CABEZ,SEPAR)
return

SUM TOTVENTAS TO VTOTVENTAS

SET COLOR TO W+/n
@32,3 SAY 'Total Ventas desde Fecha:'
@32,29 SAY desde
@32,29 SAY 'hasta Fecha:'
@32,42 SAY hasta
@32,60 SAY VTOTVENTAS
return nil


function imprime
go top

*set printer to listcaja.txt

set printer to lpt1
set device to print

if eof()
  @12,40 say 'NO EXISTEN DATOS'
  INKEY(0)
  RETURN
ENDIF

set device to printer
  @ PROW(),PCOL() SAY CHR(27)+'C'+CHR(72)
  @ PROW(),PCOL() SAY CHR(15)
  @ prow()+1,1 say date()
  @ prow()+1,30 say 'ESTACION DE SERVICIO CENTRO CONTROL DE CAJAS'
  @ prow()+2,1 say 'Desde: '+dtoc(desde)+' Hasta: '+dtoc(hasta)
  @ prow()+2,0 say 'Fecha'
  @ prow()  ,9 say 'Operador'
  @ prow()  ,22 say 'Caja Nro.'
  @ prow()  ,33 say 'Ventas'
  @ prow()  ,49 say 'Gastos'
  @ prow()  ,61 say 'Inicial'
  @ prow()  ,75 say 'Tot.Caja'
  @ prow()  ,85 say 'Ef.en Caja'
  do while .t.
    if eof()
      store prow() to linea
      exit
    endif
      XX=DTOC(FECHA)

      @prow()+1,0 say SUBS(XX,1,6)+SUBS(XX,9,2)
      @prow()  ,9 say operador
      @prow()  ,22 say NUMEROCAJA
      @prow()  ,33 say VENTAS
      @prow()  ,46 say GASTOS
      @prow()  ,60 say INICIAL
      @prow()  ,75 say TOTCAJA
      @prow()  ,83 say EFENCAJA

      skip
      loop
  enddo

  go top
  sum VENTAS to vtotalvtas
  go top
  sum gastos to vgastos
  go top
  sum INICIAL to vencaja
  go top
  sum EFENCAJA to VEFECTIVO

  @prow()+2,28 say vtotalvtas
  @prow()  ,41 say vgastos
  @prow()  ,55 say vencaja
  @prow()  ,78 say VEFECTIVO


 set device to screen
 set printer to lpt1
return


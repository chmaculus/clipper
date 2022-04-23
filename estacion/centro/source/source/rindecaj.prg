#include "colores.ch"

SET TALK OFF
SET SCOREBOARD OFF
SET STATUS OFF
SET DATE BRIT
SET MENU OFF
set cent on
set dele on

PUBLIC VGRB_CAJA
PUBLIC VSVUELVE

use .\ESC\VTANRO
go top
store VTANRO to VVTANRO

use .\ESC\nrocaja
go top
*store cajanro to ncaja (VER ME PARECE QUE FALLA)
use .\ESC\cajas
INDEX ON FECHA TO CAJAS

STORE LASTREC() TO ncaja

store VOPERA to mresponsable
*store space(5) to ncaja
store date() to vfecha
STORE 0 TO VGRB_CAJA
STORE TIME() TO VHORACI

STORE 0 TO tEFENCAJA




***stand
store 0 to vnroz,vtotothers,vcanttikem,vretiros,vmutual,vdevolucion

***totales
store 0 to vtotalcaja,vtottik,vtotaltarj,vdife
STORE VTOT_SUBTOT TO vtotz
STORE VTOTZ+VINICIAL-VTOT_GASTOS TO VTOTALEFECTIVO

****Tikets
store 0 to vpatacon,vlecop

**sumas
store 0 to vcltctas,vperctacte,vmonedas,vbilletes
store 0 to vpagefvo

****doble
store 0 to tvcltctas,tvperctacte,tvtotaltarj,tvmonedas,tvbilletes,tvtottik,tvpagefvo,tvotros

***Tarjetas_dbl
store 0 to tvdevolucion

****tickets_dbl
store 0 to tvpatacon,tvlecop

*INICIO01()

DO WHILE .T.
  INICIO01()
  GET_DATA()
  decide()

  IF VSVUELVE=1
     LOOP
  ENDIF

EXIT
ENDDO


FUNCTION INICIO01
clear
set color to B
@1,1, 24,79 BOX 'ллллллллл'

set color to w+/b
@ 1,1 say 'ESTACION DE SERVICIO CONTROL CAJAS'


set color to w/b
@19,1 say 'Total Clasificacion:'
@19,24 say vclasificacion
@19,44 say VTOT_CLASIFICACION
      
set color to w/b
@20,1 say 'Total Ventas:'
@20,18 say vtotz

set color to w/b
@21,1 say 'Efectivo inicial:'
@21,23 say VINICIAL


@22,1 say 'Total Gastos:'
@22,18 say VTOT_GASTOS

@23,1 say 'TOTAL EFECTIVO:'
@23,18 say VTOTALEFECTIVO

set color to w/b
@20,40 say 'Efectivo en Caja:'

set color to w/b
@22,40 say 'Diferencia:'
RETURN NIL



function totales
****************
store vtotothers+vtottik to vtotalcaja
store VTOTALEFECTIVO-vtotalcaja to vdife      

set color to W/B
@20,58 say vtotalcaja picture '999999.99'
@22,58 say vdife  picture '999999.99'
set color to get02
return .t.



Function others
***************
if lastkey()=27.or.lastkey()=24.or.lastkey()=5
   return .t.
endif
store readvar() to variable
store 'T'+variable to sumador
store &variable+&sumador to &sumador
store 0 to &variable
store &sumador to vtotvar
store tvbilletes+tvmonedas-tvdevolucion to vtotothers
@ row(),col() say vtotvar picture '999999.99'
store vtotothers+vtottik to vtotalcaja
store VTOTALEFECTIVO-vtotalcaja to vdife      
set color to W/B
@20,58 say vtotalcaja picture '999999.99'
@22,58 say vdife  picture '999999.99'
if lastkey()<>27.or.lastkey()<>24
   return .f.
endif
set color to get02
return .t.

Function Impcaj1
***************
set printer to caja.txt
set device to printer


@ 1,1 say 'ESTECION DE SERVICIO CENTRO CONTROL DE CAJAS'

@ 1,30 say 'Fecha:'
@ prow(),pcol() say vfecha picture '99/99/9999'

@ 1,48   say 'Nro.de Z:'
@ prow(),pcol() say vnroz picture '99999'



@ 2,1   say 'Caja Nro. :'
@ prow(),pcol() say ncaja picture '@!'

@ 2,40  say 'Billetes   :'
@ prow(),pcol() say tvbilletes  picture '999999.99'

@ 3,1   say 'Operador       :'
@ prow(),pcol() say mresponsable picture '@!'

@ 3,40  say 'Monedas    : '
@ prow(),pcol() say tvmonedas   picture '99999.99'

@ 4,1   say 'Total Ventas   :'
@ prow(),pcol() say vtotz picture      '999999.99'

@ 5,1   say 'NRO de Ventas  :'
@ prow(),pcol()  say vcanttikem picture    '999999.99'

@ 7,40  say 'Total Efec :'
@ prow(),pcol() say tvmonedas+tvbilletes picture '999999.99'

@29,1 say  'TOTAL CAJA:'
@ prow(),pcol() say vtotalcaja   picture '999999.99'

@30,1 say 'Difer.c/Z :'
@ prow(),pcol() say vdife   picture '999999.99'

*eject
set device to screen
return .t.

function gbrcaja

go botto
appen blank

replace NUMEROCAJA with ncaja
replace operador with mresponsable
replace FECHA with vfecha
replace HORACI with VHORACI
replace HORAAP with VHORAAP
replace VENTAS with vtotz
replace EFENCAJA with VTOTALEFECTIVO
replace TOTCAJA with vtotalcaja
replace DIFER with vdife
replace gastos WITH VTOT_GASTOS
REPLACE CANTVTAS WITH VVTANRO
REPLACE INICIAL WITH VINICIAL



store ncaja+1 to ncaja
use .\ESC\nrocaja
go top
replace cajanro with ncaja

STORE 1 TO VGRB_CAJA
set color to color0
return nil


function decide
        STORE 1 TO VSVUELVE

        set color to SELECT1
        @21,58 say 'Sale S/N: ' 
        INKEY(0)
        set color to COLOR0

        IF lastkey()=27
           STORE 0 TO VSVUELVE
           RETURN NIL
        ENDIF
         
        IF LASTKEY()=78.OR.LASTKEY()=110.OR.lastkey()=27
           STORE 1 TO VSVUELVE
           RETURN NIL
        ENDIF
         
        IF LASTKEY()=13.OR.LASTKEY()=83.OR.lastkey()=115
           STORE 0 TO VSVUELVE
        ENDIF

        set color to SELECT1
        @21,58 say 'Graba Caja S/N: '
        INKEY(0)
        set color to COLOR0
        
        IF lastkey()=27
           STORE 0 TO VSVUELVE
           RETURN NIL
        ENDIF
         
        IF LASTKEY()=78.OR.LASTKEY()=110
           STORE 0 TO VSVUELVE
        ENDIF
         
        IF LASTKEY()=13.OR.LASTKEY()=83.OR.lastkey()=115
           STORE 0 TO VSVUELVE
           gbrcaja()
        ENDIF

        @21,55 clear to 21,76
        SET COLOR TO GET01
        @21,55 say 'Imprime Caja S/N: '
        INKEY(0)

        IF LASTKEY()=13.OR.LASTKEY()=78.OR.LASTKEY()=110.OR.lastkey()=27
           STORE 0 TO VSVUELVE
           RETURN NIL
        ENDIF
         
        IF LASTKEY()=83.OR.lastkey()=115
           STORE 0 TO VSVUELVE
           impcaj1()
           return nil
        ENDIF

STORE 0 TO VSVUELVE
return nil

FUNCTION GET_DATA
do while .t.
   SET CURSOR ON

   set color to COLOR0
   @ 3,1  say 'Fecha:'
   @ 3,8  say vfecha

   *SET COLOR TO W/B
   @ 4,1 say 'Caja Nro. :'
   @ 4,12 say ncaja

   @ 5,1  say 'Resposable:'
   @ 5,12  say mresponsable

   @ 7,1  say 'Cantidad Ventas  :'
   @ 7,19  say VVTANRO

   @ 9,1 say 'Efectivo Billetes:' get vbilletes  picture '999999.99'  valid others()
   @ 10,1 say 'Monedas          :' get vmonedas   picture '999999.99'  valid others()
   @ 12,1 say 'Devoluciones     :' get vdevolucion picture    '999999.99'  valid others()
   read

   *set color to w+/b
*   @14,1  say 'Tickets   :'

   *set color to get02
*   @16,1 say 'Patacon:' get vpatacon picture    '999999.99' vali tik()
*   @17,1 say 'Lecop  :' get vlecop  picture    '999999.99' vali tik()
*   read

   if lastkey()=27
       exit
   endif
exit
enddo
RETURN NIL


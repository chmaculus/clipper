#include "colores.ch"
CLEAR

store space(20) to vclasi
STORE 0 TO id_clasi
public vclasi, id_clasi, id_clasi_n

DO WHILE .T.
   ultima_idclasific()

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
   @3,20 TO 5,59
   SET COLOR TO COLOR3
   @4,23 SAY 'PANTALLA INGRESO DE CLASIFICACION'
   @1,LL SAY VFECHA
   SET CURSOR ON
   SET COLOR TO COLOR0
   @6,0 SAY REPLICATE('Ä',79)
   @8,0 SAY REPLICATE('Ä',79)
   @9,35 SAY 'Ultimo ¢rden de c¢digo ingresado:'
   SET COLOR TO LETRASC0
   @9,69 SAY Id_clasi


   IF LASTKEY()=27
      RETURN
   ENDIF


   SET COLOR TO GET02
   @11,1 SAY 'Clasificacion:'GET vclasi PICTURE '@!'
   READ

   IF LASTKEY()=27
      RETURN
   ENDIF

   SET COLOR TO  COLOR0
   SET CURSOR OFF
   @23,25 SAY '¨ Graba esta clasificacion (S/N) ?'
   SET COLOR TO COLOR3
   @23,53 SAY 'S'
   @23,55 SAY 'N'
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
      APPEND BLANK

      REPLACE ID WITH id_clasi_n
      REPLACE CLASIFICAC WITH vclasi

      STORE SPACE(30) TO Vclasi
   ENDIF

   CLEAR
   LOOP
ENDDO





function ultima_idclasific()
   USE clasific
   index on id to id_clasi
   GO BOTTOM
   STORE id TO id_clasi
   STORE id_clasi+1 TO id_clasi_n
return nil





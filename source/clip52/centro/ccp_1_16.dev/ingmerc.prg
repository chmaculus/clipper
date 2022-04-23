#include "colores.ch"
CLEAR

STORE SPACE(60) TO VDETALLE
STORE 0 TO VBARRA
STORE 0 TO VPCOSTO,VGANANCIA,VVENTA,oldcodi,vcodigo
public oldcodi, vcodigo

USE MERCA
INDEX ON CODIGBARRA TO ORDBARRA
INDEX ON CODIGO TO ORDCOD

DO WHILE .T.
   ultimo_registro()

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
   @4,23 SAY 'PANTALLA DE INGRESOS DE MERCADERIA'
   @1,LL SAY VFECHA
   SET CURSOR ON
   SET COLOR TO COLOR0
   @6,0 SAY REPLICATE('Ä',79)
   @8,0 SAY REPLICATE('Ä',79)
   @9,35 SAY 'Ultimo ¢rden de c¢digo ingresado:'
   SET COLOR TO LETRASC0
   @9,69 SAY OLDCODI
   SET COLOR TO GET02
   @7,1 SAY 'C¢digo de Barra:'GET VBARRA PICTURE '99999999999999'
   SET CONFIRM OFF
   READ

   IF LASTKEY()=27
      RETURN
   ENDIF

   verifica_barra()

   @9,1 SAY 'C¢digo :'GET VCODIGO PICTURE '999999'
   SET CONFIRM ON
   @10,0 SAY REPLICATE('Ä',79)
   READ

   IF LASTKEY()=27
      RETURN
   ENDIF

   USE MERCA INDEX ORDCOD
   GO TOP
   SEEK VCODIGO

   IF .NOT. EOF()
      TONE(1200,1)
      TONE(1200,1)
      TONE(1200,1)
      SET CURSOR OFF
      SET COLOR TO COLOR9
      @18,27 SAY 'C¢digo de art¡culo EXISTENTE'
      SET COLOR TO COLOR0
      INKEY(3)
      STORE 0 TO VCODIGO
      CLEAR
      LOOP
   ENDIF

   SET COLOR TO GET02
   @11,1 SAY 'Detalle:'GET VDETALLE PICTURE '@!'
   SET COLOR TO COLOR0
   @12,0 SAY REPLICATE('Ä',79)
   READ

   SET COLOR TO GET02
   @13,1 SAY 'Precio de Costo:'GET VPCOSTO PICTURE '9999.999' RANGE 0,9999.999
   SET COLOR TO COLOR0
   @14,0 SAY REPLICATE('Ä',79)
   @15,1 SAY 'Precio de Venta:'GET VVENTA PICTURE '9999.999' RANGE 0,9999.999
   SET COLOR TO GET02
   SET COLOR TO COLOR0
   @16,0 SAY REPLICATE('Ä',79)
   READ

   IF LASTKEY()=27
      RETURN
   ENDIF

   IF VVENTA<=VPCOSTO
      TONE(1200,1)
      TONE(1200,1)
      TONE(1200,1)
      SET CURSOR OFF
      SET COLOR TO COLOR9
      @18,14 SAY 'El precio de VENTA es menor o igual que el de COSTO'
      SET COLOR TO COLOR0
      INKEY(8)
      CLEAR
      LOOP
   ENDIF

   PLISTA=ROUND((VVENTA/1.21),3)
   VGANANCIA=ROUND(((PLISTA-VPCOSTO)/VPCOSTO)*100,3)

   store 0 to id_clasificacion
   public id_clasificacion,vclasificacion

   save screen to aa

   do clas_lis

   restore screen from aa

   IF LASTKEY()=27
      RETURN
   ENDIF

   @17,1 SAY 'CLASIFICACION  :'+vclasificacion
   @19,1 SAY '% de ganancia  :'
   @21,1 SAY 'Precio sin IVA :'
   @18,0 SAY REPLICATE('Ä',79)
   @20,0 SAY REPLICATE('Ä',79)
   SET COLOR TO COLOR3
   @19,18 SAY '% '+ALLTRIM(STR(VGANANCIA))
   @21,18 SAY '$ '+ALLTRIM(STR(PLISTA))
   SET COLOR TO  COLOR0
   SET CURSOR OFF
   @23,25 SAY '¨ Graba este art¡culo (S/N) ?'
   SET COLOR TO COLOR3
   @23,48 SAY 'S'
   @23,50 SAY 'N'
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
      use merca
      APPEND BLANK
      REPLACE CODIGO WITH VCODIGO
      REPLACE DETALLE WITH VDETALLE
      REPLACE CODIGBARRA WITH VBARRA
      REPLACE PCOSTO WITH VPCOSTO,GANANCIA WITH VGANANCIA,SINIVA WITH PLISTA
      REPLACE CONIVA WITH VVENTA
      REPLACE idclasific WITH id_clasificacion

      STORE SPACE(60) TO VDETALLE
      STORE 0 TO VBARRA
      STORE 0 TO VCODIGO
      STORE 0 TO VPCOSTO,VGANANCIA,VVENTA
   ENDIF

   CLEAR
   LOOP
ENDDO






































function ultimo_registro()
   USE MERCA
   set index to ordcod
   reindex
   GO BOTTOM
   STORE CODIGO TO OLDCODI
   STORE OLDCODI+1 TO VCODIGO
return nil



function verifica_barra()
   save screen to aa
   if vbarra=0
      return nil
   endif

      USE MERCA INDEX ORDBARRA
      GO TOP
      SEEK VBARRA

      IF .NOT. EOF()
         TONE(1200,1)
         TONE(1200,1)
         TONE(1200,1)
         SET CURSOR OFF
         SET COLOR TO COLOR9
         @15,22 SAY 'C¢digo de barras de art¡culo EXISTENTE'
         SET COLOR TO COLOR0
         INKEY(3)
         CLEAR
         STORE 0 TO VCODIGO
         STORE 0 TO VBARRA
         return nil
      ENDIF
   restore screen from aa      
return nil


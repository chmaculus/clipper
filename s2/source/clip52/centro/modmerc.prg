#include "colores.ch"
SAVE SCREEN TO JERI

store 0 to error
public error

USE MERCA
INDEX ON CODIGO TO ORDCOD
INDEX ON DETALLE TO ORDDET

DO WHILE .T.
   GO TOP
   SET COLOR TO COLOR4
   @8,1 TO 23,78
   @9,2 CLEAR TO 22,76
   @21,2 TO 21,77
   @19,2 TO 19,77
   @20,2 CLEAR TO 20,77
   @22,2 CLEAR TO 22,77
   @22,11 SAY '        Tomar'
   @22,58 SAY '      Salir'
   @20,48 SAY 'Por C¢digo -      Por Detalle'
   SET COLOR TO COLOR10
   @20,5 SAY 'Art¡culos ordenados:'
   @20,43 SAY '<F2>'
   @20,61 SAY '<F3>'
   @22,11 SAY '<ENTER>'
   @22,58 SAY '<ESC>'

   DECLARE CAMP[3]
   CAMP[1]='CODIGO'
   CAMP[2]='DETALLE'
   CAMP[3]='idclasific'

   DECLARE CABEZ[3]
   CABEZ[1]=' C¢digo'
   CABEZ[2]='                       Detalle'
   CABEZ[3]='Clasificacion'

   DECLARE SEPAR[3]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'

   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO COLOR6
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO COLOR7
   DBEDIT(9,2,18,77,CAMP,'FUNMOD','',CABEZ,SEPAR)

   IF LASTKEY()=-1
      INDEX ON CODIGO TO ORDCOD
      GO TOP
      LOOP
   ENDIF

   IF LASTKEY()=-2
      INDEX ON DETALLE TO ORDDET
      GO TOP
      LOOP
   ENDIF

   IF LASTKEY()=27
      RETURN
   ENDIF
   EXIT

ENDDO

STORE CODIGO TO VCODIGO,VC
STORE DETALLE TO VDETALLE,VD
STORE CODIGBARRA TO VBARRA,VB
STORE PCOSTO TO VPCOSTO,VP
STORE CONIVA TO VVENTA,VV
STORE GANANCIA TO VGANANCIA,VG
store idclasific to id_clasificacion
STORE RECNO() TO REGISTRO

public id_clasificacion,vclasificacion

CLEAR
DO WHILE .T.
   store 0 to error

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
   @3,20 TO 5,61
   SET COLOR TO COLOR3
   @4,22 SAY 'PANTALLA DE MODIFICACION DE MERCADERIA'
   @1,LL SAY VFECHA
   SET CURSOR ON
   SET COLOR TO COLOR0
   @6,1 SAY 'C¢digo actual: '
   SET COLOR TO COLOR3
   @6,16 SAY VCODIGO
   STORE VCODIGO TO VCOD2
   SET COLOR TO COLOR0
   @7,0 SAY REPLICATE('Ä',79)
   SET COLOR TO GET01
   @8,1 SAY 'C¢digo : '
   @8,1 SAY 'C¢digo :'GET VCODIGO PICTURE '999999'
   SET COLOR TO COLOR0
   @9,0 SAY REPLICATE('Ä',79)
   READ

   IF LASTKEY()=27
      RETURN
   ENDIF

   public VCODIGO,VCOD2
   verifica_codigo()

   if error=1
      loop
   endif

   SET COLOR TO GET01
   @10,1 SAY 'Detalle:'GET VDETALLE PICTURE '@!'
   SET COLOR TO COLOR0
   @11,0 SAY REPLICATE('Ä',79)
   SET COLOR TO GET01
   @12,1 SAY 'C¢digo de Barra:'GET VBARRA PICTURE '999999999999999'
   SET COLOR TO COLOR0
   @13,0 SAY REPLICATE('Ä',79)
   read

   IF LASTKEY()=27
      RETURN
   ENDIF

   save screen to aa

   id_clasificacion()
   @14,1 SAY 'CLASIFICACION  :'+vclasificacion
   inkey(0)

   do clas_lis

   restore screen from aa
   set cursor on
   @14,1 SAY 'CLASIFICACION  :'+vclasificacion
   SET COLOR TO GET01
   @16,1 SAY 'Precio de Costo:'GET VPCOSTO PICTURE '9999.999' RANGE 0,9999.999
   SET COLOR TO COLOR0
   @15,0 SAY REPLICATE('Ä',79)
   SET COLOR TO GET01
   @18,1 SAY 'Precio de Venta:'GET VVENTA PICTURE '9999.999' RANGE 0,9999.999
   SET COLOR TO COLOR0
   @17,0 SAY REPLICATE('Ä',79)
   READ

   IF LASTKEY()=27
      RETURN
   ENDIF

   public VVENTA,VPCOSTO
   verifica_pventa()

   if error=1
      loop
   endif

   PLISTA=ROUND((VVENTA/1.21),3)
   VGANANCIA=ROUND(((PLISTA-VPCOSTO)/VPCOSTO)*100,3)
   @18,1 SAY '% de ganancia  :'
   @19,0 SAY REPLICATE('Ä',79)
   @20,1 SAY 'Precio sin IVA :'
   @21,0 SAY REPLICATE('Ä',79)
   SET COLOR TO COLOR3
   @18,18 SAY '% '+ALLTRIM(STR(VGANANCIA))
   @20,18 SAY '$ '+ALLTRIM(STR(PLISTA))
   SET COLOR TO COLOR0
   SET CURSOR OFF
   @23,25 SAY '¨ Grabar modificaci¢n (S/N) ?'
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
      USE MERCA
      GO REGISTRO
      REPLACE CODIGO WITH VCODIGO,DETALLE WITH VDETALLE,CODIGBARRA WITH VBARRA
      REPLACE PCOSTO WITH VPCOSTO,GANANCIA WITH VGANANCIA,SINIVA WITH PLISTA
      replace idclasific with id_clasificacion
      REPLACE CONIVA WITH VVENTA

      INDEX ON CODIGO TO ORDCODST
      GO TOP
      SEEK VCOD2

      IF .NOT. EOF()
         REPLACE CODIGO WITH VCODIGO
         REPLACE DETALLE WITH VDETALLE
         REPLACE CODIGBARRA WITH VBARRA
         REPLACE PCOSTO WITH VPCOSTO,CONIVA WITH VVENTA
         replace idclasific with id_clasificacion
      ENDIF

      RESTORE SCREEN FROM JERI

      DO MODMERC

      IF LASTKEY()=27
         RETURN
      ENDIF
   ENDIF
   @23,2 CLEAR TO 23,77
   STORE VC TO VCODIGO
   STORE VD TO VDETALLE
   STORE VB TO VBARRA
   STORE VP TO VPCOSTO
   STORE VG TO VGANANCIA
   STORE VV TO VVENTA
   LOOP
ENDDO





function verifica_codigo()
   IF VCODIGO<>VCOD2
      USE MERCA INDEX ORDCOD
      GO TOP
      SEEK VCODIGO

      IF .NOT. EOF()
         TONE(1200,1)
         TONE(1200,1)
         TONE(1200,1)
         SET CURSOR OFF
         SET COLOR TO COLOR9
         @15,27 SAY 'C¢digo de art¡culo EXISTENTE'
         SET COLOR TO COLOR0
         INKEY(3)
         STORE VCOD2 TO VCODIGO
         CLEAR
         store 1 to error
         return
      ENDIF
   ENDIF
return nil

function verifica_pventa()
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
      store 1 to error
      return
   ENDIF
return nil

function id_clasificacion()
   if id_clasificacion=0
      store "SIN CLASIFICACION" to vclasificacion
      return
   endif
      
   use clasific
   set index to id_clasi
   go top
   seek id_clasificacion

   if found()=.t.
      store clasificac to vclasificacion
   else
      store "SIN CLASIFICACION" to vclasificacion
   endif
return nil

#include "colores.ch"
set COLOR TO COLOR0

USE esc\clasific
set index to esc\id_clasi
seek id_clasificacion

DECLARE CAMP[2]
CAMP[1]='id'
CAMP[2]='clasificac'

DECLARE CABEZ[2]
CABEZ[1]='ID'
CABEZ[2]='Clasificacion'

DECLARE SEPAR[2]
SEPAR[1]='Ф'
SEPAR[2]='Ф'

SET CURSOR OFF
CLEAR TYPEAHEAD
@9,19, 19,59 box 'ллллллллл'

SET COLOR TO COLOR7
DBEDIT(10,20,18,58,CAMP,'','',CABEZ,SEPAR)

IF LASTKEY()=27
   return
endif

IF LASTKEY()=13
   store id to id_clasificacion
   store clasificacion to vclasificacion
   return
endif


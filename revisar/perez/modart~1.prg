#WNAME wz_win
#READCLAUSE NOLOCK
*~ WIZARDSCREEN

#SECTION1
PRIVATE wzfields,wztalk
IF SET("TALK") = "ON"
	SET TALK OFF
	m.wztalk = "ON"
ELSE
	m.wztalk = "OFF"
ENDIF
m.wzfields=SET('FIELDS')
SET FIELDS OFF
IF m.wztalk = "ON"
	SET TALK ON
ENDIF


#SECTION2

#DEFINE C_DBFEMPTY		'La base de datos está vacía. ¿Desea agregar algún registro?'
#DEFINE C_EDITS			'Por favor, finalice su edición.' 
#DEFINE C_TOPFILE		'Principio de archivo.'
#DEFINE C_ENDFILE		'Fin de archivo.'
#DEFINE C_BRTITLE		'Encontrar registro'
#DEFINE C_NOLOCK		'En este momento no se puede bloquear el registro, inténtelo más tarde.' 
#DEFINE C_ECANCEL		'Edición cancelada.'
#DEFINE C_DELREC		'¿Eliminar registros seleccionados?'
#DEFINE C_NOFEAT		'Característica no disponible ahora.'
#DEFINE C_NOWIZ			'Asistente no disponible.'
#DEFINE C_MAKEREPO		'Crear un informe con el Asistente para informes.'
#DEFINE C_NOREPO		'No se puede crear el informe.'
#DEFINE C_DELNOTE 		'Eliminando registros...'
#DEFINE C_READONLY 		'La tabla es de sólo lectura: no se permite su edición.'
#DEFINE C_NOTABLE 		'No hay ninguna tabla seleccionada. Abra una tabla o ejecute una consulta.'
#DEFINE C_BADEXPR		'Expresión no válida.'
#DEFINE C_LOCWIZ		'Buscar WIZARD.APP:'
#DEFINE C_MULTITABLE	'Tiene tablas de relación multiple: no se permite agregar registros.'

MOVE WINDOW 'wz_win' CENTER
PRIVATE isediting,isadding,wztblarr
PRIVATE wzolddelete,wzolderror,wzoldesc
PRIVATE wzalias, tempcurs,wzlastrec
PRIVATE isreadonly,find_drop,is2table

IF EMPTY(ALIAS())
	WAIT WINDOW C_NOTABLE
	RETURN
ENDIF

m.wztblarr= ''
m.wzalias=SELECT()
m.isediting=.F.
m.isadding=.F.
m.is2table = .F.
m.wzolddelete=SET('DELETE')
SET DELETED ON
m.tempcurs=SYS(2015)  &&used if General field
m.wzlastrec = 1
m.wzolderror=ON('error')
ON ERROR DO wizerrorhandler
wzoldesc=ON('KEY','ESCAPE')
ON KEY LABEL ESCAPE
m.find_drop = IIF(_DOS,0,2)

m.isreadonly=IIF(ISREAD(),.T.,.F.)
IF m.isreadonly
	WAIT WINDOW C_READONLY TIMEOUT 1
ENDIF


IF RECCOUNT()=0 AND !m.isreadonly AND fox_alert(C_DBFEMPTY)
    APPEND BLANK
ENDIF

GOTO TOP
SCATTER MEMVAR MEMO
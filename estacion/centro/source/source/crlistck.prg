DECLARE CAMP[10]
CAMP[1]='CODIGO'
CAMP[2]='DETALLE'
CAMP[3]='CONIVA'
CAMP[4]='CANTIDAD'
CAMP[5]='REAL'
CAMP[6]='FALTANTE'

DECLARE TIPO[6]
TIPO[1]='N'
TIPO[2]='C'
TIPO[3]='N'
TIPO[4]='N'
TIPO[5]='N'
TIPO[6]='N'

DECLARE LON[6]
LON[1]=8
LON[2]=60
LON[3]=8
LON[4]=5
LON[5]=8
LON[6]=8

DECLARE DECI[6]
DECI[1]=0
DECI[2]=0
DECI[3]=2
DECI[4]=0
DECI[5]=0
DECI[6]=0


ERASE SWAP.DBF
ERASE TEMP.DBF

CREATE TEMP

STORE 1 TO I
do while .t.
   APPEND BLANK
   REPLACE field_name with CAMP[I]
   REPLACE field_type with tipo[I]
   REPLACE field_len with lon[I]
   REPLACE field_dec with deci[I]

   if i=6
     exit
   endif

   store i+1 to i
   loop
enddo

CREATE LISTOCK FROM TEMP
ERASE TEMP.DBF

USE LISTOCK
ZAP

USE STOCK
COPY TO STKSWP FOR .NOT.CANTIDAD=0
ERASE ORDTMP.NTX

USE LISTOCK
ZAP
APPEND FROM STKSWP

STORE 0 TO VCODIGO
STORE 0 TO VCANT
STORE 0 TO SALE
STORE 1 TO IR

USE MERCA
INDEX ON CODIGO TO ORDCOD
GO TOP

IF .NOT. DESDE=0
*  SET FILTER TO CODIGO=>DESDE.AND.CODIGO<=HASTA
ENDIF
USE MERCA
INDEX ON CODIGO TO ORDTEMP

   DO WHILE.T.
     USE LISTOCK

     GO IR

     IF EOF()=.T.
       STORE 1 TO SALE
     ENDIF

     STORE CODIGO TO VCODIGO

     IF .NOT. SALE=1
        USE MERCA
        SET INDEX TO ORDTEMP
        SEEK VCODIGO
        IF FOUND()=.F.
           STORE IR+1 TO IR
           LOOP
        ENDIF
     ENDIF


     STORE DETALLE TO VDET
     STORE CONIVA TO VCONIVA

     USE LISTOCK
     GO IR

     IF SALE=1
       EXIT
     ENDIF

     REPLACE DETALLE WITH VDET
     REPLACE CONIVA WITH VCONIVA

     STORE IR+1 TO IR

     LOOP
  ENDDO

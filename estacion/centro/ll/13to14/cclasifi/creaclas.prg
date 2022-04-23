DECLARE CAMP[2]
CAMP[1]='MARCA'
CAMP[2]='CODIGO'


DECLARE TIPO[2]
TIPO[1]='N'
TIPO[2]='C'

DECLARE LON[2]
LON[1]=3
LON[2]=20

DECLARE DECI[2]
DECI[1]=0
DECI[2]=0


ERASE CLASIFIC.DBF
ERASE TEMP.DBF

CREATE TEMP
store 1 to I

do while .t.
   APPEND BLANK
   REPLACE field_name with CAMP[I]
   REPLACE field_type with tipo[I]
   REPLACE field_len with lon[I]
   REPLACE field_dec with deci[I]

   if i=2
     exit
   endif

   store i+1 to i
   loop
enddo

CREATE CLASIFIC FROM TEMP
ERASE TEMP.DBF

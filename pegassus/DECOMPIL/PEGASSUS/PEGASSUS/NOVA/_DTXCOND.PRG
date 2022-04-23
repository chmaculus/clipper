#include "common.ch"
#include "inkey.ch"

********************************
function _DTXCONDSE(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
   Arg9, Arg10, Arg11)

   return ordcondset(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg8, Arg9, ;
      Arg10, Arg11)

********************************
function DBCREATEIN(Arg1, Arg2, Arg3, Arg4, Arg5)

   ordcreate(Arg1, Arg5, Arg2, Arg3, Arg4)
   return Nil

********************************
function DBSETINDEX(Arg1)

   ordListAdd(Arg1)
   return Nil

********************************
function DBCLEARIND

   return ordListClear()

********************************
function DBREINDEX

   return ordListRebuild()

********************************
function DBSETORDER(Arg1)

   if (ISCHARACTER(Arg1) .AND. !Empty(Val(Arg1)))
      Arg1:= Val(Arg1)
   endif
   set order to Arg1
   return Nil

********************************
function INDEXORD

   return ordnumber(ordSetFocus())

********************************
function INDEXEXT

   return ordbagext()

********************************
function INDEXKEY(Arg1)

   return ordkey(Arg1)

* EOF

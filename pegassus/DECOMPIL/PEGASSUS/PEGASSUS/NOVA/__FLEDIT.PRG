#include "common.ch"
#include "inkey.ch"

********************************
function __FLEDIT(Arg1, Arg2)

   local Local1, Local2, Local3
   if (Empty(Arg2))
      return Arg1
   endif
   Local1:= {}
   aeval(Arg2, {|_1| AAdd(Local1, furbof(_1))})
   Arg2:= Local1
   Local1:= {}
   Local2:= {|_1| _1[1] == Local3}
   aeval(Arg2, {|_1, _2| (Local3:= _1, _2:= ascan(Arg1, Local2), ;
      iif(_2 == 0, Nil, AAdd(Local1, Arg1[_2])))})
   return Local1

********************************
static function FURBOF(Arg1)

   Arg1:= SubStr(Arg1, At(">", Arg1) + 1)
   Arg1:= Trim(Upper(Arg1))
   return Arg1

* EOF

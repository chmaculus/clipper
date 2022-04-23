#include "common.ch"
#include "inkey.ch"

********************************
init procedure INITHANDL

   local Local1
   Local1:= errorblock({|_1| lockerrhan(_1, Local1)})
   return

********************************
static function LOCKERRHAN(Arg1, Arg2)

   if (Arg1:gencode() == 41)
      return .T.
   endif
   return eval(Arg2, Arg1)

********************************
procedure _NTXERR

   return

* EOF

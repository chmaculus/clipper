#include "common.ch"
#include "inkey.ch"

********************************
function STRZERO(Arg1, Arg2, Arg3)

   local Local1
   if (PCount() == 3)
      Local1:= Str(Arg1, Arg2, Arg3)
   elseif (PCount() == 2)
      Local1:= Str(Arg1, Arg2)
   else
      Local1:= Str(Arg1)
   endif
   if ("-" $ Local1)
      return "-" + Replicate("0", Len(Local1) - Len(LTrim(Local1))) ;
         + SubStr(Local1, At("-", Local1) + 1)
   endif
   return Replicate("0", Len(Local1) - Len(LTrim(Local1))) + ;
      LTrim(Local1)

* EOF

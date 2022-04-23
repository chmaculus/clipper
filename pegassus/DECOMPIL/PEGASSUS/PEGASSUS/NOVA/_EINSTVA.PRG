#include "common.ch"
#include "inkey.ch"

********************************
function _EINSTVAR(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)

   local Local1, Local2
   Local2:= .F.
   if (ValType(Arg3) == Arg4)
      if (!(ISNIL(Arg6)))
         Local2:= !(Arg3 >= Arg6)
      endif
      if (!(ISNIL(Arg7)))
         Local2:= !(Arg3 <= Arg7)
      endif
   else
      Local2:= .T.
   endif
   if (Local2 .AND. ValType((Local1:= errornew(), Local1:gencode(1), ;
         Local1:severity(2), Local1:subsystem(Arg1:classname()), ;
         Local1:subcode(Arg5), Local1:args({Arg3}), ;
         Local1:cansubsti(.T.), Arg3:= eval(errorblock(), Local1), ;
         Arg3)) != Arg4)
      errorinhan()
   endif
   return Arg3

* EOF

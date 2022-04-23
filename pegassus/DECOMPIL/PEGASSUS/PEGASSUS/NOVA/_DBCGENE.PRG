#include "common.ch"
#include "inkey.ch"

********************************
static procedure _DBCGENERR(Arg1)

   local Local1, Local2
   Local2:= errornew()
   Local2:gencode(35)
   Local2:subcode(2001)
   Local2:subsystem("DBCMD")
   Local2:severity(2)
   Local2:operation(Arg1)
   Local2:candefaul(.T.)
   Local1:= eval(errorblock(), Local2)
   if (ValType(Local1) != "L" .OR. Local1 != .F.)
      errorinhan()
   endif
   return

********************************
function __DBCOPY(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8
   Local7:= .F.
   Local8:= .T.
   Local1:= Select()
   begin sequence
      if (!used())
         _dbcgenerr("COPY TO")
         Local8:= .F.
      endif
      if (Local8 .AND. Empty(Local3:= __fledit(dbstruct(), Arg2)))
         Local8:= .F.
      endif
      dbcreate(Arg1, Local3, Arg8, .T., "")
      Local2:= Select()
      select (Local1)
      __dbtrans(Local2, Local3, Arg3, Arg4, Arg5, Arg6, Arg7)
   recover using Local6
      Local7:= .T.
   end sequence
   if (Local2 != Nil)
      select (Local2)
      close
   endif
   select (Local1)
   if (Local7)
      break(Local6)
   endif
   return Local8

********************************
function __DBAPP(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8, Local9
   Local8:= .F.
   Local9:= .T.
   Local2:= Select()
   begin sequence
      if (!used())
         _dbcgenerr("APPEND FROM")
         Local9:= .F.
      endif
      if (Local9 .AND. Empty(Local3:= __fledit(dbstruct(), Arg2)))
         Local9:= .F.
      endif
      use (Arg1) via Arg8 alias  new shared readonly
      Local1:= Select()
      Arg2:= {}
      aeval(dbstruct(), {|_1| AAdd(Arg2, _1[1])})
      if (!Empty(Local3:= __fledit(Local3, Arg2)))
         __dbtrans(Local2, Local3, Arg3, Arg4, Arg5, Arg6, Arg7)
      endif
   recover using Local7
      Local8:= .T.
   end sequence
   if (Local1 != Nil)
      close
   endif
   select (Local2)
   if (Local8)
      break(Local7)
   endif
   return Local9

* EOF

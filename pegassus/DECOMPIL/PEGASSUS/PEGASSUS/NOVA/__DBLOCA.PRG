#include "common.ch"
#include "inkey.ch"

********************************
function __DBLOCATE(Arg1, Arg2, Arg3, Arg4, Arg5)

   local Local1
   if (ISNIL(Arg2))
      Arg2:= {|| .T.}
   else
      Arg5:= .T.
   endif
   if (ISNIL(Arg1) .OR. ValType(Arg1) != "B")
      Arg1:= {|| .T.}
   endif
   default Arg5 to .F.
   __dbsetloc(Arg1)
   if (Arg4 != Nil)
      goto Arg4
      Local1:= !EOF() .AND. eval(Arg2) .AND. eval(Arg1)
   elseif (Arg3 != Nil)
      Local1:= .F.
      do while (!EOF() .AND. Arg3-- > 0 .AND. eval(Arg2) .AND. ;
            !(Local1:= eval(Arg1)))
         skip 
      enddo
   elseif (Arg5)
      Local1:= .F.
      do while (!EOF() .AND. eval(Arg2) .AND. !(Local1:= eval(Arg1)))
         skip 
      enddo
   else
      goto top
      do while (!EOF() .AND. !(Local1:= eval(Arg1)))
         skip 
      enddo
   endif
   __dbsetfou(Local1)
   return Nil

********************************
function __DBCONTIN

   local Local1, Local2
   if (Empty(Local2:= __dbsetloc()))
      return Nil
   endif
   Local1:= .F.
   skip 
   do while (!EOF() .AND. !(Local1:= eval(Local2)))
      skip 
   enddo
   __dbsetfou(Local1)
   return Nil

* EOF

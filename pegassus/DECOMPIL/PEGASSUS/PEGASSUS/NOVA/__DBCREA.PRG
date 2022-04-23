#include "common.ch"
#include "inkey.ch"

********************************
function __DBCREATE(Arg1, Arg2, Arg3, Arg4, Arg5)

   local Local1, Local2, Local3, Local4
   Local1:= {}
   default Arg5 to Arg1
   default Arg4 to .F.
   Local4:= Select()
   if (!Empty(Local3:= rat("\", Arg5) + 1))
      Arg5:= SubStr(Arg5, Local3)
   endif
   if (!Empty(Local3:= At(".", Arg5)))
      Arg5:= Left(Arg5, Local3 - 1)
   endif
   if (used() .AND. !Arg4)
      close
   endif
   begin sequence
      if (Empty(Arg2))
         if (dbcreate(Arg1, {{"FIELD_NAME", "C", 10, 0}, ;
               {"FIELD_TYPE", "C", 1, 0}, {"FIELD_LEN", "N", 3, 0}, ;
               {"FIELD_DEC", "N", 3, 0}}, Arg3, .F., Arg5))
         endif
      else
         if (Arg4)
            use (Arg2) new exclusive
         else
            use (Arg2) exclusive
         endif
         DBEval({|| AAdd(Local1, {field->field_name, ;
            field->field_type, field->field_len, field->field_dec})})
         close
         if (Arg4)
            select (Local4)
         endif
         aeval(Local1, {|_1| iif(_1[2] == "C" .AND. _1[4] != 0, ;
            _1[3]:= _1[3] + _1[4] * 256, Nil)})
         dbcreate(Arg1, Local1, Arg3, Arg4, Arg5)
      endif
   recover using Local2
      close
      break(Local2)
   end sequence
   return used()

********************************
function __DBCOPYST(Arg1, Arg2)

   return dbcreate(Arg1, __fledit(dbstruct(), Arg2))

********************************
function __DBCOPYXS(Arg1)

   local Local1, Local2, Local3, Local4
   Local4:= .F.
   if (Empty(Local2:= dbstruct()))
      return .F.
   endif
   Local1:= Select()
   begin sequence
      select (0)
      create (Arg1)
      aeval(Local2, {|_1| (iif(_1[2] == "C" .AND. _1[3] > 255, ;
         (_1[4]:= Int(_1[3] / 256), _1[3]:= _1[3] % 256), Nil), .F.)})
      aeval(Local2, {|_1| (dbAppend(), field->field_name:= _1[1], ;
         field->field_type:= _1[2], field->field_len:= _1[3], ;
         field->field_dec:= _1[4], .F.)})
   recover
      Local4:= .T.
   end sequence
   if (Select() != Local1)
      close
      select (Local1)
   endif
   if (Local4)
      break(Local3)
   endif
   return .T.

* EOF

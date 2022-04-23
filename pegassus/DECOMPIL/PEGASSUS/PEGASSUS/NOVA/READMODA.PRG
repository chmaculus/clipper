#include "common.ch"
#include "inkey.ch"

static Static1, Static2:= .F., Static3, Static4, Static5, Static6, ;
   Static7, Static8, Static9, Static10

********************************
function READMODAL(Arg1, Arg2)

   local Local1, Local2
   if (ISBLOCK(Static1))
      eval(Static1)
   endif
   if (Empty(Arg1))
      SetPos(MaxRow() - 1, 0)
      return .F.
   endif
   Local2:= cleargetsy()
   Static9:= procname(1)
   Static10:= procline(1)
   if (!(ISNUMBER(Arg2) .AND. Arg2 > 0))
      Arg2:= settle(Arg1, 0)
   endif
   do while (!(Arg2 == 0))
      postactive(Local1:= Arg1[Arg2])
      if (ISBLOCK(Local1:reader()))
         eval(Local1:reader(), Local1)
      else
         getreader(Local1)
      endif
      Arg2:= settle(Arg1, Arg2)
   enddo
   restoreget(Local2)
   SetPos(MaxRow() - 1, 0)
   return Static2

********************************
procedure GETREADER(Arg1)

   if (getprevali(Arg1))
      Arg1:setfocus()
      do while (Arg1:exitstate() == 0)
         if (Arg1:typeout())
            Arg1:exitstate(5)
         endif
         do while (Arg1:exitstate() == 0)
            getapplyke(Arg1, InKey(0))
         enddo
         if (!getpostval(Arg1))
            Arg1:exitstate(0)
         endif
      enddo
      Arg1:killfocus()
   endif
   return

********************************
procedure GETAPPLYKE(Arg1, Arg2)

   local Local1, Local2
   if (!(ISNIL(Local2:= SetKey(Arg2))))
      getdosetke(Local2, Arg1)
   else
      do case
      case Arg2 == 5
         Arg1:exitstate(1)
      case Arg2 == 271
         Arg1:exitstate(1)
      case Arg2 == 24
         Arg1:exitstate(2)
      case Arg2 == 9
         Arg1:exitstate(2)
      case Arg2 == 13
         Arg1:exitstate(5)
      case Arg2 == 27
         if (Set(_SET_ESCAPE))
            Arg1:undo()
            Arg1:exitstate(7)
         endif
      case Arg2 == 18
         Arg1:exitstate(6)
      case Arg2 == 3
         Arg1:exitstate(6)
      case Arg2 == 29
         Arg1:exitstate(3)
      case Arg2 == 23
         Arg1:exitstate(6)
      case Arg2 == 22
         Set(_SET_INSERT, !Set(_SET_INSERT))
         showscoreb()
      case Arg2 == 21
         Arg1:undo()
      case Arg2 == 1
         Arg1:home()
      case Arg2 == 6
         Arg1:end()
      case Arg2 == 4
         Arg1:right()
      case Arg2 == 19
         Arg1:left()
      case Arg2 == 2
         Arg1:wordright()
      case Arg2 == 26
         Arg1:wordleft()
      case Arg2 == 8
         Arg1:backspace()
      case Arg2 == 7
         Arg1:delete()
      case Arg2 == 20
         Arg1:delwordrig()
      case Arg2 == 25
         Arg1:delend()
      case Arg2 == 127
         Arg1:delwordlef()
      otherwise
         if (Arg2 >= 32 .AND. Arg2 <= 255)
            Local1:= Chr(Arg2)
            if (Arg1:type() == "N" .AND. (Local1 == "." .OR. Local1 ;
                  == ","))
               Arg1:todecpos()
            else
               if (Set(_SET_INSERT))
                  Arg1:insert(Local1)
               else
                  Arg1:overstrike(Local1)
               endif
               if (Arg1:typeout())
                  if (Set(_SET_BELL))
                     ?? ""
                  endif
                  if (!Set(_SET_CONFIRM))
                     Arg1:exitstate(5)
                  endif
               endif
            endif
         endif
      endcase
      return
   endif

********************************
function GETPREVALI(Arg1)

   local Local1, Local2
   Local2:= .T.
   if (!(ISNIL(Arg1:preblock())))
      Local1:= Static2
      Local2:= eval(Arg1:preblock(), Arg1)
      Arg1:display()
      showscoreb()
      Static2:= Local1
   endif
   if (Static3)
      Local2:= .F.
      Arg1:exitstate(7)
   elseif (!Local2)
      Arg1:exitstate(8)
   else
      Arg1:exitstate(0)
   endif
   return Local2

********************************
function GETPOSTVAL(Arg1)

   local Local1, Local2
   Local2:= .T.
   if (Arg1:exitstate() == 7)
      return .T.
   endif
   if (Arg1:baddate())
      Arg1:home()
      datemsg()
      showscoreb()
      return .F.
   endif
   if (Arg1:changed())
      Arg1:assign()
      Static2:= .T.
   endif
   Arg1:reset()
   if (!(ISNIL(Arg1:postblock())))
      Local1:= Static2
      SetPos(Arg1:row(), Arg1:col() + Len(Arg1:buffer()))
      Local2:= eval(Arg1:postblock(), Arg1)
      SetPos(Arg1:row(), Arg1:col())
      showscoreb()
      Arg1:updatebuff()
      Static2:= Local1
      if (Static3)
         Arg1:exitstate(7)
         Local2:= .T.
      endif
   endif
   return Local2

********************************
procedure GETDOSETKE(Arg1, Arg2)

   local Local1
   if (Arg2:changed())
      Arg2:assign()
      Static2:= .T.
   endif
   Local1:= Static2
   eval(Arg1, Static9, Static10, readvar())
   showscoreb()
   Arg2:updatebuff()
   Static2:= Local1
   if (Static3)
      Arg2:exitstate(7)
   endif
   return

********************************
static function SETTLE(Arg1, Arg2)

   local Local1
   if (Arg2 == 0)
      Local1:= 2
   else
      Local1:= Arg1[Arg2]:exitstate()
   endif
   if (Local1 == 7 .OR. Local1 == 6)
      return 0
   endif
   if (!(Local1 == 8))
      Static7:= Arg2
      Static4:= .F.
      Static5:= .F.
   else
      Local1:= Static6
   endif
   do case
   case Local1 == 1
      Arg2--
   case Local1 == 2
      Arg2++
   case Local1 == 3
      Arg2:= 1
      Static4:= .T.
      Local1:= 2
   case Local1 == 4
      Arg2:= Len(Arg1)
      Static5:= .T.
      Local1:= 1
   case Local1 == 5
      Arg2++
   endcase
   if (Arg2 == 0)
      if (!readexit() .AND. !Static5)
         Static4:= .T.
         Arg2:= Static7
         Local1:= 2
      endif
   elseif (Arg2 == Len(Arg1) + 1)
      if (!readexit() .AND. !(Local1 == 5) .AND. !Static4)
         Static5:= .T.
         Arg2:= Static7
         Local1:= 1
      else
         Arg2:= 0
      endif
   endif
   Static6:= Local1
   if (!(Arg2 == 0))
      Arg1[Arg2]:exitstate(Local1)
   endif
   return Arg2

********************************
static procedure POSTACTIVE(Arg1)

   getactive(Arg1)
   readvar(getreadvar(Arg1))
   showscoreb()
   return

********************************
static function CLEARGETSY

   local Local1[9]
   Local1[1]:= Static3
   Local1[2]:= Static4
   Local1[3]:= Static5
   Local1[4]:= Static6
   Local1[5]:= Static7
   Local1[6]:= getactive(Nil)
   Local1[7]:= readvar("")
   Local1[8]:= Static9
   Local1[9]:= Static10
   Static3:= .F.
   Static4:= .F.
   Static5:= .F.
   Static6:= 0
   Static7:= 0
   Static9:= ""
   Static10:= 0
   Static2:= .F.
   return Local1

********************************
static procedure RESTOREGET(Arg1)

   Static3:= Arg1[1]
   Static4:= Arg1[2]
   Static5:= Arg1[3]
   Static6:= Arg1[4]
   Static7:= Arg1[5]
   getactive(Arg1[6])
   readvar(Arg1[7])
   Static9:= Arg1[8]
   Static10:= Arg1[9]
   return

********************************
static function GETREADVAR(Arg1)

   local Local1, Local2
   Local1:= Upper(Arg1:name())
   if (!(ISNIL(Arg1:subscript())))
      for Local2:= 1 to Len(Arg1:subscript())
         Local1:= Local1 + ("[" + ;
            LTrim(Str(Arg1:subscript()[Local2])) + "]")
      next
   endif
   return Local1

********************************
procedure __SETFORMA(Arg1)

   Static1:= iif(ISBLOCK(Arg1), Arg1, Nil)
   return

********************************
procedure __KILLREAD

   Static3:= .T.
   return

********************************
function GETACTIVE(Arg1)

   local Local1
   Local1:= Static8
   if (PCount() > 0)
      Static8:= Arg1
   endif
   return Local1

********************************
function UPDATED

   return Static2

********************************
function READEXIT(Arg1)

   return Set(_SET_EXIT, Arg1)

********************************
function READINSERT(Arg1)

   return Set(_SET_INSERT, Arg1)

********************************
static procedure SHOWSCOREB

   local Local1, Local2
   if (Set(_SET_SCOREBOARD))
      Local1:= Row()
      Local2:= Col()
      SetPos(0, 60)
      dispout(iif(Set(_SET_INSERT), nationmsg(7), nationmsg(8)))
      SetPos(Local1, Local2)
   endif
   return

********************************
static procedure DATEMSG

   local Local1, Local2
   if (Set(_SET_SCOREBOARD))
      Local1:= Row()
      Local2:= Col()
      SetPos(0, 60)
      dispout(nationmsg(9))
      SetPos(Local1, Local2)
      do while (nextkey() == 0)
      enddo
      SetPos(0, 60)
      dispout(Space(Len(nationmsg(9))))
      SetPos(Local1, Local2)
   endif
   return

********************************
function RANGECHECK(Arg1, Arg2, Arg3, Arg4)

   local Local1, Local2, Local3, Local4
   if (!Arg1:changed())
      return .T.
   endif
   Local4:= Arg1:varget()
   if (Local4 >= Arg3 .AND. Local4 <= Arg4)
      return .T.
   endif
   if (Set(_SET_SCOREBOARD))
      Local1:= nationmsg(10) + LTrim(Transform(Arg3, "")) + ;
         nationmsg(11) + LTrim(Transform(Arg4, ""))
      if (Len(Local1) > MaxCol())
         Local1:= SubStr(Local1, 1, MaxCol())
      endif
      Local2:= Row()
      Local3:= Col()
      SetPos(0, Min(60, MaxCol() - Len(Local1)))
      dispout(Local1)
      SetPos(Local2, Local3)
      do while (nextkey() == 0)
      enddo
      SetPos(0, Min(60, MaxCol() - Len(Local1)))
      dispout(Space(Len(Local1)))
      SetPos(Local2, Local3)
   endif
   return .F.

********************************
function READKILL(Arg1)

   local Local1
   Local1:= Static3
   if (PCount() > 0)
      Static3:= Arg1
   endif
   return Local1

********************************
function READUPDATE(Arg1)

   local Local1
   Local1:= Static2
   if (PCount() > 0)
      Static2:= Arg1
   endif
   return Local1

********************************
function READFORMAT(Arg1)

   local Local1
   Local1:= Static1
   if (PCount() > 0)
      Static1:= Arg1
   endif
   return Local1

* EOF

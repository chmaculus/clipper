#include "common.ch"
#include "inkey.ch"

static Static1, Static2

********************************
static function SKIPPED(Arg1)

   local Local1
   Local1:= 0
   if (LastRec() != 0)
      if (Arg1 == 0)
         if (EOF() .AND. !Static1)
            skip -1
            Local1:= -1
         else
            skip 0
         endif
      elseif (Arg1 > 0 .AND. RecNo() != LastRec() + 1)
         do while (Local1 < Arg1)
            skip 
            if (EOF())
               if (Static1)
                  Local1++
               else
                  skip -1
               endif
               exit
            endif
            Local1++
         enddo
      elseif (Arg1 < 0)
         do while (Local1 > Arg1)
            skip -1
            if (BOF())
               exit
            endif
            Local1--
         enddo
      endif
   endif
   return Local1

********************************
static function EMPTYFILE

   if (LastRec() == 0)
      return .T.
   endif
   if ((EOF() .OR. RecNo() == LastRec() + 1) .AND. BOF())
      return .T.
   endif
   return .F.

********************************
static function CALLUSER(Arg1, Arg2, Arg3)

   local Local1, Local2, Local3, Local4
   do case
   case Arg3 != 0
      Local1:= 4
   case !Static1 .AND. emptyfile()
      Local1:= 3
   case Arg1:hitbottom()
      Local1:= 2
   case Arg1:hittop()
      Local1:= 1
   otherwise
      Local1:= 0
   endcase
   do while (!Arg1:stabilize())
   enddo
   Local3:= RecNo()
   if (ValType(Arg2) != "C" .OR. Empty(Arg2))
      if (Arg3 == 13 .OR. Arg3 == 27)
         Local2:= 0
      else
         Local2:= 1
      endif
   else
      Local2:= &Arg2(Local1, Arg1:colpos())
   endif
   Local4:= Local2 != 0
   if (!Static1 .AND. EOF() .AND. !emptyfile())
      skip -1
   endif
   if (Local2 == 3)
      Static1:= !(Static1 .AND. EOF())
      if (Static1)
         goto bottom
         Arg1:down()
      else
         Arg1:refreshcur()
      endif
      Static2:= .F.
   elseif (Local2 == 2 .OR. Local3 != RecNo())
      if (Local4)
         Static1:= .F.
         if (Set(_SET_DELETED) .AND. Deleted() .OR. ;
               !Empty(dbfilter()) .AND. !&(dbfilter()))
            skip 
         endif
         if (EOF())
            goto bottom
         endif
         Local3:= RecNo()
         Arg1:refreshall()
         do while (!Arg1:stabilize())
         enddo
         do while (Local3 != RecNo())
            Arg1:up()
            do while (!Arg1:stabilize())
            enddo
         enddo
         Static2:= .F.
      endif
   else
      Arg1:refreshcur()
   endif
   return Local4

********************************
static function DBEDSETUP(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, ;
   Arg8, Arg9, Arg10, Arg11, Arg12)

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8
   if (ValType(Arg1) != "N" .OR. Arg1 < 0)
      Arg1:= 0
   endif
   if (ValType(Arg2) != "N" .OR. Arg2 < 0)
      Arg2:= 0
   endif
   if (ValType(Arg3) != "N" .OR. Arg3 > MaxRow() .OR. Arg3 < Arg1)
      Arg3:= MaxRow()
   endif
   if (ValType(Arg4) != "N" .OR. Arg4 > MaxCol() .OR. Arg4 < Arg2)
      Arg4:= MaxCol()
   endif
   if ((Arg4 - Arg2) * (Arg3 - Arg1) > MaxRow() * MaxCol())
      Arg1:= Arg2:= 0
      Arg3:= MaxRow()
      Arg4:= MaxCol()
   endif
   Local1:= tbrowsedb(Arg1, Arg2, Arg3, Arg4)
   if (ISARRAY(Arg5))
      Local3:= Len(Arg5)
      Local2:= 1
      do while (Local2 <= Local3)
         if (ValType(Arg5[Local2]) != "C" .OR. Empty(Arg5[Local2]))
            exit
         endif
         Local2++
      enddo
      Local3:= Local2 - 1
   else
      Local3:= FCount()
   endif
   if (Local3 == 0)
      return .F.
   endif
   Local1:headsep("мям")
   Local1:colsep(" Ё ")
   Local4:= array(Local3, 6)
   if (ISARRAY(Arg5))
      for Local2:= 1 to Local3
         if ("->" $ Arg5[Local2])
            Local6:= At("->", Arg5[Local2])
            Local4[Local2][3]:= SubStr(Arg5[Local2], 1, Local6 - 1)
            Local4[Local2][4]:= SubStr(Arg5[Local2], Local6 + 2)
            Local4[Local2][1]:= Local4[Local2][3] + "->;" + ;
               Local4[Local2][4]
         else
            Local4[Local2][3]:= Nil
            Local4[Local2][4]:= Nil
            Local4[Local2][1]:= Arg5[Local2]
         endif
         Local4[Local2][2]:= Arg5[Local2]
      next
   elseif (FCount() > 0)
      for Local2:= 1 to Local3
         Local4[Local2][3]:= Nil
         Local4[Local2][4]:= Nil
         Local4[Local2][1]:= FieldName(Local2)
         Local4[Local2][2]:= FieldName(Local2)
      next
   else
      return .F.
   endif
   for Local2:= 1 to Local3
      Local5:= ""
      if (ISARRAY(Arg7))
         if (Len(Arg7) >= Local2 .AND. ISCHARACTER(Arg7[Local2]) ;
               .AND. !Empty(Arg7[Local2]))
            Local5:= Arg7[Local2]
         endif
      elseif (ISCHARACTER(Arg7) .AND. !Empty(Arg7))
         Local5:= Arg7
      endif
      Local7:= Nil
      if (ISMEMO(&(Local4[Local2][2])))
         Local7:= "{|| '  <Memo>  '}"
      elseif (Empty(Local5))
         if ("->" $ Local4[Local2][2])
            if (Upper(Local4[Local2][3]) == "M")
               Local7:= memvarbloc(Local4[Local2][2])
            elseif (Upper(Local4[Local2][3]) == "FIELD")
               Local7:= fieldwbloc(Local4[Local2][4], Select())
            else
               Local7:= fieldwbloc(Local4[Local2][4], ;
                  Select(Local4[Local2][3]))
            endif
         elseif (!Empty(fieldpos(Local4[Local2][2])))
            Local7:= fieldwbloc(Local4[Local2][2], Select())
         endif
      endif
      if (ISNIL(Local7))
         if (Empty(Local5))
            Local7:= "{||" + Local4[Local2][2] + "}"
         else
            Local7:= "{|| Transform(" + Local4[Local2][2] + ",'" + ;
               Local5 + "')}"
         endif
      endif
      if (ISCHARACTER(Local7))
         Local4[Local2][2]:= &Local7
      elseif (ISBLOCK(Local7))
         Local4[Local2][2]:= Local7
      endif
      if (ISARRAY(Arg8))
         if (Len(Arg8) >= Local2 .AND. ISCHARACTER(Arg8[Local2]))
            Local4[Local2][1]:= Arg8[Local2]
         endif
      elseif (ISCHARACTER(Arg8))
         Local4[Local2][1]:= Arg8
      endif
      Local4[Local2][3]:= Nil
      if (ISARRAY(Arg9))
         if (Len(Arg9) >= Local2 .AND. ISCHARACTER(Arg9[Local2]))
            Local4[Local2][3]:= Arg9[Local2]
         endif
      elseif (ISCHARACTER(Arg9))
         Local4[Local2][3]:= Arg9
      endif
      Local4[Local2][4]:= Nil
      if (ISARRAY(Arg10))
         if (Len(Arg10) >= Local2 .AND. ISCHARACTER(Arg10[Local2]))
            Local4[Local2][4]:= Arg10[Local2]
         endif
      elseif (ISCHARACTER(Arg10))
         Local4[Local2][4]:= Arg10
      endif
      Local4[Local2][5]:= Nil
      if (ISARRAY(Arg11))
         if (Len(Arg11) >= Local2 .AND. ISCHARACTER(Arg11[Local2]))
            Local4[Local2][5]:= Arg11[Local2]
         endif
      elseif (ISCHARACTER(Arg11))
         Local4[Local2][5]:= Arg11
      endif
      Local4[Local2][6]:= Nil
      if (ISARRAY(Arg12))
         if (Len(Arg12) >= Local2 .AND. ISCHARACTER(Arg12[Local2]))
            Local4[Local2][6]:= Arg12[Local2]
         endif
      elseif (ISCHARACTER(Arg12))
         Local4[Local2][6]:= Arg12
      endif
   next
   for Local2:= 1 to Local3
      Local8:= tbcolumnne(Local4[Local2][1], Local4[Local2][2])
      if (Local4[Local2][3] != Nil)
         Local8:headsep(Local4[Local2][3])
      endif
      if (Local4[Local2][4] != Nil)
         Local8:colsep(Local4[Local2][4])
      endif
      if (Local4[Local2][5] != Nil)
         Local8:footsep(Local4[Local2][5])
      endif
      if (Local4[Local2][6] != Nil)
         Local8:footing(Local4[Local2][6])
      endif
      Local1:addcolumn(Local8)
   next
   return Local1

********************************
function DBEDIT(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
   Arg9, Arg10, Arg11, Arg12)

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7
   if (EOF())
      goto bottom
   endif
   Local1:= dbedsetup(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, ;
      Arg8, Arg9, Arg10, Arg11, Arg12)
   Local1:skipblock({|_1| skipped(_1)})
   Local1:autolite(.F.)
   Local2:= setcursor(0)
   Local7:= {Static1, Static2}
   Static1:= .F.
   Static2:= .T.
   Local5:= .T.
   Local3:= .T.
   do while (Local3)
      do while (!Local1:stabilize())
         if (nextkey() != 0)
            exit
         endif
      enddo
      if ((Local4:= InKey()) == 0)
         if (Local5)
            Local3:= calluser(Local1, Arg6, 0)
            do while (!Local1:stabilize())
            enddo
         endif
         if (Local3 .AND. Static2)
            Local1:hilite()
            Local4:= InKey(0)
            Local1:dehilite()
            if ((Local6:= SetKey(Local4)) != Nil)
               eval(Local6, procname(1), procline(1), "")
               loop
            endif
         else
            Static2:= .T.
         endif
      endif
      Local5:= .T.
      do case
      case Local4 == 0
      case Local4 == 24
         if (Static1)
            Local1:hitbottom(.T.)
         else
            Local1:down()
         endif
      case Local4 == 5
         if (Static1)
            Local1:hittop(.T.)
         else
            Local1:up()
         endif
      case Local4 == 3
         if (Static1)
            Local1:hitbottom(.T.)
         else
            Local1:pagedown()
         endif
      case Local4 == 18
         if (Static1)
            Local1:hittop(.T.)
         else
            Local1:pageup()
         endif
      case Local4 == 31
         if (Static1)
            Local1:hittop(.T.)
         else
            Local1:gotop()
         endif
      case Local4 == 30
         if (Static1)
            Local1:hitbottom(.T.)
         else
            Local1:gobottom()
         endif
      case Local4 == 4
         Local1:right()
      case Local4 == 19
         Local1:left()
      case Local4 == 1
         Local1:home()
      case Local4 == 6
         Local1:end()
      case Local4 == 26
         Local1:panleft()
      case Local4 == 2
         Local1:panright()
      case Local4 == 29
         Local1:panhome()
      case Local4 == 23
         Local1:panend()
      otherwise
         Local3:= calluser(Local1, Arg6, Local4)
         Local5:= .F.
      endcase
   enddo
   setcursor(Local2)
   Static1:= Local7[1]
   Static2:= Local7[2]
   return .T.

********************************
function TBROWSENEW(Arg1, Arg2, Arg3, Arg4)

   local Local1[14]
   default Arg1 to 0
   default Arg2 to 0
   default Arg3 to MaxRow()
   default Arg4 to MaxCol()
   __totbrows(Local1)
   Local1:ntop(Arg1)
   Local1:nleft(Arg2)
   Local1:nbottom(Arg3)
   Local1:nright(Arg4)
   Local1[6]:= {}
   Local1[7]:= ""
   Local1[8]:= " "
   Local1[9]:= ""
   Local1[10]:= SetColor()
   Local1[11]:= {|| Nil}
   Local1[12]:= {|| Nil}
   Local1[13]:= {|| Nil}
   Local1:autolite(.T.)
   Local1:colpos(1)
   Local1:freeze(0)
   Local1:hitbottom(.F.)
   Local1:hittop(.F.)
   return Local1

********************************
static function SKIPPED(Arg1)

   local Local1
   Local1:= 0
   if (LastRec() != 0)
      if (Arg1 == 0)
         skip 0
      elseif (Arg1 > 0 .AND. RecNo() != LastRec() + 1)
         do while (Local1 < Arg1)
            skip 
            if (EOF())
               skip -1
               exit
            endif
            Local1++
         enddo
      elseif (Arg1 < 0)
         do while (Local1 > Arg1)
            skip -1
            if (BOF())
               exit
            endif
            Local1--
         enddo
      endif
   endif
   return Local1

********************************
function TBROWSEDB(Arg1, Arg2, Arg3, Arg4)

   local Local1
   Local1:= tbrowsenew(Arg1, Arg2, Arg3, Arg4)
   Local1:skipblock({|_1| skipped(_1)})
   Local1:gotopbloc({|| dbGoTop()})
   Local1:gobottomb({|| dbGoBottom()})
   return Local1

* EOF

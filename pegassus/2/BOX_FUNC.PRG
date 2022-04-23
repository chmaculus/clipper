#include "common.ch"
#include "inkey.ch"

********************************
procedure TF1

   if (Len(alltrim(tef1)) > 0)
      keyboard "X" + tef1 + Chr(13)
   endif
   return

********************************
procedure TF2

   if (Len(alltrim(tef2)) > 0)
      keyboard "X" + tef2 + Chr(13)
   endif
   return

********************************
procedure TF3

   if (Len(alltrim(tef3)) > 0)
      keyboard "X" + tef3 + Chr(13)
   endif
   return

********************************
procedure TF4

   if (Len(alltrim(tef4)) > 0)
      keyboard "X" + tef4 + Chr(13)
   endif
   return

********************************
procedure TF5

   if (Len(alltrim(tef5)) > 0)
      keyboard "X" + tef5 + Chr(13)
   endif
   return

********************************
procedure TF6

   if (Len(alltrim(tef6)) > 0)
      keyboard "X" + tef6 + Chr(13)
   endif
   return

********************************
procedure TF7

   if (Len(alltrim(tef7)) > 0)
      keyboard "X" + tef7 + Chr(13)
   endif
   return

********************************
procedure TF8

   if (Len(alltrim(tef8)) > 0)
      keyboard "X" + tef8 + Chr(13)
   endif
   return

********************************
function CCBOX

   parameters top, left, bottom, right, color, speed, boxtype, shadow
   private t, b, l, r, s, oldcolor, retscr, boxframe, seed1, seed2
   retscr:= boxscr(top, left, bottom, right)
   oldcolor:= SetColor()
   boxframe:= getbox(boxtype)
   set color to (color)
   setcursor(0)
   @ top, left, bottom, right box boxframe
   if (shadow)
      boxshadow(top, left, bottom, right)
   endif
   set color to (oldcolor)
   setcursor(1)
   return retscr

********************************
function BOXSCR

   parameters top, left, bottom, right
   private retval
   do case
   case bottom < 24 .AND. right < 79
      retval:= SaveScreen(top, left, bottom + 1, right + 1)
   case bottom = 24 .AND. right < 79
      retval:= SaveScreen(top, left, bottom, right + 1)
   case bottom < 24 .AND. right = 79
      retval:= SaveScreen(top, left, bottom + 1, right)
   case bottom = 24 .AND. right = 79
      retval:= SaveScreen(top, left, bottom, right)
   endcase
   return retval

********************************
function GETBOX

   parameters btype
   b_single:= "ËÎÌÊÅÏÐ "
   b_double:= "ÏÏÏÊÎÎÎ "
   b_single_d:= "ßßßÊßßß "
   b_double_s:= "ÉÏª©ÎÈÊ "
   b_blanco:= Replicate(" ", 8) + " "
   b_juanca1:= "Þß««ßÞÊ "
   b_juanca2:= "Þß«©ÎÈÊ "
   b_heart:= Replicate("", 8) + " "
   b_diamond:= Replicate("", 8) + " "
   do case
   case btype = 1
      return b_single
   case btype = 2
      return b_double
   case btype = 3
      return b_single_d
   case btype = 4
      return b_double_s
   case btype = 5
      return b_blanco
   case btype = 6
      return b_juanca1
   case btype = 7
      return b_juanca2
   endcase

********************************
function FUNPROV2(Arg1, Arg2)

   alfa:= aprov[Arg2]
   do case
   case Arg1 = 0 .OR. Arg1 = 1
      return 1
   case LastKey() = K_ESC
      return 0
   case LastKey() = K_ENTER
      acata:= RecNo()
      return 0
   case Arg1 = 2
      return 1
   case Arg1 = 3
      return 1
   otherwise
      buscol:= SetColor()
      save screen to pbusca
      set color to (bcol1)
      @ baba1 + 1, bizq1 + 2 say SubStr(alltrim(afrases[29]) + ":" + ;
         Space(60), 1, Len(&campos))
      set color to r/w*,r/w*
      setcursor(1)
      if (tref == 2)
         quebusca:= Space(Len(&cref))
         @ baba1 + 2, bizq1 + 2 get quebusca picture "@!"
         read
         quebusca:= alltrim(quebusca)
         if (LastKey() != K_ESC .AND. Len(alltrim(quebusca)) > 0)
            goto top
            locate
         endif
      else
         quebusca:= 0
         @ baba1 + 2, bizq1 + 2 get quebusca picture "999999999"
         read
         if (LastKey() != K_ESC .AND. quebusca > 0)
            goto top
            locate
         endif
      endif
      setcursor(0)
      restore screen from pbusca
      set color to (buscol)
      return 1
   endcase
   return 1

********************************
function FUNPROV3(Arg1, Arg2)

   alfa:= aprov[Arg2]
   do case
   case Arg1 = 0 .OR. Arg1 = 1
      return 1
   case LastKey() = K_ESC
      return 0
   case LastKey() = K_ENTER
      acata:= RecNo()
      return 0
   case Arg1 = 2
      return 1
   case Arg1 = 3
      return 1
   otherwise
      return 1
   endcase
   return 1

********************************
function USERFUN2(Arg1, Arg2, Arg3)

   local Local1
   Local1:= 2
   if (LastKey() == K_ESC)
      return 0
   else
      k:= 1
      for k:= 1 to totlen
         if (Arg2 == k)
            nelem:= k
            if (LastKey() == K_ENTER)
               return 0
            endif
         endif
      next
   endif
   return Local1

********************************
function USERFUNC(Arg1, Arg2, Arg3)

   local Local1
   Local1:= 2
   if (LastKey() == K_ESC)
      return 0
   else
      k:= 1
      for k:= 1 to totlen
         if (Arg2 == k)
            nelem:= k
         endif
      next
   endif
   return Local1

********************************
function GETERRORS

   parameters resp
   private origen, offsetsep, i, c
   private fiscalerro[16]
   private printererr[16]
   fiscalerro[1]:= "Error en chequeo de memoria fiscal"
   fiscalerro[2]:= "Error en chequeo de la memoria de trabajo"
   fiscalerro[3]:= "Carga de bateria baja"
   fiscalerro[4]:= "Comando desconocido"
   fiscalerro[5]:= "Datos no validos en un campo"
   fiscalerro[6]:= "Comando no valido para el estado fiscal actual"
   fiscalerro[7]:= "Desborde del total"
   fiscalerro[8]:= "Memoria fiscal llena"
   fiscalerro[9]:= "Memoria fiscal a punto de llenarse"
   fiscalerro[10]:= ""
   fiscalerro[11]:= ""
   fiscalerro[12]:= "Error en ingreso de fecha"
   fiscalerro[13]:= ""
   fiscalerro[14]:= ""
   fiscalerro[15]:= ""
   fiscalerro[16]:= ""
   printererr[1]:= ""
   printererr[2]:= ""
   printererr[3]:= "Error de Impresora"
   printererr[4]:= "Impresora Fuera de l¡nea"
   printererr[5]:= "Falta papel del diario"
   printererr[6]:= "Falta papel de tickets"
   printererr[7]:= "Buffer de Impresora lleno"
   printererr[8]:= ""
   printererr[9]:= ""
   printererr[10]:= ""
   printererr[11]:= ""
   printererr[12]:= ""
   printererr[13]:= ""
   printererr[14]:= ""
   printererr[15]:= ""
   printererr[16]:= ""
   origen:= 0
   offsetsep:= At("", resp)
   printersta:= hexatoint(SubStr(resp, origen, offsetsep - 1))
   if (printersta < 0)
      return -1
   endif
   origen:= offsetsep
   for i:= 1 to 16
      if (Int(printersta % 2) == 1)
         if (Len(printererr[i]) > 0)
            fiserr:= "PrinterStatus: " + printererr[i]
         endif
      endif
      printersta:= printersta / 2
   next
   offsetsep:= At("", SubStr(resp, origen + 1))
   if (offsetsep == 0)
      offsetsep:= Len(resp)
   endif
   fiscalstat:= hexatoint(SubStr(resp, origen + 1, offsetsep - 1))
   if (fiscalstat < 0)
      return -1
   endif
   for i:= 1 to 16
      if (Int(fiscalstat % 2) == 1)
         if (Len(fiscalerro[i]) > 0)
            fiserr:= "FiscalStatus: " + fiscalerro[i]
         endif
      endif
      fiscalstat:= fiscalstat / 2
   next
   return 0

********************************
function HEXATOINT

   parameters hexvalue
   private i, value, status
   status:= 0
   for i:= 4 to 1 step -1
      s:= SubStr(hexvalue, i, 1)
      value:= Asc(s)
      if (value >= 65 .AND. value <= 70)
         value:= value - 65 + 10
      elseif (value >= 97 .AND. value <= 102)
         value:= value - 97 + 10
      elseif (value >= 48 .AND. value <= 57)
         value:= value - 48
      else
         return -1
      endif
      status:= status + value * 16 ^ (4 - i)
   next
   return status

********************************
function OKCANCEL

   save screen to pokc
   olcol:= SetColor()
   set color to W+/R,W+/B
   parameters qtexto
   okcan:= "S"
   oktext:= Len(alltrim(qtexto))
   if (oktext < 17)
      okcan:= 17
   endif
   okx:= Int((80 - oktext - 3) / 2)
   oks:= Int((oktext - 17) / 2)
   confir:= 1
   do while (confir != 0)
      @ 10, okx clear to 14, okx + oktext + 3
      @ 10, okx to 14, okx + oktext + 3
      @ 11, okx + 2 say alltrim(qtexto)
      @ 13, okx + 3 + oks prompt " OK "
      @ 13, okx + 3 + 5 + oks prompt " Aborta "
      set wrap on
      menu to confir
      if (confir = 1)
         okcan:= "S"
         exit
      elseif (confir = 2)
         okcan:= "N"
         exit
      endif
   enddo
   set color to (olcol)
   restore screen from pokc
   return okcan

********************************
procedure PLAYLOTES

   clovar()
   mevoy:= 2
   olcol:= SetColor()
   save screen to playm
   @  1,  0 clear to 23, 79
   jjbox(1, 0, 23, 79, "N/BG", 20, 1, .F.)
   set color to N/BG
   @  2,  2 say ;
      "                  LOTES ABIERTOS SIN CERRAR  por cada vendedor              "
   moz1:= 0
   moz2:= 0
   moz3:= 0
   moz4:= 0
   moz5:= 0
   moz6:= 0
   moz7:= 0
   moz8:= 0
   moz9:= 0
   moz10:= 0
   lem1:= "Õ"
   lem2:= "Õ"
   lem3:= "Õ"
   lem4:= "Õ"
   lem5:= "Õ"
   lem6:= "Õ"
   lem7:= "Õ"
   lem8:= "Õ"
   lem9:= "Õ"
   lem10:= "Õ"
   lim1:= "³"
   lim2:= "³"
   lim3:= "³"
   lim4:= "³"
   lim5:= "³"
   lim6:= "³"
   lim7:= "³"
   lim8:= "³"
   lim9:= "³"
   lim10:= "³"
   lom1:= "Ô"
   lom2:= "Ô"
   lom3:= "Ô"
   lom4:= "Ô"
   lom5:= "Ô"
   lom6:= "Ô"
   lom7:= "Ô"
   lom8:= "Ô"
   lom9:= "Ô"
   lom10:= "Ô"
   select 5
   opbassha("BASE008", "BASE008A")
   select 2
   opbassha("LOTES")
   if (EOF())
      alert("NO EXISTEN LOTES ABIERTOS")
      close databases
      select 1
      set color to (olcol)
      restore screen from playm
   else
      nmoz:= nvend
      moz1:= nvend
      lem1:= "ÚÄÄÄ¿"
      lim1:= "³" + Str(nlote, 3) + "³"
      lom1:= "ÀÄÄÄÙ"
      nmes:= nlote
      do while (!EOF())
         if (nvend != nmoz .AND. nvend != moz1 .AND. nvend != moz2 ;
               .AND. nvend != moz3 .AND. nvend != moz4 .AND. nvend ;
               != moz5 .AND. nvend != moz6 .AND. nvend != moz7 .AND. ;
               nvend != moz8 .AND. nvend != moz9 .AND. nvend != moz10)
            nmoz:= nvend
            do case
            case moz2 == 0
               moz2:= nvend
            case moz3 == 0
               moz3:= nvend
            case moz4 == 0
               moz4:= nvend
            case moz5 == 0
               moz5:= nvend
            case moz6 == 0
               moz6:= nvend
            case moz7 == 0
               moz7:= nvend
            case moz8 == 0
               moz8:= nvend
            case moz9 == 0
               moz9:= nvend
            case moz10 == 0
               moz10:= nvend
            endcase
            if (nlote != nmes)
               nmes:= nlote
               do case
               case nvend = moz1
                  lem1:= SubStr(lem1, 1, Len(lem1) - 1) + "ÚÄÄÄ¿"
                  lim1:= lim1 + Str(nlote, 3) + "³"
                  lom1:= SubStr(lom1, 1, Len(lom1) - 1) + "ÀÄÄÄÙ"
               case nvend = moz2
                  lem2:= SubStr(lem2, 1, Len(lem2) - 1) + "ÚÄÄÄ¿"
                  lim2:= lim2 + Str(nlote, 3) + "³"
                  lom2:= SubStr(lom2, 1, Len(lom2) - 1) + "ÀÄÄÄÙ"
               case nvend = moz3
                  lem3:= SubStr(lem3, 1, Len(lem3) - 1) + "ÚÄÄÄ¿"
                  lim3:= lim3 + Str(nlote, 3) + "³"
                  lom3:= SubStr(lom3, 1, Len(lom3) - 1) + "ÀÄÄÄÙ"
               case nvend = moz4
                  lem4:= SubStr(lem4, 1, Len(lem4) - 1) + "ÚÄÄÄ¿"
                  lim4:= lim4 + Str(nlote, 3) + "³"
                  lom4:= SubStr(lom4, 1, Len(lom4) - 1) + "ÀÄÄÄÙ"
               case nvend = moz5
                  lem5:= SubStr(lem5, 1, Len(lem5) - 1) + "ÚÄÄÄ¿"
                  lim5:= lim5 + Str(nlote, 3) + "³"
                  lom5:= SubStr(lom5, 1, Len(lom5) - 1) + "ÀÄÄÄÙ"
               case nvend = moz6
                  lem6:= SubStr(lem6, 1, Len(lem6) - 1) + "ÚÄÄÄ¿"
                  lim6:= lim6 + Str(nlote, 3) + "³"
                  lom6:= SubStr(lom6, 1, Len(lom6) - 1) + "ÀÄÄÄÙ"
               case nvend = moz7
                  lem7:= SubStr(lem7, 1, Len(lem7) - 1) + "ÚÄÄÄ¿"
                  lim7:= lim7 + Str(nlote, 3) + "³"
                  lom7:= SubStr(lom7, 1, Len(lom7) - 1) + "ÀÄÄÄÙ"
               case nvend = moz8
                  lem8:= SubStr(lem8, 1, Len(lem8) - 1) + "ÚÄÄÄ¿"
                  lim8:= lim8 + Str(nlote, 3) + "³"
                  lom8:= SubStr(lom8, 1, Len(lom8) - 1) + "ÀÄÄÄÙ"
               case nvend = moz9
                  lem9:= SubStr(lem9, 1, Len(lem9) - 1) + "ÚÄÄÄ¿"
                  lim9:= lim9 + Str(nlote, 3) + "³"
                  lom9:= SubStr(lom9, 1, Len(lom9) - 1) + "ÀÄÄÄÙ"
               case nvend = moz10
                  lem10:= SubStr(lem10, 1, Len(lem10) - 1) + "ÚÄÄÄ¿"
                  lim10:= lim10 + Str(nlote, 3) + "³"
                  lom10:= SubStr(lom10, 1, Len(lom10) - 1) + "ÀÄÄÄÙ"
               endcase
            endif
         elseif (nlote != nmes)
            nmes:= nlote
            do case
            case nvend = moz1
               lem1:= SubStr(lem1, 1, Len(lem1) - 1) + "ÚÄÄÄ¿"
               lim1:= lim1 + Str(nlote, 3) + "³"
               lom1:= SubStr(lom1, 1, Len(lom1) - 1) + "ÀÄÄÄÙ"
            case nvend = moz2
               lem2:= SubStr(lem2, 1, Len(lem2) - 1) + "ÚÄÄÄ¿"
               lim2:= lim2 + Str(nlote, 3) + "³"
               lom2:= SubStr(lom2, 1, Len(lom2) - 1) + "ÀÄÄÄÙ"
            case nvend = moz3
               lem3:= SubStr(lem3, 1, Len(lem3) - 1) + "ÚÄÄÄ¿"
               lim3:= lim3 + Str(nlote, 3) + "³"
               lom3:= SubStr(lom3, 1, Len(lom3) - 1) + "ÀÄÄÄÙ"
            case nvend = moz4
               lem4:= SubStr(lem4, 1, Len(lem4) - 1) + "ÚÄÄÄ¿"
               lim4:= lim4 + Str(nlote, 3) + "³"
               lom4:= SubStr(lom4, 1, Len(lom4) - 1) + "ÀÄÄÄÙ"
            case nvend = moz5
               lem5:= SubStr(lem5, 1, Len(lem5) - 1) + "ÚÄÄÄ¿"
               lim5:= lim5 + Str(nlote, 3) + "³"
               lom5:= SubStr(lom5, 1, Len(lom5) - 1) + "ÀÄÄÄÙ"
            case nvend = moz6
               lem6:= SubStr(lem6, 1, Len(lem6) - 1) + "ÚÄÄÄ¿"
               lim6:= lim6 + Str(nlote, 3) + "³"
               lom6:= SubStr(lom6, 1, Len(lom6) - 1) + "ÀÄÄÄÙ"
            case nvend = moz7
               lem7:= SubStr(lem7, 1, Len(lem7) - 1) + "ÚÄÄÄ¿"
               lim7:= lim7 + Str(nlote, 3) + "³"
               lom7:= SubStr(lom7, 1, Len(lom7) - 1) + "ÀÄÄÄÙ"
            case nvend = moz8
               lem8:= SubStr(lem8, 1, Len(lem8) - 1) + "ÚÄÄÄ¿"
               lim8:= lim8 + Str(nlote, 3) + "³"
               lom8:= SubStr(lom8, 1, Len(lom8) - 1) + "ÀÄÄÄÙ"
            case nvend = moz9
               lem9:= SubStr(lem9, 1, Len(lem9) - 1) + "ÚÄÄÄ¿"
               lim9:= lim9 + Str(nlote, 3) + "³"
               lom9:= SubStr(lom9, 1, Len(lom9) - 1) + "ÀÄÄÄÙ"
            case nvend = moz10
               lem10:= SubStr(lem10, 1, Len(lem10) - 1) + "ÚÄÄÄ¿"
               lim10:= lim10 + Str(nlote, 3) + "³"
               lom10:= SubStr(lom10, 1, Len(lom10) - 1) + "ÀÄÄÄÙ"
            endcase
         endif
         skip 
      enddo
      if (moz1 > 0)
         select 5
         seek moz1
         n1:= SubStr(nombre, 1, 20)
         select 2
         @  4,  1 say Str(moz1, 2) + " " + n1
         @  3, 25 say lem1
         @  4, 25 say lim1
         @  5, 25 say lom1
      endif
      if (moz2 > 0)
         select 5
         seek moz2
         n2:= SubStr(nombre, 1, 20)
         select 2
         @  6,  1 say Str(moz2, 2) + " " + n2
         @  5, 25 say lem2
         @  6, 25 say lim2
         @  7, 25 say lom2
      endif
      if (moz3 > 0)
         select 5
         seek moz3
         n3:= SubStr(nombre, 1, 20)
         select 2
         @  8,  1 say Str(moz3, 2) + " " + n3
         @  7, 25 say lem3
         @  8, 25 say lim3
         @  9, 25 say lom3
      endif
      if (moz4 > 0)
         select 5
         seek moz4
         n4:= SubStr(nombre, 1, 20)
         select 2
         @ 10,  1 say Str(moz4, 2) + " " + n4
         @  9, 25 say lem4
         @ 10, 25 say lim4
         @ 11, 25 say lom4
      endif
      if (moz5 > 0)
         select 5
         seek moz5
         n5:= SubStr(nombre, 1, 20)
         select 2
         @ 12,  1 say Str(moz5, 2) + " " + n5
         @ 11, 25 say lem5
         @ 12, 25 say lim5
         @ 13, 25 say lom5
      endif
      if (moz6 > 0)
         select 5
         seek moz6
         n6:= SubStr(nombre, 1, 20)
         select 2
         @ 14,  1 say Str(moz6, 2) + " " + n6
         @ 13, 25 say lem6
         @ 14, 25 say lim6
         @ 15, 25 say lom6
      endif
      if (moz7 > 0)
         select 5
         seek moz7
         n7:= SubStr(nombre, 1, 20)
         select 2
         @ 16,  1 say Str(moz7, 2) + " " + n7
         @ 15, 25 say lem7
         @ 16, 25 say lim7
         @ 17, 25 say lom7
      endif
      if (moz8 > 0)
         select 5
         seek moz8
         n8:= SubStr(nombre, 1, 20)
         select 2
         @ 18,  1 say Str(moz8, 2) + " " + n8
         @ 17, 25 say lem8
         @ 18, 25 say lim8
         @ 19, 25 say lom8
      endif
      if (moz9 > 0)
         select 5
         seek moz9
         n9:= SubStr(nombre, 1, 20)
         select 2
         @ 20,  1 say Str(moz9, 2) + " " + n9
         @ 19, 25 say lem9
         @ 20, 25 say lim9
         @ 21, 25 say lom9
      endif
      if (moz10 > 0)
         select 5
         seek moz10
         n10:= SubStr(nombre, 1, 20)
         select 2
         @ 22,  1 say Str(moz10, 2) + " " + n10
         @ 21, 25 say lem10
         @ 22, 25 say lim10
         @ 23, 25 say lom10
      endif
      set color to R/W*
      @ 24, 45 say "Pulse una tecla para continuar..."
      InKey(0)
      keyboard Chr(27)
      close databases
      select 1
      set color to (olcol)
      restore screen from playm
      opevar()
      return
   endif

********************************
procedure VERFACT

   clovar()
   olcol:= SetColor()
   save screen to pverf
   opbassha("FACTURAS")
   if (EOF())
      alert("No hay comprobantes emitidos.")
      close
      set color to (olcol)
      restore screen from pverf
      opevar()
   else
      qt1:= qt2:= qt3:= qt4:= qt5:= 0
      DBEval({|| (qt1:= qt1 + totbase, qt2:= qt2 + iva, qt3:= qt3 + ;
         impint, qt4:= qt4 + retrni, qt5:= qt5 + total)}, Nil, Nil, ;
         Nil, Nil, .F.)
      campy:= ;
         "strzero(sucursal,4)+'-'+strzero(Numero,8)+' '+letra+' ³'+str(Totbase,10,2)+' '+str(iva,9,2)+' '+str(impint,9,2)+' '+str(retrni,9,2)+'³'+str(total,10,2)+'³'+str(descuento,9,2)    "
      private aprov[1]
      private tit1[1]
      aprov:= {campy}
      tit1:= ;
         {"  Comprobante       M.base    I.V.A.   Imp.Int    R.N.I.    TOTAL    Descuento"}
      jjbox(6, 0, 23, 79, "N/BG", 20, 1, .F.)
      set color to R/W*
      @ 24,  0 say ;
         "                                                            ESC=salir           "
      set color to N/BG,W+/R
      @ 21,  1 say ;
         "                 ÄÄÄÄÄÄÄÄÄÄ ÄÄÄÄÄÄÄÄÄ ÄÄÄÄÄÄÄÄÄ ÄÄÄÄÄÄÄÄÄ³ÄÄÄÄÄÄÄÄÄÄ³ÄÄÄÄÄÄÄÄÄ"
      @ 22, 18 say Str(qt1, 10, 2) + " " + Str(qt2, 9, 2) + " " + ;
         Str(qt3, 9, 2) + " " + Str(qt4, 9, 2) + "³" + Str(qt5, 10, ;
         2) + "³"
      goto bottom
      skip -11
      keyboard Chr(3)
      dbedit(7, 1, 20, 78, aprov, "funprov8", .T., tit1)
      close
      set color to (olcol)
      restore screen from pverf
      opevar()
      return
   endif

********************************
function FUNPROV8(Arg1, Arg2)

   alfa:= aprov[Arg2]
   do case
   case Arg1 = 0 .OR. Arg1 = 1
      set color to B/BG
      @ 22,  5 say hora
      set color to B/W
      @  2, 10 say lote picture "9999"
      @  3, 10 say ncliente picture "99999"
      @  3, 16 say SubStr(cliente, 1, 25)
      @  4, 10 say nrodoc
      if (respon > 0)
         @  4, 24 say respiva[respon][3]
      else
         @  4, 24 say "                    "
      endif
      @  2, 56 say nvend picture "99"
      @  3, 56 say ncondvent picture "99"
      @  4, 56 say ndeposito picture "99"
      @  5, 56 say nlista picture "99"
      @  2, 59 say SubStr(vendedor, 1, 20)
      @  3, 59 say condvent
      @  4, 59 say SubStr(deposito, 1, 20)
      @  5, 59 say lista
      set color to N/BG,W+/R
      return 1
   case LastKey() = K_ESC
      return 0
   case LastKey() = K_ENTER
      acata:= RecNo()
      return 0
   case Arg1 = 2
      return 1
   case Arg1 = 3
      return 1
   otherwise
      return 1
   endcase
   return 1

********************************
procedure INDEXAR

   save screen to pindex
   colindex:= SetColor()
   set default to (idireca)
   mensaje("Indexando: EST03   .DBF", "N/W")
   use EST03
   index on STR(NRO_MODULO,2)+STR(NRO_RUTINA,3) to NUMMOD3
   mensaje("Indexando: EST04   .DBF", "N/W")
   use EST04
   index on STR(NRO_MODULO,2)+STR(NRO_RUTINA,3)+STR(NRO_SUBMEN,3) to ;
      NUMMOD4
   set default to (idirec)
   mensaje("Indexando: BASE003 .DBF", "N/W")
   use BASE003
   index on COD to BASE003A
   index on NOMBRECOM to BASE003B
   index on CODBARRA to BASE003X
   mensaje("Indexando: BASE004 .DBF", "N/W")
   use BASE004
   index on NRO_RUBRO to BASE004A
   index on NOM_RUBRO to BASE004B
   mensaje("Indexando: BASE005 .DBF", "N/W")
   use BASE005
   index on NRO_RUBRO to BASE005A
   index on NOM_RUBRO to BASE005B
   index on STR(NRO_GRUPO,2)+STR(NRO_RUBRO,2) to BASE005C
   mensaje("Indexando: BASE007 .DBF", "N/W")
   use BASE007
   index on NRO_CONCEP to BASE007A
   index on NOM_CONCEP to BASE007B
   mensaje("Indexando: BASE008 .DBF", "N/W")
   use BASE008
   index on NUMERO to BASE008A
   index on NOMBRE to BASE008B
   mensaje("Indexando: BASE009 .DBF", "N/W")
   use BASE009
   index on NRO_CLIENT to BASE009A
   index on EMPRESA to BASE009B
   index on NRODOC to BASE009C
   mensaje("Indexando: BASE010 .DBF", "N/W")
   use BASE010
   index on NUMERO to BASE010A
   mensaje("Indexando: BASE011 .DBF", "N/W")
   use BASE011
   index on NUMERO to BASE011A
   mensaje("Indexando: BASE012 .DBF", "N/W")
   use BASE012
   index on NUMERO to BASE012A
   mensaje("Indexando: BASE013 .DBF", "N/W")
   use BASE013
   index on NUMERO to BASE013A
   mensaje("Indexando: BASE014 .DBF", "N/W")
   use BASE014
   index on NUMERO to BASE014A
   mensaje("Indexando: BASE015 .DBF", "N/W")
   use BASE015
   index on NUMERO to BASE015A
   mensaje("Indexando: BASE016 .DBF", "N/W")
   use BASE016
   index on NUMERO to BASE016A
   mensaje("Indexando: RECIBOS .DBF", "N/W")
   use RECIBOS
   index on NRO_RECI to NUMRECI
   index on NRO_CLIEN to CLIRECI
   mensaje("Indexando: BASE018 .DBF", "N/W")
   use BASE018
   index on FECHAVTO to BASE018C
   mensaje("Indexando: BASE019 .DBF", "N/W")
   use BASE019
   index on CUENTA to BASE019A
   mensaje("Indexando: MAYORFAC.DBF", "N/W")
   use MAYORFAC
   index on STRZERO(SUCURSAL,4)+STRZERO(NUMERO,8) to NUMAYFAC
   use COMPINIC
   index on TIPO to COMPINIC
   close
   restore screen from pindex
   set color to (colindex)
   return

********************************
function USERSELE1(Arg1, Arg2, Arg3)

   local Local1
   Local1:= 2
   if (LastKey() == K_ESC)
      return 0
   else
      k:= 1
      for k:= 1 to totlen
         if (Arg2 == k)
            nelem:= k
            do case
            case LastKey() = K_ENTER
               wwrr:= SubStr(selecciona[nelem], 1, 30)
               if (seleccionb[nelem][2] == 0)
                  selecciona[nelem]:= wwrr + " Œ  "
                  seleccionb[nelem][2]:= 1
                  wwquereg:= wwquereg + 1
               else
                  selecciona[nelem]:= wwrr + "    "
                  seleccionb[nelem][2]:= 0
                  wwquereg:= wwquereg - 1
               endif
            case LastKey() >= 65 .AND. LastKey() <= 90
               qmbusc:= Upper(Chr(LastKey()))
               hayono:= ascan(selecciona, qmbusc)
               if (hayono > 0)
                  Local1:= 3
               endif
            case LastKey() >= 97 .AND. LastKey() <= 122
            case LastKey() = 164 .OR. LastKey() = 165
            endcase
         endif
      next
   endif
   return Local1

********************************
function USERSELE(Arg1, Arg2, Arg3)

   local Local1, Local2
   Local1:= 2
   Local2:= LastKey()
   do case
   case Arg1 == 1
      tone(100, 3)
   case Arg1 == 2
      tone(100, 3)
   case Arg1 == 3
      do case
      case Local2 == 13
         k:= 1
         for k:= 1 to totlen
            if (Arg2 == k)
               nelem:= k
               wwrr:= SubStr(selecciona[nelem], 1, 30)
               if (seleccionb[nelem][2] == 0)
                  selecciona[nelem]:= wwrr + " Œ  "
                  seleccionb[nelem][2]:= 1
                  wwquereg:= wwquereg + 1
               else
                  selecciona[nelem]:= wwrr + "    "
                  seleccionb[nelem][2]:= 0
                  wwquereg:= wwquereg - 1
               endif
               Local1:= 2
            endif
         next
      case Local2 == 27
         Local1:= 0
      otherwise
         Local1:= 3
      endcase
   endcase
   return Local1

* EOF

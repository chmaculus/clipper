#include "common.ch"
#include "inkey.ch"

********************************
function JJBOX

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
procedure BROW03

   colbrow:= SetColor()
   parameters campos, coorx, coory, bcol1, bcol3, cref, tref
   barr1:= coorx
   bizq1:= coory
   baba1:= barr1 + 2 + cuanhay
   if (baba1 > 22)
      baba1:= 22
   endif
   bder1:= bizq1 + Len(&campos) + 1
   private aprov[1]
   private tit1[1]
   aprov:= {campos}
   tit1:= {" " + alltrim(afrases[37])}
   jjbox(barr1, bizq1, baba1 + 1, bder1, bcol1, 20, 1, .T.)
   set color to (bcol1)
   set color to (bcol3)
   dbedit(barr1 + 1, bizq1 + 1, baba1, bder1 - 1, aprov, "funprov3", ;
      .T., tit1)
   set color to (colbrow)
   return

********************************
*procedure MOD1E


********************************
procedure FUN_16_4

   set color to N/W
   jcbox(3, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Carga Inicial de Saldos")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @  4,  1 say ;
      "                                                                              "
   @  5,  1 say ;
      " Cliente   :                                       Fecha de saldo:            "
   @  6,  1 say ;
      "                                                   Saldo         :            "
   @  7,  1 say ;
      "                                                   Diferencia    :            "
   @  8,  1 say ;
      "ÄComprobantes que componen saldoÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @  9,  1 say ;
      "                                                                              "
   @ 10,  1 say ;
      "  Tipo   N£mero      Fecha Emis Fecha Vto.    D‚bito     Cr‚dito              "
   @ 11,  1 say ;
      "                                                                              "
   @ 12,  1 say ;
      "                                                                              "
   @ 13,  1 say ;
      "                                                                              "
   @ 14,  1 say ;
      "                                                                              "
   @ 15,  1 say ;
      "                                                                              "
   @ 16,  1 say ;
      "                                                                              "
   @ 17,  1 say ;
      "                                                                              "
   @ 18,  1 say ;
      "                                                                              "
   @ 19,  1 say ;
      "                                                                              "
   @ 20,  1 say ;
      "                                                                              "
   @ 21,  1 say ;
      "                                                                              "
   @ 22,  1 say ;
      "                                                                              "
   save screen to pinic0
   save screen to pinic1
   wnrocl:= 0
   wclien:= Space(30)
   wfesal:= Date()
   wfemax:= Date()
   wconce:= "Composicion inicial de saldos"
   do while (.T.)
      close databases
      restore screen from pinic0
      wwwdifer:= 0
      wwsaldo:= 0
      wclien:= Space(30)
      wwwdifer:= 0
      set color to B/W,R/W*,,B,B/W
      campy:= "substr(str(nro_client,5)+' '+empresa,1,35)"
      elnom:= wclien
      elnum:= wnrocl
      do while (.T.)
         select 3
         opbassha("BASE009", "BASE009B")
         @  5, 20 get elnom picture "@K"
         read
         if (LastKey() == K_ESC)
            exit
         endif
         elno:= Upper(alltrim(elnom))
         if (Len(elno) > 0)
            opbasexc("SELEC")
            zap
            append from BASE009 for Upper(empresa) = elno
            goto top
            if (EOF())
               alert(alltrim(afrases[44]))
               close
               loop
            endif
         endif
         cuanhay:= LastRec()
         if (cuanhay == 1)
            wnrocl:= nro_client
            wclien:= empresa
            exit
         else
            save screen to panty
            brow03(campy, 8, 18, "N/BG", "N/BG,W+/R", "empresa", 2)
            restore screen from panty
            if (LastKey() == K_ESC)
               exit
            endif
            wnrocl:= nro_client
            wclien:= empresa
            exit
         endif
      enddo
      close
      if (LastKey() == K_ESC)
         alert("Carga cancelada.")
         close databases
         select 1
         return
      endif
      @  5, 14 say Str(wnrocl, 5) + " " + wclien
      save screen to pinic1
      opbasexc("BASE018")
      copy to temp018 for nro_client = wnrocl
      opbassha("temp018")
      if (!EOF())
         index on fecha to temp018
         goto top
         wfemax:= fecha - 1
         wfesal:= fecha - 1
      endif
      close
      @  5, 68 get wfesal valid wfesal <= wfemax
      read
      if (LastKey() == K_ESC)
         loop
      endif
      y:= 1
      for y:= 1 to 12
         wcompr:= "wcompr" + alltrim(Str(y, 2))
         wfecha:= "wfecha" + alltrim(Str(y, 2))
         wnroco:= "wnroco" + alltrim(Str(y, 2))
         wtipoc:= "wtipoc" + alltrim(Str(y, 2))
         wfecvt:= "wfecvt" + alltrim(Str(y, 2))
         wdebit:= "wdebit" + alltrim(Str(y, 2))
         wcredi:= "wcredi" + alltrim(Str(y, 2))
         &wcompr:= "   "
         &wfecha:= wfesal
         &wnroco:= "0000-00000000"
         &wtipoc:= " "
         &wfecvt:= wfesal
         &wdebit:= 0
         &wcredi:= 0
      next
      save screen to pinic1
      wwsaldo:= 0
      mensaje("Si es saldo deudor ingresarlo negativo", "N/W")
      @  6, 68 get wwsaldo picture "9999999.99" valid wwsaldo != 0
      read
      restore screen from pinic1
      if (LastKey() == K_ESC)
         loop
      endif
      wwwdifer:= wwsaldo
      @  5, 68 say wfesal
      @  6, 68 say wwsaldo picture "9999999.99"
      @  7, 68 say wwwdifer picture "9999999.99"
      save screen to pinic1
      y:= 1
      do while (.T.)
         wcompr:= "wcompr" + alltrim(Str(y, 2))
         wfecha:= "wfecha" + alltrim(Str(y, 2))
         wnroco:= "wnroco" + alltrim(Str(y, 2))
         wtipoc:= "wtipoc" + alltrim(Str(y, 2))
         wfecvt:= "wfecvt" + alltrim(Str(y, 2))
         wdebit:= "wdebit" + alltrim(Str(y, 2))
         wcredi:= "wcredi" + alltrim(Str(y, 2))
         campy:= "tipo"
         elnom:= &wcompr
         do while (.T.)
            opbassha("compinic", "compinic")
            @ 10 + y,  6 say ;
               "                                                             "
            @ 10 + y,  2 get elnom picture "@!"
            read
            if (LastKey() == K_ESC)
               exit
            endif
            elno:= alltrim(elnom)
            if (Len(elno) > 0)
               copy to selinic for Upper(tipo) = elno
               opbasexc("SELINIC")
               goto top
               if (EOF())
                  alert(alltrim(afrases[44]))
                  close
                  loop
               endif
            endif
            cuanhay:= LastRec()
            if (cuanhay == 1)
               &wcompr:= tipo
               exit
            else
               save screen to panty
               brow03(campy, 8, 18, "N/BG", "N/BG,W+/R", "empresa", 2)
               restore screen from panty
               if (LastKey() == K_ESC)
                  exit
               endif
               &wcompr:= tipo
               exit
            endif
         enddo
         close
         if (LastKey() == K_ESC)
            exit
         endif
         @ 10 + y,  2 say &wcompr
         @ 10 + y,  6 get &wtipoc picture "@!"
         @ 10 + y,  8 get &wnroco picture "9999-99999999"
         @ 10 + y, 22 get &wfecha
         @ 10 + y, 33 get &wfecvt
         @ 10 + y, 45 get &wdebit picture "9999999.99"
         @ 10 + y, 57 get &wcredi picture "9999999.99"
         read
         wwwdifer:= wwwdifer + &wdebit - &wcredi
         @  7, 68 say wwwdifer picture "9999999.99"
         if (LastKey() == K_ESC)
            &wcompr:= "   "
            &wfecha:= Date()
            &wnroco:= "0000-00000000"
            &wtipoc:= " "
            &wfecvt:= Date()
            &wdebit:= 0
            &wcredi:= 0
            if (wwwdifer == 0)
               exit
            else
               loop
            endif
         endif
         if (y == 12)
            exit
         endif
         y:= y + 1
      enddo
      wwwdifer:= Val(Str(wwwdifer, 11, 2))
      if (wwwdifer == 0)
      else
         alert("La diferencia debe quedar en cero.")
         close databases
         select 1
         loop
      endif
      save screen to pinic1
      resp:= " "
      confirm0(19, 30)
      restore screen from pinic1
      if (resp = "S")
         close databases
         select 2
         opbasexc("BASE009", "BASE009A")
         seek wnrocl
         if (Found())
            oldsaldo:= saldo
            replace saldo with wwsaldo + oldsaldo
         else
            alert("No encontr‚ el cliente para actualizar el saldo...")
         endif
         close
         select 1
         opbasexc("BASE018", "BASE018C")
         y:= 1
         for y:= 1 to 12
            wcompr:= "wcompr" + alltrim(Str(y, 2))
            wfecha:= "wfecha" + alltrim(Str(y, 2))
            wnroco:= "wnroco" + alltrim(Str(y, 2))
            wtipoc:= "wtipoc" + alltrim(Str(y, 2))
            wfecvt:= "wfecvt" + alltrim(Str(y, 2))
            wdebit:= "wdebit" + alltrim(Str(y, 2))
            wcredi:= "wcredi" + alltrim(Str(y, 2))
            if (Len(alltrim(&wcompr)) > 0)
               append blank
               replace fecha with &wfecha
               if (&wcompr = "FAC")
                  replace nro_compr with strzero(Val(SubStr(&wnroco, ;
                     1, 4))) + "-" + strzero(Val(SubStr(&wnroco, 6, ;
                     8)))
               else
                  replace nro_compr with &wcompr + SubStr(&wtipoc, ;
                     4, 1) + "-" + strzero(Val(SubStr(&wnroco, 6, 8)))
               endif
               replace tipo with &wtipoc
               replace concepto with wconce
               replace nro_client with wnrocl
               replace cliente with wclien
               replace fechavto with &wfecvt
               replace debito with &wdebit
               replace credito with &wcredi
               if (&wdebit > 0)
                  replace totalfac with &wdebit
               else
                  replace totalfac with &wcredi
               endif
            else
               exit
            endif
         next
      endif
   enddo
   close databases
   select 1
   return

********************************
procedure FUN_12_3

   set color to N/W,W+/B
   jcbox(3, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Actualizar Listas de Precios")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   opbassha("BASE003")
   set index to base003a, base003b
   set order to 1
   goto top
   private aprov[6]
   private tit1[1]
   aprov:= {"cod+' '+nombrered", "str(precio1,11,4)", ;
      "str(precio2,11,4)", "str(precio3,11,4)", "str(precio4,11,4)", ;
      "str(precio5,11,4)"}
   tit1:= {" C¢digo        Art¡culo      ", "  Lista 1  ", ;
      "  Lista 2  ", "  Lista 3  ", "  Lista 4  ", "  Lista 5  "}
   set color to N/W
   set color to R/W*
   @ 24,  0 say ;
      "     <Enter>=modifica precio individual      <F10>=modifica precio en bloque    "
   set color to N/W
   dbedit(4, 1, 22, 78, aprov, "funprov9", .T., tit1)
   close
   select 1

********************************
function FUNPROV9(Arg1, Arg2)

   alfa:= aprov[Arg2]
   do case
   case Arg1 = 0 .OR. Arg1 = 1
      return 1
   case LastKey() = K_ESC
      return 0
   case LastKey() = K_ENTER
      wh:= Row()
      wf:= Col()
      save screen to pannet
      opbcol:= SetColor()
      do while (.T.)
         if (FLock())
            set color to R/W*
            @ 24,  0 say ;
               "     Ingrese el nuevo precio y pulse Enter.             Esc=cancela             "
            set color to N/W,R/W*
            setcursor(1)
            do case
            case Arg2 = 2
               @ wh, wf get precio1 picture "999999.9999"
            case Arg2 = 3
               @ wh, wf get precio2 picture "999999.9999"
            case Arg2 = 4
               @ wh, wf get precio3 picture "999999.9999"
            case Arg2 = 5
               @ wh, wf get precio4 picture "999999.9999"
            case Arg2 = 6
               @ wh, wf get precio5 picture "999999.9999"
            endcase
            read
            setcursor(0)
            unlock
            exit
         else
            set color to W+/R
            jjbox(9, 12, 11, 70, "W+/R", 20, 1, .F.)
            @ 10, 15 say ;
               "ATENCION: Archivo ocupado en red, espere por favor.."
            InKey(1)
         endif
      enddo
      set color to (opbcol)
      restore screen from pannet
      return 1
   case LastKey() = -9
      save screen to pbloque
      mueva:= 1
      if (Arg2 < 2)
         alert("Debe posicionarse en la lista que quiere modificar")
         setcursor(0)
         return 1
      endif
      jjbox(16, 0, 23, 79, "N/W", 20, 1, .T.)
      @ 17,  1 say "  Actualizar precios en bloque a "
      @ 19,  1 say "  Actualizar: "
      @ 21,  1 say "  Lista base: "
      set color to R/W
      do case
      case Arg2 = 2
         @ 17, 35 say "LISTA 1"
      case Arg2 = 3
         @ 17, 35 say "LISTA 2"
      case Arg2 = 4
         @ 17, 35 say "LISTA 3"
      case Arg2 = 5
         @ 17, 35 say "LISTA 4"
      case Arg2 = 6
         @ 17, 35 say "LISTA 5"
      endcase
      set wrap on
      save screen to plista
      cartel1:= ""
      nque:= 0
      numref:= ""
      set color to N/W
      @ 19, 15 say "ÄÂÄ"
      @ 20, 15 say " ÃÄ"
      @ 21, 15 say " ÀÄ"
      wwopc:= 1
      do while (wwopc != 0)
         @ 19, 18 prompt "Todos  "
         @ 20, 18 prompt "Grupo  "
         @ 21, 18 prompt "Familia"
         menu to wwopc
         if (wwopc = 1)
            cartel1:= "Todos...                      "
            nque:= 1
            exit
         elseif (wwopc = 2)
            cartel1:= "                              "
            nque:= 2
            exit
         elseif (wwopc = 3)
            cartel1:= "                              "
            nque:= 3
            exit
         endif
      enddo
      if (LastKey() == K_ESC)
         alert("Modificaci¢n cancelada")
         restore screen from pbloque
         setcursor(0)
         return 1
      endif
      restore screen from plista
      if (nque == 2)
         select 2
         opbassha("BASE004", "BASE004A")
         campy:= "SUBSTR(STR(NRO_RUBRO,2)+' '+NOM_RUBRO,1,24)"
         cuanhay:= LastRec()
         save screen to p13_2
         brow03(campy, 15, 15, "N/BG", "N/BG,W+/R", "NOM_RUBRO", 2)
         restore screen from p13_2
         if (LastKey() == K_ESC)
            alert("Modificaci¢n cancelada")
            close
            select 1
            setcursor(0)
            restore screen from pbloque
            return 1
         endif
         numref:= strzero(nro_rubro, 2)
         cartel1:= nom_rubro
         close
         select 1
      endif
      if (nque == 3)
         select 2
         opbassha("BASE005", "BASE005A")
         campy:= ;
            "SUBSTR(STR(NRO_GRUPO,2)+' '+NOM_GRUPO+'ÄÄ>'+STR(NRO_RUBRO,2)+' '+NOM_RUBRO,1,49)"
         cuanhay:= LastRec()
         save screen to p13_2
         brow03(campy, 15, 15, "N/BG", "N/BG,W+/R", "NOM_RUBRO", 2)
         restore screen from p13_2
         if (LastKey() == K_ESC)
            alert("Modificaci¢n cancelada")
            close
            select 1
            setcursor(0)
            restore screen from pbloque
            return 1
         endif
         numref:= strzero(nro_grupo, 2) + strzero(nro_rubro, 2)
         cartel1:= nom_rubro
         close
         select 1
      endif
      restore screen from plista
      @ 19, 15 say cartel1
      save screen to plista
      set wrap on
      save screen to plista
      cartel2:= ""
      ncampo:= 0
      jjbox(17, 15, 23, 31, "N/BG", 20, 1, .T.)
      set color to N/BG
      wwopc:= 1
      do while (wwopc != 0)
         @ 18, 16 prompt " Sobre Lista 1 "
         @ 19, 16 prompt " Sobre Lista 2 "
         @ 20, 16 prompt " Sobre Lista 3 "
         @ 21, 16 prompt " Sobre Lista 4 "
         @ 22, 16 prompt " Sobre Lista 5 "
         menu to wwopc
         do case
         case wwopc = 1
            cartel2:= "Lista 1"
            ncampo:= 2
            exit
         case wwopc = 2
            cartel2:= "Lista 2"
            ncampo:= 3
            exit
         case wwopc = 3
            cartel2:= "Lista 3"
            ncampo:= 4
            exit
         case wwopc = 4
            cartel2:= "Lista 4"
            ncampo:= 5
            exit
         case wwopc = 5
            cartel2:= "Lista 5"
            ncampo:= 6
            exit
         endcase
      enddo
      set color to N/W
      if (LastKey() == K_ESC)
         alert("Modificaci¢n cancelada")
         restore screen from pbloque
         setcursor(0)
         return 1
      endif
      restore screen from plista
      @ 21, 15 say cartel2 + " x "
      save screen to plista
      liscoef:= 0
      @ 21, 25 get liscoef picture "99.99"
      read
      if (LastKey() == K_ESC)
         alert("Modificaci¢n cancelada")
         restore screen from pbloque
         setcursor(0)
         return 1
      endif
      @ 21, 25 say liscoef picture "99.99"
      save screen to pfinal
      resp:= " "
      confirm0(15, 30)
      set color to N/W
      restore screen from pfinal
      if (resp = "S")
         mensaje("Actualizando listas de precios...", "N/W")
         save screen to pannet
         opbcol:= SetColor()
         set color to W+/R
         do while (.T.)
            if (FLock())
               estereg:= RecNo()
               wcampo1:= FieldName(ncampo + 19)
               wcampo2:= FieldName(Arg2 + 19)
               woper:= wcampo1 + "*" + alltrim(Str(liscoef, 5, 2))
               if (nque = 1)
                  DBEval(&("{|| _FIELD->&wcampo2 := &woper}"), Nil, ;
                     Nil, Nil, Nil, .F.)
               elseif (nque = 2)
                  DBEval(&("{|| _FIELD->&wcampo2 := &woper}"), {|| ;
                     SubStr(cod, 1, 2) = numref}, Nil, Nil, Nil, .F.)
               elseif (nque = 3)
                  DBEval(&("{|| _FIELD->&wcampo2 := &woper}"), {|| ;
                     SubStr(cod, 1, 4) = numref}, Nil, Nil, Nil, .F.)
               endif
               goto top
               locate for RecNo() = estereg
               unlock
               exit
            else
               jjbox(9, 12, 11, 70, "W+/R", 20, 1, .F.)
               @ 10, 15 say ;
                  "ATENCION: Registro ocupado en red, espere por favor.."
               InKey(1)
            endif
         enddo
         set color to (opbcol)
         restore screen from pannet
      endif
      setcursor(0)
      restore screen from pbloque
      keyboard Chr(3) + Chr(18)
      return 1
   case Arg1 = 2
      return 1
   case Arg1 = 3
      return 1
   otherwise
      return 1
   endcase
   return 1

********************************
procedure FUN_12_4

   set color to N/W
   jcbox(10, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Listado de saldos")
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @ 12,  1 say ;
      " Art¡culos desde : 99999999   hasta: 99999999                                 "
   @ 13,  1 say ;
      "                                                                              "
   @ 14,  1 say ;
      " Listas a incluir:                                                            "
   @ 15,  1 say ;
      "                                                                              "
   @ 16,  1 say ;
      " Separa x fl¡as? :                                                            "
   @ 17,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   opbassha("BASE003", "BASE003A")
   goto top
   desdecod:= cod
   goto bottom
   hastacod:= cod
   close
   save screen to plistas
   do while (.T.)
      restore screen from plistas
      set color to R/W*
      @ 24,  0 say ;
         "  Ingrese los c¢digos de art¡culos como referencias.                            "
      set color to N/W
      @ 12, 20 get desdecod picture "99999999" valid desdecod <= ;
         hastacod
      @ 12, 38 get hastacod picture "99999999" valid hastacod >= ;
         desdecod
      read
      if (LastKey() == K_ESC)
         alert("Consulta cancelada...")
         exit
      endif
      save screen to plistas1
      set color to R/W*
      @ 24,  0 say ;
         "  Ingrese N§ de lista que desea agregar y t¡tulo de columna que tendr .         "
      set color to N/W
      wlis1:= 0
      wlis2:= 0
      wlis3:= 0
      wlis4:= 0
      wnlis1:= Space(12)
      wnlis2:= Space(12)
      wnlis3:= Space(12)
      wnlis4:= Space(12)
      @ 14, 20 get wlis1 picture "9" valid wlis1 > 0
      @ 14, 22 get wnlis1 valid Len(alltrim(wnlis1)) > 0
      @ 14, 35 get wlis2 picture "9"
      @ 14, 37 get wnlis2 when wlis2 > 0
      @ 14, 50 get wlis3 picture "9"
      @ 14, 52 get wnlis3 when wlis3 > 0
      @ 14, 65 get wlis4 picture "9"
      @ 14, 67 get wnlis4 when wlis4 > 0
      read
      if (LastKey() = K_ESC .AND. wlis1 + wlis2 + wlis3 + wlis4 = 0)
         restore screen from plistas1
         loop
      endif
      set color to R/W*
      @ 24,  0 say ;
         "                                                                                "
      set color to N/W
      save screen to plistas1
      set wrap on
      @ 16, 19 say "ÄÂÄ"
      @ 17, 19 say " ÀÄ"
      wwopc:= 1
      wwcartel2:= ""
      do while (wwopc != 0)
         @ 16, 22 prompt "S¡"
         @ 17, 22 prompt "No"
         menu to wwopc
         if (wwopc = 1)
            wwcartel2:= "S¡"
            exit
         elseif (wwopc = 2)
            wwcartel2:= "No"
            exit
         endif
      enddo
      restore screen from plistas1
      if (LastKey() == K_ESC)
         loop
      endif
      @ 16, 20 say wwcartel2
      save screen to plistas1
      resp:= " "
      confirm0(19, 30)
      restore screen from plistas1
      if (resp = "S")
         nimpf:= 0
         do while (.T.)
            wwdonimp:= dondeimpri(1)
            if (wwdonimp == 0)
               exit
            endif
            if (wwdonimp = 1)
               alert("Seleccione una impresora.")
               loop
            elseif (wwdonimp = 2)
               alert("Seleccione una impresora.")
               loop
            elseif (wwdonimp > 2)
               exit
            endif
         enddo
         if (wwdonimp == 0)
            loop
         endif
         restore screen from plistas1
         if (wwopc == 1)
            opbasexc("BASE003", "BASE003A")
         else
            opbasexc("BASE003", "BASE003B")
         endif
         copy to lista01 for cod >= desdecod .AND. cod <= hastacod
         opbassha("LISTA01")
         if (!EOF())
            mensaje("Imprimiendo listas de precios...", 28)
            imprimepre()
         else
            alert("No existen art¡culos que cumplan la condici¢n...")
         endif
         exit
      endif
   enddo
   close databases
   select 1
   return

********************************
procedure IMPRIMEPRE

   xxpprr:= impresoras[wwdonimp][5]
   mpconon:= &xxpprr
   xxpprr:= impresoras[wwdonimp][6]
   mpconoff:= &xxpprr
   xxpprr:= impresoras[wwdonimp][7]
   titulon:= &xxpprr
   xxpprr:= impresoras[wwdonimp][8]
   tituloff:= &xxpprr
   nport:= impresoras[wwdonimp][2]
   set printer to (nport)
   pri:= 0
   do while (.T.)
      if (isprinter())
         exit
      else
         pri:= pri + 1
         alert("IMPRESORA FUERA DE LINEA, VERIFIQUE...")
         if (pri == 3)
            set printer to lpt1
            return
         endif
      endif
   enddo
   set console off
   pag:= 1
   set printer on
   goto top
   desdereg:= RecNo()
   refartic:= "0000"
   do while (.T.)
      ? mpconoff, "      ", Space(35), "   ", "    ", Date(), ;
         "     Pag.", Str(pag, 4, 0)
      ? "       ", titulon, titular, tituloff
      ? 
      ? "       ", titulon, "LISTAS DE PRECIOS", tituloff
      ? 
      ? "       ", Replicate("Í", 70)
      ? "       ", mpconon, ;
         " CODIGO   DESCRIPCION DE ARTICULO                 UNID.", ;
         SubStr(Space(12 - Len(alltrim(wnlis1))) + alltrim(wnlis1), ;
         1, 12), SubStr(Space(12 - Len(alltrim(wnlis2))) + ;
         alltrim(wnlis2), 1, 12), SubStr(Space(12 - ;
         Len(alltrim(wnlis3))) + alltrim(wnlis3), 1, 12), ;
         SubStr(Space(12 - Len(alltrim(wnlis4))) + alltrim(wnlis4), ;
         1, 12), mpconoff
      ? "       ", Replicate("Ä", 70)
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas <= 55)
         if (SubStr(cod, 1, 4) != refartic .AND. wwopc = 1)
            ? "       ", Replicate("Í", 70)
            ? "       ", grupo, "", familia
            ? "       ", Replicate("Ä", 70)
            filas:= filas + 3
            refartic:= SubStr(cod, 1, 4)
         endif
         if (wlis4 > 0)
            wclis1:= "precio" + Str(wlis1, 1)
            wclis2:= "precio" + Str(wlis2, 1)
            wclis3:= "precio" + Str(wlis3, 1)
            wclis4:= "precio" + Str(wlis4, 1)
            waclis1:= Str(&wclis1, 12, 4)
            waclis2:= Str(&wclis2, 12, 4)
            waclis3:= Str(&wclis3, 12, 4)
            waclis4:= Str(&wclis4, 12, 4)
            ? "       ", mpconon, cod, nombrecom, unidad, waclis1, ;
               waclis2, waclis3, waclis4, mpconoff
         elseif (wlis3 > 0)
            wclis1:= "precio" + Str(wlis1, 1)
            wclis2:= "precio" + Str(wlis2, 1)
            wclis3:= "precio" + Str(wlis3, 1)
            waclis1:= Str(&wclis1, 12, 4)
            waclis2:= Str(&wclis2, 12, 4)
            waclis3:= Str(&wclis3, 12, 4)
            ? "       ", mpconon, cod, nombrecom, unidad, waclis1, ;
               waclis2, waclis3, mpconoff
         elseif (wlis2 > 0)
            wclis1:= "precio" + Str(wlis1, 1)
            wclis2:= "precio" + Str(wlis2, 1)
            waclis1:= Str(&wclis1, 12, 4)
            waclis2:= Str(&wclis2, 12, 4)
            ? "       ", mpconon, cod, nombrecom, unidad, waclis1, ;
               waclis2, mpconoff
         else
            wclis1:= "precio" + Str(wlis1, 1)
            waclis1:= Str(&wclis1, 12, 4)
            ? "       ", mpconon, cod, nombrecom, unidad, waclis1, ;
               mpconoff
         endif
         filas:= 1 + filas
         skip 
         if (EOF())
            exit
         endif
      enddo
      if (EOF())
         ? "       ", Replicate("Ä", 70)
      endif
      eject
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
      pag:= 1 + pag
   enddo
   set printer off
   set console on
   set printer to lpt1
   return

********************************
procedure FUN_17_1

   set color to N/W
   jcbox(10, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "IVA Ventas - Encabezados")
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @ 12,  1 say ;
      " T¡tulo           :                                                           "
   @ 13,  1 say ;
      "                                                                              "
   @ 14,  1 say ;
      " Fecha de timbrado:                                                           "
   @ 15,  1 say ;
      " Libro N§         :                                                           "
   @ 16,  1 say ;
      " Desde hoja Nro   :       hasta:                                              "
   @ 17,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   opbassha("BASE002")
   dato1:= alltrim(empresa) + " (" + alltrim(comercio) + ")"
   dato2:= alltrim(direccion) + " - " + alltrim(localidad) + " - " + ;
      alltrim(provincia)
   dato3:= "C.U.I.T. " + alltrim(cuit) + " - Ing.Brutos " + ;
      alltrim(ibruto) + " - N§ Estab. " + alltrim(estable) + ;
      " - Sede Timb. " + alltrim(timbrado)
   dato4:= "Libro I.V.A. VENTAS  COD.ACTIV." + alltrim(codact)
   close
   dato4:= SubStr(dato4 + Space(57), 1, 57)
   dato5:= Date()
   dato6:= 0
   dato7a:= 0
   dato7b:= 0
   save screen to plistas
   do while (.T.)
      restore screen from plistas
      set color to N/W
      @ 12, 21 get dato4 valid Len(alltrim(dato4)) > 0
      @ 14, 21 get dato5
      @ 15, 21 get dato6 picture "99" valid dato6 > 0
      @ 16, 21 get dato7a picture "9999" valid dato7a > 0
      @ 16, 34 get dato7b picture "9999" valid dato7b >= dato7a
      read
      if (LastKey() == K_ESC)
         alert("Procedimiento cancelado...")
         exit
      endif
      save screen to plistas1
      resp:= " "
      confirm0(19, 30)
      restore screen from plistas1
      if (resp = "S")
         nimpf:= 0
         do while (.T.)
            wwdonimp:= dondeimpri(1)
            if (wwdonimp == 0)
               exit
            endif
            if (wwdonimp = 1)
               alert("Seleccione una impresora.")
               loop
            elseif (wwdonimp = 2)
               alert("Seleccione una impresora.")
               loop
            elseif (wwdonimp > 2)
               exit
            endif
         enddo
         if (wwdonimp == 0)
            loop
         endif
         restore screen from plistas1
         mensaje("Imprimiendo encabezados...", 28)
         imprimeenc()
         exit
      endif
   enddo
   close databases
   select 1
   return

********************************
procedure IMPRIMEENC

   xxpprr:= impresoras[wwdonimp][5]
   mpconon:= &xxpprr
   xxpprr:= impresoras[wwdonimp][6]
   mpconoff:= &xxpprr
   xxpprr:= impresoras[wwdonimp][7]
   titulon:= &xxpprr
   xxpprr:= impresoras[wwdonimp][8]
   tituloff:= &xxpprr
   nport:= impresoras[wwdonimp][2]
   set printer to (nport)
   pri:= 0
   do while (.T.)
      if (isprinter())
         exit
      else
         pri:= pri + 1
         alert("IMPRESORA FUERA DE LINEA, VERIFIQUE...")
         if (pri == 3)
            set printer to lpt1
            return
         endif
      endif
   enddo
   set console off
   set printer on
   dato7c:= dato7a
   do while (.T.)
      ? "  ", mpconon, titulon, Space(Int((61 - Len(alltrim(dato1))) ;
         / 2)), alltrim(dato1), tituloff, mpconoff
      ? 
      ? "  ", mpconon, titulon, Space(Int((61 - Len(alltrim(dato2))) ;
         / 2)), alltrim(dato2), tituloff, mpconoff
      ? " ", mpconon, Space(Int((132 - Len(alltrim(dato3))) / 2)), ;
         alltrim(dato3), mpconoff
      ? 
      ? "  ", mpconon, titulon, Space(Int((61 - Len(alltrim(dato4))) ;
         / 2)), alltrim(dato4), tituloff, mpconoff
      ? 
      ? "    ", "Fecha de timbrado:", DToC(dato5), ;
         "          Libro N§", Str(dato6, 2), "          Hoja N§", ;
         Str(dato7c, 4)
      ? "  ", mpconon, Replicate("Ä", 130), mpconoff
      ? "  ", mpconon, ;
         "  Fecha   |  Tipo y n£mero  |                 Comprador                  |Conceptos|  Neto   |Impuest|  I.V.A. | Reten. |  Total  ", ;
         mpconoff
      ? "  ", mpconon, ;
         "          |  de comprobante | Raz¢n social                  C.U.I.T.  Res|no grabad| Grabado |Interno|   21%   | a RNI  | Facturas", ;
         mpconoff
      ? "  ", mpconon, Replicate("Ä", 130), mpconoff
      eject
      if (dato7c = dato7b)
         exit
      endif
      dato7c:= dato7c + 1
   enddo
   set printer off
   set console on
   set printer to lpt1
   return

********************************
procedure FUN_17_2

   set color to N/W
   jcbox(10, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "IVA Ventas - Cuerpo de listado")
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @ 12,  1 say ;
      " Desde fecha      :             hasta:                                        "
   @ 13,  1 say ;
      "                                                                              "
   @ 14,  1 say ;
      " Comprobantes tipo:                                                           "
   @ 15,  1 say ;
      "                                                                              "
   @ 16,  1 say ;
      "                                                                              "
   @ 17,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   opbassha("MAYORFAC")
   if (EOF())
      alert("No existen ventas registradas con cierre de caja.")
      close databases
      select 1
   else
      goto top
      desdef:= fecha
      goto bottom
      hastaf:= fecha
      close
      condicion:= ""
      condicion1:= ""
      acumtick:= " "
      save screen to plistas
      do while (.T.)
         restore screen from plistas
         set color to N/W
         @ 12, 21 get DesdeF valid desdef <= hastaf
         @ 12, 40 get HastaF valid hastaf >= desdef
         read
         if (LastKey() == K_ESC)
            alert("Proceso cancelado...")
            exit
         endif
         condicion:= "fecha>=DesdeF .and. fecha<=HastaF"
         save screen to plistas
         set wrap on
         @ 14, 20 say "ÄÂÄ"
         @ 15, 20 say " ÃÄ"
         @ 16, 20 say " ÀÄ"
         wwopc:= 1
         wwcartel2:= ""
         do while (wwopc != 0)
            @ 14, 23 prompt " Todos     "
            @ 15, 23 prompt " Fact. A   "
            @ 16, 23 prompt " Fac.B/Tic "
            menu to wwopc
            if (wwopc = 1)
               wwcartel2:= "Todos"
               exit
            elseif (wwopc = 2)
               wwcartel2:= "Facturas A"
               condicion1:= "upper(letra)='A'"
               exit
            elseif (wwopc = 3)
               wwcartel2:= "Facturas B y Tickets"
               condicion1:= "upper(letra)='B' .or. letra='T'"
               exit
            endif
         enddo
         restore screen from plistas
         if (LastKey() == K_ESC)
            loop
         endif
         @ 14, 21 say wwcartel2
         save screen to plistas
         resp:= " "
         confirm0(19, 30)
         restore screen from plistas
         if (resp = "S")
            opbasexc("MAYORFAC")
            copy structure to ivaventa
            opbasexc("IVAVENTA")
            append from mayorfac for &condicion
            goto top
            if (EOF())
               alert("No existen ventas en ‚ste per¡odo.")
               exit
            endif
            if (Len(alltrim(condicion1)) > 0)
               DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
               DBEval({|| dbRecall()}, &("{||" + condicion1 + "}"), ;
                  Nil, Nil, Nil, .F.)
               pack
            endif
            goto top
            if (EOF())
               alert("No existen los comprobantes de venta en ‚ste per¡odo.")
               exit
            endif
            DBEval({|| field->ncaja:= 5}, Nil, Nil, Nil, Nil, .F.)
            DBEval({|| field->ncaja:= 1}, {|| Upper(letra) = "A"}, ;
               Nil, Nil, Nil, .F.)
            DBEval({|| field->ncaja:= 2}, {|| Upper(letra) = "B" ;
               .OR. letra = "T"}, Nil, Nil, Nil, .F.)
            index on str(ncaja,12)+str(sucursal,4)+str(numero) to ;
               ivaventa
            nimpf:= 0
            do while (.T.)
               wwdonimp:= dondeimpri(1)
               if (wwdonimp == 0)
                  exit
               endif
               if (wwdonimp = 1)
                  alert("Seleccione una impresora.")
                  loop
               elseif (wwdonimp = 2)
                  alert("Seleccione una impresora.")
                  loop
               elseif (wwdonimp > 2)
                  exit
               endif
            enddo
            if (wwdonimp == 0)
               loop
            endif
            restore screen from plistas
            mensaje("Imprimiendo cuerpo de listado...", 28)
            imprimecue()
            exit
         endif
      enddo
      close databases
      select 1
      return
   endif

********************************
procedure IMPRIMECUE

   xxpprr:= impresoras[wwdonimp][5]
   mpconon:= &xxpprr
   xxpprr:= impresoras[wwdonimp][6]
   mpconoff:= &xxpprr
   xxpprr:= impresoras[wwdonimp][7]
   titulon:= &xxpprr
   xxpprr:= impresoras[wwdonimp][8]
   tituloff:= &xxpprr
   nport:= impresoras[wwdonimp][2]
   set printer to (nport)
   pri:= 0
   do while (.T.)
      if (isprinter())
         exit
      else
         pri:= pri + 1
         alert("IMPRESORA FUERA DE LINEA, VERIFIQUE...")
         if (pri == 3)
            set printer to lpt1
            return
         endif
      endif
   enddo
   goto top
   set console off
   set printer on
   desdereg:= RecNo()
   fsubtot1:= 0
   fsubtot2:= 0
   fsubtot3:= 0
   fsubtot4:= 0
   fsubtot5:= 0
   fsubtot6:= 0
   wwtipoc:= ncaja
   wwsucur:= sucursal
   wwnumer:= numero
   do while (.T.)
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 50 .AND. !EOF())
         wwnumer:= numero
         wwcomprob:= hqueletra() + strzero(sucursal, 4) + ;
            strzero(numero, 8)
         wwcuit:= SubStr(nrodoc, 1, 2) + "-" + SubStr(nrodoc, 3, 8) ;
            + "-" + SubStr(nrodoc, 11, 1)
         ? "  ", mpconon, DToC(fecha), hquetipoco(), wwcomprob, ;
            SubStr(cliente, 1, 27), wwcuit, hquerespon(), hnograb(), ;
            hnetograb(), himpint(), hiva(), hretib(), Str(total, 9, ;
            2), mpconoff
         if (iva == 0)
            fsubtot1:= fsubtot1 + totbase
         else
            fsubtot2:= fsubtot2 + totbase
         endif
         fsubtot3:= fsubtot3 + impint
         fsubtot4:= fsubtot4 + iva
         fsubtot5:= fsubtot5 + retrni
         fsubtot6:= fsubtot6 + total
         filas:= filas + 1
         wywfecha:= fecha
         skip 
         if (ncaja = wwtipoc)
            if (sucursal = wwsucur)
               do while (.T.)
                  wwnumer:= wwnumer + 1
                  if (numero != wwnumer)
                     wycomprob:= SubStr(wwcomprob, 1, 5) + ;
                        strzero(wwnumer, 8)
                     ? "  ", mpconon, DToC(wywfecha), hquetipoco(), ;
                        wycomprob, "Comprobante Cancelado", mpconoff
                  else
                     exit
                  endif
               enddo
            else
               wwsucur:= sucursal
               wwnumer:= numero
            endif
         else
            wwtipoc:= ncaja
            wwsucur:= sucursal
            wwnumer:= numero
         endif
      enddo
      if (EOF())
         ? "  ", mpconon, Replicate("Ä", 130), mpconoff
         ? "  ", mpconon, ;
            "                            T O T A L E S    G E N E R A L E S           ", ;
            Str(fsubtot1, 9, 2), Str(fsubtot2, 9, 2), Str(fsubtot3, ;
            7, 2), Str(fsubtot4, 9, 2), Str(fsubtot5, 8, 2), ;
            Str(fsubtot6, 9, 2), mpconoff
         ? "  ", mpconon, Replicate("Ä", 130), mpconoff
      else
         ? "  ", mpconon, Replicate("Ä", 130), mpconoff
         ? "  ", mpconon, ;
            "                                       Totales acumulados                ", ;
            Str(fsubtot1, 9, 2), Str(fsubtot2, 9, 2), Str(fsubtot3, ;
            7, 2), Str(fsubtot4, 9, 2), Str(fsubtot5, 8, 2), ;
            Str(fsubtot6, 9, 2), mpconoff
         ? "  ", mpconon, Replicate("Ä", 130), mpconoff
      endif
      eject
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
   enddo
   set printer off
   set console on
   set printer to lpt1
   return

********************************
function HQUERESPON

   do case
   case respon = 1
      return "RI"
   case respon = 2
      return "NI"
   case respon = 3
      return "EX"
   case respon = 4
      return "NR"
   case respon = 5
      return "CF"
   case respon = 6
      return "RM"
   case respon = 7
      return "NC"
   otherwise
      return "XX"
   endcase
   return

********************************
function HNOGRAB

   if (iva == 0)
      return Str(totbase, 9, 2)
   else
      return "         "
   endif
   return

********************************
function HRETIB

   if (retrni == 0)
      return "        "
   else
      return Str(retrni, 8, 2)
   endif
   return

********************************
procedure FUN_17_3

   set color to N/W
   jcbox(8, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "IVA Ventas - Completo")
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @ 10,  1 say ;
      " T¡tulo           :                                                           "
   @ 11,  1 say ;
      "                                                                              "
   @ 12,  1 say ;
      " Fecha de timbrado:                                                           "
   @ 13,  1 say ;
      " Libro N§         :                                                           "
   @ 14,  1 say ;
      " Desde hoja Nro   :                                                           "
   @ 15,  1 say ;
      "                                                                              "
   @ 16,  1 say ;
      " Desde fecha      :             hasta:                                        "
   @ 17,  1 say ;
      " Comprobantes tipo:                                                           "
   @ 18,  1 say ;
      "                                                                              "
   @ 19,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   opbassha("BASE002")
   dato1:= alltrim(empresa) + " (" + alltrim(comercio) + ")"
   dato2:= alltrim(direccion) + " - " + alltrim(localidad) + " - " + ;
      alltrim(provincia)
   dato3:= "C.U.I.T. " + alltrim(cuit) + " - Ing.Brutos " + ;
      alltrim(ibruto) + " - N§ Estab. " + alltrim(estable) + ;
      " - Sede Timb. " + alltrim(timbrado)
   dato4:= "Libro I.V.A. VENTAS  COD.ACTIV." + alltrim(codact)
   close
   dato4:= SubStr(dato4 + Space(57), 1, 57)
   dato5:= Date()
   dato6:= 0
   dato7a:= 0
   dato7b:= 0
   opbassha("MAYORFAC")
   if (EOF())
      alert("No existen ventas registradas con cierre de caja.")
      close databases
      select 1
   else
      goto top
      desdef:= fecha
      goto bottom
      hastaf:= fecha
      close
      condicion:= ""
      condicion1:= ""
      acumtick:= " "
      save screen to plistas
      do while (.T.)
         restore screen from plistas
         set color to N/W
         @ 10, 21 get dato4 valid Len(alltrim(dato4)) > 0
         @ 12, 21 get dato5
         @ 13, 21 get dato6 picture "99" valid dato6 > 0
         @ 14, 21 get dato7a picture "9999" valid dato7a > 0
         @ 16, 21 get DesdeF valid desdef <= hastaf
         @ 16, 40 get HastaF valid hastaf >= desdef
         read
         if (LastKey() == K_ESC)
            alert("Proceso cancelado...")
            exit
         endif
         condicion:= "fecha>=DesdeF .and. fecha<=HastaF"
         save screen to plistas
         set wrap on
         @ 17, 20 say "ÄÂÄ"
         @ 18, 20 say " ÃÄ"
         @ 19, 20 say " ÀÄ"
         wwopc:= 1
         wwcartel2:= ""
         do while (wwopc != 0)
            @ 17, 23 prompt " Todos     "
            @ 18, 23 prompt " Fact. A   "
            @ 19, 23 prompt " Fac.B/Tic "
            menu to wwopc
            if (wwopc = 1)
               wwcartel2:= "Todos"
               exit
            elseif (wwopc = 2)
               wwcartel2:= "Facturas A"
               condicion1:= "upper(letra)='A'"
               exit
            elseif (wwopc = 3)
               wwcartel2:= "Facturas B"
               condicion1:= "upper(letra)='B' .or. letra='T'"
               exit
            endif
         enddo
         restore screen from plistas
         if (LastKey() == K_ESC)
            loop
         endif
         set color to B/W
         @ 17, 21 say wwcartel2
         set color to N/W
         save screen to plistas
         resp:= " "
         confirm0(19, 30)
         restore screen from plistas
         if (resp = "S")
            opbasexc("MAYORFAC")
            copy structure to ivaventa
            opbasexc("IVAVENTA")
            append from mayorfac for &condicion
            goto top
            if (EOF())
               alert("No existen ventas en ‚ste per¡odo.")
               exit
            endif
            if (Len(alltrim(condicion1)) > 0)
               DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
               DBEval({|| dbRecall()}, &("{||" + condicion1 + "}"), ;
                  Nil, Nil, Nil, .F.)
               pack
            endif
            goto top
            if (EOF())
               alert("No existen los comprobantes de venta en ‚ste per¡odo.")
               exit
            endif
            DBEval({|| field->ncaja:= 5}, Nil, Nil, Nil, Nil, .F.)
            DBEval({|| field->ncaja:= 1}, {|| Upper(letra) = "A" ;
               .OR. letra = "D"}, Nil, Nil, Nil, .F.)
            DBEval({|| field->ncaja:= 2}, {|| Upper(letra) = "B" ;
               .OR. letra = "T"}, Nil, Nil, Nil, .F.)
            index on str(ncaja,12)+str(sucursal,4)+str(numero) to ;
               ivaventa
            nimpf:= 0
            do while (.T.)
               wwdonimp:= dondeimpri(1)
               if (wwdonimp == 0)
                  exit
               endif
               if (wwdonimp = 1)
                  exit
               elseif (wwdonimp = 2)
                  alert("Seleccione una impresora.")
                  loop
               elseif (wwdonimp > 2)
                  exit
               endif
            enddo
            if (wwdonimp == 0)
               loop
            endif
            restore screen from plistas
            mensaje("Imprimiendo IVA Ventas...", 28)
            if (wwdonimp == 1)
               paniva()
            else
               impcomplet()
            endif
            exit
         endif
      enddo
      close databases
      select 1
      return
   endif

********************************
procedure IMPCOMPLET

   xxpprr:= impresoras[wwdonimp][5]
   mpconon:= &xxpprr
   xxpprr:= impresoras[wwdonimp][6]
   mpconoff:= &xxpprr
   xxpprr:= impresoras[wwdonimp][7]
   titulon:= &xxpprr
   xxpprr:= impresoras[wwdonimp][8]
   tituloff:= &xxpprr
   nport:= impresoras[wwdonimp][2]
   set printer to (nport)
   pri:= 0
   do while (.T.)
      if (isprinter())
         exit
      else
         pri:= pri + 1
         alert("IMPRESORA FUERA DE LINEA, VERIFIQUE...")
         if (pri == 3)
            set printer to lpt1
            return
         endif
      endif
   enddo
   goto top
   set console off
   set printer on
   desdereg:= RecNo()
   fsubtot1:= 0
   fsubtot2:= 0
   fsubtot3:= 0
   fsubtot4:= 0
   fsubtot5:= 0
   fsubtot6:= 0
   wwtipoc:= ncaja
   wwsucur:= sucursal
   wwnumer:= numero
   dato7c:= dato7a
   do while (.T.)
      ? "  ", mpconon, titulon, Space(Int((61 - Len(alltrim(dato1))) ;
         / 2)), alltrim(dato1), tituloff, mpconoff
      ? 
      ? "  ", mpconon, titulon, Space(Int((61 - Len(alltrim(dato2))) ;
         / 2)), alltrim(dato2), tituloff, mpconoff
      ? " ", mpconon, Space(Int((132 - Len(alltrim(dato3))) / 2)), ;
         alltrim(dato3), mpconoff
      ? 
      ? "  ", mpconon, titulon, Space(Int((61 - Len(alltrim(dato4))) ;
         / 2)), alltrim(dato4), tituloff, mpconoff
      ? 
      ? "    ", "Fecha de timbrado:", DToC(dato5), ;
         "          Libro N§", Str(dato6, 2), "          Hoja N§", ;
         Str(dato7c, 4)
      ? "  ", mpconon, Replicate("Ä", 130), mpconoff
      ? "  ", mpconon, ;
         "  Fecha   |  Tipo y n£mero  |                 Comprador                  |Conceptos|  Neto   |Impuest|  I.V.A. | Reten. |  Total  ", ;
         mpconoff
      ? "  ", mpconon, ;
         "          |  de comprobante | Raz¢n social                  C.U.I.T.  Res|no grabad| Grabado |Interno|   21%   | a RNI  | Facturas", ;
         mpconoff
      ? "  ", mpconon, Replicate("Ä", 130), mpconoff
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 50 .AND. !EOF())
         wwnumer:= numero
         wwcomprob:= hqueletra() + strzero(sucursal, 4) + ;
            strzero(numero, 8)
         wwcuit:= SubStr(nrodoc, 1, 2) + "-" + SubStr(nrodoc, 3, 8) ;
            + "-" + SubStr(nrodoc, 11, 1)
         ? "  ", mpconon, DToC(fecha), hquetipoco(), wwcomprob, ;
            SubStr(cliente, 1, 27), wwcuit, hquerespon(), hnograb(), ;
            hnetograb(), himpint(), hiva(), hretib(), Str(total, 9, ;
            2), mpconoff
         if (iva == 0)
            fsubtot1:= fsubtot1 + totbase
         else
            fsubtot2:= fsubtot2 + totbase
         endif
         fsubtot3:= fsubtot3 + impint
         fsubtot4:= fsubtot4 + iva
         fsubtot5:= fsubtot5 + retrni
         fsubtot6:= fsubtot6 + total
         filas:= filas + 1
         wywfecha:= fecha
         skip 
         if (ncaja = wwtipoc)
            if (sucursal = wwsucur)
               do while (.T.)
                  wwnumer:= wwnumer + 1
                  if (numero != wwnumer)
                     wycomprob:= SubStr(wwcomprob, 1, 5) + ;
                        strzero(wwnumer, 8)
                     ? "  ", mpconon, DToC(wywfecha), hquetipoco(), ;
                        wycomprob, "Comprobante Cancelado", mpconoff
                  else
                     exit
                  endif
               enddo
            else
               wwsucur:= sucursal
               wwnumer:= numero
            endif
         else
            wwtipoc:= ncaja
            wwsucur:= sucursal
            wwnumer:= numero
         endif
      enddo
      if (EOF())
         ? "  ", mpconon, Replicate("Ä", 130), mpconoff
         ? "  ", mpconon, ;
            "                            T O T A L E S    G E N E R A L E S           ", ;
            Str(fsubtot1, 9, 2), Str(fsubtot2, 9, 2), Str(fsubtot3, ;
            7, 2), Str(fsubtot4, 9, 2), Str(fsubtot5, 8, 2), ;
            Str(fsubtot6, 9, 2), mpconoff
         ? "  ", mpconon, Replicate("Ä", 130), mpconoff
      else
         ? "  ", mpconon, Replicate("Ä", 130), mpconoff
         ? "  ", mpconon, ;
            "                                       Totales acumulados                ", ;
            Str(fsubtot1, 9, 2), Str(fsubtot2, 9, 2), Str(fsubtot3, ;
            7, 2), Str(fsubtot4, 9, 2), Str(fsubtot5, 8, 2), ;
            Str(fsubtot6, 9, 2), mpconoff
         ? "  ", mpconon, Replicate("Ä", 130), mpconoff
      endif
      eject
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
      dato7c:= dato7c + 1
   enddo
   set printer off
   set console on
   set printer to lpt1
   return

********************************
procedure PANIVA

   select 2
   opbasexc("PANTALLA")
   zap
   select 1
   goto top
   desdereg:= RecNo()
   fsubtot1:= 0
   fsubtot2:= 0
   fsubtot3:= 0
   fsubtot4:= 0
   fsubtot5:= 0
   fsubtot6:= 0
   wwtipoc:= ncaja
   wwsucur:= sucursal
   wwnumer:= numero
   dato7c:= dato7a
   do while (.T.)
      lin:= Space(30)
      llenepanta()
      lin:= Space(30)
      llenepanta()
      lin:= Space(30)
      llenepanta()
      lin:= "     " + Space(Int((61 - Len(alltrim(dato1))) / 2)) + ;
         " " + alltrim(dato1)
      llenepanta()
      lin:= Space(30)
      llenepanta()
      lin:= "     " + Space(Int((61 - Len(alltrim(dato4))) / 2)) + ;
         " " + alltrim(dato4)
      llenepanta()
      lin:= Space(30)
      llenepanta()
      lin:= "     Fecha de timbrado: " + DToC(dato5) + ;
         "           Libro N§ " + Str(dato6, 2) + ;
         "          Hoja N§ " + Str(dato7c, 4)
      llenepanta()
      lin:= ;
         "ÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ"
      llenepanta()
      lin:= ;
         "  Fecha   ³  Tipo y n£mero  ³       Comprador             ³  I.V.A. ³  Total   "
      llenepanta()
      lin:= ;
         "          ³  de comprobante ³ Raz¢n social             Res³    21%  ³ Facturas "
      llenepanta()
      lin:= ;
         "ÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ"
      llenepanta()
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 50 .AND. !EOF())
         wwnumer:= numero
         wwcomprob:= hqueletra() + strzero(sucursal, 4) + ;
            strzero(numero, 8)
         wwcuit:= SubStr(nrodoc, 1, 2) + "-" + SubStr(nrodoc, 3, 8) ;
            + "-" + SubStr(nrodoc, 11, 1)
         lin:= DToC(fecha) + " " + hquetipoco() + " " + wwcomprob + ;
            " " + SubStr(cliente, 1, 26) + " " + hquerespon() + " " ;
            + hiva() + " " + Str(total, 9, 2)
         llenepanta()
         if (iva == 0)
            fsubtot1:= fsubtot1 + totbase
         else
            fsubtot2:= fsubtot2 + totbase
         endif
         fsubtot3:= fsubtot3 + impint
         fsubtot4:= fsubtot4 + iva
         fsubtot5:= fsubtot5 + retrni
         fsubtot6:= fsubtot6 + total
         filas:= filas + 1
         wywfecha:= fecha
         skip 
         if (EOF())
            exit
         endif
         if (ncaja = wwtipoc)
            if (sucursal = wwsucur)
               do while (.T.)
                  wwnumer:= wwnumer + 1
                  if (numero != wwnumer)
                     wycomprob:= SubStr(wwcomprob, 1, 5) + ;
                        strzero(wwnumer, 8)
                     wwcomprob:= hqueletra() + strzero(sucursal, 4) ;
                        + strzero(numero, 8)
                     wwcuit:= SubStr(nrodoc, 1, 2) + "-" + ;
                        SubStr(nrodoc, 3, 8) + "-" + SubStr(nrodoc, ;
                        11, 1)
                     lin:= DToC(wywfecha) + " " + hquetipoco() + " " ;
                        + wycomprob + " Comprobante Cancelado"
                     llenepanta()
                  else
                     exit
                  endif
               enddo
            else
               wwsucur:= sucursal
               wwnumer:= numero
            endif
         else
            wwtipoc:= ncaja
            wwsucur:= sucursal
            wwnumer:= numero
         endif
      enddo
      if (EOF())
         lin:= Replicate("Ä", 78)
         llenepanta()
         lin:= ;
            "                T O T A L E S    G E N E R A L E S         " ;
            + Str(fsubtot4, 9, 2) + " " + Str(fsubtot6, 9, 2)
         llenepanta()
         lin:= Replicate("Ä", 78)
         llenepanta()
         lin:= Space(30)
         llenepanta()
         lin:= "Conceptos no grabados: " + Str(fsubtot1, 10, 2)
         llenepanta()
         lin:= Space(30)
         llenepanta()
         lin:= "Neto Grabado         : " + Str(fsubtot2, 10, 2)
         llenepanta()
         lin:= "Impuestos Internos   : " + Str(fsubtot3, 10, 2)
         llenepanta()
         lin:= "I.V.A. 21%           : " + Str(fsubtot4, 10, 2)
         llenepanta()
         lin:= "Reten. a Resp.No Insc: " + Str(fsubtot5, 10, 2)
         llenepanta()
         lin:= Space(30)
         llenepanta()
         lin:= Space(30)
         llenepanta()
         lin:= Space(30)
         llenepanta()
      else
         lin:= Replicate("Ä", 78)
         llenepanta()
         lin:= ;
            "                      Totales acumulados                   " ;
            + Str(fsubtot4, 9, 2) + " " + Str(fsubtot6, 9, 2)
         llenepanta()
         lin:= Replicate("Ä", 78)
         llenepanta()
      endif
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
      dato7c:= dato7c + 1
   enddo
   select 2
   goto top
   private aprov[1]
   private tit1[1]
   aprov:= {"lineas"}
   tit1:= {"                                        "}
   set color to N/W
   jcbox(1, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Subdiario I.V.A. Ventas")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   dbedit(2, 1, 22, 78, aprov, "funprov3", .T., tit1)
   close
   select 1
   return

********************************
procedure IMPRES777

   save screen to plistas
   nimpf:= 0
   do while (.T.)
      wwdonimp:= dondeimpri(1)
      if (wwdonimp == 0)
         exit
      endif
      if (wwdonimp = 1)
         alert("Seleccione una impresora.")
         loop
      elseif (wwdonimp = 2)
         alert("Seleccione una impresora.")
         loop
      elseif (wwdonimp > 2)
         exit
      endif
   enddo
   if (wwdonimp == 0)
   else
      restore screen from plistas
      mensaje("Imprimiendo IVA Ventas...", 28)
      select 1
      opbassha("FACTURAS")
      xxpprr:= impresoras[wwdonimp][5]
      mpconon:= &xxpprr
      xxpprr:= impresoras[wwdonimp][6]
      mpconoff:= &xxpprr
      xxpprr:= impresoras[wwdonimp][7]
      titulon:= &xxpprr
      xxpprr:= impresoras[wwdonimp][8]
      tituloff:= &xxpprr
      nport:= impresoras[wwdonimp][2]
      set printer to (nport)
      pri:= 0
      do while (.T.)
         if (isprinter())
            exit
         else
            pri:= pri + 1
            alert("IMPRESORA FUERA DE LINEA, VERIFIQUE...")
            if (pri == 3)
               set printer to lpt1
               return
            endif
         endif
      enddo
      set console off
      pag:= 1
      set printer on
      goto top
      desdereg:= RecNo()
      refecha:= CToD("01-01-1900")
      refclien:= 0
      wwtotal:= 0
      wwsubtot:= 0
      do while (.T.)
         ? mpconoff, "      ", Space(35), "   ", "    ", Date(), ;
            "     Pag.", Str(pag, 4, 0)
         ? "     ", titulon, titular, tituloff
         ? 
         ? "     ", titulon, "RESUMEN DE CTAS CTES DEL DIA", tituloff
         ? "       ", "FECHA DE REFERENCIA:", DToC(Date())
         ? "       ", Replicate("Í", 70)
         filas:= 1
         locate for RecNo() = desdereg
         do while (!EOF())
            if (ncondvent > 1)
               wwnumer:= numero
               wwcomprob:= hqueletra() + strzero(sucursal, 4) + ;
                  strzero(numero, 8)
               wwcuit:= SubStr(nrodoc, 1, 2) + "-" + SubStr(nrodoc, ;
                  3, 8) + "-" + SubStr(nrodoc, 11, 1)
               ? "  ", mpconon, DToC(fecha), hquetipoco(), ;
                  wwcomprob, SubStr(cliente, 1, 24), wwcuit, ;
                  hquerespon(), hnograb(), hnetograb(), himpint(), ;
                  hiva(), hretib(), Str(total, 9, 2), mpconoff
               wwsubtot:= wwsubtot + total
               filas:= 1 + filas
            endif
            skip 
         enddo
         if (EOF())
            ? ;
               "                                                      ÄÄÄÄÄÄÄÄÄÄ"
            ? ;
               "                                                    ", ;
               Str(wwsubtot, 10, 2)
            ? "       ", Replicate("Í", 70)
         endif
         eject
         if (EOF())
            exit
         endif
         desdereg:= RecNo()
         pag:= 1 + pag
      enddo
      set printer off
      set console on
      set printer to lpt1
      select 1
      close
      return
   endif

* EOF

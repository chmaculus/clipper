#include "common.ch"
#include "inkey.ch"

********************************
function JCBOX

   parameters top, left, bottom, right, color, speed, boxtype, ;
      shadow, linetop, linebott, bcolor, btitle
   private t, b, l, r, s, oldcolor, retscr, boxframe, seed1, seed2
   retscr:= boxscr(top, left, bottom, right)
   oldcolor:= SetColor()
   boxframe:= getbox(boxtype)
   set color to (color)
   setcursor(0)
   @ top, left, bottom, right box boxframe
   @ top, left say "ÆÇ"
   if (linetop)
      @ top + 2, left say "Ë" + Replicate("Î", right - left - 1) + "Ì"
   endif
   if (linebott)
      @ bottom - 1, left say "Ğ" + Replicate("Ï", right - left - 1) ;
         + "Å"
   endif
   set color to (bcolor)
   @ top, left + 2 say Space(right - left - 1)
   if (shadow)
      boxshadow(top, left, bottom, right)
   endif
   if (PCount() > 11)
      lenscr:= (right - left) / 2 + left
      @ top, lenscr - Len(alltrim(btitle)) / 2 say alltrim(btitle)
   endif
   set color to (oldcolor)
   setcursor(1)
   return retscr

********************************
procedure CONFIRM0

   parameters par, piz
   confcol:= SetColor()
   confir:= 1
   loncf1:= Len(alltrim(afrases[18]))
   loncf2:= Len(alltrim(afrases[19]))
   do while (confir != 0)
      jjbox(par, piz, par + 2, piz + loncf1 + loncf2 + 6 + 1, ;
         "W+/R", 20, 5, .T.)
      set color to W+/R,W+/B
      @ par + 1, piz + 2 prompt " " + alltrim(afrases[18]) + " "
      @ par + 1, piz + 2 + loncf1 + 2 prompt " " + ;
         alltrim(afrases[19]) + " "
      set wrap on
      menu to confir
      if (confir = 1)
         resp:= "S"
         exit
      elseif (confir = 2)
         resp:= "N"
         exit
      endif
   enddo
   set color to (confcol)
   return

********************************
procedure OPBASEXC

   parameters ybase, yindex
   save screen to pannet
   opbcol:= SetColor()
   set color to W+/R
   do while (.T.)
      use (ybase) exclusive
      if (!neterr())
         if (Len(alltrim(yindex)) > 0)
            set index to (yindex)
         endif
         exit
      endif
      InKey(1)
      jjbox(9, 12, 11, 70, "W+/R", 20, 1, .F.)
      @ 10, 15 say ;
         "ATENCION: Archivo ocupado en red, espere por favor..."
   enddo
   set color to (opbcol)
   restore screen from pannet
   return

********************************
procedure OPBASSHA

   parameters ybase, yindex
   save screen to pannet
   opbcol:= SetColor()
   set color to W+/R
   do while (.T.)
      use (ybase) shared
      if (!neterr())
         if (Len(alltrim(yindex)) > 0)
            set index to (yindex)
         endif
         exit
      endif
      InKey(1)
      jjbox(9, 12, 11, 70, "W+/R", 20, 1, .F.)
      @ 10, 15 say ;
         "ATENCION: Archivo ocupado en red, espere por favor..."
   enddo
   set color to (opbcol)
   restore screen from pannet
   return

********************************
procedure MENSAJE

   parameters texmens, mcol
   mencol:= SetColor()
   ml:= Len(alltrim(texmens))
   my:= Int((79 - ml) / 2)
   set color to (mcol)
   jjbox(10, my - 2, 12, my + ml + 2, mcol, 20, 1, .T.)
   @ 11, my say texmens
   set color to (mencol)
   return

********************************
function TODOSSELEC

   parameters wwx, wwy
   set wrap on
   @ wwx, wwy say "ÄÂÄ"
   @ wwx + 1, wwy say " ÃÄ"
   @ wwx + 2, wwy say " ÀÄ"
   wwopc:= 1
   do while (wwopc != 0)
      @ wwx, wwy + 3 prompt "Todos     "
      @ wwx + 1, wwy + 3 prompt "Selecciona"
      @ wwx + 2, wwy + 3 prompt "Por c¢digo"
      menu to wwopc
      if (wwopc = 1)
         return 1
      elseif (wwopc = 2)
         return 2
      elseif (wwopc = 3)
         return 3
      endif
   enddo
   return 0

********************************
procedure QUESELEC

   parameters quemuestro, quecargo, quetomo
   colbrow:= SetColor()
   wwreg:= ""
   y:= 1
   for y:= 1 to yy
      selecciona[y]:= &quemuestro + "    "
      seleccionb[y][1]:= &quetomo
      seleccionb[y][2]:= 0
      skip 
   next
   totlen:= Len(selecciona)
   jcbox(8, 40, 21, 77, "N/W", 20, 1, .T., .F., .F., "W+/B", ;
      "Seleccione...")
   jjbox(9, 41, 19, 76, "N/W", 20, 4, .F.)
   set color to N/W,
   @ 20, 42 say "Enter=marca/desmarca     Esc=Salir"
   set color to N/W*,W+/B
   achoice(10, 42, 18, 75, selecciona, .T., "UserSele")
   y:= 1
   conty:= 1
   for y:= 1 to totlen
      if (seleccionb[y][2] == 1)
         if (wwquereg == 1)
            wwquecarte:= SubStr(selecciona[y], 1, 30)
         else
            wwquecarte:= wwquecarte + SubStr(selecciona[y], 1, 10) + ;
               "-/"
         endif
         if (conty == 1)
            if (Type("SeleccionB[y,1]") = "N")
               condicion1:= quecargo + "=" + ;
                  alltrim(Str(seleccionb[y][1]))
            else
               condicion1:= quecargo + "=" + alltrim(seleccionb[y][1])
            endif
         elseif (Type("SeleccionB[y,1]") = "N")
            condicion1:= condicion1 + " .or. " + quecargo + "=" + ;
               alltrim(Str(seleccionb[y][1]))
         else
            condicion1:= condicion1 + " .or. " + quecargo + "=" + ;
               alltrim(seleccionb[y][1])
         endif
         conty:= 2
      endif
   next
   set color to (colbrow)
   return

********************************
function DONDEIMPRI

   parameters wwimpfis
   colorant:= SetColor()
   save screen to pdi
   play1:= 1
   play2:= 0
   nimpf:= 0
   play3:= 0
   nimp1:= 0
   play4:= 0
   nimp2:= 0
   play5:= 0
   nimp3:= 0
   if (impresoras[1][9] == 2)
      play2:= 1
      nimpf:= 1
   endif
   if (impresoras[2][9] == 2)
      play2:= 1
      nimpf:= 2
   endif
   if (impresoras[3][9] > 0)
      play3:= 1
   endif
   if (impresoras[4][9] > 0)
      play4:= 1
   endif
   if (impresoras[5][9] > 0)
      play5:= 1
   endif
   nreport:= 0
   opimp:= 1
   set color to N/W*,N/W
   do while (opimp != 0)
      jjbox(14, 29, 15 + play1 + 1 + play3 + play4 + play5, 47, ;
         "N/W*", 20, 1, .T.)
      @ 15, 30 prompt " Monitor         "
      qli:= 16
      if (play2 > 0)
         @ qli, 30 prompt " " + SubStr(impresoras[nimpf][3], 1, 15) ;
            + " "
         qli:= qli + 1
      else
         @ qli, 30 prompt " Impresor fiscal "
         qli:= qli + 1
      endif
      if (play3 > 0)
         @ qli, 30 prompt " " + SubStr(impresoras[3][3], 1, 15) + " "
         qli:= qli + 1
      endif
      if (play4 > 0)
         @ qli, 30 prompt " " + SubStr(impresoras[4][3], 1, 15) + " "
         qli:= qli + 1
      endif
      if (play5 > 0)
         @ qli, 30 prompt " " + SubStr(impresoras[5][3], 1, 15) + " "
         qli:= qli + 1
      endif
      menu to opimp
      do case
      case opimp = 1
         nreport:= 1
         exit
      case opimp = 2
         nreport:= 2
         exit
      case opimp = 3
         nreport:= 3
         exit
      case opimp = 4
         nreport:= 4
         exit
      case opimp = 5
         nreport:= 5
         exit
      endcase
   enddo
   restore screen from pdi
   set color to (colorant)
   return nreport

********************************
procedure LLENEPANTA

   select 2
   append blank
   replace lineas with lin
   select 1
   return

********************************
function HQUETIPOCO

   do case
   case Upper(letra) = "A"
      return "FAC"
   case letra = "D"
      return "NDE"
   case Upper(letra) = "B"
      return "FAC"
   case letra = "E"
      return "NDE"
   case letra = "R"
      return "NCR"
   case letra = "S"
      return "NCR"
   case letra = "O"
      return "ORD"
   case letra = "T"
      return "TIC"
   otherwise
      return "XXX"
   endcase
   return

********************************
function HQUELETRA

   do case
   case Upper(letra) = "A"
      return "A"
   case letra = "D"
      return "A"
   case Upper(letra) = "B"
      return "B"
   case letra = "E"
      return "B"
   case letra = "R"
      return "A"
   case letra = "S"
      return "B"
   case letra = "T"
      return "T"
   case letra = "O"
      return "O"
   otherwise
      alert("existe un comprobante no identificado...")
      return "X"
   endcase
   return

********************************
function HNETOGRAB

   if (iva == 0)
      return "         "
   else
      return Str(totbase, 9, 2)
   endif
   return

********************************
function HIMPINT

   if (impint == 0)
      return "       "
   else
      return Str(impint, 7, 2)
   endif
   return

********************************
function HIVA

   if (iva == 0)
      return "         "
   else
      return Str(iva, 9, 2)
   endif
   return

********************************
*procedure MOD1F


********************************
procedure FUN_14_1

   set color to N/W
   jcbox(8, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Res£men de venta")
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @ 10,  1 say ;
      " Fecha desde      :            hasta:                                         "
   @ 11,  1 say ;
      " Cliente          :                                                           "
   @ 12,  1 say ;
      " Vendedor         :                                                           "
   @ 13,  1 say ;
      " Cond. de venta   :                                                           "
   @ 14,  1 say ;
      " Tipo de comprob. :                                                           "
   @ 15,  1 say ;
      " Lista de precios :                                                           "
   @ 16,  1 say ;
      " Emitir           :                                                           "
   @ 17,  1 say ;
      " Detallar comprob.:                                                           "
   @ 18,  1 say ;
      "                                                                              "
   @ 19,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   opbassha("MAYORFAC")
   if (EOF())
      alert("No existen ventas registradas con cierre de caja.")
      close databases
      select 1
   else
      goto top
      desdef:= qfecha
      goto bottom
      hastaf:= qfecha
      close
      save screen to plistas
      save screen to pplistas
      do while (.T.)
         restore screen from pplistas
         condclien:= ""
         condvende:= ""
         condconve:= 0
         condtipco:= 0
         set color to N/W
         @ 10, 21 get DesdeF valid desdef <= hastaf
         @ 10, 39 get HastaF valid hastaf >= desdef
         read
         if (LastKey() == K_ESC)
            alert("Proceso cancelado...")
            exit
         endif
         wwcartel0:= "desde " + DToC(desdef) + "  hasta " + ;
            DToC(hastaf)
         condicion:= "qfecha>=DesdeF .and. qfecha<=HastaF"
         save screen to plistas
         condicion1:= ""
         wwrespue1:= 0
         wwcartel1:= ""
         wwrespue1:= todosselec(11, 21)
         do case
         case wwrespue1 = 0
            loop
         case wwrespue1 = 1
            wwcartel1:= "Todos..."
         case wwrespue1 = 2
            wwcartel1:= ""
         case wwrespue1 = 3
            wwcartel1:= ""
         endcase
         restore screen from plistas
         if (wwrespue1 == 2)
            opbassha("BASE009", "BASE009B")
            yy:= LastRec()
            private selecciona[yy]
            private seleccionb[yy, 2]
            wwquecarte:= ""
            wwquereg:= 0
            queselec("empresa", "ncliente", "nro_client")
            close
            if (wwquereg == 0)
               alert("No seleccion¢ registros")
               loop
            endif
            if (Len(alltrim(wwquecarte)) > 60)
               wwcartel1:= SubStr(wwquecarte, 1, 60) + "..."
            else
               wwcartel1:= wwquecarte
            endif
            condclien:= condicion1
         endif
         restore screen from plistas
         set color to B/W
         @ 11, 21 say wwcartel1
         set color to N/W
         if (wwrespue1 == 3)
            opbassha("BASE009", "BASE009A")
            goto bottom
            hastacod:= nro_client
            goto top
            desdecod:= nro_client
            @ 11, 21 say "desde cod: 99999 hasta cod: 99999"
            @ 11, 32 get desdecod picture "99999"
            @ 11, 49 get hastacod picture "99999" valid hastacod > 0 ;
               .AND. hastacod >= desdecod
            read
            if (LastKey() == K_ESC)
               alert("No seleccion¢ registros")
               loop
            endif
            wwcartel1:= "desde cod: " + Str(desdecod, 5) + ;
               "   hasta cod: " + Str(hastacod, 5)
            condclien:= "ncliente>=" + Str(desdecod, 5) + ;
               " .and. ncliente<=" + Str(hastacod, 5)
         endif
         save screen to plistas
         condicion1:= ""
         wwrespue1:= 0
         wwcartel2:= ""
         wwrespue1:= todosselec(12, 21)
         do case
         case wwrespue1 = 0
            loop
         case wwrespue1 = 1
            wwcartel2:= "Todos..."
         case wwrespue1 = 2
            wwcartel2:= ""
         case wwrespue1 = 3
            wwcartel2:= ""
         endcase
         restore screen from plistas
         if (wwrespue1 == 2)
            opbassha("BASE008", "BASE008B")
            yy:= LastRec()
            private selecciona[yy]
            private seleccionb[yy, 2]
            wwquecarte:= ""
            wwquereg:= 0
            queselec("substr(str(numero,2)+' '+nombre,1,30)", ;
               "nvend", "numero")
            close
            if (wwquereg == 0)
               alert("No seleccion¢ registros")
               loop
            endif
            if (Len(alltrim(wwquecarte)) > 60)
               wwcartel2:= SubStr(wwquecarte, 1, 60) + "..."
            else
               wwcartel2:= wwquecarte
            endif
            condvende:= condicion1
         endif
         restore screen from plistas
         set color to B/W
         @ 12, 21 say wwcartel2
         set color to N/W
         if (wwrespue1 == 3)
            opbassha("BASE008", "BASE008A")
            goto bottom
            hastacod:= numero
            goto top
            desdecod:= numero
            @ 12, 21 say "desde cod: 99    hasta cod: 99"
            @ 12, 32 get desdecod picture "99"
            @ 12, 49 get hastacod picture "99" valid hastacod > 0 ;
               .AND. hastacod >= desdecod
            read
            if (LastKey() == K_ESC)
               alert("No seleccion¢ registros")
               loop
            endif
            wwcartel2:= "desde cod: " + Str(desdecod, 2) + ;
               "   hasta cod: " + Str(hastacod, 2)
            condvende:= "nvend>=" + Str(desdecod, 2) + ;
               " .and. nvend<=" + Str(hastacod, 2)
         endif
         save screen to plistas
         set wrap on
         @ 13, 20 say "ÄÂÄ"
         @ 14, 20 say " ÃÄ"
         @ 15, 20 say " ÀÄ"
         wwopc:= 1
         wwcartel3:= ""
         do while (wwopc != 0)
            @ 13, 23 prompt " Todos   "
            @ 14, 23 prompt " Contado "
            @ 15, 23 prompt " Cta.Cte."
            menu to wwopc
            if (wwopc = 1)
               wwcartel3:= "Todos"
               exit
            elseif (wwopc = 2)
               wwcartel3:= "Contado"
               condconve:= "ncondvent=1"
               exit
            elseif (wwopc = 3)
               wwcartel3:= "Cta.Cte."
               condconve:= "ncondvent=2"
               exit
            endif
         enddo
         restore screen from plistas
         if (LastKey() == K_ESC)
            loop
         endif
         set color to B/W
         @ 13, 21 say wwcartel3
         set color to N/W
         save screen to plistas
         set wrap on
         @ 14, 20 say "ÄÂÄ"
         @ 15, 20 say " ÃÄ"
         @ 16, 20 say " ÃÄ"
         @ 17, 20 say " ÃÄ"
         @ 18, 20 say " ÃÄ"
         @ 19, 20 say " ÀÄ"
         wwopc:= 1
         wwcartel4:= ""
         do while (wwopc != 0)
            @ 14, 23 prompt " Todos   "
            @ 15, 23 prompt " Fact. A "
            @ 16, 23 prompt " Fact. B "
            @ 17, 23 prompt " N.D‚bi. "
            @ 18, 23 prompt " N.Cr‚d. "
            @ 19, 23 prompt " T¡ckets "
            menu to wwopc
            do case
            case wwopc = 1
               wwcartel4:= "Todos"
               exit
            case wwopc = 2
               wwcartel4:= "Facturas A"
               condicion1:= "upper(letra)='A'"
               exit
            case wwopc = 3
               wwcartel4:= "Facturas B"
               condicion1:= "upper(letra)='B'"
               exit
            case wwopc = 4
               wwcartel4:= "Notas de d‚bito"
               condicion1:= "letra='D' .or. letra='E'"
               exit
            case wwopc = 5
               wwcartel4:= "Notas de cr‚dito"
               condicion1:= "letra='R' .or. letra='S'"
               exit
            case wwopc = 6
               wwcartel4:= "T¡ckets"
               condicion1:= "letra='T'"
               exit
            endcase
         enddo
         restore screen from plistas
         if (LastKey() == K_ESC)
            loop
         endif
         condtipco:= condicion1
         set color to B/W
         @ 14, 21 say wwcartel4
         set color to N/W
         save screen to plistas
         set wrap on
         @ 15, 20 say "ÄÂÄ"
         @ 16, 20 say " ÃÄ"
         @ 17, 20 say " ÃÄ"
         @ 18, 20 say " ÃÄ"
         @ 19, 20 say " ÃÄ"
         @ 20, 20 say " ÀÄ"
         wwopc:= 1
         wwcartel5:= ""
         do while (wwopc != 0)
            @ 15, 23 prompt " Todas   "
            @ 16, 23 prompt " Lista 1 "
            @ 17, 23 prompt " Lista 2 "
            @ 18, 23 prompt " Lista 3 "
            @ 19, 23 prompt " Lista 4 "
            @ 20, 23 prompt " Lista 5 "
            menu to wwopc
            do case
            case wwopc = 1
               wwcartel5:= "Todas"
               exit
            case wwopc = 2
               wwcartel5:= "Lista 1"
               condicion1:= "nLista=1"
               exit
            case wwopc = 3
               wwcartel5:= "Lista 2"
               condicion1:= "nLista=2"
               exit
            case wwopc = 4
               wwcartel5:= "Lista 3"
               condicion1:= "nLista=3"
               exit
            case wwopc = 5
               wwcartel5:= "Lista 4"
               condicion1:= "nLista=4"
               exit
            case wwopc = 6
               wwcartel5:= "Lista 5"
               condicion1:= "nLista=5"
               exit
            endcase
         enddo
         restore screen from plistas
         if (LastKey() == K_ESC)
            loop
         endif
         condpreci:= condicion1
         set color to B/W
         @ 15, 21 say wwcartel5
         set color to N/W
         save screen to plistas
         set wrap on
         @ 16, 20 say "ÄÂÄ"
         @ 17, 20 say " ÃÄ"
         @ 18, 20 say " ÃÄ"
         @ 19, 20 say " ÀÄ"
         wwopc:= 1
         wwcartel6:= ""
         tiporesum:= 0
         do while (wwopc != 0)
            @ 16, 23 prompt " RESUMEN DE VENTAS POR CLIENTE         "
            @ 17, 23 prompt " RESUMEN DE VENTAS POR VENDEDOR        "
            @ 18, 23 prompt " RESUMEN DE VENTAS POR COND.DE VENTA   "
            @ 19, 23 prompt " RESUMEN DE VENTAS POR LISTA DE PRECIO "
            menu to wwopc
            do case
            case wwopc = 1
               wwcartel6:= "RESUMEN DE VENTAS POR CLIENTE"
               tiporesum:= 1
               exit
            case wwopc = 2
               wwcartel6:= "RESUMEN DE VENTAS POR VENDEDOR"
               tiporesum:= 2
               exit
            case wwopc = 3
               wwcartel6:= "RESUMEN DE VENTAS POR COND.DE VENTA"
               tiporesum:= 3
               exit
            case wwopc = 4
               wwcartel6:= "RESUMEN DE VENTAS POR LISTA DE PRECIO"
               tiporesum:= 4
               exit
            endcase
         enddo
         restore screen from plistas
         if (LastKey() == K_ESC)
            loop
         endif
         set color to B/W
         @ 16, 21 say wwcartel6
         set color to N/W
         save screen to plistas
         detacomp:= " "
         @ 17, 21 get detacomp picture "@!" valid detacomp = "S" ;
            .OR. detacomp = "N"
         read
         if (LastKey() == K_ESC)
            loop
         endif
         save screen to plistas
         resp:= " "
         confirm0(19, 30)
         restore screen from plistas
         if (resp = "S")
            opbasexc("MAYORFAC")
            copy structure to ResuVent
            opbasexc("ResuVent")
            append from mayorfac for &condicion
            goto top
            if (EOF())
               alert("No existen ventas en ‚ste per¡odo.")
               exit
            endif
            if (Len(alltrim(condclien)) > 0)
               DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
               DBEval({|| dbRecall()}, &("{||" + condclien + "}"), ;
                  Nil, Nil, Nil, .F.)
               pack
            endif
            if (Len(alltrim(condvende)) > 0)
               DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
               DBEval({|| dbRecall()}, &("{||" + condvende + "}"), ;
                  Nil, Nil, Nil, .F.)
               pack
            endif
            if (Len(alltrim(condconve)) > 0)
               DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
               DBEval({|| dbRecall()}, &("{||" + condconve + "}"), ;
                  Nil, Nil, Nil, .F.)
               pack
            endif
            if (Len(alltrim(condpreci)) > 0)
               DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
               DBEval({|| dbRecall()}, &("{||" + condpreci + "}"), ;
                  Nil, Nil, Nil, .F.)
               pack
            endif
            goto top
            if (EOF())
               alert("No existen los comprobantes de venta en ‚ste per¡odo.")
               exit
            endif
            do case
            case tiporesum = 1
               index on cliente to resumntx
            case tiporesum = 2
               index on nvend to resumntx
            case tiporesum = 3
               index on ncondvent to resumntx
            case tiporesum = 4
               index on nlista to resumntx
            endcase
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
            mensaje("Emitiendo res£men de ventas...", 28)
            if (wwdonimp == 1)
               panresvta()
            else
               impresvta()
            endif
            exit
         endif
      enddo
      close databases
      select 1
      return
   endif

********************************
procedure PANRESVTA

   select 2
   opbasexc("PANTALLA")
   zap
   select 1
   fsubtot1:= 0
   DBEval({|| fsubtot1:= fsubtot1 + total}, Nil, Nil, Nil, Nil, .F.)
   goto top
   desdereg:= RecNo()
   pag:= 1
   do case
   case tiporesum = 1
      nrefer:= ncliente
   case tiporesum = 2
      nrefer:= nvend
   case tiporesum = 3
      nrefer:= ncondvent
   case tiporesum = 4
      nrefer:= nlista
   endcase
   do while (.T.)
      lin:= Space(30)
      llenepanta()
      lin:= "          " + wwcartel6
      llenepanta()
      lin:= "Per¡odo:  " + wwcartel0
      llenepanta()
      if (pag == 1)
         lin:= "Clientes: " + wwcartel1
         llenepanta()
         lin:= "Vendedor: " + wwcartel2
         llenepanta()
         lin:= "Cond.Vta: " + wwcartel3
         llenepanta()
         lin:= "Comprob.: " + wwcartel4
         llenepanta()
         lin:= "L.Precio: " + wwcartel5
         llenepanta()
      else
         lin:= Space(30)
         llenepanta()
      endif
      lin:= ;
         "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      llenepanta()
      if (detacomp = "S")
         if (tiporesum == 1)
            lin:= ;
               "  Fecha      Comprobante      M.Base     IVA    Imp.Int.   Total  LP CV Ve    "
            llenepanta()
         else
            lin:= ;
               "  Fecha      Comprobante       Cliente                  IVA     Total  LP CV V"
            llenepanta()
         endif
      else
         lin:= ;
            "    Nombre (c¢digo)                                             Total         "
         llenepanta()
      endif
      lin:= ;
         "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      llenepanta()
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 50 .AND. !EOF())
         desdereg:= RecNo()
         do case
         case detacomp = "S"
            wwnumer:= numero
            wwcomprob:= hqueletra() + strzero(sucursal, 4) + ;
               strzero(numero, 8)
            do case
            case tiporesum = 1
               if (ncliente != nrefer .OR. pag = 1)
                  if (pag > 1)
                     lin:= ;
                        "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                     llenepanta()
                     filas:= filas + 1
                  endif
                  nrefer:= ncliente
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| ;
                     ncliente = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  lin:= SubStr(alltrim(cliente) + " (" + ;
                     alltrim(Str(ncliente, 5)) + ")" + ;
                     Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
                  llenepanta()
                  filas:= filas + 1
               endif
            case tiporesum = 2
               if (nvend != nrefer .OR. pag = 1)
                  if (pag > 1)
                     lin:= ;
                        "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                     llenepanta()
                     filas:= filas + 1
                  endif
                  nrefer:= nvend
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| nvend ;
                     = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  select 3
                  opbassha("base008", "base008a")
                  seek nrefer
                  if (Found())
                     lin:= SubStr(alltrim(nombre) + " (" + ;
                        alltrim(Str(numero, 2)) + ")" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  else
                     lin:= SubStr("VENDEDOR DESCONOCIDO" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  endif
                  close
                  select 1
                  llenepanta()
                  filas:= filas + 1
               endif
            case tiporesum = 3
               if (ncondvent != nrefer .OR. pag = 1)
                  if (pag > 1)
                     lin:= ;
                        "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                     llenepanta()
                     filas:= filas + 1
                  endif
                  nrefer:= ncondvent
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| ;
                     ncondvent = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  if (ncondvent == 1)
                     lin:= SubStr("VENTA DE CONTADO" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  else
                     lin:= SubStr("VENTA EN CUENTA CORRIENTE" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  endif
                  llenepanta()
                  filas:= filas + 1
               endif
            case tiporesum = 4
               if (nlista != nrefer .OR. pag = 1)
                  if (pag > 1)
                     lin:= ;
                        "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                     llenepanta()
                     filas:= filas + 1
                  endif
                  nrefer:= nlista
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| ;
                     nlista = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  select 3
                  opbassha("base010", "base010a")
                  seek nrefer
                  if (Found())
                     lin:= SubStr("VENTA DE " + ;
                        alltrim(Upper(nombre)) + Replicate(".", 61), ;
                        1, 61) + " " + Str(grantota, 9, 2)
                  else
                     lin:= SubStr("LISTA DESCONOCIDA" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  endif
                  close
                  select 1
                  llenepanta()
                  filas:= filas + 1
               endif
            endcase
            if (tiporesum == 1)
               lin:= DToC(fecha) + " " + hquetipoco() + " " + ;
                  wwcomprob + " " + hnetograb() + " " + hiva() + " " ;
                  + himpint() + " " + Str(total, 9, 2) + Str(nlista, ;
                  2) + Str(ncondvent, 3) + Str(nvend, 3)
               llenepanta()
            else
               lin:= DToC(fecha) + " " + hquetipoco() + " " + ;
                  wwcomprob + " " + SubStr(cliente, 1, 22) + " " + ;
                  hiva() + " " + Str(total, 9, 2) + Str(nlista, 2) + ;
                  Str(ncondvent, 2) + Str(nvend, 3)
               llenepanta()
            endif
         case tiporesum = 1
            if (ncliente != nrefer .OR. pag = 1)
               nrefer:= ncliente
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| ncliente ;
                  = nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               lin:= SubStr(alltrim(cliente) + " (" + ;
                  alltrim(Str(ncliente, 5)) + ")" + Replicate(".", ;
                  61), 1, 61) + " " + Str(grantota, 9, 2)
               llenepanta()
               filas:= filas + 1
            endif
         case tiporesum = 2
            if (nvend != nrefer .OR. pag = 1)
               nrefer:= nvend
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| nvend = ;
                  nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               select 3
               opbassha("base008", "base008a")
               seek nrefer
               if (Found())
                  lin:= SubStr(alltrim(nombre) + " (" + ;
                     alltrim(Str(numero, 2)) + ")" + Replicate(".", ;
                     61), 1, 61) + " " + Str(grantota, 9, 2)
               else
                  lin:= SubStr("VENDEDOR DESCONOCIDO" + ;
                     Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
               endif
               close
               select 1
               llenepanta()
               filas:= filas + 1
            endif
         case tiporesum = 3
            if (ncondvent != nrefer .OR. pag = 1)
               nrefer:= ncondvent
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| ;
                  ncondvent = nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               if (ncondvent == 1)
                  lin:= SubStr("VENTA DE CONTADO" + Replicate(".", ;
                     61), 1, 61) + " " + Str(grantota, 9, 2)
               else
                  lin:= SubStr("VENTA EN CUENTA CORRIENTE" + ;
                     Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
               endif
               llenepanta()
               filas:= filas + 1
            endif
         case tiporesum = 4
            if (nlista != nrefer .OR. pag = 1)
               nrefer:= nlista
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| nlista = ;
                  nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               select 3
               opbassha("base010", "base010a")
               seek nrefer
               if (Found())
                  lin:= SubStr("VENTA DE " + alltrim(Upper(nombre)) ;
                     + Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
               else
                  lin:= SubStr("LISTA DESCONOCIDA" + Replicate(".", ;
                     61), 1, 61) + " " + Str(grantota, 9, 2)
               endif
               close
               select 1
               llenepanta()
               filas:= filas + 1
            endif
         endcase
         pag:= 2
         if (detacomp = "S")
            filas:= filas + 1
         endif
         skip 
      enddo
      if (EOF())
         lin:= Replicate("Ä", 78)
         llenepanta()
         lin:= ;
            "                        Total del Res£men de Ventas           " ;
            + Str(fsubtot1, 9, 2)
         llenepanta()
         lin:= Replicate("Ä", 78)
         llenepanta()
      else
         lin:= Replicate("Ä", 78)
         llenepanta()
      endif
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
   enddo
   select 2
   goto top
   private aprov[1]
   private tit1[1]
   aprov:= {"lineas"}
   tit1:= {"                                        "}
   set color to N/W
   jcbox(1, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "I.V.A. Venta")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   dbedit(2, 1, 22, 78, aprov, "funprov3", .T., tit1)
   close
   select 1
   return

********************************
procedure IMPRESVTA

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
   fsubtot1:= 0
   DBEval({|| fsubtot1:= fsubtot1 + total}, Nil, Nil, Nil, Nil, .F.)
   goto top
   set console off
   set printer on
   desdereg:= RecNo()
   pag:= 1
   do case
   case tiporesum = 1
      nrefer:= ncliente
   case tiporesum = 2
      nrefer:= nvend
   case tiporesum = 3
      nrefer:= ncondvent
   case tiporesum = 4
      nrefer:= nlista
   endcase
   do while (.T.)
      ? "       ", Space(35), "     Pag.", Str(pag, 4, 0), "   ", ;
         "      ", Date()
      ? "       ", titulon, titular, tituloff
      ? 
      ? "       ", titulon, wwcartel6, tituloff
      ? "       ", "Per¡odo: ", wwcartel0
      if (pag == 1)
         ? "       ", "Clientes:", wwcartel1
         ? "       ", "Vendedor:", wwcartel2
         ? "       ", "Cond.Vta:", wwcartel3
         ? "       ", "Comprob.:", wwcartel4
         ? "       ", "L.Precio:", wwcartel5
         filas:= 4
      else
         ? 
         filas:= 1
      endif
      ? " ", Replicate("Ä", 78)
      if (detacomp = "S")
         if (tiporesum == 1)
            ? " ", ;
               "  Fecha      Comprobante      M.Base     IVA    Imp.Int.   Total  LP CV Ve    "
         else
            ? " ", ;
               "  Fecha      Comprobante       Cliente                  IVA     Total  LP CV V"
         endif
      else
         ? " ", ;
            "    Nombre (c¢digo)                                             Total         "
      endif
      ? " ", Replicate("Ä", 78)
      locate for RecNo() = desdereg
      do while (filas < 50 .AND. !EOF())
         desdereg:= RecNo()
         do case
         case detacomp = "S"
            wwnumer:= numero
            wwcomprob:= hqueletra() + strzero(sucursal, 4) + ;
               strzero(numero, 8)
            do case
            case tiporesum = 1
               if (ncliente != nrefer .OR. pag = 1)
                  if (pag > 1)
                     ? " ", Replicate("Ä", 78)
                     filas:= filas + 1
                  endif
                  nrefer:= ncliente
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| ;
                     ncliente = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  lin:= SubStr(alltrim(cliente) + " (" + ;
                     alltrim(Str(ncliente, 5)) + ")" + ;
                     Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
                  ? " ", lin
                  filas:= filas + 1
               endif
            case tiporesum = 2
               if (nvend != nrefer .OR. pag = 1)
                  if (pag > 1)
                     ? " ", Replicate("Ä", 78)
                     filas:= filas + 1
                  endif
                  nrefer:= nvend
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| nvend ;
                     = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  select 3
                  opbassha("base008", "base008a")
                  seek nrefer
                  if (Found())
                     lin:= SubStr(alltrim(nombre) + " (" + ;
                        alltrim(Str(numero, 2)) + ")" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  else
                     lin:= SubStr("VENDEDOR DESCONOCIDO" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  endif
                  close
                  select 1
                  ? " ", lin
                  filas:= filas + 1
               endif
            case tiporesum = 3
               if (ncondvent != nrefer .OR. pag = 1)
                  if (pag > 1)
                     ? " ", Replicate("Ä", 78)
                     filas:= filas + 1
                  endif
                  nrefer:= ncondvent
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| ;
                     ncondvent = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  if (ncondvent == 1)
                     lin:= SubStr("VENTA DE CONTADO" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  else
                     lin:= SubStr("VENTA EN CUENTA CORRIENTE" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  endif
                  ? " ", lin
                  filas:= filas + 1
               endif
            case tiporesum = 4
               if (nlista != nrefer .OR. pag = 1)
                  if (pag > 1)
                     ? " ", Replicate("Ä", 78)
                     filas:= filas + 1
                  endif
                  nrefer:= nlista
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| ;
                     nlista = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  select 3
                  opbassha("base010", "base010a")
                  seek nrefer
                  if (Found())
                     lin:= SubStr("VENTA DE " + ;
                        alltrim(Upper(nombre)) + Replicate(".", 61), ;
                        1, 61) + " " + Str(grantota, 9, 2)
                  else
                     lin:= SubStr("LISTA DESCONOCIDA" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  endif
                  close
                  select 1
                  ? " ", lin
                  filas:= filas + 1
               endif
            endcase
            if (tiporesum == 1)
               lin:= DToC(fecha) + " " + hquetipoco() + " " + ;
                  wwcomprob + " " + hnetograb() + " " + hiva() + " " ;
                  + himpint() + " " + Str(total, 9, 2) + Str(nlista, ;
                  2) + Str(ncondvent, 3) + Str(nvend, 3)
               ? " ", lin
            else
               lin:= DToC(fecha) + " " + hquetipoco() + " " + ;
                  wwcomprob + " " + SubStr(cliente, 1, 22) + " " + ;
                  hiva() + " " + Str(total, 9, 2) + Str(nlista, 2) + ;
                  Str(ncondvent, 2) + Str(nvend, 3)
               ? " ", lin
            endif
         case tiporesum = 1
            if (ncliente != nrefer .OR. pag = 1)
               nrefer:= ncliente
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| ncliente ;
                  = nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               lin:= SubStr(alltrim(cliente) + " (" + ;
                  alltrim(Str(ncliente, 5)) + ")" + Replicate(".", ;
                  61), 1, 61) + " " + Str(grantota, 9, 2)
               ? " ", lin
               filas:= filas + 1
            endif
         case tiporesum = 2
            if (nvend != nrefer .OR. pag = 1)
               nrefer:= nvend
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| nvend = ;
                  nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               select 3
               opbassha("base008", "base008a")
               seek nrefer
               if (Found())
                  lin:= SubStr(alltrim(nombre) + " (" + ;
                     alltrim(Str(numero, 2)) + ")" + Replicate(".", ;
                     61), 1, 61) + " " + Str(grantota, 9, 2)
               else
                  lin:= SubStr("VENDEDOR DESCONOCIDO" + ;
                     Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
               endif
               close
               select 1
               ? " ", lin
               filas:= filas + 1
            endif
         case tiporesum = 3
            if (ncondvent != nrefer .OR. pag = 1)
               nrefer:= ncondvent
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| ;
                  ncondvent = nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               if (ncondvent == 1)
                  lin:= SubStr("VENTA DE CONTADO" + Replicate(".", ;
                     61), 1, 61) + " " + Str(grantota, 9, 2)
               else
                  lin:= SubStr("VENTA EN CUENTA CORRIENTE" + ;
                     Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
               endif
               ? " ", lin
               filas:= filas + 1
            endif
         case tiporesum = 4
            if (nlista != nrefer .OR. pag = 1)
               nrefer:= nlista
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| nlista = ;
                  nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               select 3
               opbassha("base010", "base010a")
               seek nrefer
               if (Found())
                  lin:= SubStr("VENTA DE " + alltrim(Upper(nombre)) ;
                     + Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
               else
                  lin:= SubStr("LISTA DESCONOCIDA" + Replicate(".", ;
                     61), 1, 61) + " " + Str(grantota, 9, 2)
               endif
               close
               select 1
               ? " ", lin
               filas:= filas + 1
            endif
         endcase
         if (detacomp = "S")
            filas:= filas + 1
         endif
         skip 
      enddo
      if (EOF())
         ? " ", Replicate("Ä", 78)
         lin:= ;
            "                        Total del Res£men de Ventas           " ;
            + Str(fsubtot1, 9, 2)
         ? " ", lin
         ? " ", Replicate("Ä", 78)
      else
         ? " ", Replicate("Ä", 78)
      endif
      eject
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
      pag:= pag + 1
   enddo
   set printer off
   set console on
   set printer to lpt1
   return

********************************
procedure FUN_14_2

   set color to N/W
   jcbox(8, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Ranking de venta")
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @ 10,  1 say ;
      " Fecha desde      : 99/99/9999 hasta: 99/99/9999                              "
   @ 11,  1 say ;
      " Cliente          :                                                           "
   @ 12,  1 say ;
      " Vendedor         :                                                           "
   @ 13,  1 say ;
      " Condic. de Venta :                                                           "
   @ 14,  1 say ;
      " Familia          :                                                           "
   @ 15,  1 say ;
      " Art¡culo         :                                                           "
   @ 16,  1 say ;
      " Emitir           :                                                           "
   @ 17,  1 say ;
      " Detallar (S/N)   :                                                           "
   @ 18,  1 say ;
      "                                                                              "
   @ 19,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   select 1
   opbassha("MAYORFAC")
   goto top
   desdef:= qfecha
   goto bottom
   hastaf:= qfecha
   close
   save screen to plistas
   save screen to pplistas
   do while (.T.)
      restore screen from pplistas
      condclien:= ""
      condvende:= ""
      condconve:= 0
      condrubro:= ""
      condfamil:= ""
      condartic:= ""
      set color to N/W
      @ 10, 21 get DesdeF valid desdef <= hastaf
      @ 10, 39 get HastaF valid hastaf >= desdef
      read
      if (LastKey() == K_ESC)
         alert("Proceso cancelado...")
         exit
      endif
      wwcartel0:= "desde " + DToC(desdef) + "  hasta " + DToC(hastaf)
      condicion:= "Qfecha>=DesdeF .and. Qfecha<=HastaF"
      save screen to plistas
      condicion1:= ""
      wwrespue1:= 0
      wwcartel1:= ""
      wwrespue1:= todosselec(11, 21)
      do case
      case wwrespue1 = 0
         loop
      case wwrespue1 = 1
         wwcartel1:= "Todos..."
      case wwrespue1 = 2
         wwcartel1:= ""
      case wwrespue1 = 3
         wwcartel1:= ""
      endcase
      restore screen from plistas
      if (wwrespue1 == 2)
         opbassha("BASE009", "BASE009B")
         yy:= LastRec()
         private selecciona[yy]
         private seleccionb[yy, 2]
         wwquecarte:= ""
         wwquereg:= 0
         queselec("empresa", "mayorfac->ncliente", "nro_client")
         close
         if (wwquereg == 0)
            alert("No seleccion¢ registros")
            loop
         endif
         if (Len(alltrim(wwquecarte)) > 60)
            wwcartel1:= SubStr(wwquecarte, 1, 60) + "..."
         else
            wwcartel1:= wwquecarte
         endif
         condclien:= condicion1
      endif
      restore screen from plistas
      set color to B/W
      @ 11, 21 say wwcartel1
      set color to N/W
      if (wwrespue1 == 3)
         opbassha("BASE009", "BASE009A")
         goto bottom
         hastacod:= nro_client
         goto top
         desdecod:= nro_client
         @ 11, 21 say "desde cod: 99999 hasta cod: 99999"
         @ 11, 32 get desdecod picture "99999"
         @ 11, 49 get hastacod picture "99999" valid hastacod > 0 ;
            .AND. hastacod >= desdecod
         read
         if (LastKey() == K_ESC)
            alert("No seleccion¢ registros")
            loop
         endif
         wwcartel1:= "desde cod: " + Str(desdecod, 5) + ;
            "   hasta cod: " + Str(hastacod, 5)
         condclien:= "mayorfac->ncliente>=" + Str(desdecod, 5) + ;
            " .and. mayorfac->ncliente<=" + Str(hastacod, 5)
      endif
      save screen to plistas
      condicion1:= ""
      wwrespue1:= 0
      wwcartel2:= ""
      wwrespue1:= todosselec(12, 21)
      do case
      case wwrespue1 = 0
         loop
      case wwrespue1 = 1
         wwcartel2:= "Todos..."
      case wwrespue1 = 2
         wwcartel2:= ""
      case wwrespue1 = 3
         wwcartel2:= ""
      endcase
      restore screen from plistas
      if (wwrespue1 == 2)
         opbassha("BASE008", "BASE008B")
         yy:= LastRec()
         private selecciona[yy]
         private seleccionb[yy, 2]
         wwquecarte:= ""
         wwquereg:= 0
         queselec("substr(str(numero,2)+' '+nombre,1,30)", "nvend", ;
            "numero")
         close
         if (wwquereg == 0)
            alert("No seleccion¢ registros")
            loop
         endif
         if (Len(alltrim(wwquecarte)) > 60)
            wwcartel2:= SubStr(wwquecarte, 1, 60) + "..."
         else
            wwcartel2:= wwquecarte
         endif
         condvende:= condicion1
      endif
      restore screen from plistas
      set color to B/W
      @ 12, 21 say wwcartel2
      set color to N/W
      if (wwrespue1 == 3)
         opbassha("BASE008", "BASE008A")
         goto bottom
         hastacod:= numero
         goto top
         desdecod:= numero
         @ 12, 21 say "desde cod: 99    hasta cod: 99"
         @ 12, 32 get desdecod picture "99"
         @ 12, 49 get hastacod picture "99" valid hastacod > 0 .AND. ;
            hastacod >= desdecod
         read
         if (LastKey() == K_ESC)
            alert("No seleccion¢ registros")
            loop
         endif
         wwcartel2:= "desde cod: " + Str(desdecod, 2) + ;
            "   hasta cod: " + Str(hastacod, 2)
         condvende:= "nvend>=" + Str(desdecod, 2) + " .and. nvend<=" ;
            + Str(hastacod, 2)
      endif
      save screen to plistas
      set wrap on
      @ 13, 20 say "ÄÂÄ"
      @ 14, 20 say " ÃÄ"
      @ 15, 20 say " ÀÄ"
      wwopc:= 1
      wwcartel3:= ""
      do while (wwopc != 0)
         @ 13, 23 prompt " Todos   "
         @ 14, 23 prompt " Contado "
         @ 15, 23 prompt " Cta.Cte."
         menu to wwopc
         if (wwopc = 1)
            wwcartel3:= "Todos"
            exit
         elseif (wwopc = 2)
            wwcartel3:= "Contado"
            condconve:= "ncondvent=1"
            exit
         elseif (wwopc = 3)
            wwcartel3:= "Cta.Cte."
            condconve:= "ncondvent=2"
            exit
         endif
      enddo
      restore screen from plistas
      if (LastKey() == K_ESC)
         loop
      endif
      set color to B/W
      @ 13, 21 say wwcartel3
      set color to N/W
      save screen to plistas
      condicion1:= ""
      wwrespue1:= 0
      wwcartel5:= ""
      wwrespue1:= todosselec(14, 21)
      do case
      case wwrespue1 = 0
         loop
      case wwrespue1 = 1
         wwcartel5:= "Todos..."
      case wwrespue1 = 2
         wwcartel5:= ""
      case wwrespue1 = 3
         wwcartel5:= ""
      endcase
      restore screen from plistas
      if (wwrespue1 == 2)
         opbassha("BASE005", "BASE005C")
         yy:= LastRec()
         private selecciona[yy]
         private seleccionb[yy, 2]
         wwquecarte:= ""
         wwquereg:= 0
         queselec("substr(strzero(nro_grupo,2)+strzero(nro_rubro,2)+' '+nom_rubro,1,30)", ;
            "substr(cod,1,4)", "str(nro_grupo,2)+str(nro_rubro,2)")
         close
         if (wwquereg == 0)
            alert("No seleccion¢ registros")
            loop
         endif
         if (Len(alltrim(wwquecarte)) > 60)
            wwcartel5:= SubStr(wwquecarte, 1, 60) + "..."
         else
            wwcartel5:= wwquecarte
         endif
         condfamil:= condicion1
      endif
      restore screen from plistas
      set color to B/W
      @ 14, 21 say wwcartel5
      set color to N/W
      if (wwrespue1 == 3)
         opbassha("BASE005", "BASE005C")
         goto bottom
         hastacod:= strzero(nro_grupo, 2) + strzero(nro_rubro, 2)
         goto top
         desdecod:= strzero(nro_grupo, 2) + strzero(nro_rubro, 2)
         @ 14, 21 say "desde cod:       hasta cod:     "
         @ 14, 32 get desdecod picture "9999"
         @ 14, 49 get hastacod picture "9999" valid Val(hastacod) > ;
            0 .AND. Val(hastacod) >= Val(desdecod)
         read
         if (LastKey() == K_ESC)
            alert("No seleccion¢ registros")
            loop
         endif
         wwcartel5:= "desde cod: " + desdecod + " hasta cod: " + ;
            hastacod
         condfamil:= "val(substr(cod,1,4))>=" + Str(Val(desdecod), ;
            4) + " .and. val(substr(cod,1,4))<=" + ;
            Str(Val(hastacod), 4)
      endif
      save screen to plistas
      condicion1:= ""
      wwrespue1:= 0
      wwcartel6:= ""
      wwrespue1:= todosselec(15, 21)
      do case
      case wwrespue1 = 0
         loop
      case wwrespue1 = 1
         wwcartel6:= "Todos..."
      case wwrespue1 = 2
         wwcartel6:= ""
      case wwrespue1 = 3
         wwcartel6:= ""
      endcase
      restore screen from plistas
      if (wwrespue1 == 2)
         opbassha("BASE003", "BASE003A")
         if (Len(alltrim(condfamil)) > 0)
            copy to temp771 for &condfamil
            opbassha("temp771")
            if (EOF())
               alert("No existen art¡culos en familia/s seleccionada/s.")
               close
               loop
            endif
         endif
         yy:= LastRec()
         private selecciona[yy]
         private seleccionb[yy, 2]
         wwquecarte:= ""
         wwquereg:= 0
         queselec("substr(cod+' '+nombrecom,1,45)", "cod", "cod")
         close
         if (wwquereg == 0)
            alert("No seleccion¢ registros")
            loop
         endif
         if (Len(alltrim(wwquecarte)) > 60)
            wwcartel6:= SubStr(wwquecarte, 1, 60) + "..."
         else
            wwcartel6:= wwquecarte
         endif
         condartic:= condicion1
      endif
      restore screen from plistas
      set color to B/W
      @ 15, 21 say wwcartel6
      set color to N/W
      if (wwrespue1 == 3)
         opbassha("BASE003", "BASE003A")
         if (Len(alltrim(condfamil)) > 0)
            copy to temp771 for &condfamil
            opbassha("temp771")
            if (EOF())
               alert("No existen art¡culos en familia/s seleccionada/s.")
               close
               loop
            endif
         endif
         goto bottom
         hastacod:= cod
         goto top
         desdecod:= cod
         @ 15, 21 say "desde cod: 99999999  hasta cod: 99999999"
         @ 15, 32 get desdecod picture "99999999"
         @ 15, 53 get hastacod picture "99999999" valid ;
            Val(hastacod) > 0 .AND. Val(hastacod) >= Val(desdecod)
         read
         if (LastKey() == K_ESC)
            alert("No seleccion¢ registros")
            loop
         endif
         wwcartel6:= "desde cod: " + desdecod + "  hasta cod: " + ;
            hastacod
         condartic:= "val(cod)>=" + alltrim(Str(Val(desdecod), 8)) + ;
            " .and. val(cod)<=" + alltrim(Str(Val(hastacod), 8))
      endif
      save screen to plistas
      set wrap on
      @ 16, 20 say "ÄÂÄ"
      @ 17, 20 say " ÃÄ"
      @ 18, 20 say " ÃÄ"
      @ 19, 20 say " ÃÄ"
      @ 20, 20 say " ÃÄ"
      @ 21, 20 say " ÃÄ"
      @ 22, 20 say " ÀÄ"
      wwopc:= 1
      wwcartel7:= ""
      tiporesum:= 0
      do while (wwopc != 0)
         @ 16, 23 prompt " RESUMEN POR CLIENTE C/ARTICULOS  "
         @ 17, 23 prompt " RESUMEN POR CLIENTE C/FAMILIAS   "
         @ 18, 23 prompt " RESUMEN POR VENDEDOR C/ARTICULOS "
         @ 19, 23 prompt " RESUMEN POR VENDEDOR C/FAMILIAS  "
         @ 20, 23 prompt " RESUMEN POR ARTICULOS            "
         @ 21, 23 prompt " RESUMEN POR FAMILIAS C/ARTICULOS "
         @ 22, 23 prompt " RESUMEN POR DIA C/ARTICULOS      "
         menu to wwopc
         do case
         case wwopc = 1
            wwcartel7:= "RESUMEN POR CLIENTE C/ARTICULOS"
            tiporesum:= 1
            exit
         case wwopc = 2
            wwcartel7:= "RESUMEN POR CLIENTE C/FAMILIAS"
            tiporesum:= 2
            exit
         case wwopc = 3
            wwcartel7:= "RESUMEN POR VENDEDOR C/ARTICULOS"
            tiporesum:= 3
            exit
         case wwopc = 4
            wwcartel7:= "RESUMEN POR VENDEDOR C/FAMILIAS"
            tiporesum:= 4
            exit
         case wwopc = 5
            wwcartel7:= "RESUMEN POR ARTICULOS"
            tiporesum:= 5
            exit
         case wwopc = 6
            wwcartel7:= "RESUMEN POR FAMILIAS C/ARTICULOS"
            tiporesum:= 6
            exit
         case wwopc = 7
            wwcartel7:= "RESUMEN POR DIA C/ARTICULOS"
            tiporesum:= 7
            exit
         endcase
      enddo
      restore screen from plistas
      if (LastKey() == K_ESC)
         loop
      endif
      set color to B/W
      @ 16, 21 say wwcartel7
      set color to N/W
      save screen to plistas
      close databases
      select 1
      resp:= " "
      confirm0(19, 30)
      restore screen from plistas
      if (resp = "S")
         mensaje("Procesando informaci¢n, espere por favor...", 28)
         opbasexc("MAYORFAC")
         copy structure to ResuVent
         opbasexc("ResuVent")
         append from mayorfac for &condicion
         goto top
         if (EOF())
            alert("No existen ventas en ‚ste per¡odo.")
            exit
         endif
         if (Len(alltrim(condclien)) > 0)
            DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
            DBEval({|| dbRecall()}, &("{||" + condclien + "}"), Nil, ;
               Nil, Nil, .F.)
            pack
         endif
         if (Len(alltrim(condvende)) > 0)
            DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
            DBEval({|| dbRecall()}, &("{||" + condvende + "}"), Nil, ;
               Nil, Nil, .F.)
            pack
         endif
         if (Len(alltrim(condconve)) > 0)
            DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
            DBEval({|| dbRecall()}, &("{||" + condconve + "}"), Nil, ;
               Nil, Nil, .F.)
            pack
         endif
         goto top
         if (EOF())
            alert("No existen los comprobantes de venta en ‚ste per¡odo.")
            exit
         endif
         totbarr:= LastRec()
         opbasexc("ITEMVEND")
         copy structure to Resuarti
         opbasexc("RESUARTI")
         select 2
         opbassha("RESUVENT")
         do while (!EOF())
            puntbarr:= RecNo()
            playbarr(18, 20)
            queleter:= letra + strzero(sucursal, 4) + ;
               strzero(numero, 8)
            select 1
            append from ItemVend for comprob == queleter
            select 2
            skip 
         enddo
         close
         select 1
         goto top
         if (EOF())
            alert("No existen art¡culos vendidos en ‚stas condiciones.")
            close
            exit
         endif
         restore screen from plistas
         mensaje("Unificando art¡culos, espere por favor...", 28)
         close databases
         select 2
         opbassha("ResuVent")
         index on letra+strzero(sucursal,4)+strzero(numero,8) to ;
            comprntx
         select 1
         opbassha("ResuArti")
         if (.T.)
            set relation to
         endif
         set relation to comprob into ResuVent
         do case
         case tiporesum = 1 .OR. tiporesum = 2
            index on str(ResuVent->ncliente,5)+cod to unific unique
         case tiporesum = 3 .OR. tiporesum = 4
            index on str(ResuVent->nvend,5)+cod to unific unique
         case tiporesum = 5 .OR. tiporesum = 6
            index on cod to unific unique
         case tiporesum = 7
            index on dtoc(Resuvent->qfecha)+cod to unific unique
         endcase
         copy to unific all
         set index to 
         return
         select 2
         opbassha("Unific")
         totbarr:= LastRec()
         goto top
         do while (!EOF())
            ffffcod:= cod
            puntbarr:= RecNo()
            playbarr(18, 20)
            select 1
            ffffcant:= fffftota:= 0
            DBEval({|| (ffffcant:= ffffcant + cantidad, fffftota:= ;
               fffftota + subtotal)}, {|| cod == ffffcod}, Nil, Nil, ;
               Nil, .F.)
            select 2
            replace cantidad with ffffcant
            replace subtotal with fffftota
            skip 
         enddo
         close databases
         select 1
         opbassha("Unific")
         restore screen from plistas
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
         mensaje("Emitiendo res£men de ventas...", 28)
         if (wwdonimp == 1)
         else
         endif
         exit
      endif
   enddo
   close databases
   select 1
   return

********************************
procedure PANRESART

   select 2
   opbasexc("PANTALLA")
   zap
   select 1
   fsubtot1:= 0
   DBEval({|| fsubtot1:= fsubtot1 + total}, Nil, Nil, Nil, Nil, .F.)
   goto top
   desdereg:= RecNo()
   pag:= 1
   do case
   case tiporesum = 1
      nrefer:= ncliente
   case tiporesum = 2
      nrefer:= nvend
   case tiporesum = 3
      nrefer:= ncondvent
   case tiporesum = 4
      nrefer:= nlista
   endcase
   do while (.T.)
      lin:= Space(30)
      llenepanta()
      lin:= "          " + wwcartel6
      llenepanta()
      lin:= "Per¡odo:  " + wwcartel0
      llenepanta()
      if (pag == 1)
         lin:= "Clientes: " + wwcartel1
         llenepanta()
         lin:= "Vendedor: " + wwcartel2
         llenepanta()
         lin:= "Cond.Vta: " + wwcartel3
         llenepanta()
         lin:= "Comprob.: " + wwcartel4
         llenepanta()
         lin:= "L.Precio: " + wwcartel5
         llenepanta()
      else
         lin:= Space(30)
         llenepanta()
      endif
      lin:= ;
         "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      llenepanta()
      if (detacomp = "S")
         if (tiporesum == 1)
            lin:= ;
               "  Fecha      Comprobante      M.Base     IVA    Imp.Int.   Total  LP CV Ve    "
            llenepanta()
         else
            lin:= ;
               "  Fecha      Comprobante       Cliente                  IVA     Total  LP CV V"
            llenepanta()
         endif
      else
         lin:= ;
            "    Nombre (c¢digo)                                             Total         "
         llenepanta()
      endif
      lin:= ;
         "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      llenepanta()
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 50 .AND. !EOF())
         desdereg:= RecNo()
         do case
         case detacomp = "S"
            wwnumer:= numero
            wwcomprob:= hqueletra() + strzero(sucursal, 4) + ;
               strzero(numero, 8)
            do case
            case tiporesum = 1
               if (ncliente != nrefer .OR. pag = 1)
                  if (pag > 1)
                     lin:= ;
                        "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                     llenepanta()
                     filas:= filas + 1
                  endif
                  nrefer:= ncliente
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| ;
                     ncliente = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  lin:= SubStr(alltrim(cliente) + " (" + ;
                     alltrim(Str(ncliente, 5)) + ")" + ;
                     Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
                  llenepanta()
                  filas:= filas + 1
               endif
            case tiporesum = 2
               if (nvend != nrefer .OR. pag = 1)
                  if (pag > 1)
                     lin:= ;
                        "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                     llenepanta()
                     filas:= filas + 1
                  endif
                  nrefer:= nvend
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| nvend ;
                     = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  select 3
                  opbassha("base008", "base008a")
                  seek nrefer
                  if (Found())
                     lin:= SubStr(alltrim(nombre) + " (" + ;
                        alltrim(Str(numero, 2)) + ")" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  else
                     lin:= SubStr("VENDEDOR DESCONOCIDO" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  endif
                  close
                  select 1
                  llenepanta()
                  filas:= filas + 1
               endif
            case tiporesum = 3
               if (ncondvent != nrefer .OR. pag = 1)
                  if (pag > 1)
                     lin:= ;
                        "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                     llenepanta()
                     filas:= filas + 1
                  endif
                  nrefer:= ncondvent
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| ;
                     ncondvent = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  if (ncondvent == 1)
                     lin:= SubStr("VENTA DE CONTADO" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  else
                     lin:= SubStr("VENTA EN CUENTA CORRIENTE" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  endif
                  llenepanta()
                  filas:= filas + 1
               endif
            case tiporesum = 4
               if (nlista != nrefer .OR. pag = 1)
                  if (pag > 1)
                     lin:= ;
                        "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                     llenepanta()
                     filas:= filas + 1
                  endif
                  nrefer:= nlista
                  grantota:= 0
                  grantota:= 0
                  DBEval({|| grantota:= grantota + total}, {|| ;
                     nlista = nrefer}, Nil, Nil, Nil, .F.)
                  goto top
                  locate for RecNo() = desdereg
                  select 3
                  opbassha("base010", "base010a")
                  seek nrefer
                  if (Found())
                     lin:= SubStr("VENTA DE " + ;
                        alltrim(Upper(nombre)) + Replicate(".", 61), ;
                        1, 61) + " " + Str(grantota, 9, 2)
                  else
                     lin:= SubStr("LISTA DESCONOCIDA" + ;
                        Replicate(".", 61), 1, 61) + " " + ;
                        Str(grantota, 9, 2)
                  endif
                  close
                  select 1
                  llenepanta()
                  filas:= filas + 1
               endif
            endcase
            if (tiporesum == 1)
               lin:= DToC(fecha) + " " + hquetipoco() + " " + ;
                  wwcomprob + " " + hnetograb() + " " + hiva() + " " ;
                  + himpint() + " " + Str(total, 9, 2) + Str(nlista, ;
                  2) + Str(ncondvent, 3) + Str(nvend, 3)
               llenepanta()
            else
               lin:= DToC(fecha) + " " + hquetipoco() + " " + ;
                  wwcomprob + " " + SubStr(cliente, 1, 22) + " " + ;
                  hiva() + " " + Str(total, 9, 2) + Str(nlista, 2) + ;
                  Str(ncondvent, 2) + Str(nvend, 3)
               llenepanta()
            endif
         case tiporesum = 1
            if (ncliente != nrefer .OR. pag = 1)
               nrefer:= ncliente
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| ncliente ;
                  = nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               lin:= SubStr(alltrim(cliente) + " (" + ;
                  alltrim(Str(ncliente, 5)) + ")" + Replicate(".", ;
                  61), 1, 61) + " " + Str(grantota, 9, 2)
               llenepanta()
               filas:= filas + 1
            endif
         case tiporesum = 2
            if (nvend != nrefer .OR. pag = 1)
               nrefer:= nvend
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| nvend = ;
                  nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               select 3
               opbassha("base008", "base008a")
               seek nrefer
               if (Found())
                  lin:= SubStr(alltrim(nombre) + " (" + ;
                     alltrim(Str(numero, 2)) + ")" + Replicate(".", ;
                     61), 1, 61) + " " + Str(grantota, 9, 2)
               else
                  lin:= SubStr("VENDEDOR DESCONOCIDO" + ;
                     Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
               endif
               close
               select 1
               llenepanta()
               filas:= filas + 1
            endif
         case tiporesum = 3
            if (ncondvent != nrefer .OR. pag = 1)
               nrefer:= ncondvent
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| ;
                  ncondvent = nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               if (ncondvent == 1)
                  lin:= SubStr("VENTA DE CONTADO" + Replicate(".", ;
                     61), 1, 61) + " " + Str(grantota, 9, 2)
               else
                  lin:= SubStr("VENTA EN CUENTA CORRIENTE" + ;
                     Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
               endif
               llenepanta()
               filas:= filas + 1
            endif
         case tiporesum = 4
            if (nlista != nrefer .OR. pag = 1)
               nrefer:= nlista
               grantota:= 0
               grantota:= 0
               DBEval({|| grantota:= grantota + total}, {|| nlista = ;
                  nrefer}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = desdereg
               select 3
               opbassha("base010", "base010a")
               seek nrefer
               if (Found())
                  lin:= SubStr("VENTA DE " + alltrim(Upper(nombre)) ;
                     + Replicate(".", 61), 1, 61) + " " + ;
                     Str(grantota, 9, 2)
               else
                  lin:= SubStr("LISTA DESCONOCIDA" + Replicate(".", ;
                     61), 1, 61) + " " + Str(grantota, 9, 2)
               endif
               close
               select 1
               llenepanta()
               filas:= filas + 1
            endif
         endcase
         pag:= 2
         if (detacomp = "S")
            filas:= filas + 1
         endif
         skip 
      enddo
      if (EOF())
         lin:= Replicate("Ä", 78)
         llenepanta()
         lin:= ;
            "                        Total del Res£men de Ventas           " ;
            + Str(fsubtot1, 9, 2)
         llenepanta()
         lin:= Replicate("Ä", 78)
         llenepanta()
      else
         lin:= Replicate("Ä", 78)
         llenepanta()
      endif
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
   enddo
   select 2
   goto top
   private aprov[1]
   private tit1[1]
   aprov:= {"lineas"}
   tit1:= {"                                        "}
   set color to N/W
   jcbox(1, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "I.V.A. Venta")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   dbedit(2, 1, 22, 78, aprov, "funprov3", .T., tit1)
   close
   select 1
   return

********************************
procedure PLAYBARR

   parameters ttx, tty
   @ ttx, tty say "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
   indibarr:= totbarr / 40
   cantbarr:= Int(puntbarr / indibarr)
   @ ttx, tty say Replicate("Û", cantbarr)
   return

* EOF

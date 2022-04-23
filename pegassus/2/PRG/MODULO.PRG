#include "common.ch"
#include "inkey.ch"

********************************
*procedure MODULO


********************************
procedure FUN_14_9

   set color to N/W
   jcbox(8, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Recibos emitidos")
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @ 10,  1 say ;
      "                                                                              "
   @ 11,  1 say ;
      " Fecha desde      :            hasta:                                         "
   @ 12,  1 say ;
      "                                                                              "
   @ 13,  1 say ;
      " Cliente          :                                                           "
   @ 14,  1 say ;
      "                                                                              "
   @ 15,  1 say ;
      " Ordenados por    :                                                           "
   @ 16,  1 say ;
      "                                                                              "
   @ 17,  1 say ;
      "                                                                              "
   @ 18,  1 say ;
      "                                                                              "
   @ 19,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   opbassha("RECIBOS")
   if (EOF())
      alert("No existen Recibos emitidos.")
      close databases
      select 1
   else
      goto top
      desdef:= fecha
      goto bottom
      hastaf:= fecha
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
         @ 11, 21 get DesdeF valid desdef <= hastaf
         @ 11, 39 get HastaF valid hastaf >= desdef
         read
         if (LastKey() == K_ESC)
            alert("Proceso cancelado...")
            exit
         endif
         wwcartel0:= "desde " + DToC(desdef) + "  hasta " + ;
            DToC(hastaf)
         condicion:= "fecha>=DesdeF .and. fecha<=HastaF"
         save screen to plistas
         condicion1:= ""
         wwrespue1:= 0
         wwcartel1:= ""
         wwrespue1:= todosselec(13, 21)
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
         @ 13, 21 say wwcartel1
         set color to N/W
         if (wwrespue1 == 3)
            opbassha("BASE009", "BASE009A")
            goto bottom
            hastacod:= nro_client
            goto top
            desdecod:= nro_client
            @ 13, 21 say "desde cod: 99999 hasta cod: 99999"
            @ 13, 32 get desdecod picture "99999"
            @ 13, 49 get hastacod picture "99999" valid hastacod > 0 ;
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
         set wrap on
         @ 15, 20 say "ƒ¬ƒ"
         @ 16, 20 say " ¿ƒ"
         wwopc:= 1
         wwcartel2:= ""
         tiporesum:= 0
         do while (wwopc != 0)
            @ 15, 23 prompt " Fecha    "
            @ 16, 23 prompt " Cliente  "
            menu to wwopc
            if (wwopc = 1)
               wwcartel2:= "Fecha"
               tiporesum:= 1
               exit
            elseif (wwopc = 2)
               wwcartel2:= "Cliente"
               tiporesum:= 2
               exit
            endif
         enddo
         restore screen from plistas
         if (LastKey() == K_ESC)
            loop
         endif
         set color to B/W
         @ 15, 21 say wwcartel2
         set color to N/W
         save screen to plistas
         opbasexc("RECIBOS")
         copy structure to ResuReci
         opbasexc("ResuReci")
         append from Recibos for &condicion
         goto top
         if (EOF())
            alert("No existen recibos en Çste per°odo.")
            close
            opbassha("recibos")
            loop
         endif
         if (Len(alltrim(condclien)) > 0)
            DBEval({|| dbDelete()}, Nil, Nil, Nil, Nil, .F.)
            DBEval({|| dbRecall()}, &("{||" + condclien + "}"), Nil, ;
               Nil, Nil, .F.)
            pack
         endif
         goto top
         if (EOF())
            alert("No existen Recibos para el/los cliente/s ingresados.")
            close
            opbassha("recibos")
            loop
         endif
         ttt_ord:= LastRec()
         ttt_bru:= 0
         DBEval({|| ttt_bru:= ttt_bru + total}, Nil, Nil, Nil, Nil, ;
            .F.)
         lk1:= "Total recibos   : " + Str(ttt_ord, 3)
         lk2:= "Monto recibido  : $" + Str(ttt_bru, 9, 2)
         @ 17,  2 say lk1
         @ 18,  2 say lk2
         resp:= " "
         confirm0(19, 30)
         restore screen from plistas
         if (resp = "S")
            if (tiporesum = 1)
               index on fecha to recibntx
            elseif (tiporesum = 2)
               index on nom_clien to recibntx
            endif
            select 1
            goto top
            private aprov[1]
            private tit1[1]
            aprov:= ;
               {"'0000-'+strzero(nro_reci,8)+' '+dtoc(fecha)+'  '+str(nro_clien,5)+' '+nom_clien+'  '+str(total,10,2)"}
            tit1:= ;
               {" Nro.Comprob. Fecha emis.  Cod/Raz¢n Social Cliente                Importe "}
            set color to N/W
            jcbox(1, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
               "Recibos Emitidos")
            @  2,  1 say "Fecha    : "
            @  3,  1 say "Cliente/s: "
            @  4,  1 say "Orden por: "
            set color to B/W
            @  2, 12 say wwcartel0
            @  3, 12 say wwcartel1
            @  4, 12 say wwcartel2
            @  4, 28 say "Total selecci¢n: " + Str(ttt_ord, 3) + ;
               " recibos,  Total: $ " + Str(ttt_bru, 9, 2)
            set color to N/W*
            @ 24,  0 say ;
               "     F5=Ver pago      F6=Imprime recibo      F7=Imprime listado      Esc=Salir  "
            set color to N/W
            dbedit(6, 1, 22, 78, aprov, "funreci3", .T., tit1)
            close
            select 1
            exit
         endif
      enddo
      close databases
      select 1
      return
   endif

********************************
function FUNRECI3(Arg1, Arg2)

   alfa:= aprov[Arg2]
   do case
   case Arg1 = 0 .OR. Arg1 = 1
      return 1
   case LastKey() = K_ESC
      return 0
   case LastKey() = K_ENTER
      acata:= RecNo()
      return 0
   case LastKey() = -4
      hhh:= Row()
      save screen to vpag
      @ hhh,  1 say ">"
      set color to N/BG
      jjbox(3, 2, 10, 36, "N/BG", 20, 1, .T.)
      set color to BG/N
      @  3,  2 say "        DETALLE DE PAGOS:          "
      set color to N/BG
      @  5,  3 say "Pago 1: " + nom_val1 + "   $" + Str(tot_val1)
      @  6,  3 say "Pago 2: " + nom_val2 + "   $" + Str(tot_val2)
      @  7,  3 say "Pago 3: " + nom_val3 + "   $" + Str(tot_val3)
      @  8,  3 say "Pago 4: " + nom_val4 + "   $" + Str(tot_val4)
      @  9,  3 say "Pago 5: " + nom_val5 + "   $" + Str(tot_val5)
      if (nom_val1 = "CHEQUE" .OR. nom_val2 = "CHEQUE" .OR. nom_val3 ;
            = "CHEQUE" .OR. nom_val4 = "CHEQUE" .OR. nom_val5 = ;
            "CHEQUE")
         quereci:= nro_reci
         select 2
         opbasexc("cheqterc")
         copy structure to tempcheq
         opbasexc("tempcheq")
         append from cheqterc for nro_reci = quereci
         goto top
         if (EOF())
            alert("No encuentro los cheques...")
            close
            select 1
            return 1
         endif
         jjbox(10, 2, 21, 75, "N/BG", 20, 1, .T.)
         set color to BG/N
         @ 10,  2 say ;
            "                    DETALLE DE CHEQUES RECIBIDOS                          "
         set color to N/BG
         @ 12,  3 say ;
            "      Nß cheque        Banco emisor               Fechado        Monto  "
         do while (!EOF())
            @ 12 + RecNo(),  3 say nro_cheque picture ;
               "999999999999999"
            @ 12 + RecNo(), 20 say SubStr(banco, 1, 29)
            @ 12 + RecNo(), 52 say fecha_cob
            @ 12 + RecNo(), 64 say total picture "999999.99"
            skip 
         enddo
         close
         select 1
      endif
      set color to N/W*
      @ 24,  0 say ;
         "                                        Pulse una tecla para continuar...       "
      setcursor(0)
      InKey(0)
      set color to N/W
      restore screen from vpag
      return 1
   case LastKey() = 73 .OR. LastKey() = 105
      save screen to pantm8
      prinsn:= " "
      if (prinsn = "S")
         @ 10, 20 say "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
         @ 11, 20 say "∫     IMPRIMIENDO...    ∫"
         @ 12, 20 say "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº"
      endif
      restore screen from pantm8
      return 1
   case Arg1 = 2
      return 1
   case Arg1 = 3
      return 1
   otherwise
      return 1
   endcase
   return 1

* EOF

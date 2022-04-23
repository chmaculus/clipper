#include "common.ch"
#include "inkey.ch"

********************************
function MONTOESC

   parameters valor
   if (valor == 0)
      return "cero"
   endif
   cadval:= Str(valor, 9, 2)
   valorcad:= ""
   cadval9:= SubStr(cadval, 1, 1)
   cadval8:= SubStr(cadval, 2, 1)
   cadval7:= SubStr(cadval, 3, 1)
   cadval6:= SubStr(cadval, 4, 1)
   cadval5:= SubStr(cadval, 5, 1)
   cadval4:= SubStr(cadval, 6, 1)
   cadval2:= SubStr(cadval, 8, 1)
   cadval1:= SubStr(cadval, 9, 1)
   if (Val(cadval9) > 0)
      do case
      case cadval9 = "1"
         if (cadval8 = "0" .AND. cadval7 = "0")
            valorcad:= valorcad + " cien"
         else
            valorcad:= valorcad + " ciento"
         endif
      case cadval9 = "2"
         valorcad:= valorcad + " doscientos"
      case cadval9 = "3"
         valorcad:= valorcad + " trescientos"
      case cadval9 = "4"
         valorcad:= valorcad + " cuatrocientos"
      case cadval9 = "5"
         valorcad:= valorcad + " quinientos"
      case cadval9 = "6"
         valorcad:= valorcad + " seiscientos"
      case cadval9 = "7"
         valorcad:= valorcad + " setecientos"
      case cadval9 = "8"
         valorcad:= valorcad + " ochocientos"
      case cadval9 = "9"
         valorcad:= valorcad + " novecientos"
      endcase
   endif
   if (Val(cadval8) > 0)
      do case
      case cadval8 = "1" .AND. cadval7 = "0"
         valorcad:= valorcad + " diez"
      case cadval8 = "2"
         if (Val(cadval7) > 0)
            valorcad:= valorcad + " veinte y"
         else
            valorcad:= valorcad + " veinte"
         endif
      case cadval8 = "3"
         if (Val(cadval7) > 0)
            valorcad:= valorcad + " treinta y"
         else
            valorcad:= valorcad + " treinta"
         endif
      case cadval8 = "4"
         if (Val(cadval7) > 0)
            valorcad:= valorcad + " cuerenta y"
         else
            valorcad:= valorcad + " cuarenta"
         endif
      case cadval8 = "5"
         if (Val(cadval7) > 0)
            valorcad:= valorcad + " cincuenta y"
         else
            valorcad:= valorcad + " cincuenta"
         endif
      case cadval8 = "6"
         if (Val(cadval7) > 0)
            valorcad:= valorcad + " sesenta y"
         else
            valorcad:= valorcad + " sesenta"
         endif
      case cadval8 = "7"
         if (Val(cadval7) > 0)
            valorcad:= valorcad + " setenta y"
         else
            valorcad:= valorcad + " setenta"
         endif
      case cadval8 = "8"
         if (Val(cadval7) > 0)
            valorcad:= valorcad + " ochenta y"
         else
            valorcad:= valorcad + " ochenta"
         endif
      case cadval8 = "9"
         if (Val(cadval7) > 0)
            valorcad:= valorcad + " noventa y"
         else
            valorcad:= valorcad + " noventa"
         endif
      endcase
   endif
   if (Val(cadval7) > 0)
      do case
      case cadval7 = "1"
         if (cadval8 = "1")
            valorcad:= valorcad + " once"
         else
            valorcad:= valorcad + " un"
         endif
      case cadval7 = "2"
         if (cadval8 = "1")
            valorcad:= valorcad + " doce"
         else
            valorcad:= valorcad + " dos"
         endif
      case cadval7 = "3"
         if (cadval8 = "1")
            valorcad:= valorcad + " trece"
         else
            valorcad:= valorcad + " tres"
         endif
      case cadval7 = "4"
         if (cadval8 = "1")
            valorcad:= valorcad + " catorce"
         else
            valorcad:= valorcad + " cuatro"
         endif
      case cadval7 = "5"
         if (cadval8 = "1")
            valorcad:= valorcad + " quince"
         else
            valorcad:= valorcad + " cinco"
         endif
      case cadval7 = "6"
         if (cadval8 = "1")
            valorcad:= valorcad + " dieciseis"
         else
            valorcad:= valorcad + " seis"
         endif
      case cadval7 = "7"
         if (cadval8 = "1")
            valorcad:= valorcad + " diecisiete"
         else
            valorcad:= valorcad + " siete"
         endif
      case cadval7 = "8"
         if (cadval8 = "1")
            valorcad:= valorcad + " dieciocho"
         else
            valorcad:= valorcad + " ocho"
         endif
      case cadval7 = "9"
         if (cadval8 = "1")
            valorcad:= valorcad + " diecinueve"
         else
            valorcad:= valorcad + " nueve"
         endif
      endcase
   endif
   if (Len(alltrim(valorcad)) > 0)
      valorcad:= valorcad + " mil"
   endif
   if (Val(cadval6) > 0)
      do case
      case cadval6 = "1"
         if (cadval5 = "0" .AND. cadval4 = "0")
            valorcad:= valorcad + " cien"
         else
            valorcad:= valorcad + " ciento"
         endif
      case cadval6 = "2"
         valorcad:= valorcad + " doscientos"
      case cadval6 = "3"
         valorcad:= valorcad + " trescientos"
      case cadval6 = "4"
         valorcad:= valorcad + " cuatrocientos"
      case cadval6 = "5"
         valorcad:= valorcad + " quinientos"
      case cadval6 = "6"
         valorcad:= valorcad + " seiscientos"
      case cadval6 = "7"
         valorcad:= valorcad + " setecientos"
      case cadval6 = "8"
         valorcad:= valorcad + " ochocientos"
      case cadval6 = "9"
         valorcad:= valorcad + " novecientos"
      endcase
   endif
   if (Val(cadval5) > 0)
      do case
      case cadval5 = "1" .AND. cadval4 = "0"
         valorcad:= valorcad + " diez"
      case cadval5 = "2"
         if (Val(cadval4) > 0)
            valorcad:= valorcad + " veinte y"
         else
            valorcad:= valorcad + " veinte"
         endif
      case cadval5 = "3"
         if (Val(cadval4) > 0)
            valorcad:= valorcad + " treinta y"
         else
            valorcad:= valorcad + " treinta"
         endif
      case cadval5 = "4"
         if (Val(cadval4) > 0)
            valorcad:= valorcad + " cuerenta y"
         else
            valorcad:= valorcad + " cuarenta"
         endif
      case cadval5 = "5"
         if (Val(cadval4) > 0)
            valorcad:= valorcad + " cincuenta y"
         else
            valorcad:= valorcad + " cincuenta"
         endif
      case cadval5 = "6"
         if (Val(cadval4) > 0)
            valorcad:= valorcad + " sesenta y"
         else
            valorcad:= valorcad + " sesenta"
         endif
      case cadval5 = "7"
         if (Val(cadval4) > 0)
            valorcad:= valorcad + " setenta y"
         else
            valorcad:= valorcad + " setenta"
         endif
      case cadval5 = "8"
         if (Val(cadval4) > 0)
            valorcad:= valorcad + " ochenta y"
         else
            valorcad:= valorcad + " ochenta"
         endif
      case cadval5 = "9"
         if (Val(cadval4) > 0)
            valorcad:= valorcad + " noventa y"
         else
            valorcad:= valorcad + " noventa"
         endif
      endcase
   endif
   if (Val(cadval4) > 0)
      do case
      case cadval4 = "1"
         if (cadval5 = "1")
            valorcad:= valorcad + " once"
         else
            valorcad:= valorcad + " uno"
         endif
      case cadval4 = "2"
         if (cadval5 = "1")
            valorcad:= valorcad + " doce"
         else
            valorcad:= valorcad + " dos"
         endif
      case cadval4 = "3"
         if (cadval5 = "1")
            valorcad:= valorcad + " trece"
         else
            valorcad:= valorcad + " tres"
         endif
      case cadval4 = "4"
         if (cadval5 = "1")
            valorcad:= valorcad + " catorce"
         else
            valorcad:= valorcad + " cuatro"
         endif
      case cadval4 = "5"
         if (cadval5 = "1")
            valorcad:= valorcad + " quince"
         else
            valorcad:= valorcad + " cinco"
         endif
      case cadval4 = "6"
         if (cadval5 = "1")
            valorcad:= valorcad + " dieciseis"
         else
            valorcad:= valorcad + " seis"
         endif
      case cadval4 = "7"
         if (cadval5 = "1")
            valorcad:= valorcad + " diecisiete"
         else
            valorcad:= valorcad + " siete"
         endif
      case cadval4 = "8"
         if (cadval5 = "1")
            valorcad:= valorcad + " dieciocho"
         else
            valorcad:= valorcad + " ocho"
         endif
      case cadval4 = "9"
         if (cadval5 = "1")
            valorcad:= valorcad + " diecinueve"
         else
            valorcad:= valorcad + " nueve"
         endif
      endcase
   endif
   if (Val(cadval2 + cadval1) > 0)
      valorcad:= valorcad + " con " + cadval2 + cadval1 + " ctvos."
   endif
   return valorcad

********************************
procedure FUN_16_1

   set color to N/W
   mensaje("Inicializando impresor fiscal...", "N/W")
   public handler, port, n, se
   com:= "1"
   se:= ""
   n:= Val(com)
   mensaje("Abro port de comunicaciones......", "N/W")
   mensaje("Establezco velocidad de comunic.", "N/W")
   mensaje("Inicializo el impresor..........", "N/W")
   jcbox(3, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Ingresar cobranza")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @  4,  1 say ;
      "                                                                              "
   @  5,  1 say ;
      " Recibo N§ :                                      Total $                     "
   @  6,  1 say ;
      "                                                                              "
   @  7,  1 say ;
      " Cliente   :                                      Saldo $                     "
   @  8,  1 say ;
      "                                                                              "
   @  9,  1 say ;
      " Concepto  :                                                                  "
   @ 10,  1 say ;
      "                                                                              "
   @ 11,  1 say ;
      "ÄComposici¢n de pagoÄÄÄÄÄÄÄÄÄÄDetalle facturas pendientesÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 12,  1 say ;
      "                           ³                                                  "
   @ 13,  1 say ;
      "                           ³  Factura N§      F.Vencim.     Monto      Saldo  "
   @ 14,  1 say ;
      "                           ³                                                  "
   @ 15,  1 say ;
      "                           ³                                                  "
   @ 16,  1 say ;
      "                           ³                                                  "
   @ 17,  1 say ;
      "                           ³                                                  "
   @ 18,  1 say ;
      "                           ³                                                  "
   @ 19,  1 say ;
      "                           ³                                                  "
   @ 20,  1 say ;
      "                           ³                                                  "
   @ 21,  1 say ;
      "                           ³                                                  "
   @ 22,  1 say ;
      "                           ³                                                  "
   grup:= 0
   xgrup:= "          "
   y:= 1
   for y:= 1 to 10
      codv:= "CODV" + alltrim(Str(y, 2))
      nomv:= "NOMV" + alltrim(Str(y, 2))
      totv:= "TOTV" + alltrim(Str(y, 2))
      &codv:= 0
      &nomv:= Space(10)
      &totv:= 0
   next
   opbassha("BASE019", "BASE019A")
   goto top
   do while (!EOF())
      vvaar1:= "CODV" + alltrim(Str(RecNo(), 2))
      vvaar2:= "NOMV" + alltrim(Str(RecNo(), 2))
      &vvaar1:= cuenta
      &vvaar2:= concepto
      skip 
   enddo
   opbasexc("RECIBOS", "NUMRECI")
   if (EOF())
      dato1:= 1
   else
      goto bottom
      dato1:= nro_reci + 1
   endif
   close
   dato2:= 0
   dato3a:= 0
   dato3:= Space(30)
   dato4:= Space(60)
   y:= 1
   for y:= 1 to 5
      codval:= "CODVAL" + alltrim(Str(y, 2))
      nomval:= "NOMVAL" + alltrim(Str(y, 2))
      totval:= "TOTVAL" + alltrim(Str(y, 2))
      &codval:= 0
      &nomval:= Space(10)
      &totval:= 0
   next
   do while (.T.)
      set color to B/W,R/W*
      dato4:= Space(60)
      @  9, 14 say dato4
      @  5, 14 get dato1 picture "99999999"
      campy:= "substr(str(nro_client,5)+' '+empresa,1,35)"
      elnom:= dato3
      elnum:= dato2
      do while (.T.)
         select 3
         opbassha("BASE009", "BASE009B")
         @  7, 14 get elnom picture "@!"
         read
         if (LastKey() == K_ESC)
            exit
         endif
         elno:= alltrim(elnom)
         if (Len(elno) > 0)
            opbasexc("TMPBAS09")
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
            dato2:= nro_client
            dato3:= empresa
            dato3a:= saldo
            exit
         else
            save screen to panty
            brow03(campy, 8, 18, "N/BG", "N/BG,W+/R", "empresa", 2)
            restore screen from panty
            if (LastKey() == K_ESC)
               exit
            endif
            dato2:= nro_client
            dato3:= empresa
            dato3a:= saldo
            exit
         endif
      enddo
      close
      if (LastKey() = K_ESC .OR. dato2 = 0)
         alert("Ingreso de cobranza cancelado.")
         close databases
         select 1
         return
      endif
      @  7, 14 say Str(dato2, 5) + " " + dato3
      @  7, 59 say Str(dato3a, 9, 2)
      opbasexc("DEUDA")
      zap
      if (dato3a >= 0)
         @ 14, 31 say "No se registran comprobantes impagos."
      else
         save screen to sacocuen
         mensaje("Consolidando saldos", "N/W")
         append from BASE018 for nro_client = dato2
         index on fechavto to temp_ntx
         goto top
         wwolsald:= saldo
         wwtpago:= 0
         DBEval({|| wwtpago:= wwtpago + credito}, Nil, Nil, Nil, ;
            Nil, .F.)
         wwtpago:= wwtpago + wwolsald
         DBEval({|| dbDelete()}, {|| credito > 0}, Nil, Nil, Nil, .F.)
         pack
         do while (!EOF())
            if (wwtpago >= debito)
               wwtpago:= wwtpago - debito
               delete
               skip 
            else
               replace credito with wwtpago
               exit
            endif
         enddo
         pack
         goto top
         f:= 14
         restore screen from sacocuen
         do while (!EOF())
            deu1:= SubStr(concepto, 1, 7) + ".F" + SubStr(nro_compr, ;
               5, 8)
            deu2:= DToC(fechavto)
            deu3:= Str(debito, 9, 2)
            deu4:= debito - credito
            if (fechavto <= Date())
               set color to R/W
            else
               set color to B/W
            endif
            @ f, 29 say deu1
            @ f, 47 say deu2
            @ f, 58 say "$" + deu3
            @ f, 69 say "$" + Str(deu4, 9, 2)
            f:= f + 1
            if (f == 23)
               exit
            endif
            skip 
         enddo
      endif
      close
      set color to B/W
      y:= 1
      for y:= 1 to 10
         codv:= "CODV" + alltrim(Str(y, 2))
         nomv:= "NOMV" + alltrim(Str(y, 2))
         totv:= "TOTV" + alltrim(Str(y, 2))
         if (&codv > 0)
            @ y + 12,  4 say &nomv + ":" get &totv picture "999999.99"
         endif
      next
      read
      if (LastKey() = K_ESC .OR. dato1 = 0)
         close databases
         select 1
         loop
      endif
      save screen to tomocheq
      haycheq:= 0
      totcheq:= 0
      r:= 1
      do while (.T.)
         gg1:= "CODV" + alltrim(Str(r, 2))
         gg2:= "NOMV" + alltrim(Str(r, 2))
         gg3:= "TOTV" + alltrim(Str(r, 2))
         if (&gg2 = "CHEQUE TER" .AND. &gg3 > 0)
            esw:= &gg1
            haycheq:= 1
            totcheq:= &gg3
         endif
         r:= r + 1
         if (r == 11)
            exit
         endif
      enddo
      if (haycheq != 0)
         y:= 1
         for y:= 1 to 10
            nche:= "nche" + alltrim(Str(y, 2))
            bco:= "bco" + alltrim(Str(y, 2))
            fche:= "fche" + alltrim(Str(y, 2))
            &nche:= 0
            &bco:= Space(30)
            &fche:= Date()
         next
         do while (.T.)
            do while (.T.)
               set color to B/W,R/W*
               y:= 1
               for y:= 1 to 10
                  tche:= "tche" + alltrim(Str(y, 2))
                  &tche:= 0
               next
               set color to N/W
               @ 11,  1 say ;
                  "ÄDETALLE DE CHEQUES RECIBIDOS: $ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
               @ 12,  1 say ;
                  "       N§ cheque        Banco emisor               Fechado        Monto       "
               @ 13,  1 say ;
                  "                                                                              "
               @ 14,  1 say ;
                  " -                                                                            "
               @ 15,  1 say ;
                  " -                                                                            "
               @ 16,  1 say ;
                  " -                                                                            "
               @ 17,  1 say ;
                  " -                                                                            "
               @ 18,  1 say ;
                  " -                                                                            "
               @ 19,  1 say ;
                  " -                                                                            "
               @ 20,  1 say ;
                  " -                                                                            "
               @ 21,  1 say ;
                  " -                                                                            "
               @ 22,  1 say ;
                  " -                                                                            "
               @ 11, 33 say totcheq picture "999999.99"
               salcheq:= totcheq
               set color to B/W
               tche1:= totcheq
               @ 13,  3 get nche1 picture "999999999999999" valid ;
                  nche1 > 0
               @ 13, 20 get bco1 picture "@!" valid ;
                  Len(alltrim(bco1)) > 0
               @ 13, 52 get fche1
               @ 13, 65 get tche1 picture "999999.99"
               read
               if (LastKey() == K_ESC)
                  exit
               endif
               @ 13,  3 say nche1 picture "999999999999999"
               @ 13, 20 say bco1
               @ 13, 52 say fche1
               @ 13, 65 say tche1 picture "999999.99"
               salcheq:= salcheq - tche1
               if (salcheq == 0)
                  exit
               endif
               y:= 2
               for y:= 2 to 9
                  tche:= "tche" + alltrim(Str(y, 2))
                  nche:= "nche" + alltrim(Str(y, 2))
                  fche:= "fche" + alltrim(Str(y, 2))
                  bco:= "bco" + alltrim(Str(y, 2))
                  &tche:= salcheq
                  @ y + 12,  3 get &nche picture "999999999999999"
                  read
                  if (LastKey() = K_ESC .OR. &nche = 0)
                     &tche:= 0
                     exit
                  endif
                  @ y + 12,  3 say &nche picture "999999999999999"
                  @ y + 12, 20 get &bco picture "@!"
                  @ y + 12, 52 get &fche
                  @ y + 12, 65 get &tche picture "999999.99"
                  read
                  if (LastKey() == K_ESC)
                     exit
                  endif
                  @ y + 12, 20 say &bco
                  @ y + 12, 52 say &fche
                  @ y + 12, 65 say &tche picture "999999.99"
                  salcheq:= salcheq - &tche
                  if (salcheq == 0)
                     exit
                  endif
               next
               if (LastKey() = K_ESC .OR. &nche = 0)
                  exit
               endif
               if (salcheq == 0)
                  exit
               endif
               tche10:= salcheq
               @ 22,  3 get nche10 picture "999999999999999"
               read
               if (LastKey() = K_ESC .OR. nche10 = 0)
                  tche10:= 0
                  exit
               endif
               @ 22,  3 say nche10 picture "999999999999999"
               @ 22, 20 get bco10 picture "@!" valid ;
                  Len(alltrim(bco10)) > 0
               @ 22, 52 get fche10
               @ 22, 65 get tche10 picture "999999.99"
               read
               if (LastKey() == K_ESC)
                  exit
               endif
               @ 22, 20 say bco10
               @ 22, 52 say fche10
               @ 22, 65 say tche10 picture "999999.99"
               salcheq:= salcheq - tche10
               if (salcheq == 0)
                  exit
               endif
               exit
            enddo
            if (LastKey() == K_ESC)
               exit
            endif
            cargo:= tche1 + tche2 + tche3 + tche4 + tche5 + tche6 + ;
               tche7 + tche8 + tche9 + tche10
            if (totcheq != cargo)
               respu:= " "
               set color to N/W*,W/B
               save screen to pantsn
               opcsn1:= 1
               do while (opcsn1 != 0)
                  @ 24,  0 say ;
                     "                                                ¨ Confirma ?                    "
                  @ 24,  0 say " Ud. indic¢ $ " + ;
                     alltrim(Str(totcheq, 9, 2)) + " y carg¢ $ " + ;
                     alltrim(Str(cargo, 9, 2))
                  @ 24, 63 prompt " SI "
                  @ 24, 69 prompt " NO "
                  set wrap on
                  menu to opcsn1
                  if (opcsn1 = 1)
                     respu:= "S"
                     exit
                  elseif (opcsn1 = 2)
                     respu:= "N"
                     exit
                  endif
               enddo
               restore screen from pantsn
               set color to B/W,R/W*
               if (respu = "S")
                  bcg:= "totv" + alltrim(Str(esw, 2))
                  &bcg:= cargo
                  restore screen from tomocheq
                  set color to R/W*
                  @ 12 + esw, 16 say &bcg picture "999999.99"
                  set color to B/W,R/W*
                  save screen to tomocheq
                  exit
               endif
            else
               respu:= " "
               set color to N/W*,W/B
               save screen to pantsn
               opcsn1:= 1
               do while (opcsn1 != 0)
                  @ 24,  0 say ;
                     "                                                ¨ Confirma ?                    "
                  @ 24, 63 prompt " SI "
                  @ 24, 69 prompt " NO "
                  set wrap on
                  menu to opcsn1
                  if (opcsn1 = 1)
                     respu:= "S"
                     exit
                  elseif (opcsm1 = 2)
                     respu:= "N"
                     exit
                  endif
               enddo
               restore screen from pantsn
               set color to B/W,R/W*
               if (respu = "S")
                  exit
               endif
            endif
         enddo
      endif
      restore screen from tomocheq
      set color to B/W
      if (LastKey() == K_ESC)
         select 1
         loop
      endif
      dato5:= totv1 + totv2 + totv3 + totv4 + totv5 + totv6 + totv7 ;
         + totv8 + totv9 + totv10
      @  5, 59 say dato5 picture "999999.99"
      dato3a:= dato3a + dato5
      @  7, 59 say dato3a picture "999999.99"
      resto:= dato5
      if (dato5 == 0)
         alert("Total en cero. Ingreso de cobranza cancelado.")
         select 1
         exit
      endif
      opbasexc("DEUDA")
      if (EOF())
         dato4:= "A cuenta de futura facturaci¢n"
      else
         set index to temp_ntx
         f:= 14
         do while (!EOF())
            debe:= debito - credito
            sobra:= resto - debe
            if (sobra < 0)
               dato4:= alltrim(dato4) + "A cta.FN§ " + ;
                  SubStr(nro_compr, 5, 8) + "."
               deu4:= debe - resto
               resto:= resto - debe
               @ f, 70 say Str(deu4, 9, 2)
               exit
            else
               dato4:= alltrim(dato4) + "Canc.FN§ " + ;
                  SubStr(nro_compr, 5, 8) + "."
               resto:= resto - debe
               @ f, 70 say "........."
               if (resto == 0)
                  exit
               endif
            endif
            f:= f + 1
            skip 
         enddo
         if (resto > 0)
            dato4:= alltrim(dato4) + " y a cta $ " + ;
               alltrim(Str(resto, 9, 2))
         endif
      endif
      close
      dato4:= SubStr(dato4 + Space(60), 1, 60)
      @  9, 14 get dato4
      read
      if (LastKey() == K_ESC)
         select 1
         loop
      endif
      save screen to pfinal
      resp:= " "
      confirm0(15, 30)
      set color to N/W
      select 1
      restore screen from pfinal
      if (resp = "S")
         opbasexc("BASE009", "BASE009A")
         seek dato2
         if (Found())
            wwnomcli:= alltrim(empresa)
            wwdircli:= alltrim(direccion)
            wwtipdoc:= adocum[tipodoc][2]
            wwnrodoc:= alltrim(nrodoc)
            wwresiva:= respiva[respon][2]
         endif
         close
         mensaje("Imprimiendo comprobante...", "N/W")
         klis:= 1
         kpag:= 1
         do while (.T.)
            kref1:= "CODV" + alltrim(Str(klis, 2))
            kref2:= "NOMV" + alltrim(Str(klis, 2))
            kref3:= "TOTV" + alltrim(Str(klis, 2))
            kdat1:= "CODVAL" + alltrim(Str(kpag, 2))
            kdat2:= "NOMVAL" + alltrim(Str(kpag, 2))
            kdat3:= "TOTVAL" + alltrim(Str(kpag, 2))
            if (&kref3 > 0)
               &kdat1:= &kref1
               &kdat2:= &kref2
               &kdat3:= &kref3
               kpag:= kpag + 1
            endif
            klis:= klis + 1
            if (klis == 11)
               exit
            endif
         enddo
         opbasexc("RECIBOS")
         set index to numreci, clireci
         append blank
         replace nro_reci with dato1
         replace nro_clien with dato2
         replace nom_clien with dato3
         replace concepto with dato4
         replace total with dato5
         replace fecha with Date()
         replace cod_val1 with codval1
         replace nom_val1 with nomval1
         replace tot_val1 with totval1
         replace cod_val2 with codval2
         replace nom_val2 with nomval2
         replace tot_val2 with totval2
         replace cod_val3 with codval3
         replace nom_val3 with nomval3
         replace tot_val3 with totval3
         replace cod_val4 with codval4
         replace nom_val4 with nomval4
         replace tot_val4 with totval4
         replace cod_val5 with codval5
         replace nom_val5 with nomval5
         replace tot_val5 with totval5
         opbasexc("BASE018", "BASE018C")
         append blank
         replace fecha with Date()
         replace nro_compr with "REC." + strzero(dato1, 8)
         replace tipo with "X"
         replace concepto with dato4
         replace nro_client with dato2
         replace cliente with dato3
         replace fechavto with Date()
         replace credito with dato5
         opbasexc("BASE009", "BASE009A")
         seek dato2
         if (Found())
            replace saldo with dato3a
         endif
         if (haycheq != 0)
            opbasexc("CHEQTERC")
            y:= 1
            for y:= 1 to 10
               nche:= "nche" + alltrim(Str(y, 2))
               bco:= "bco" + alltrim(Str(y, 2))
               fche:= "fche" + alltrim(Str(y, 2))
               tche:= "tche" + alltrim(Str(y, 2))
               if (&nche > 0)
                  append blank
                  replace nro_reci with dato1
                  replace nro_cheque with &nche
                  replace banco with &bco
                  replace c_recibido with dato2
                  replace n_recibido with dato3
                  replace fecha_rec with Date()
                  replace fecha_cob with &fche
                  replace total with &tche
               endif
            next
            close
         endif
      endif
      exit
   enddo
   close databases
   select 1
   return

********************************
function IMPRIMEREC

   wwdonimp:= 3
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
            return -1
         endif
      endif
   enddo
   set console off
   set printer on
   ? 
   ? titulon, "                     RECIBO", tituloff
   ? ;
      "                                                             ", ;
      DToC(Date())
   ? 
   ? 
   ? 
   ? 
   ? 
   ? "Cliente      :", Str(dato2, 5), wwnomcli
   ? "Direcci¢n    :", wwdircli
   ? "C.U.I.T./Resp:", wwnrodoc, wwresiva
   ? ;
      "-------------------------------------------------------------------------------"
   ? 
   ? "RECIBIMOS LA SUMA DE PESOS:"
   ? montoesc(dato5)
   ? 
   ? "EN CONCEPTO DE:"
   ? dato4
   ? 
   ? ;
      "-------------------------------------------------------------------------------"
   ? "Detalle de valores recibidos"
   if (haycheq != 0)
      y:= 1
      for y:= 1 to 8
         nche:= "nche" + alltrim(Str(y, 2))
         bco:= "bco" + alltrim(Str(y, 2))
         fche:= "fche" + alltrim(Str(y, 2))
         tche:= "tche" + alltrim(Str(y, 2))
         if (&nche > 0)
            ? mpconon, Str(&nche, 15), &bco, &fche, Str(&tche, 10, ;
               2), mpconoff
         else
            ? 
         endif
      next
      close
   else
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
   endif
   ? ;
      "                                              ..................    $", ;
      Str(dato5, 10, 2)
   ? 
   ? 
   ? 
   ? 
   ? 
   ? 
   ? titulon, "                     RECIBO", tituloff
   ? ;
      "                                                             ", ;
      DToC(Date())
   ? 
   ? 
   ? 
   ? 
   ? 
   ? "Cliente      :", Str(dato2, 5), wwnomcli
   ? "Direcci¢n    :", wwdircli
   ? "C.U.I.T./Resp:", wwnrodoc, wwresiva
   ? ;
      "-------------------------------------------------------------------------------"
   ? 
   ? "RECIBIMOS LA SUMA DE PESOS:"
   ? montoesc(dato5)
   ? 
   ? "EN CONCEPTO DE:"
   ? dato4
   ? 
   ? ;
      "-------------------------------------------------------------------------------"
   ? "Detalle de valores recibidos"
   if (haycheq != 0)
      y:= 1
      for y:= 1 to 8
         nche:= "nche" + alltrim(Str(y, 2))
         bco:= "bco" + alltrim(Str(y, 2))
         fche:= "fche" + alltrim(Str(y, 2))
         tche:= "tche" + alltrim(Str(y, 2))
         if (&nche > 0)
            ? mpconon, Str(&nche, 15), &bco, &fche, Str(&tche, 10, ;
               2), mpconoff
         else
            ? 
         endif
      next
      close
   else
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
   endif
   ? ;
      "                                              ..................    $", ;
      Str(dato5, 10, 2)
   ? 
   ? titulon, "                     RECIBO", tituloff
   ? ;
      "                                                             ", ;
      DToC(Date())
   ? 
   ? 
   ? 
   ? 
   ? 
   ? "Cliente      :", Str(dato2, 5), wwnomcli
   ? "Direcci¢n    :", wwdircli
   ? "C.U.I.T./Resp:", wwnrodoc, wwresiva
   ? ;
      "-------------------------------------------------------------------------------"
   ? 
   ? "RECIBIMOS LA SUMA DE PESOS:"
   ? montoesc(dato5)
   ? 
   ? "EN CONCEPTO DE:"
   ? dato4
   ? 
   ? ;
      "-------------------------------------------------------------------------------"
   ? "Detalle de valores recibidos"
   if (haycheq != 0)
      y:= 1
      for y:= 1 to 8
         nche:= "nche" + alltrim(Str(y, 2))
         bco:= "bco" + alltrim(Str(y, 2))
         fche:= "fche" + alltrim(Str(y, 2))
         tche:= "tche" + alltrim(Str(y, 2))
         if (&nche > 0)
            ? mpconon, Str(&nche, 15), &bco, &fche, Str(&tche, 10, ;
               2), mpconoff
         else
            ? 
         endif
      next
      close
   else
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
      ? 
   endif
   ? ;
      "                                              ..................    $", ;
      Str(dato5, 10, 2)
   set printer off
   set console on
   eject
   return 0

********************************
function FUNDEB

   if (debito > 0)
      return Str(debito, 10, 2)
   else
      return "          "
   endif

********************************
function FUNCRE

   if (credito > 0)
      return Str(credito, 10, 2)
   else
      return "          "
   endif

********************************
procedure FUN_14_5

   set color to N/W
   jcbox(10, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Res£men de Cta.Cte. de cliente")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   opbassha("BASE018")
   index on fecha to fechavto
   goto bottom
   wwhastaf:= fecha
   goto top
   wwdesdef:= fecha
   condicion1:= ""
   wwrespue1:= 0
   wwcartel1:= ""
   close
   set color to N/W
   @ 12,  1 say ;
      " Fecha desde:              hasta:                                             "
   @ 13,  1 say ;
      "                                                                              "
   @ 14,  1 say ;
      " Cliente    :                                                                 "
   @ 15,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   save screen to pctacte
   do while (.T.)
      restore screen from pctacte
      @ 12, 15 get wwDesdeF valid wwdesdef <= wwhastaf
      @ 12, 35 get wwHastaF valid wwhastaf >= wwdesdef
      read
      if (LastKey() == K_ESC)
         alert("Consulta cancelada...")
         exit
      endif
      condicionf:= "fecha<wwDesdeF .or. fecha>wwHastaF"
      save screen to pctacte1
      wwrespue1:= todosselec(14, 15)
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
      restore screen from pctacte1
      if (wwrespue1 == 2)
         opbassha("BASE009", "BASE009B")
         yy:= LastRec()
         private selecciona[yy]
         private seleccionb[yy, 2]
         wwquecarte:= ""
         wwquereg:= 0
         queselec("empresa", "nro_client", "nro_client")
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
      endif
      restore screen from pctacte1
      @ 14, 15 say wwcartel1
      if (wwrespue1 == 3)
         opbassha("BASE009", "BASE009A")
         goto bottom
         hastacod:= nro_client
         goto top
         desdecod:= nro_client
         @ 14, 15 say "desde cod: 99999 hasta cod: 99999"
         @ 14, 26 get desdecod picture "99999"
         @ 14, 43 get hastacod picture "99999" valid hastacod > 0 ;
            .AND. hastacod >= desdecod
         read
         if (LastKey() == K_ESC)
            alert("No seleccion¢ registros")
            loop
         endif
         condicion1:= "nro_client>=" + Str(desdecod, 5) + ;
            " .and. nro_client<=" + Str(hastacod, 5)
      endif
      save screen to pctacte1
      resp:= " "
      confirm0(19, 30)
      restore screen from pctacte1
      if (resp = "S")
         nimpf:= 0
         wwdonimp:= dondeimpri(1)
         if (wwdonimp == 0)
            loop
         endif
         mensaje("Elaborando informe...", 28)
         opbasexc("BASE018")
         index on str(nro_client,5)+str(year(fechavto), ;
            4)+str(month(fechavto),2)+str(day(fechavto),2)+nro_compr ;
            to resumenA
         goto top
         refclien:= 0
         rsaldo:= 0
         do while (!EOF())
            if (nro_client != refclien)
               refclien:= nro_client
               rsaldo:= 0
            endif
            rsaldo:= rsaldo - debito + credito
            replace saldo with rsaldo
            skip 
         enddo
         if (wwrespue1 == 1)
            opbasexc("Resumen")
            zap
            append from BASE018 all
            condicion1:= "nro_client>0"
         else
            opbasexc("Resumen")
            zap
            append from BASE018 for &condicion1
         endif
         goto top
         if (!EOF())
            DBEval({|| dbDelete()}, &("{||" + condicionf + "}"), ;
               Nil, Nil, Nil, .F.)
            pack
         endif
         opbasexc("BASE018")
         DBEval({|| field->saldo:= 0}, Nil, Nil, Nil, Nil, .F.)
         opbasexc("RESUMEN")
         goto top
         if (EOF())
            close
            alert("No existen registros que cumplan la condici¢n.")
            loop
         endif
         index on str(nro_client,5)+str(year(fechavto), ;
            4)+str(month(fechavto),2)+str(day(fechavto),2)+nro_compr ;
            to resumenB
         wwdd:= LastRec()
         if (wwdonimp = 1)
            panresum()
         elseif (wwdonimp = 2)
            if (nimpf > 0)
               fisresum()
            endif
         elseif (wwdonimp > 2)
            porpag:= 1
            do while (porpag != 0)
               jjbox(15, 21, 19, 55, "N/W", 20, 1, .T.)
               set color to N/W
               @ 16, 23 say "¨Imprime un res£men por p gina?"
               @ 18, 31 prompt " SI "
               @ 18, 41 prompt " NO "
               set wrap on
               menu to porpag
               if (porpag = 1)
                  exit
               elseif (porpag = 2)
                  exit
               endif
            enddo
            if (porpag > 0)
               impresum()
            endif
         endif
         restore screen from pctacte1
      endif
      exit
   enddo
   close databases
   select 1
   return

********************************
procedure PANRESUM

   select 2
   opbasexc("PANTALLA")
   zap
   select 1
   goto top
   desdereg:= RecNo()
   refclien:= 0
   do while (.T.)
      lin:= "                    RESUMEN DE CUENTA"
      llenepanta()
      lin:= "                    DESDE: " + DToC(wwdesdef) + ;
         " HASTA: " + DToC(wwhastaf)
      llenepanta()
      filas:= 1
      locate for RecNo() = desdereg
      do while (!EOF())
         if (nro_client != refclien)
            lin:= "        " + Replicate("Í", 70)
            llenepanta()
            lin:= "        " + Str(nro_client, 5) + " " + cliente
            llenepanta()
            lin:= "        " + Replicate("Ä", 70)
            llenepanta()
            lin:= ;
               "        COMPROBANTE: FECH/TIPO/N§  FECHA VTO     DEBITO    CREDITO     SALDO"
            llenepanta()
            lin:= "        " + Replicate("Ä", 70)
            llenepanta()
            lin:= "        Saldo al " + DToC(wwdesdef - 1) + ;
               "                                         " + ;
               Str(saldo - credito + debito, 10, 2)
            llenepanta()
            refclien:= nro_client
         endif
         lin:= "        " + DToC(fecha) + " " + tipo + " " + ;
            nro_compr + " " + DToC(fechavto) + "  " + fundeb() + " " ;
            + funcre() + " " + Str(saldo, 10, 2)
         llenepanta()
         skip 
      enddo
      if (EOF())
         lin:= "        " + Replicate("Í", 70)
         llenepanta()
      endif
      if (EOF())
         exit
      endif
   enddo
   select 2
   goto top
   private aprov[1]
   private tit1[1]
   aprov:= {"lineas"}
   tit1:= {"                                        "}
   set color to N/W
   jcbox(1, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Res£men de Cta.Cte. de cliente")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   dbedit(2, 1, 22, 78, aprov, "funprov3", .T., tit1)
   close
   select 1
   return

********************************
procedure FISRESUM

   alert("No habilitado para impresora fiscal")
   return

********************************
procedure IMPRESUM

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
   refclien:= 0
   do while (.T.)
      ? mpconoff, "      ", Space(35), "   ", "    ", Date(), ;
         "     Pag.", Str(pag, 4, 0)
      ? "       ", titulon, titular, tituloff
      ? 
      ? "       ", titulon, "RESUMEN DE CUENTA", tituloff
      ? "       ", "  DESDE:", DToC(wwdesdef), "HASTA:", ;
         DToC(wwhastaf)
      filas:= 1
      locate for RecNo() = desdereg
      do while (!EOF())
         if (nro_client != refclien)
            if (porpag = 1 .AND. refclien > 0)
            else
               qrg:= RecNo()
               qcl:= nro_client
               qco:= 0
               do while (!EOF())
                  if (nro_client != qcl)
                     goto top
                     locate for RecNo() = qrg
                     exit
                  endif
                  qco:= qco + 1
                  skip 
               enddo
               if (EOF())
                  goto top
                  locate for RecNo() = qrg
               endif
               if (filas + 6 + qco > 60)
                  exit
               endif
            endif
            ? "       ", Replicate("Í", 70)
            ? "       ", Str(nro_client, 5), cliente
            ? "       ", Replicate("Ä", 70)
            ? "       ", ;
               "COMPROBANTE: FECH/TIPO/N§  FECHA VTO     DEBITO    CREDITO     SALDO"
            ? "       ", Replicate("Ä", 70)
            ? "       ", "Saldo al", DToC(wwdesdef - 1), ;
               "                                       ", Str(saldo ;
               - credito + debito, 10, 2)
            filas:= 6 + filas
            refclien:= nro_client
         endif
         ? "       ", DToC(fecha), tipo, nro_compr, DToC(fechavto), ;
            "", fundeb(), funcre(), Str(saldo, 10, 2)
         filas:= 1 + filas
         skip 
         if (nro_client != refclien .AND. porpag = 1)
            exit
         endif
      enddo
      if (EOF())
         ? "       ", Replicate("Í", 70)
      else
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
procedure FUN_14_6

   set color to N/W
   jcbox(10, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Res£men de Deudas Vencidas")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   opbassha("BASE018")
   wwfecvto:= Date()
   goto top
   condicion1:= ""
   wwrespue1:= 0
   wwcartel1:= ""
   wwcartel2:= ""
   close
   set color to N/W
   @ 12,  1 say ;
      " Fecha vto. :             (fecha de referencia para vencimientos)             "
   @ 13,  1 say ;
      "                                                                              "
   @ 14,  1 say ;
      " Cliente    :                                                                 "
   @ 15,  1 say ;
      "                                                                              "
   @ 16,  1 say ;
      " Emitir por :                                                                 "
   @ 17,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   save screen to pctacte
   do while (.T.)
      restore screen from pctacte
      @ 12, 15 get wwFecVto
      read
      if (LastKey() == K_ESC)
         alert("Consulta cancelada...")
         exit
      endif
      condicionf:= "fechavto>wwFecVto"
      save screen to pctacte1
      wwrespue1:= todosselec(14, 15)
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
      restore screen from pctacte1
      if (wwrespue1 == 2)
         opbassha("BASE009", "BASE009B")
         yy:= LastRec()
         private selecciona[yy]
         private seleccionb[yy, 2]
         wwquecarte:= ""
         wwquereg:= 0
         queselec("empresa", "nro_client", "nro_client")
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
         restore screen from pctacte1
      endif
      @ 14, 15 say wwcartel1
      save screen to pctacte1
      if (wwrespue1 == 3)
         opbassha("BASE009", "BASE009A")
         goto bottom
         hastacod:= nro_client
         goto top
         desdecod:= nro_client
         @ 14, 15 say "desde cod: 99999 hasta cod: 99999"
         @ 14, 26 get desdecod picture "99999"
         @ 14, 43 get hastacod picture "99999" valid hastacod > 0 ;
            .AND. hastacod >= desdecod
         read
         if (LastKey() == K_ESC)
            alert("No seleccion¢ registros")
            loop
         endif
         condicion1:= "nro_client>=" + Str(desdecod, 5) + ;
            " .and. nro_client<=" + Str(hastacod, 5)
         save screen to pctacte1
      endif
      set wrap on
      comoemit:= 0
      wwx:= 16
      wwy:= 15
      @ wwx, wwy say "ÄÂÄ"
      @ wwx + 1, wwy say " ÀÄ"
      wwopc:= 1
      do while (wwopc != 0)
         @ wwx, wwy + 3 prompt "Clientes            "
         @ wwx + 1, wwy + 3 prompt "Fecha de vencimiento"
         menu to wwopc
         if (wwopc = 1)
            wwcartel2:= "Clientes            "
            exit
         elseif (wwopc = 2)
            wwcartel2:= "Fecha de vencimiento"
            exit
         endif
      enddo
      if (LastKey() == K_ESC)
         alert("No seleccion¢ registros")
         loop
      endif
      comoemit:= wwopc
      restore screen from pctacte1
      @ 16, 15 say wwcartel2
      save screen to pctacte1
      resp:= " "
      confirm0(19, 30)
      restore screen from pctacte1
      if (resp = "S")
         nimpf:= 0
         wwdonimp:= dondeimpri(1)
         if (wwdonimp == 0)
            loop
         endif
         mensaje("Elaborando informe...", 28)
         opbasexc("BASE018")
         if (wwrespue1 == 1)
            opbasexc("Resumen")
            zap
            append from BASE018 all
            condicion1:= "nro_client>0"
         else
            opbasexc("Resumen")
            zap
            append from BASE018 for &condicion1
         endif
         index on str(nro_client,5)+str(year(fechavto), ;
            4)+str(month(fechavto),2)+str(day(fechavto),2)+nro_compr ;
            to resumenD
         goto top
         estereg:= RecNo()
         refclien:= 0
         wcredit:= 0
         do while (!EOF())
            if (nro_client != refclien)
               estereg:= RecNo()
               refclien:= nro_client
               wcredit:= 0
               DBEval({|| wcredit:= wcredit + credito}, {|| ;
                  nro_client = refclien}, Nil, Nil, Nil, .F.)
               goto top
               locate for RecNo() = estereg
            endif
            if (debito > 0)
               wcredit:= wcredit - debito
               if (wcredit >= 0)
                  replace saldo with 0
               elseif (debito > wcredit * -1)
                  replace saldo with wcredit * -1
               else
                  replace saldo with debito
               endif
            endif
            skip 
         enddo
         goto top
         if (!EOF())
            DBEval({|| dbDelete()}, &("{||" + condicionf + "}"), ;
               Nil, Nil, Nil, .F.)
            DBEval({|| dbDelete()}, {|| credito > 0 .OR. saldo = 0}, ;
               Nil, Nil, Nil, .F.)
            pack
         endif
         opbasexc("BASE018")
         DBEval({|| field->saldo:= 0}, Nil, Nil, Nil, Nil, .F.)
         opbasexc("RESUMEN")
         goto top
         if (EOF())
            close
            alert("No existen registros que cumplan la condici¢n.")
            loop
         endif
         if (comoemit = 1)
            index on str(nro_client,5)+str(year(fechavto), ;
               4)+str(month(fechavto),2)+str(day(fechavto), ;
               2)+nro_compr to resumenC
         elseif (comoemit = 2)
            index on str(year(fechavto),4)+str(month(fechavto), ;
               2)+str(day(fechavto),2)+nro_compr to resumenC
         endif
         wwdd:= LastRec()
         if (wwdonimp = 1)
            panresum1()
         elseif (wwdonimp = 2)
            if (nimpf > 0)
               fisresum1()
            endif
         elseif (wwdonimp > 2)
            porpag:= 1
            do while (porpag != 0)
               jjbox(15, 21, 19, 55, "N/W", 20, 1, .T.)
               set color to N/W
               @ 16, 23 say "¨Imprime un informe por p gina?"
               @ 18, 31 prompt " SI "
               @ 18, 41 prompt " NO "
               set wrap on
               menu to porpag
               if (porpag = 1)
                  exit
               elseif (porpag = 2)
                  exit
               endif
            enddo
            if (porpag > 0)
               impresum1()
            endif
         endif
         restore screen from pctacte1
      endif
      exit
   enddo
   close databases
   select 1
   return

********************************
procedure PANRESUM1

   select 3
   opbassha("BASE009", "BASE009A")
   select 2
   opbasexc("PANTALLA")
   zap
   select 1
   goto top
   desdereg:= RecNo()
   refecha:= CToD("01-01-1900")
   refclien:= 0
   wwtotal:= 0
   wwsubtot:= 0
   do while (.T.)
      if (comoemit == 1)
         lin:= ;
            "               INFORME DE DEUDAS VENCIDAS POR CLIENTES"
      else
         lin:= ;
            "               INFORME DE DEUDAS VENCIDAS POR FECHA VTO"
      endif
      llenepanta()
      lin:= "               FECHA DE REF: " + DToC(wwfecvto)
      llenepanta()
      filas:= 1
      locate for RecNo() = desdereg
      do while (!EOF())
         if (comoemit == 1)
            if (nro_client != refclien)
               if (refclien > 0)
                  lin:= ;
                     "                                                      ÄÄÄÄÄÄÄÄÄÄ"
                  llenepanta()
                  lin:= ;
                     "                                                     " ;
                     + Str(wwsubtot, 10, 2)
                  llenepanta()
               endif
               lin:= Replicate("Í", 78)
               llenepanta()
               dref1:= nro_client
               select 3
               seek dref1
               if (Found())
                  lin:= " " + Str(nro_client, 5) + " " + ;
                     alltrim(empresa) + " " + alltrim(direccion) + ;
                     " " + alltrim(localidad)
               else
                  lin:= "  Carga inicial de saldos"
               endif
               select 1
               llenepanta()
               lin:= Replicate("Ä", 78)
               llenepanta()
               lin:= ;
                  "        FECHA VTO   COMPROBANTE     TOTAL    VENCIDO   A PAGAR   DIAS"
               llenepanta()
               lin:= Replicate(" ", 78)
               llenepanta()
               refclien:= nro_client
               wwtotal:= wwtotal + wwsubtot
               wwsubtot:= 0
            endif
         elseif (fechavto != refecha)
            if (refecha > CToD("01-01-1900"))
               lin:= ;
                  "                                                                ÄÄÄÄÄÄÄÄÄÄ"
               llenepanta()
               lin:= ;
                  "                                                               " ;
                  + Str(wwsubtot, 10, 2)
               llenepanta()
            endif
            lin:= Replicate("Í", 78)
            llenepanta()
            lin:= ;
               "FECHA VTO     CLIENTE                   COMPROBANTE    VENCIDO   A PAGAR  DIAS"
            llenepanta()
            lin:= Replicate(" ", 78)
            llenepanta()
            refecha:= fechavto
            wwtotal:= wwtotal + wwsubtot
            wwsubtot:= 0
         endif
         if (comoemit == 1)
            lin:= "        " + DToC(fechavto) + " " + tipo + " " + ;
               nro_compr + " " + Str(totalfac, 9, 2) + " " + ;
               Str(debito, 9, 2) + " " + Str(saldo, 9, 2) + " " + ;
               Str(wwfecvto - fechavto, 5)
         else
            lin:= DToC(fechavto) + " " + Str(nro_client, 5) + " " + ;
               SubStr(cliente, 1, 21) + " " + tipo + " " + nro_compr ;
               + " " + Str(debito, 9, 2) + " " + Str(saldo, 9, 2) + ;
               " " + Str(wwfecvto - fechavto, 4)
         endif
         llenepanta()
         wwsubtot:= wwsubtot + saldo
         skip 
      enddo
      if (EOF())
         if (comoemit == 1)
            lin:= ;
               "                                                      ÄÄÄÄÄÄÄÄÄÄ"
            llenepanta()
            lin:= ;
               "                                                     " ;
               + Str(wwsubtot, 10, 2)
            wwtotal:= wwtotal + wwsubtot
            llenepanta()
            lin:= Replicate("Í", 78)
            llenepanta()
            lin:= ;
               "                               TOTAL GENERAL        " ;
               + Str(wwtotal, 11, 2)
            llenepanta()
            lin:= Replicate("Í", 78)
            llenepanta()
         else
            lin:= ;
               "                                                                ÄÄÄÄÄÄÄÄÄÄ"
            llenepanta()
            lin:= ;
               "                                                               " ;
               + Str(wwsubtot, 10, 2)
            wwtotal:= wwtotal + wwsubtot
            llenepanta()
            lin:= Replicate("Í", 78)
            llenepanta()
            lin:= ;
               "                                         TOTAL GENERAL        " ;
               + Str(wwtotal, 11, 2)
            llenepanta()
            lin:= Replicate("Í", 78)
            llenepanta()
         endif
         exit
      endif
   enddo
   select 2
   goto top
   private aprov[1]
   private tit1[1]
   aprov:= {"lineas"}
   tit1:= {"                                        "}
   set color to N/W
   jcbox(1, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Informe de Deudas Vencidas")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   dbedit(2, 1, 22, 78, aprov, "funprov3", .T., tit1)
   select 3
   close
   select 2
   close
   select 1
   return

********************************
procedure FISRESUM1

   alert("No habilitado para impresora fiscal")
   return

********************************
procedure IMPRESUM1

   select 3
   opbassha("BASE009", "BASE009A")
   select 1
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
      if (comoemit == 1)
         ? "     ", titulon, "DEUDAS VENCIDAS POR CLIENTE", tituloff
      else
         ? "     ", titulon, "DEUDAS VENCIDAS POR FECHA VTO", tituloff
      endif
      ? "       ", "FECHA DE REFERENCIA:", DToC(wwfecvto)
      filas:= 1
      locate for RecNo() = desdereg
      do while (!EOF())
         if (comoemit == 1)
            if (nro_client != refclien)
               if (refclien > 0 .AND. porpag != 1 .AND. filas > 1)
                  ? ;
                     "                                                      ÄÄÄÄÄÄÄÄÄÄ"
                  ? ;
                     "                                                    ", ;
                     Str(wwsubtot, 10, 2)
                  filas:= filas + 2
               endif
               if (porpag = 1 .AND. refclien > 0)
               else
                  qrg:= RecNo()
                  qcl:= nro_client
                  qco:= 0
                  do while (!EOF())
                     if (nro_client != qcl)
                        goto top
                        locate for RecNo() = qrg
                        exit
                     endif
                     qco:= qco + 1
                     skip 
                  enddo
                  if (EOF())
                     goto top
                     locate for RecNo() = qrg
                  endif
                  if (filas + 5 + qco > 58)
                     ? "       ", Replicate("Ä", 70)
                     exit
                  endif
               endif
               ? "       ", Replicate("Í", 70)
               dref1:= nro_client
               select 3
               seek dref1
               if (Found())
                  ? SubStr("        " + Str(nro_client, 5) + " " + ;
                     alltrim(empresa) + " " + alltrim(direccion) + ;
                     " " + alltrim(localidad), 1, 79)
               else
                  ? "        Carga inicial de saldos"
               endif
               select 1
               ? "       ", Replicate("Ä", 70)
               ? "       ", ;
                  "FECHA VTO   COMPROBANTE     TOTAL    VENCIDO   A PAGAR   DIAS"
               ? 
               filas:= 5 + filas
               refclien:= nro_client
               wwtotal:= wwtotal + wwsubtot
               wwsubtot:= 0
            endif
         elseif (fechavto != refecha)
            if (refecha > CToD("01-01-1900") .AND. porpag != 1 .AND. ;
                  filas > 1)
               ? mpconon, ;
                  "                                                                                                   ÄÄÄÄÄÄÄÄÄÄ", ;
                  mpconoff
               ? mpconon, ;
                  "                                                                                                  ", ;
                  Str(wwsubtot, 10, 2), mpconoff
               filas:= filas + 2
            endif
            if (porpag = 1 .AND. refecha > CToD("01-01-1900"))
            else
               qrg:= RecNo()
               qcl:= fechavto
               qco:= 0
               do while (!EOF())
                  if (fechavto != qcl)
                     goto top
                     locate for RecNo() = qrg
                     exit
                  endif
                  qco:= qco + 1
                  skip 
               enddo
               if (EOF())
                  goto top
                  locate for RecNo() = qrg
               endif
               if (filas + 3 + qco > 56)
                  ? "       ", Replicate("Ä", 70)
                  exit
               endif
            endif
            ? "       ", Replicate("Í", 70)
            ? mpconon, "               ", ;
               "FECHA VTO     CLIENTE                            COMPROBANTE     TOTAL    VENCIDO   A PAGAR   DIAS", ;
               mpconoff
            ? 
            filas:= 3 + filas
            refecha:= fechavto
            wwtotal:= wwtotal + wwsubtot
            wwsubtot:= 0
         endif
         if (comoemit == 1)
            ? "       ", DToC(fechavto), tipo, nro_compr, ;
               Str(totalfac, 9, 2), Str(debito, 9, 2), Str(saldo, 9, ;
               2), Str(wwfecvto - fechavto, 5)
         else
            ? mpconon, "                ", DToC(fechavto), ;
               Str(nro_client, 5), cliente, tipo, nro_compr, ;
               Str(totalfac, 9, 2), Str(debito, 9, 2), Str(saldo, 9, ;
               2), Str(wwfecvto - fechavto, 5), mpconoff
         endif
         wwsubtot:= wwsubtot + saldo
         filas:= 1 + filas
         skip 
         if (comoemit == 1)
            if (nro_client != refclien .AND. porpag = 1)
               exit
            endif
         elseif (fechavto != refecha .AND. porpag = 1)
            exit
         endif
      enddo
      if (EOF() .OR. porpag = 1)
         if (comoemit == 1)
            ? ;
               "                                                      ÄÄÄÄÄÄÄÄÄÄ"
            ? ;
               "                                                    ", ;
               Str(wwsubtot, 10, 2)
            ? "       ", Replicate("Í", 70)
            if (porpag != 1)
               wwtotal:= wwtotal + wwsubtot
               ? ;
                  "                               TOTAL GENERAL       ", ;
                  Str(wwtotal, 11, 2)
               ? "       ", Replicate("Í", 70)
            endif
         else
            ? mpconon, ;
               "                                                                                                   ÄÄÄÄÄÄÄÄÄÄ", ;
               mpconoff
            ? mpconon, ;
               "                                                                                                  ", ;
               Str(wwsubtot, 10, 2), mpconoff
            ? "       ", Replicate("Í", 70)
            if (porpag != 1)
               wwtotal:= wwtotal + wwsubtot
               ? mpconon, ;
                  "                                                                            TOTAL GENERAL        ", ;
                  Str(wwtotal, 11, 2), mpconoff
               ? "       ", Replicate("Í", 70)
            endif
         endif
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
   select 3
   close
   select 1
   return

********************************
procedure FUN_14_7

   set color to N/W
   jcbox(10, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Listado de saldos")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   opbassha("BASE018")
   goto bottom
   wwfecvto:= Date()
   goto top
   condicion1:= ""
   wwrespue1:= 0
   wwcartel1:= ""
   wwcartel2:= ""
   close
   set color to N/W
   @ 12,  1 say ;
      " Fecha ref. :                   (fecha de referencia para saldos)             "
   @ 13,  1 say ;
      "                                                                              "
   @ 14,  1 say ;
      " Cliente    :                                                                 "
   @ 15,  1 say ;
      "                                                                              "
   @ 16,  1 say ;
      " Saldo 0    :                   (indicar si incluye los saldos en cero)       "
   @ 17,  1 say ;
      "                                                                              "
   set color to N/W,R/W*,,B,B/W
   save screen to pctacte
   do while (.T.)
      restore screen from pctacte
      @ 12, 15 get wwFecVto
      read
      if (LastKey() == K_ESC)
         alert("Consulta cancelada...")
         exit
      endif
      condicionf:= "fechavto>wwFecVto"
      save screen to pctacte1
      wwrespue1:= todosselec(14, 15)
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
      restore screen from pctacte1
      if (wwrespue1 == 2)
         opbassha("BASE009", "BASE009B")
         yy:= LastRec()
         private selecciona[yy]
         private seleccionb[yy, 2]
         wwquecarte:= ""
         wwquereg:= 0
         queselec("empresa", "nro_client", "nro_client")
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
         restore screen from pctacte1
      endif
      @ 14, 15 say wwcartel1
      save screen to pctacte1
      if (wwrespue1 == 3)
         opbassha("BASE009", "BASE009A")
         goto bottom
         hastacod:= nro_client
         goto top
         desdecod:= nro_client
         @ 14, 15 say "desde cod: 99999 hasta cod: 99999"
         @ 14, 26 get desdecod picture "99999"
         @ 14, 43 get hastacod picture "99999" valid hastacod > 0 ;
            .AND. hastacod >= desdecod
         read
         if (LastKey() == K_ESC)
            alert("No seleccion¢ registros")
            loop
         endif
         save screen to pctacte1
         condicion1:= "nro_client>=" + Str(desdecod, 5) + ;
            " .and. nro_client<=" + Str(hastacod, 5)
      endif
      set wrap on
      saldocer:= 0
      wwx:= 16
      wwy:= 15
      @ wwx, wwy say "ÄÂÄ"
      @ wwx + 1, wwy say " ÀÄ"
      wwopc:= 1
      do while (wwopc != 0)
         @ wwx, wwy + 3 prompt "S¡"
         @ wwx + 1, wwy + 3 prompt "No"
         menu to wwopc
         if (wwopc = 1)
            wwcartel2:= "S¡"
            exit
         elseif (wwopc = 2)
            wwcartel2:= "No"
            exit
         endif
      enddo
      if (LastKey() == K_ESC)
         alert("No seleccion¢ registros")
         loop
      endif
      saldocer:= wwopc
      restore screen from pctacte1
      @ 16, 15 say wwcartel2
      save screen to pctacte1
      resp:= " "
      confirm0(19, 30)
      restore screen from pctacte1
      if (resp = "S")
         nimpf:= 0
         wwdonimp:= dondeimpri(1)
         if (wwdonimp == 0)
            loop
         endif
         mensaje("Elaborando informe...", 28)
         opbasexc("BASE018")
         index on str(nro_client,5)+str(year(fechavto), ;
            4)+str(month(fechavto),2)+str(day(fechavto),2)+nro_compr ;
            to resumenD
         goto top
         refclien:= 0
         rsaldo:= 0
         do while (!EOF())
            if (nro_client != refclien)
               refclien:= nro_client
               rsaldo:= 0
            endif
            rsaldo:= rsaldo - debito + credito
            replace saldo with rsaldo
            skip 
         enddo
         if (wwrespue1 == 1)
            opbasexc("Resumen")
            zap
            append from BASE018 all
            condicion1:= "nro_client>0"
         else
            opbasexc("Resumen")
            zap
            append from BASE018 for &condicion1
         endif
         goto top
         if (!EOF())
            DBEval({|| dbDelete()}, &("{||" + condicionf + "}"), ;
               Nil, Nil, Nil, .F.)
            pack
         endif
         opbasexc("BASE018")
         DBEval({|| field->saldo:= 0}, Nil, Nil, Nil, Nil, .F.)
         opbasexc("RESUMEN")
         goto top
         if (EOF())
            close
            alert("No existen registros que cumplan la condici¢n.")
            loop
         endif
         index on str(nro_client,5)+str(year(fechavto), ;
            4)+str(month(fechavto),2)+str(day(fechavto),2)+nro_compr ;
            to resumenE
         wwdd:= LastRec()
         select 2
         opbasexc("BASE009", "BASE009A")
         DBEval({|| field->wsaldo:= 0}, Nil, Nil, Nil, Nil, .F.)
         select 1
         goto top
         refclien:= nro_client
         rsaldo:= 0
         do while (.T.)
            if (nro_client != refclien .OR. EOF())
               select 2
               seek refclien
               if (Found())
                  replace wsaldo with rsaldo
               else
                  alert("No encontre al cliente " + Str(refclien, 5))
               endif
               select 1
               if (EOF())
                  exit
               endif
               refclien:= nro_client
               rsaldo:= 0
            endif
            rsaldo:= saldo
            skip 
         enddo
         close databases
         select 1
         if (wwdonimp = 1)
            panresum2()
         elseif (wwdonimp = 2)
            if (nimpf > 0)
               fisresum()
            endif
         elseif (wwdonimp > 2)
            impresum2()
         endif
         restore screen from pctacte1
      endif
      exit
   enddo
   close databases
   select 1
   return

********************************
procedure PANRESUM2

   select 2
   opbasexc("PANTALLA")
   zap
   select 1
   opbassha("BASE009", "BASE009B")
   copy to saldoscl for &condicion1
   opbassha("SALDOSCL")
   goto top
   desdereg:= RecNo()
   refclien:= 0
   wwtotal:= 0
   do while (.T.)
      lin:= "                    LISTADO DE SALDOS   (negativo=debe)"
      llenepanta()
      lin:= "                    FECHA DE REFERENCIA: " + ;
         DToC(wwfecvto)
      llenepanta()
      lin:= Replicate("Í", 78)
      llenepanta()
      lin:= "        CODIG     CLIENTE                       SALDO  "
      llenepanta()
      lin:= Replicate("Ä", 78)
      llenepanta()
      filas:= 1
      locate for RecNo() = desdereg
      do while (!EOF())
         if (saldocer = 2 .AND. wsaldo = 0)
         else
            lin:= "        " + Str(nro_client, 5) + " " + empresa + ;
               " " + Str(wsaldo, 10, 2)
            wwtotal:= wwtotal + wsaldo
            llenepanta()
         endif
         skip 
      enddo
      if (EOF())
         lin:= Replicate("Ä", 78)
         llenepanta()
         lin:= "                  SALDO GENERAL             " + ;
            Str(wwtotal, 11, 2)
         llenepanta()
         lin:= Replicate("Í", 78)
         llenepanta()
      endif
      if (EOF())
         exit
      endif
   enddo
   select 2
   goto top
   private aprov[1]
   private tit1[1]
   aprov:= {"lineas"}
   tit1:= {"                                        "}
   set color to N/W
   jcbox(1, 0, 23, 79, "N/W", 20, 1, .F., .F., .F., "W+/B", ;
      "Listado de Saldos")
   set color to N/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   dbedit(2, 1, 22, 78, aprov, "funprov3", .T., tit1)
   close
   select 1
   return

********************************
procedure IMPRESUM2

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
   select 1
   opbassha("BASE009", "BASE009B")
   copy to saldoscl for &condicion1
   opbassha("SALDOSCL")
   goto top
   desdereg:= RecNo()
   refclien:= 0
   wwtotal:= 0
   do while (.T.)
      ? mpconoff, "      ", Space(35), "   ", "    ", Date(), ;
         "     Pag.", Str(pag, 4, 0)
      ? "       ", titulon, titular, tituloff
      ? 
      ? "       ", titulon, "LISTADO DE SALDOS", tituloff
      ? "       ", "  FECHA DE REFERENCIA:", DToC(wwfecvto)
      ? "       ", Replicate("Í", 70)
      ? "        CODIG     CLIENTE                       SALDO  "
      ? "       ", Replicate("Ä", 70)
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas <= 55)
         if (saldocer = 2 .AND. wsaldo = 0)
         else
            ? "       ", Str(nro_client, 5), empresa, Str(wsaldo, ;
               10, 2)
            wwtotal:= wwtotal + wsaldo
            filas:= 1 + filas
         endif
         skip 
         if (EOF())
            exit
         endif
      enddo
      if (EOF())
         ? "       ", Replicate("Ä", 70)
         ? "                  SALDO GENERAL            ", ;
            Str(wwtotal, 11, 2)
         ? "       ", Replicate("Í", 70)
      else
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

* EOF

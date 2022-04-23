#include "pfiscal.ch"
#define PF_DEBUG

***********    Funciones para libreria EPSON
function PF_PuertoInit ( PuertoNro, PuertoIO, PuertoIRQ )
* Funci¢n   : Inicializa y abre el puerto serie para la impresora
private ComOK
private Continuar
private iret
* Carga Variable publica
PF_PuertoNro = PuertoNro
Continuar = .T.
* Setea la direccion de memoria del puerto
if .not. COM_SETIO( PF_PuertoNro, PuertoIO )
   iret = alert( "Imposible inicializar posici¢n de memoria puerto com"+ltrim(str(PF_PuertoNro)) )
   continuar =.F.
endif
if continuar
    * Setea la interrupcion del puerto
    if .not. COM_SETIRQ(PF_PuertoNro, PuertoIRQ )
       iret = alert( "Imposible inicializar IRQ puerto com"+ltrim(str(pf_PuertoNro)) )
       continuar =.F.
    endif
endif
if continuar
    * El COM_OPEN debe configurarse con Buffer de salida porque el Handshake por
    * Hardware requiere comunicacion en background
    if .not. COM_OPEN(PF_PuertoNro, 1024, 1024)
       iret = alert( "Imposible abrir puerto com"+ltrim(str(PF_PuertoNro)) )
       continuar =.F.
    endif
endif
if continuar
    * El comando COM_HARD activa el Handshake por Hardware
    COM_HARD(PF_PuertoNro,.T.,.T.)
endif
if continuar
    * Inicializa parametros de configuraci¢n de com
    if .not. COM_INIT(PF_PuertoNro,9600,"N",8,1)
       iret = alert( "Imposible configurar el puerto com"+ltrim(str(PF_PuertoNro)) )
       continuar =.F.
    endif
endif
return continuar

Function  PF_PuertoCierra
* Funcion   : Cierra el puerto utilizado por la impresora
COM_CLOSE( PF_PuertoNro)
return nil

function PF_AgregaCampoSalida ( dato )
* Funci¢n   : Agrega un campo a el array de datos a enviar del comando
* Entrada   : dato ( string a agregar )
* Salida    : True Ejecuci¢n correcta
LOCAL nro
LOCAL iRet
nro = ascan(PF_DatoaEnviar,NIL)
if nro = 0
   iret = alert( "Error intento enviar mas de 25 par metros" )
   iRet = .F.
else
   PF_DatoaEnviar[ nro ] = dato
   iRet = .T.
endif
return iRet

function PF_ControlaCRC ( )
* Funcion   : Lee los Ultimos 4 Bytes del buffer para chequear el CRC
* Entrada   : Ninguna
* Respuesta :
*             true  ==> En gDatoRecibido, VARIABLE GLOBAL QUEDA EL COMANDO
*             false ==> NO Encontrado. No llego o un Time out o error
STATIC EnviadoPrimerPaquete :=.F.    // FLAG Importante, indica si es
                                     // primer paquete enviado
LOCAL Continuar
LOCAL CRCDatoRecibido
LOCAL CantBytesCRC
LOCAL TInicio
LOCAL LapTime
LOCAL AscEntrada
LOCAL iret
LOCAL crc
LOCAL nada
*  Flag para saber si hay error ***
   continuar = .T.
*  Contador para saber si Llegaron los 4 Bytes del CRC ***
   CantBytesCRC = 0
*  El CRC lo voy a calcular ahora, por lo tanto lo pongo a CERO
   CRCDatoRecibido = ""
*  asigno a LapTime el PF_TIEMPOMAXIMO de segundos y cargo el tiempo de inicio
   LapTime = PF_TIEMPOMAXIMO
   TInicio =  seconds()
   do while ( CantBytesCRC < 4 ) .and.;
            ( mod( seconds() + 86400.1 - TInicio, 86400 ) <= LapTime ).and.;
            ( continuar = .T. )
*      veo si llego algo ***
       do while COM_COUNT(PF_PuertoNro) = 0 .and.;
                ( mod( seconds() + 86400.1 - TInicio, 86400 ) <= LapTime)
       enddo
       * veo si no Leyo algo
       if COM_COUNT(PF_PuertoNro) = 0
           continuar = .F.  // tengo un time out
           iret = .F.
           CarEntrada = ""
       else
           CarEntrada = COM_READ( PF_PuertoNro, 1 )
       endif
       do case
          case CarEntrada = PF_ETX
             * Encontre un ETX ==> Hay error ***
               iret = .F.
             * Para salir loop ***
               Continuar = .F.
          case CarEntrada = PF_TIEMPO
                * si el comando consume mucho tiempo
                LapTime = LapTime + 1.1
          otherwise
                CRCDatoRecibido = CRCDatoRecibido + CarEntrada
                CantBytesCRC = CantBytesCRC + 1

        endcase
   enddo
*  Si sali hasta aqui, controlo el CRC ***
   if Continuar
*  El string Ingresado lo tengo en una Variable GLOBAL ***
      if len(PF_StringRecibido) < 3
         iret = alert(" string muy corto ")
         continuar = .F.
         iret = .F.
      else
         crc = alltrim(ntoc( asciisum( PF_StringRecibido + PF_STX + PF_ETX) ,16 ))  // Funcion CTOOLS convierte a base 16
         crc = right("0000" + crc, 4 )
         if crc = CRCDatoRecibido
           *? "CRC Ok"
            Iret = .T.
         else
           *? "CRC Mal"
            continuar = .F.
            iret = .F.
         endif
      endif
   endif
*  veo si los numeros de paquetes son los correctos ***
   if Continuar
      if substr(PF_StringEnviado, 2, 1) <> substr(PF_StringRecibido, 1, 1)
       * tengo error en el numero de paquete ***
         iret = .F.
       * para salir loop ***
         continuar = .F.
#ifdef PF_DEBUG
         ?"Nro paquete enviado " +str(asc(substr(PF_stringEnviado,2,1)),3,0) +;
          "Nro paquete recibido " +str(asc(substr(PF_stringRecibido,1,1)),3,0)
         ?PF_StringEnviado
         ?PF_StringRecibido
         wait
#endif
      endif
   endif
*  veo si los numeros de Comando son los correctos ***
   if Continuar
      if substr(PF_StringEnviado, 3, 1) <> substr(PF_StringRecibido, 2, 1)
       * tengo error en el numero de Comando ***
         if EnviadoPrimerPaquete = .F.
            * Incremento el Nro de paquete para retransmitir el comando, solo
            * si es el primer paquete a enviar
              nada = PF_NroPaquete( "P" )
         endif
       * Indico que se debe retransmitir el comando
         iret = .F.
       * para salir loop ***
         continuar = .F.
#ifdef PF_DEBUG
         ?"Nro Comando mal"
         wait
#endif
      endif
   endif
   if Continuar = .T. .and. iret = .T.
      nada = PF_NroPaquete( "P" )
      *Indico que ya se envio el primer paquete
      EnviadoPrimerPaquete = .T.
   else
      PF_StringRecibido = ""
   endif
return iret


function PF_CRC ( entrada )
* Funcion   : Calcula el CRC para el comando a enviar
* Entrada   : Cadena de caracteres a enviar al impresor
* Respuesta :
*             CRC , si la cadena es v lida
*             ""  , si la cadena es inv lida
LOCAL Continuar
LOCAL iret
LOCAL crc
continuar = .T.
if len( entrada ) < 3
   iret = alert("Cadena muy corta en PF_CRC")
   Continuar = .F.
endif
if continuar
   crc = alltrim(ntoc( asciisum( entrada ), 16 ))  // Funcion CTOOLS convierte a base 16
   crc = right("0000" + crc, 4 )
else
   crc = ""
endif
return crc

function PF_EnviarComando( Comando )
* Funci¢n   : Env¡a un comando a la impresora Fiscal
* Entrada:
*             comando= n£mero del comando que se ejecutara
* Respuesta :
*             true  ==> OK
*             false ==> Problemas
LOCAL CantErrores
LOCAL Continuar
LOCAL ErrorProtocolo
LOCAL ErrorCom
LOCAL resultado
*  pongo contador de errores a cero ***
   CantErrores = 0
*  pongo condiciones iniciales ***
   Continuar = .F.
   ErrorProtocolo = .T.
   ErrorCom = .T.
do while ( CantErrores < 4 ) .and.;
         ((ErrorCom = .T.) .or. (ErrorProtocolo = .T.)) .and.;
         ( Continuar = .F.)
    resultado = PF_EnviaString( Comando )
    do case
       case resultado = .T.            // ==> encontrado
            ErrorCom = .F.             // no hay error en com
            ErrorProtocolo = .F.       // no se debe retransmitir
            Continuar = .T.            // procesar siguiente etapa
#ifdef PF_DEBUG
            ?"Comando Enviado"
#endif
       case resultado = .F.            // ==> no encontrado. no llego o un time out
            ErrorCom = .T.             // hay problemas con la comunicaci'on. es un time out
            ErrorProtocolo = .F.       // no hay error en protocolo , es un time out
            Continuar = .F.            // no procesar siguiente etapa
#ifdef PF_DEBUG
            ?"Comando NO Enviado"
            wait
#endif
    endcase
    if continuar = .T.
        resultado = PF_InicioPaquete()
        do case
           case resultado = .T.            // ==> encontrado
                ErrorCom = .F.             // no hay error en com
                ErrorProtocolo = .F.       // no se debe retransmitir
                Continuar = .T.            // procesar siguiente etapa
#ifdef PF_DEBUG
                ?"Inicio paquete recibido"
#endif
           case resultado = .F.            // ==> no encontrado. no llego o un time out
                ErrorCom = .T.             // hay problemas con la comunicaci'on. es un time out
                ErrorProtocolo = .F.       // no hay error en protocolo , es un time out
                Continuar = .F.            // no procesar siguiente etapa
#ifdef PF_DEBUG
                ?"Inicio paquete NO recibido"
                wait
#endif
           case resultado = asc( PF_NAK )  // ==> la impresora fiscal informa error de recepcion
                ErrorCom = .F.             // la comunicacion se realizo
                ErrorProtocolo = .T.       // hay error en protocolo, se debe retransmitir
                Continuar = .F.            // no procesar siguiente etapa
        endcase
    endif
    if continuar = .T.
        resultado = PF_FinPaquete()
        * analizo la salida de encontrar el etx ***
        do case
           case resultado = .T.            // ==> encontrado
                ErrorCom = .F.             // no hay error en com
                ErrorProtocolo = .F.       // no se debe retransmitir
                Continuar = .T.            // procesar siguiente etapa
#ifdef PF_DEBUG
                ?"Fin paquete recibido"
#endif
           case resultado = .F.            // ==> no encontrado. no llego o un time out
                ErrorCom = .T.             // hay problemas con la comunicaci'on. es un time out
                ErrorProtocolo = .F.       // no hay error en protocolo , es un time out
                Continuar = .F.            // no procesar siguiente etapa
#ifdef PF_DEBUG
                ?"Fin paquete NO recibido"
                wait
#endif
           case resultado = asc( PF_NAK )  // ==> la impresora fiscal informa error de recepcion
                ErrorCom = .F.             // la comunicacion se realizo
                ErrorProtocolo = .T.       // hay error en protocolo, se debe retransmitir
                Continuar = .F.            // no procesar siguiente etapa
        endcase
    endif
    if continuar = .T.
        resultado = PF_ControlaCRC()
        * analizo la salida luego de levantar el crc ***
        do case
           case resultado = .T.            // ==> encontrado
                ErrorCom = .F.             // no hay error en com
                ErrorProtocolo = .F.       // no se debe retransmitir
                Continuar = .T.            // procesar siguiente etapa
           case resultado = .F.            // ==> no encontrado. no llego o un time out
                ErrorCom = .T.             // hay problemas con la comunicaci'on. es un time out
                ErrorProtocolo = .F.       // no hay error en protocolo , es un time out
                Continuar = .F.            // no procesar siguiente etapa
           case resultado = asc( PF_NAK )  // ==> la impresora fiscal informa error de recepcion
                ErrorCom = .F.             // la comunicacion se realizo
                ErrorProtocolo = .T.       // hay error en protocolo, se debe retransmitir
                Continuar = .F.            // no procesar siguiente etapa
        endcase
    endif

*   si hay error, reintento
    if ErrorProtocolo = .T. .or. ErrorCom = .T.
       CantErrores = CantErrores + 1
    endif
enddo
*  Desglosa los campos recibidos en el PF_DatosRecibidos[]
   do PF_LeeCamposRecibidos
*  Controla si el comando de la impresora fue correctamante ejecutado
   Continuar = PF_ComandoOK()
return Continuar

function PF_ComandoOK(Comando )
* Funcion   : Controla la ejecuci¢n correcta del comando
* Entrada:
*             comando= numero del comando que se ejecuta
* Respuesta :
*             true  ==> OK
*             false ==> Problemas
LOCAL StatusPrint
LOCAL StatusFiscal
LOCAL Continuar
StatusPrint  = PF_DatoRecibido[1]
StatusFiscal = PF_DatoRecibido[2]
if StatusPrint = NIL .or. StatusFiscal = NIL
   Continuar = .F.
else
   Continuar = .T.
endif
* ATENCION : La funci¢n ISBIT() de las CATOOLS testea los bit desde 1 a 16.
* En la documentaci¢n de la impresora los bits se indican de 0 a 15, de modo
* que para controlar el bit 0 debo preguntar por el 1, hasta el 15 por el 16
if continuar
* si estan en 1 los bits 9 y 16 corresponde a un impresor que
* esta por llenarse de cierres z y si no tiene ningun otro
* error se puede continuar
   if isbit(StatusFiscal, 9) .and. isbit(StatusFiscal, 16) //Memoria fiscal por llenarse
      if isbit(StatusFiscal, 12 ).or.;                     //Requiere cierre Z
         isbit(StatusFiscal, 8 ).or.;                      //Memoria fiscal llena
         isbit(StatusFiscal, 4 ).or.;                      //Comando no reconocido
         isbit(StatusFiscal, 2 ).or.;                      //Error memoria de trabajo
         isbit(StatusFiscal, 1 )                           //Error memoria fiscal
              continuar = .F.
      endif
   else
      if isbit(StatusFiscal, 16 ).or.;                     //Bit indicador de errores
         isbit(StatusFiscal, 12 ).or.;                     //Requiere cierre Z
         isbit(StatusFiscal, 8 ).or.;                      //Memoria fiscal llena
         isbit(StatusFiscal, 4 ).or.;                      //Comando no reconocido
         isbit(StatusFiscal, 2 ).or.;                      //Error memoria de trabajo
         isbit(StatusFiscal, 1 )                           //Error memoria fiscal
              continuar = .F.
      endif
   endif
end if
if continuar
* si la placa fiscal esta ok controlo el estado de la impresora
   if isbit(StatusPrint, 15 ).or.;            //Impresora sin papel
      isbit(StatusPrint, 7 ).or.;             //Buffer impresora lleno
      isbit(StatusPrint, 4 ).or.;             //Impresora fuera de linea
      isbit(StatusPrint, 3 )                  //Error en impresora
           continuar = .F.
   endif
endif
return continuar

function PF_MensajeEstado( opcion )
* Funci¢n   : Devuelve un string con el detalle del estado fiscal y de la impresora
* Entrada:
*             opcion = 1 estado de la impresora
*                      2 estado fiscal
* Respuesta :
*             String con el detalle del estado
LOCAL mensaje
if opcion = 1
   if PF_DatoRecibido[1] = NIL
      mensaje = "Ultimo comando no se ejecut¢ correctamente"
   else
      mensaje = "Estado de la impresora " + PF_DatoRecibido[1] + chr(13) + chr(10)
      if isbit(PF_DatoRecibido[1], 1)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  1 " + "Impresora Ocupada"
      endif
      if isbit(PF_DatoRecibido[1], 2)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  2 " + "Impresora Seleccionada"
      endif
      if isbit(PF_DatoRecibido[1], 3)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  3 " + "Error en la Impresora"
      endif
      if isbit(PF_DatoRecibido[1], 4)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  4 " + "Impresora Fuera de L¡nea"
      endif
      if isbit(PF_DatoRecibido[1], 5)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  5 " + "Poco papel auditor¡a"
      endif
      if isbit(PF_DatoRecibido[1], 6)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  6 " + "Poco papel"
      endif
      if isbit(PF_DatoRecibido[1], 7)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  7 " + "Buffer impresora lleno"
      endif
      if isbit(PF_DatoRecibido[1], 8)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  8 " + "Buffer impresora vacio"
      endif
      if isbit(PF_DatoRecibido[1], 9)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  9 " + "Sin uso"
      endif
      if isbit(PF_DatoRecibido[1], 10)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 10 " + "Sin uso"
      endif
      if isbit(PF_DatoRecibido[1], 11)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 11 " + "Sin uso"
      endif
      if isbit(PF_DatoRecibido[1], 12)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 12 " + "Sin uso"
      endif
      if isbit(PF_DatoRecibido[1], 13)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 13 " + "Caj¢n de Dinero Abierto"
      endif
      if isbit(PF_DatoRecibido[1], 14)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 14 " + "Sin uso"
      endif
      if isbit(PF_DatoRecibido[1], 15)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 15 " + "Impresora sin Papel"
      endif
      if isbit(PF_DatoRecibido[1], 16)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 16 " + "L¢gica OR Bits 0-6 "
      endif
   endif
elseif opcion = 2
   if PF_DatoRecibido[2] = NIL
      mensaje = "Ultimo comando no se ejecut¢ correctamente"
   else
      mensaje = "Estado Fiscal " + PF_DatoRecibido[2] + chr(13) + chr(10)
      if isbit(PF_DatoRecibido[2], 1)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  1 " + "Checkeo de Memoria Fiscal !MAL!"
      endif
      if isbit(PF_DatoRecibido[2], 2)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  2 " + "Checkeo RAM de Trabajo !MAL!"
      endif
      if isbit(PF_DatoRecibido[2], 3)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  3 " + "Bater¡a BAJA "
      endif
      if isbit(PF_DatoRecibido[2], 4)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  4 " + "Comando NO Reconocido "
      endif
      if isbit(PF_DatoRecibido[2], 5)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  5 " + "Campo de Datos INVALIDO "
      endif
      if isbit(PF_DatoRecibido[2], 6)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  6 " + "Comando Inv lido para el Estado L¢gico del Equipo"
      endif
      if isbit(PF_DatoRecibido[2], 7)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  7 " + "Se va a producir el OVERFLOW en los Acumuladores del equipo"
      endif
      if isbit(PF_DatoRecibido[2], 8)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  8 " + "La memoria Fiscal esta LLENA "
      endif
      if isbit(PF_DatoRecibido[2], 9)
         mensaje = mensaje + chr(13) + chr(10) + "Bit  9 " + "La memoria fiscal se esta por LLENAR"
      endif
      if isbit(PF_DatoRecibido[2], 10)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 10 " + "El Impresor tiene N£mero de Serie(Certificado)"
      endif
      if isbit(PF_DatoRecibido[2], 11)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 11 " + "El controlador Fiscal esta Fiscalizado"
      endif
      if isbit(PF_DatoRecibido[2], 12)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 12 " + "Se llego al M ximo de Items o se requiere un cierre del d¡a"
      endif
      if isbit(PF_DatoRecibido[2], 13)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 13 " + "Documento Fiscal Abierto"
      endif
      if isbit(PF_DatoRecibido[2], 14)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 14 " + "Documento Abierto "
      endif
      if isbit(PF_DatoRecibido[2], 15)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 15 " + "Factura abierta, Hoja Suelta"
      endif
      if isbit(PF_DatoRecibido[2], 16)
         mensaje = mensaje + chr(13) + chr(10) + "Bit 16 " + "OR de bits 0-8 da 1 "
      endif
   endif
else
   mensaje = "Debe informar opcion 1 = Impresora o 2 = Fiscal"
endif
return mensaje

function PF_EnviaString( Comando )
* Funcion   : Envia un string a la impresora Fiscal
* Entrada:
*             comando= numero del comando que se ejecuta
* Respuesta :
*             true  ==> OK
*             false ==> Problemas
LOCAL datoout
LOCAL chk
LOCAL Continuar
    Continuar = .T.
    * controlo valor del comando ****
    if comando > 128
       iret = Alert( "Valor de comando muy grande" )
       continuar = .F.
    endif
    if continuar = .T.
        * Arma el string a enviar
        datoout = PF_STX + chr(PF_NroPaquete("U")) + chr(comando)
        i = 1
        do while PF_DatoaEnviar[ i ] <> NIL
            datoout = datoout + PF_TAB + PF_DatoaEnviar[ i ]
            i = i + 1
        enddo
        datoout = datoout + PF_ETX
        chk = PF_CRC(datoout)
        datoout = datoout + chk
        * en PF_StringEnviado se almacena el ultimo dato enviado
        PF_StringEnviado = datoout
        tinicio = seconds()
        do while !COM_CTS(PF_PuertoNro) .and. mod (seconds() - tinicio +86400.1, 86400) < .1
        enddo
        *Envia comando, cRest tiene la cantidad de caracteres pendientes de envio
        cRest = COM_SEND( PF_PuertoNro, datoout )
        *Si queda algo se termina de enviar el comando, con un timeout de 10 segundos
        tinicio = seconds()
        do while cRest > 0
           datoout = right( datoout, cRest )
           cRest = COM_SEND( PF_PuertoNro, datoout )
           if mod (seconds() - tinicio + 86400.1, 86400) > PF_TIEMPOMAXIMO
              iret = alert( "ERROR DE TIME OUT (ENVIO)" )
              continuar = .F.
           endif
        enddo
        * Con COM_SCOUNT se chequea cuando se termino de enviar todo del buffer de
        * salida, para luego leer las respuestas, usa timeout de 1 seg
        tinicio = seconds()
        do while COM_SCOUNT(PF_PuertoNro) > 0 .and. mod (seconds() - tinicio +86400.1, 86400) < .8
        enddo
        if mod (seconds() - tinicio+86400.1 ,86400) > 1
           continuar = alert("ERROR TIME OUT (Vaciar Salida)")
           continuar = .T.
        endif
    endif
return Continuar

function PF_InicioPaquete
* Funcion   : Espera por el principio de un paquete
*             true  ==> encontrado
*             false ==> no encontrado no llego o un time out
*             nak   ==> la impresora fiscal informa error de recepcion
LOCAL Continuar
LOCAL STXencontrado
LOCAL TInicio
LOCAL LapTime
LOCAL AscEntrada
LOCAL CarEntrada
LOCAL iret
*   si voy a recibir un paquete, borro el ultimo recibido
    PF_StringRecibido = ""
*   flag para saber si hay error ***
    continuar = .T.
*   flag para saber si encontre un stx ***
    STXecontrado = .F.
    iret = .F.
*   asigno a LapTime el PF_TIEMPOMAXIMO de segundos y cargo el tiempo de inicio
    LapTime = PF_TIEMPOMAXIMO
    TInicio =  seconds()
    do while ( STXecontrado = .F.) .and.;
             ( mod( seconds() + 86400.1 - TInicio, 86400 ) <= LapTime ).and.;
             ( continuar = .T. )
*       veo si llego algo ***
        do while COM_COUNT(PF_PuertoNro) = 0 .and.;
                 ( mod( seconds() + 86400.1 - TInicio, 86400 ) <= LapTime)
        enddo
        * veo si no Leyo algo
        if COM_COUNT(PF_PuertoNro) = 0
            continuar = .F.  // tengo un time out
            iret = .F.
            CarEntrada = ""
#ifdef PF_DEBUG
            ?"Time out STX"
            wait
#endif
        else
            CarEntrada = COM_READ( PF_PuertoNro, 1 )
        endif
        if continuar
            * analizo el byte que entro
            do case
            case CarEntrada = PF_NAK
                  * encontre un nak ==> hay error ***
                  iret = .F.
                  * para salir loop ***
                  STXecontrado = .T.
#ifdef PF_DEBUG
                  ?"Inicio con NAK"
                  wait
#endif
            case CarEntrada = PF_STX
                  * encontre el stx ***
                  iret = .T.
                  * para salir loop ***
                  STXecontrado = .T.
            case CarEntrada = PF_TIEMPO
                  * si el comando consume mucho tiempo
                  LapTime = LapTime + 1.1
            otherwise
#ifdef PF_DEBUG
                  ?"Inicio con "+str(asc(carentrada))
                  wait
#endif
                  * si llega basura, limpio el buffer
                  do PF_LimpiarBufferCom
                  * incremento tiempo para no tener falso timeout
                  LapTime = LapTime + 1.1
            endcase
        endif
    enddo
return iret

function PF_FinPaquete
* Funcion   : Espera por el FIN de un paquete
* Respuesta :
*             true  ==> encontrado
*             false ==> no encontrado no llego o un time out
*             nak   ==> la impresora fiscal informa error de recepcion
LOCAL Continuar
LOCAL ETXencontrado
LOCAL TInicio
LOCAL LapTime
LOCAL CarEntrada
LOCAL AscEntrada
LOCAL iret
*   flag para saber si hay error ***
    continuar = .T.
*   flag para saber si encontre un stx ***
    ETXecontrado = .F.
    iret = .F.
*   asigno a LapTime el PF_TIEMPOMAXIMO de segundos y cargo el tiempo de inicio
    LapTime = PF_TIEMPOMAXIMO
    TInicio =  seconds()

    do while ( ETXecontrado = .F.) .and.;
             ( mod( seconds() + 86400.1 - TInicio, 86400 ) <= LapTime ) .and.;
             ( continuar = .T. )
*       veo si llego algo ***
        do while COM_COUNT(PF_PuertoNro) = 0 .and.;
                 ( mod( seconds() + 86400.1 - TInicio, 86400 ) <= LapTime)
        enddo
        * veo si no Leyo algo
        if COM_COUNT(PF_PuertoNro) = 0
            continuar = .F.  // tengo un time out
            iret = .F.
            CarEntrada = ""
#ifdef PF_DEBUG
            ?"Time out ETX"
            wait
#endif
        else
            CarEntrada = COM_READ( PF_PuertoNro, 1 )
        endif
        * analizo la informacion que entro
        do case
        case CarEntrada = PF_NAK .or. CarEntrada = PF_STX
             * encontre un nak ==> hay error ***
             iret = .F.
             * para salir loop ***
             STXecontrado = .T.
             PF_StringRecibido = ""
#ifdef PF_DEBUG
             if CarEntrada = PF_NAK
                ?"EsperaFinal NAK"
                wait
             endif
#endif
        case CarEntrada = PF_ETX
             * Encontre el STX ***
             iret = .T.
             * Para salir loop ***
             ETXecontrado = .T.
        case CarEntrada = PF_TIEMPO
             * Si el Comando consume mucho tiempo
             LapTime = LapTime + 1.1
        otherwise
             PF_StringRecibido = PF_StringRecibido + CarEntrada
        endcase
    enddo
return iret

function SelectSlip
Private Continuar
do PF_IniciarSalida
nada = PF_AgregaCampoSalida("P")
nada = PF_AgregaCampoSalida("D")
nada = PF_AgregaCampoSalida("S")
nada = PF_AgregaCampoSalida("O")
* El comando PF_AgregaCampoSalida da error si se sobrepasan los 20 elementos
if PF_EnviarComando( PF_SetPrefer )
   Continuar = .T.
   ? "SLIP seleccionado"
else
   Continuar = .F.
   ? PF_MensajeEstado( PF_ModuloImpresor )
   ? PF_MensajeEstado( PF_ModuloFiscal )
   * La aplicaci¢n aca debe analizar por que se produjo el error del comando
   * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
endif
return Continuar

function PrepareSlip
* Prepara la estaci¢n de trabajo SLIP para recibir la hoja
Private Continuar
do PF_IniciarSalida
nada = PF_AgregaCampoSalida("D")
nada = PF_AgregaCampoSalida("P")
nada = PF_AgregaCampoSalida("P")
nada = PF_AgregaCampoSalida("U")
nada = PF_AgregaCampoSalida("O")
* El comando PF_AgregaCampoSalida da error si se sobrepasan los 20 elementos
if PF_EnviarComando( PF_SysCommand )
   Continuar = .T.
   ? "SLIP preparado"
else
   Continuar = .F.
   ? PF_MensajeEstado( PF_ModuloImpresor )
   ? PF_MensajeEstado( PF_ModuloFiscal )
   * La aplicaci¢n aca debe analizar por que se produjo el error del comando
   * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
endif
return Continuar

function SetPaperSize ( Lineas, Columnas )
* Configura el tama¤o de la hoja para SLIP
Private Continuar
do PF_IniciarSalida
nada = PF_AgregaCampoSalida( "P" )
nada = PF_AgregaCampoSalida( "P" )
nada = PF_AgregaCampoSalida( "S" )
nada = PF_AgregaCampoSalida( "U" )
nada = PF_AgregaCampoSalida( alltrim(str(Lineas)) )
nada = PF_AgregaCampoSalida( alltrim(str(Columnas)) )
* El comando PF_AgregaCampoSalida da error si se sobrepasan los 20 elementos
if PF_EnviarComando( PF_SetPrefer )
   Continuar = .T.
   ? "Tama¤o SLIP configurado"
else
   Continuar = .F.
   ? PF_MensajeEstado( PF_ModuloImpresor )
   ? PF_MensajeEstado( PF_ModuloFiscal )
   * La aplicaci¢n aca debe analizar por que se produjo el error del comando
   * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
endif
return Continuar



function OpenSlipNoFiscal
* Abre Documento no fiscal en SLIP
Private Continuar
do PF_IniciarSalida
nada = PF_AgregaCampoSalida( "U" )
nada = PF_AgregaCampoSalida( "O" )
* El comando PF_AgregaCampoSalida da error si se sobrepasan los 20 elementos
if PF_EnviarComando( PF_NFAbre )
   Continuar = .T.
   ? "DNF SLIP Abierto"
else
   Continuar = .F.
   ? PF_MensajeEstado( PF_ModuloImpresor )
   ? PF_MensajeEstado( PF_ModuloFiscal )
   * La aplicaci¢n aca debe analizar por que se produjo el error del comando
   * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
endif
return Continuar

function TextoNoFiscal ( TextoNF )
* Env¡a texto no fiscal
Private Continuar
do PF_IniciarSalida
nada = PF_AgregaCampoSalida( TextoNF )
* El comando PF_AgregaCampoSalida da error si se sobrepasan los 20 elementos
if PF_EnviarComando( PF_NFItem )
   Continuar = .T.
   ? "Envia texto --- " + TextoNF
else
   Continuar = .F.
   ? PF_MensajeEstado( PF_ModuloImpresor )
   ? PF_MensajeEstado( PF_ModuloFiscal )
   * La aplicaci¢n aca debe analizar por que se produjo el error del comando
   * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
endif
return Continuar

function CierraNoFiscal
* Cierra documento no fiscal
Private Continuar
do PF_IniciarSalida
nada = PF_AgregaCampoSalida( "T" )
* El comando PF_AgregaCampoSalida da error si se sobrepasan los 20 elementos
if PF_EnviarComando( PF_NFCerrar )
   Continuar = .T.
   ? "Cierra DNF"
else
   Continuar = .F.
   ? PF_MensajeEstado( PF_ModuloImpresor )
   ? PF_MensajeEstado( PF_ModuloFiscal )
   * La aplicaci¢n aca debe analizar por que se produjo el error del comando
   * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
endif
return Continuar

function PF_Sincronizar
* Funci¢n   : Controla el estado de la impresora y lo restablece
*             de forma de dejarla preparada para generar un nuevo comprobante
*             Se usa en caso de querer cancelar un comprobante abierto
* Entrada   : Nada
* Respuesta :
*             True,  Si se ejecut¢ correctamente
*             False, Si hubo problemas
LOCAL iRet
LOCAL Continuar
LOCAL TipoDocu
LOCAL CerroDocu
STATIC sincroniza :=  .F.
* La variable est tica sincroniza se usa para saber si esta funci¢n fue llamada
* por la ejecuci¢n de un comando o llamado por ella misma, de modo que si esta
* en true sale de la funci¢n sin ejecutarla
if sincroniza = .T.
        return .T.
endif
sincroniza = .T.
do PF_IniciarSalida                 // Inicializa los par metros del comando
iRet = PF_AgregaCampoSalida ("D")   // Env¡a "D" para pedir estado de documento
if PF_EnviarComando( PF_Estado )
        Continuar = .T.
else
        Continuar = .F.
endif
TipoDocu = alltrim(PF_DatoRecibido[ 3 ])   // El parametro 3 contiene el tipo de documento
* tipodocu tendra el tipo de documento abierto
*     T=tique
*     F=factura
*     I=tique-factura
*     O=documento no fiscal,
*     H=documento no fiscal homologado
* si no es ninguno presumo que el equipo es una versi¢n que no soporta
* el estado(D) ni factura o tique-factura
if .not. tipodocu $ "TFIOH"
   tipodocu = "T"
endif
CerroDocu = .F.
if Continuar = .T.
        * Analizo el estado del m¢dulo Fiscal
        StatusFiscal = PF_DatoRecibido[2]
        if isbit(StatusFiscal, 12 ) .or.;    // Se requiere cierre de D¡a
           isbit(StatusFiscal, 13 ) .or.;    // Documento Fiscal
           isbit(StatusFiscal, 14 )          // Documento Abierto
           if isbit(StatusFiscal, 13 ) .or.; // Documento Fiscal
              isbit(StatusFiscal, 14 )       // Documento Abierto
              if TipoDocu = "F" .or. TipoDocu = "I"     //Factura o Tique-Factura
                 do PF_IniciarSalida
                 iRet = PF_AgregaCampoSalida ("CANCELA")  // Env¡a "CANCELA" como 1er param.
                 iRet = PF_AgregaCampoSalida ("00000000") // Env¡a "00000000" como 2do param.
                 iRet = PF_AgregaCampoSalida ("C")        // Env¡a "C" como 3er param.
                 if PF_EnviarComando( PF_FCPago )   // Ejecuta comando de Factura pago opci¢n cancelar
                    Continuar = .T.
                    Cerrodocu = .T.
                 else
                    Continuar = .F.
                 endif
              elseif TipoDocu = "T"  //Tique
                 do PF_IniciarSalida
                 iRet = PF_AgregaCampoSalida ("CANCELA")  // Env¡a "CANCELA" como 1er param.
                 iRet = PF_AgregaCampoSalida ("00000000") // Env¡a "00000000" como 2do param.
                 iRet = PF_AgregaCampoSalida ("C")        // Env¡a "C" como 3er param.
                 if PF_EnviarComando( PF_TQPago )   // Ejecuta comando de Tique pago opci¢n cancelar
                    Continuar = .T.
                    Cerrodocu = .T.
                 else
                    Continuar = .F.
                 endif
              elseif TipoDocu = "O" // Otros NO Fiscal
                 do PF_IniciarSalida
                 iRet = PF_AgregaCampoSalida ("T")  // Env¡a "T" Corte de papel
                 if PF_EnviarComando( PF_NFCerrar ) // Ejecuta comando de Cierre no Fiscal
                    Continuar = .T.
                    Cerrodocu = .T.
                 else
                    Continuar = .F.
                 endif
              endif
           endif
        endif
        if isbit(StatusFiscal, 12 )  // Se requiere cierre de D¡a
           iRet = Alert( "ATENCION, Deber  Ejecutar un cierre Z" )
           Continuar = .F.
        endif
endif
* Variable sincroniza indica con false que termino la funci¢n
sincroniza = .F.
return Continuar

******          Procedures
procedure     PF_LeeCamposRecibidos
* Funcion   : Toma el PF_StringRecibido y lo descompone por campos en PF_DatoRecibido[]
* Entrada   :
LOCAL cant
LOCAL StrAux
LOCAL Pos1
LOCAL Pos2
LOCAL continuar
StrAux = PF_StringRecibido
for cant = 1 to 25
   PF_DatoRecibido[ cant ] = NIL
next
continuar = .T.
cant = 0
*wait "descompone respuesta"
do while continuar
   pos1 = at( PF_TAB, StrAux )
   if pos1 > 0
      StrAux = substr( StrAux, pos1 + 1 )
      pos2 = at( PF_TAB, StrAux )
      if pos2 > 0
         cant = cant + 1
         PF_DatoRecibido[ cant ] = left( StrAux, pos2 - 1 )
      elseif at( PF_ETX, StrAux ) > 0
         cant = cant + 1
         PF_DatoRecibido[ cant ] = left( StrAux, at( PF_ETX, StrAux ) - 1 )
         continuar = .F.
      elseif len( StrAux ) > 0
         cant = cant + 1
         PF_DatoRecibido[ cant ] =  StrAux
         continuar = .F.
      else
         continuar = .F.
      endif
   else
      continuar = .F.
   endif
enddo
return

Procedure PF_LimpiarBufferCom
* Funcion   : Vaciar el buffer de entrada
LOCAL basura
do while com_count(PF_PuertoNro) > 0
   basura = com_read(PF_PuertoNro)
enddo
return

function PF_NroPaquete ( opcion )
* Funcion   : Maneja el numero de paquete del comando
*             opcion = "U" = Informa el ultimo numero de paquete
*             opcion = "P" = Pasa al proximo numero de paquete
STATIC numeropaquete := 0
   * para la primera vez ***
   if numeropaquete < 32
           numeropaquete = 32 +int( rand(seconds()) * (127-32) )
   endif
   * si pide el ultimo ****
   if upper(opcion) = "U"
           numeropaquete = numeropaquete
   endif
   * si pide el proximo ****
   if upper(opcion) = "P"
           numeropaquete = numeropaquete + 1
   endif
   * si llegue al limite superior ****
   if numeropaquete > 127
           numeropaquete = 32
   endif
return  numeropaquete

procedure  PF_IniciarSalida
* Funcion   : Inicializa el array de campos a enviar
LOCAL nro
for nro = 1 to 25
   PF_DatoaEnviar[ nro ] = NIL
next
return


#include "pfiscal.ch"
STORE 30504475913 TO NCUIT
vcuit=alltrim(str(ncuit))

if PF_PuertoInit( 1,"3F8", 4)
*if PF_PuertoInit( 2,"2F8", 3)
*  PF_sincronizar()
continuar = .T.

DO FACTURAA

PF_PuertoCierra()
else
? "error al abrir puerto"
   PF_PuertoCierra()
endif

close all
return


procedure facturaA
? "Abriendo factura A"
  if continuar
* Paso 1)
   ? "Abriendo Factura"
   * Armado y env¡o del comando de abrir Factura
      do PF_IniciarSalida
      nada = PF_AgregaCampoSalida( "F" )           && Documento Tique-Factura
      nada = PF_AgregaCampoSalida( "C" )           && Formulario Continuo
      nada = PF_AgregaCampoSalida( "A" )           && Letra "A"
      nada = PF_AgregaCampoSalida( "1" )           && Copias
      nada = PF_AgregaCampoSalida( "F" )           && Preimpreso
      nada = PF_AgregaCampoSalida( "12" )          && CPI
      nada = PF_AgregaCampoSalida( "I" )           && Iva Vendedor
      nada = PF_AgregaCampoSalida( "I" )           && Resp Iva Comprador
      nada = PF_AgregaCampoSalida( "WESTERN GECO")   && Nombre Comprador
      nada = PF_AgregaCampoSalida( chr(127) )               && Nombre Comprador Linea 2
      nada = PF_AgregaCampoSalida( "CUIT" )                 && Tipo de documento o CUIT
      nada = PF_AgregaCampoSalida( vcuit )          && Nro CUIT
      nada = PF_AgregaCampoSalida( "N" )                    && Bien de Uso
      nada = PF_AgregaCampoSalida( "SIN DOMICILIO")        && Domi Comprador Linea 1
      nada = PF_AgregaCampoSalida( chr(127) )               && Domi Comprador Linea 2
      nada = PF_AgregaCampoSalida( chr(127) )               && Domi Comprador Linea 3
      nada = PF_AgregaCampoSalida( chr(127) )     && Remitos Linea 1
      nada = PF_AgregaCampoSalida( chr(127) )               && Remitos Linea 2
      nada = PF_AgregaCampoSalida( "C" )                    && Tipo de lista de almacenamiento
      if PF_EnviarComando( PF_FCAbre )
         Continuar = .T.
         ? "Comprobante Abierto"
      else
         Continuar = .F.
         ? PF_MensajeEstado( PF_ModuloImpresor )
         ? PF_MensajeEstado( PF_ModuloFiscal )
         * La aplicaci¢n aca debe analizar por que se produjo el error del comando
         * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
         * o debe ejecutar un cierre Z, etc
      endif
  endif

? "Item de linea"
*XCANTIDAD=CANTIDAD*1000
set decimals to 2
VPRECIO=PRECIO/1.21
set decimals to 0
XPRECIO=VPRECIO*100
ROUND(XPRECIO,-1)
vprecio=alltrim(str(XPRECIO,0))

vcuit=alltrim(str(ncuit))
*vcantidad=alltrim(str(XCANTIDAD))
*vprecio=alltrim(str(XPRECIO,0))
*? VPRECIO
*? VCANTIDAD
   * Armado y env¡o del comando de Item de L¡nea
   if Continuar
      do PF_IniciarSalida
      nada = PF_AgregaCampoSalida( "BOLSOS DE PVC REF. CON 8 ARGOLLAS" )  && Descripci¢n
      nada = PF_AgregaCampoSalida( "2500" )  && Cantidad  3,000
      nada = PF_AgregaCampoSalida( "8500" )  && Precio   12,50
      nada = PF_AgregaCampoSalida( "2100"      )  && Tasa IVA 21,00%
      nada = PF_AgregaCampoSalida( "M"         )  && Monto vendido de mercaderia
      nada = PF_AgregaCampoSalida( "0"         )  && Bultos
      nada = PF_AgregaCampoSalida( "00000000"  )  && Tasa de Ajuste Imp.Int.
      nada = PF_AgregaCampoSalida( PF_DEL )  && DEscrip adicional 1
      nada = PF_AgregaCampoSalida( PF_DEL )  && DEscrip adicional 2
      nada = PF_AgregaCampoSalida( PF_DEL )  && DEscrip adicional 3
      nada = PF_AgregaCampoSalida( "00000000" )       && IVA Incremento no inscripto
      nada = PF_AgregaCampoSalida( "00000000"  )  && Imp.Int. monto fijo
      * El comando PF_AgregaCampoSalida da error si se sobrepasan los 25 elementos
      if PF_EnviarComando( PF_FCItemDeLinea )
         Continuar = .T.
      else
         Continuar = .F.
         ? PF_MensajeEstado( PF_ModuloImpresor )
         ? PF_MensajeEstado( PF_ModuloFiscal )
         * La aplicaci¢n aca debe analizar por que se produjo el error del comando
         * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
         * o puede haber overflow o estar mal algun dato
      endif
    ENDIF
  ? "*Pago"
   * Armado y env¡o del comando de Pago
   if Continuar
      do PF_IniciarSalida
      nada = PF_AgregaCampoSalida("CONTADO")
      nada = PF_AgregaCampoSalida(VPAGO)
      nada = PF_AgregaCampoSalida(VESTADO)
      * El comando PF_AgregaCampoSalida da error si se sobrepasan los 20 elementos
      if PF_EnviarComando( PF_FCPago )
         Continuar = .T.
         ? "Saldo         " + PF_DatoRecibido[3]
      else
         Continuar = .F.
         ? PF_MensajeEstado( PF_ModuloImpresor )
         ? PF_MensajeEstado( PF_ModuloFiscal )
         * La aplicaci¢n aca debe analizar por que se produjo el error del comando
         * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
      endif
   endif


? "Cierre de factura"
   * Armado y env¡o del comando de Cierre de Tique
   if Continuar
      do PF_IniciarSalida
      nada = PF_AgregaCampoSalida( "F" )
      nada = PF_AgregaCampoSalida( "A" )
      nada = PF_AgregaCampoSalida("FINAL")
      * El comando PF_AgregaCampoSalida da error si se sobrepasan los 20 elementos
      if PF_EnviarComando( PF_FCCerrar )
         Continuar = .T.
         ? "Factura cerrada "+ str( val(PF_DatoRecibido[3]) )
      else
         Continuar = .F.
         ? PF_MensajeEstado( PF_ModuloImpresor )
         ? PF_MensajeEstado( PF_ModuloFiscal )
         * La aplicaci¢n aca debe analizar por que se produjo el error del comando
         * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
         * o el importe del comprobante es cero
      endif
   endif
CLOSE ALL
RETURN


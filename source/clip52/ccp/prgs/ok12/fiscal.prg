#include "pfiscal.ch"

if PF_PuertoInit( 1,"3F8", 4)
*if PF_PuertoInit( 2,"2F8", 3)
   do imprime
   PF_PuertoCierra()
continuar = .T.
else
? "error al abrir puerto"
*   PF_Sincronizar()
   PF_PuertoCierra()
endif
quit

Procedure imprime()
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
      nada = PF_AgregaCampoSalida( "30641543124" )          && Nro CUIT
      nada = PF_AgregaCampoSalida( "N" )                    && Bien de Uso
      nada = PF_AgregaCampoSalida( chr(127))        && Domi Comprador Linea 1
      nada = PF_AgregaCampoSalida( chr(127) )               && Domi Comprador Linea 2
      nada = PF_AgregaCampoSalida( chr(127) )               && Domi Comprador Linea 3
      nada = PF_AgregaCampoSalida( "Nro.Remito Lin 1" )     && Remitos Linea 1
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

   * Armado y env¡o del comando de Item de L¡nea
   if Continuar
      do PF_IniciarSalida
      nada = PF_AgregaCampoSalida( "CON 8 ARGOLLAS" )  && Descripci¢n
      nada = PF_AgregaCampoSalida( "250000"      )  && Cantidad  3,000
      nada = PF_AgregaCampoSalida( "0001"      )  && Precio   12,50
      nada = PF_AgregaCampoSalida( "2100"      )  && Tasa IVA 21,00%
      nada = PF_AgregaCampoSalida( "M"         )  && Monto vendido de mercaderia
      nada = PF_AgregaCampoSalida( "0"         )  && Bultos
      nada = PF_AgregaCampoSalida( "00000000"  )  && Tasa de Ajuste Imp.Int.
      nada = PF_AgregaCampoSalida( "BOLSONES DE PVC REF." )  && DEscrip adicional 1
      nada = PF_AgregaCampoSalida( PF_DEL        )  && DEscrip adicional 2
      nada = PF_AgregaCampoSalida( PF_DEL )  && DEscrip adicional 3
      nada = PF_AgregaCampoSalida( "0000" )       && IVA Incremento no inscripto
      nada = PF_AgregaCampoSalida( "00000000"  )  && Imp.Int. monto fijo
      * El comando PF_AgregaCampoSalida da error si se sobrepasan los 25 elementos
      if PF_EnviarComando( PF_FCItemDeLinea )
         Continuar = .T.
         ? "Primer Item Vendido"
      else
         Continuar = .F.
         ? PF_MensajeEstado( PF_ModuloImpresor )
         ? PF_MensajeEstado( PF_ModuloFiscal )
         * La aplicaci¢n aca debe analizar por que se produjo el error del comando
         * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
         * o puede haber overflow o estar mal algun dato
      endif
   endif

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
return



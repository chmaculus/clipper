#include "pfiscal.ch"
if PF_PuertoInit( 1,"3F8", 4)
*if PF_PuertoInit( 2,"2F8", 3)
endif
PF_sincronizar()
PF_PuertoCierra()

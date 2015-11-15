BITS 16
;Etiquetas Globales
GLOBAL Init16

;Etiquetas Externas
EXTERN Enable_GateA20


SECTION .Init16
Init16:
      call Enable_GateA20 		;Se llama a Enable_GateA20 para poder acceder a direccione spor arriba del primer mega
      hlt
BITS 16
;Etiquetas Globales
GLOBAL Init16

;Etiquetas Externas
EXTERN Enable_GateA20
EXTERN STACK_16_BIT_START


SECTION .Init16
Init16:
      
      ;Seteo de la Stack Selector
      xor ax, ax
      mov ss, ax

      ;Seteo de la Stack Pointer
      xor ax, ax
      mov sp, STACK_16_BIT_START



      ;Vamos a copiar la ROM, por lo que paso el parametro count
      push dword (ROM_SIZE -1)
      
      push word ROM_SRC_START_LO
      push word ROM_SRC_START_HI
      
      
      push word ROM_DST_START_LO
      push word ROM_DST_START_HI


      call memcpy_c                 ; Llamos al memcpy de C
      call Enable_GateA20 		;Se llama a Enable_GateA20 para poder acceder a direccione spor arriba del primer mega
      hlt
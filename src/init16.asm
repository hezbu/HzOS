BITS 16
;Etiquetas Globales
GLOBAL Init16

;Etiquetas Externas
EXTERN Enable_GateA20

%define ROM_SIZE		      (64*1024)
%define ROM_START_HI_DWORD	0x000F
%define ROM_START_LO_DWORD	0x0000
%define RESET_VECTOR	      0xfff0

SECTION .Init16
Init16:
      
      call 
      call Enable_GateA20 		;Se llama a Enable_GateA20 para poder acceder a direccione spor arriba del primer mega
      hlt
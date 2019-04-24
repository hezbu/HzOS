USE16
;Etiquetas Globales
GLOBAL Init16

;Etiquetas Externas
EXTERN Enable_GateA20
EXTERN STACK_16_BIT_START
EXTERN Init32
EXTERN GDT
EXTERN lgdtr

SECTION .Init16
Init16:
      
      test eax, 0x0             	; Test para verificar que el uP no este en fallo
  	jne ..@fault_end

   	xor eax, eax				; Invalidar TLB ?????????????????
   	mov cr3, eax


      ;Seteo de la Stack Selector
      xor ax, ax
      mov ss, ax

      ;Seteo de la Stack Pointer
      xor ax, ax
      mov sp, STACK_16_BIT_START
      xchg bx, bx



      call Enable_GateA20 		;Se llama a Enable_GateA20 para poder acceder a direccione spor arriba del primer mega
      xchg bx, bx
      jmp Init32



      ..@fault_end:
	xchg bx,bx					; Magic Breakpoint
	mov eax, 0x09 				; Return Value
	hlt
	jmp ..@fault_end

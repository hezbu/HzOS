USE16
;Etiquetas Globales
GLOBAL Init16

;Direcciones Externas
EXTERN Enable_GateA20
EXTERN STACK_16_BIT_START
EXTERN Init32

;Labels Externos
EXTERN lgdtr
EXTERN DS_SEL
EXTERN CS_SEL


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


      call Enable_GateA20 		;Se llama a Enable_GateA20 para poder acceder a direcciones por arriba del primer mega

      ;IMPORTANT NOTE: instructions that make use
      ;                of 32-bit addressings from
      ;                16-bit code must use the
      ;                "a32" and "o32" prefixes to
      ;                override 16-bit Addressing
      ;                (thanks to "a32") and override
      ;                the 16-bit Operand limitation
      ;                (thanks to "o32"); otherwise, the
      ;                program locks in (Un)Real Mode:

      o32 lgdt [cs:lgdtr]             ; Se carga la GDT

      jmp start_protected_mode        ; Inicia la ejecución en Modo Protegido
start_protected_mode_return:

      jmp dword CS_SEL:Init32


    


; --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --;
;                                                                                           ;
;                                       START_PM                                            ;
;                                                                                           ;
; --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --;

start_protected_mode:
      mov eax, cr0
      or eax,1
      mov cr0, eax

      mov ax, DS_SEL
      mov ds, ax
      mov ss, ax
      mov es, ax

      jmp start_protected_mode_return
     


..@fault_end:
	xchg bx,bx					; Magic Breakpoint
	mov eax, 0x09 				; Return Value
	hlt
	jmp ..@fault_end

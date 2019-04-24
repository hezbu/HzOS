; --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  - ;
;																						;
;										GDT / GDTR										;
;																						;
; --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  - ;

;////////////////////////////////////////////////////////////////////////////////////////////;
;
;	GDT Formato de los selectores
;
;					+++++ FLAGS +++++				+++++ ACCESS BYTE ++++++
;|31              24|23 | 22 | 21| 20|19          16|15 |14 13| 12|11      8|7                0|
;|------------------|---|----|---|---|--------------|---|-----|---|---------|------------------|
;| Base addr(24-31) | G | DB | 0 | A | Limit(16-19) | P | DPL | S |  TYPE   | Base addr(16-23) |
;|------------------|---|----|---|------------------|---|-----|---|---------|------------------|
;|               Base address (0-15)                |           Segment Limit (0-15)           |
;|--------------------------------------------------|------------------------------------------|
;
; ACCESS BYTE:
;
;	P:			Present bit. Debe valer 1 para los segmentos válidos
;
;	DPL:		Privilege. 0 = Kernel (máximo privilegio), 3 = User (mínimo privilegio)
;
;	S:			= 1 ?
;
;	TYPE:	
;		Ex:		Executable bit. 
;					1, es un selector de código
;					0, es un selector de datos
;
;		DC:		Direction bit (para data).
;					0, el segmento es creciente
;					1, el segmento es decreciente (offset > limit)
;				Conforming bit (para code).
;					1, el código puede ser ejecutado por un nivel igual o menor de privilegio
;					0, el codigo solo puede ser ejecutado por el nivel de privilegio elegido
;
;		RW:		Read/Write bit.
;					Read: código
;					Write: datos
;
;		AC:		Accessed bit. Se inicializa en 0 y el CPU lo pone en 1 al acceder al segmento
;
; FLAGS:
;		
;		G:		Granularity bit. 
;					0, el límite esta en bloques de 1 Byte (Granularidad de Byte)
;					1, el límite está en bloques de 4 kB (Granularidad de Página)
;
;		D:		Operand Size. (se pueden combinar)
;					0, modo protegido de 16 bits
;					1, modo protegido de 32 bits
;
;		0:		Siempre en 0...
;
;		A:		Available for System, setear en 0
;
;////////////////////////////////////////////////////////////////////////////////////////////;
GLOBAL GDT
GLOBAL lgdtr

SECTION .SysTable
GDT:
	NULL_SEL    equ $-GDT
	  dq 0x0					; Selector NULO, todo en 0 (los 64bits)
	DS_SEL      equ $-GDT
	  dw 0xffff					; Primeros 16BITS correspondientes al Límite del Segmento
	  dw 0x0000					; Primeros 16BITS correspondientes a la Base (0-15)
	  db 0x00					; Base (16-23)
	  db 0x92					; Byte de Acceso 

	  db 0xcf					; Los 4BITS superiores corresponden a los flags,  	
	  							; Los 4BITS inferiores corresponden a los últimos 4 bits del 
	  							; límite (16-19), este mide 20BITS en total.

	  db 0						; Base (24-31)	  
	CS_SEL      equ $-GDT
      dw 0xffff                 ; Primeros 16BITS correspondientes al Límite del Segmento
      dw 0x0000                 ; Primeros 16BITS correspondientes a la Base (0-15)
      db 0x00                   ; Base (16-23)
      db 0x99                   ; Byte de Acceso 

      db 0xcf                   ; Los 4BITS superiores corresponden a los flags,    
                                ; Los 4BITS inferiores corresponden a los últimos 4 bits del 
                                ; límite (16-19), este mide 20BITS en total.

      db 0                      ; Base (24-31)
	GDT_LENGTH  equ $-GDT

lgdtr:							; GDTR
	dw GDT_LENGTH-1				; Límite (0-15) 16BITS, contine el tamaño - 1 de la GDT
	dd GDT 						; Base	(16-47) 32BITS, contine la ubicación de la GDT


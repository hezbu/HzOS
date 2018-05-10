BITS 16
GLOBAL Enable_GateA20
GLOBAL Memcpy

SECTION .Utils16
Enable_GateA20:
        push ebp
        mov ebp, esp

        ;FIXME: Hacer llamada a GateA20

        pop ebp
        retf





; -------------------------------------------------------------------------------
; memcopy
; -------------------------------------------------------------------------------
;
;void * memcopy(void *destino, const void *origen, unsigned int num_bytes);

Memcpy:
	
	push ebp        ; Genero stack frame para recuperar los parametros
	mov ebp, esp    ; Resguardo el ESP

	push edi        ; Salvaguardo los registros que vamos a utilizar
	push esi        ; Salvaguardo los registros que vamos a utilizar
	push ecx        ; Salvaguardo los registros que vamos a utilizar

	; La pila en este momento esta conformada
	;	ebp_h		<---	ebp
	;	ebp_l
	;	ip
	;	arg1_h		<---	ebp+6
	;	arg1_l
	;	arg2_h		<---	ebp+10
	;	arg2_l
	;	arg3_h		<---	ebp+14
	;	arg3_l

	mov edi, [ebp+6]        ;  obtengo el destino
	mov esi, [ebp+10]	;  obtengo el origen
	mov ecx, [ebp+14]	;  obtengo la cantidad de bytes a copiar

	
	Memcpy_loop:
		mov ax,[cs:si]
		mov [es:di],ax
		add di,2
		add si,2
	loop Memcpy_loop


	pop dword ecx           ;Recupero los valores de la funcion caller
	pop dword esi           ;Recupero los valores de la funcion caller
	pop dword edi           ;Recupero los valores de la funcion caller        
	pop dword ebp           ;Recupero los valores de la funcion caller        

	mov eax, [esp+2]        

	ret                     ;  Popeo IP




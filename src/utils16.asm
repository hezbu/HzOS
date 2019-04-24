USE16
GLOBAL Enable_GateA20
GLOBAL Memcpy

;///////////////////////////////////////////////////////////////////////////////
;                   Funciones para habilitar el A20 Gate
;///////////////////////////////////////////////////////////////////////////////
%define     PORT_A_8042    0x60        ;Puerto A de E/S del 8042
%define     CTRL_PORT_8042 0x64        ;Puerto de Estado del 8042
%define     KEYB_DIS       0xAD        ;Deshabilita teclado con Command Byte
%define     KEYB_EN        0xAE        ;Habilita teclado con Command Byte
%define     READ_OUT_8042  0xD0        ;Copia en 0x60 el estado de OUT
%define     WRITE_OUT_8042 0xD1        ;Escribe en OUT lo almacenado en 0x60


SECTION .Utils16
Enable_GateA20:
        push bp
        mov bp, sp

        xor ax, ax
		;Deshabilita el teclado
		mov edi, .8042_kbrd_dis
	    jmp .empty_8042_in
		.8042_kbrd_dis:
		mov al, KEYB_DIS
		out CTRL_PORT_8042, al
		
		; ;Lee la salida
		mov edi, .8042_read_out
		jmp .empty_8042_in
		.8042_read_out:
		mov al, READ_OUT_8042
		out CTRL_PORT_8042, al
		
		.empty_8042_out:  
		;      in al, CTRL_PORT_8042      ; Lee port de estado del 8042 hasta que el
		;      test al, 00000001b         ; buffer de salida este vacio
		;      jne .empty_8042_out

		xor bx, bx   
		in al, PORT_A_8042
		mov bx, ax

		;Modifica el valor del A20
		mov edi, .8042_write_out
		jmp .empty_8042_in
		.8042_write_out:
		mov al, WRITE_OUT_8042
		out CTRL_PORT_8042, al

		mov edi, .8042_set_a20
		jmp .empty_8042_in
		.8042_set_a20:
		mov ax, bx
		or ax, 00000010b              ; Habilita el bit A20
		out PORT_A_8042, al

		;Habilita el teclado
		mov edi, .8042_kbrd_en
		jmp .empty_8042_in
		.8042_kbrd_en:
		mov al, KEYB_EN
		out CTRL_PORT_8042, al

		mov edi, .a20_enable_no_stack_exit
		.empty_8042_in:  
		    ;  in al, CTRL_PORT_8042      ; Lee port de estado del 8042 hasta que el
		    ;  test al, 00000010b         ; buffer de entrada este vacio
		    ;  jne .empty_8042_in
			jmp di

		.a20_enable_no_stack_exit:


        pop bp
        ret





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




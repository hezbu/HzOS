BITS 16
GLOBAL Reset
EXTERN Init16


SECTION .Reset
Reset:
	cli
	jmp Init16
	ALIGN 16
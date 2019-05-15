GLOBAL Init32

EXTERN ROM_SRC_START
EXTERN ROM_DST_START
EXTERN ROM_LEN
EXTERN __memcpy_c
EXTERN lgdtr
EXTERN GDT

SECTION .Init32
USE32
Init32:

      xchg bx, bx

      ;Vamos a copiar la ROM, por lo que paso el parametro count
      push (ROM_LEN + 16 -1)      

      push ROM_DST_START      
       
      push ROM_SRC_START
      

	    call __memcpy_c

       xchg bx, bx

	hlt
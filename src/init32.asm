GLOBAL Init32

EXTERN ROM_SRC_START_LO
EXTERN ROM_SRC_START_HI
EXTERN ROM_DST_START_LO
EXTERN ROM_DST_START_HI
EXTERN ROM_LEN
EXTERN memcpy_c
EXTERN lgdtr
EXTERN GDT

SECTION .Init32
USE32
Init32:


      ;Vamos a copiar la ROM, por lo que paso el parametro count
      push (ROM_LEN + 16 -1)
      
      push ROM_SRC_START_LO
      push ROM_SRC_START_HI
       
      push ROM_DST_START_LO
      push ROM_DST_START_HI

	    ; call memcpy_c

	hlt
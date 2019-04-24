GLOBAL Init32

EXTERN ROM_SRC_START_LO
EXTERN ROM_SRC_START_HI
EXTERN ROM_DST_START_LO
EXTERN ROM_DST_START_HI
EXTERN ROM_SIZE
EXTERN memcpy_c

SECTION .Init32
USE32
Init32:


      ;Vamos a copiar la ROM, por lo que paso el parametro count
      push (ROM_SIZE -1)
      
      push ROM_SRC_START_LO
      push ROM_SRC_START_HI
       
      push ROM_DST_START_LO
      push ROM_DST_START_HI

	  call memcpy_c

	hlt
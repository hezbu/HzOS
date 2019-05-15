 /*
  Contenido				Posición física (VMA)

  En ROM:
  Vector de reset			FFFFFFF0h
  Inicialización de 16 bits		FFFF0000h
  Inicialización de 32 bits		000F4000h
  
  En RAM:
  Copia de ROM (cuando arranca MP)          00002000h
  Pila de 16 (cuando arranca MP)            00001000h
  sys_tables				                        00100000h
  Pila de 32					                      00140000h
  Código principal			                    00150000h
  Datos inicializados			                  00200000h
  Datos no inicializados		                00210000h
  Bibliotecas				                        00220000h
  Otros (eh_frame, init, finit, etc)	00250000h
  */
    
  STACK_16_BIT_START    = 0x00001000;
  STACK_16_BIT_LEN      = 0x00001000;

  ROM_START             = 0xFFFF0000;
  ROM_LEN               = 0x0000FFF0;

  RESET_VECTOR_START             = 0xFFFFFFF0;
  RESET_VECTOR_LEN               = 0x0000FFF0;

  ROM_SRC_START         = 0xFFFF0000;

  ROM_DST_START         = 0x00002000;
  


MEMORY
{  



    ROM (rx) :           
        ORIGIN = ROM_START,
        LENGTH = ROM_LEN


    RESET_VECTOR (rx) :   
        ORIGIN = 0xFFFFFFF0,
        LENGTH = 0x00000010
}


SECTIONS
{
  
   

   .rom :
    {
        *(.Init16);
        *(.Utils16);
        *(.SysTables);
        *(.Init32);
	      *(.Utils32);
        *(.eh_frame)
    } > ROM


   .rst : 
   {
    *(.Reset);
   } > RESET_VECTOR
	
}

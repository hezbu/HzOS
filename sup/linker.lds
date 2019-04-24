SECTIONS
{
  
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
    
  STACK_16_BIT_START     = 0x1000;
  ROM_DST_START_LO      = 0x2000;
  ROM_DST_START_HI      = 0x0000;
  ROM_SRC_START_LO      = 0x0000;
  ROM_SRC_START_HI      = 0xF000;

  ROM_SIZE            = 65535;

  .eh_frame 0x8000 :
  {
    *(.eh_frame);
  }

  /*Init16 section @VMA = 0xF0000*/
  .Init16 0xF0000 :   
      AT( 0xF0000 )
	{
	  *(.Init16);
	  *(.Utils16);
	}
	
/*Init32 section @VMA = 0xF4000*/
  .Tables 0xF3000 :   
      AT( 0xF3000 )
	{
	  *(.Tables);
	}

  /*Init32 section @VMA = 0xF4000*/
  .Init32 0xF4000 :   
      AT( 0xF4000 )
	{
	  *(.Init32);
	  *(.Utils32);

	}
	
  /*Reset section @VMA = 0xFFFF0*/
  .Reset 0xFFFF0 :   
      AT( 0xFFFF0 )
	{
	  *(.Reset);
	}
}

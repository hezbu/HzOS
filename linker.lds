SECTIONS
{
  
  /*
  Contenido				Posición física (VMA)

  En ROM:
  Vector de reset			FFFFFFF0h
  Inicialización de 16 bits		FFFF0000h
  Inicialización de 32 bits		000F4000h
  
  En RAM:
  sys_tables				00100000h
  Pila					00140000h
  Código principal			00150000h
  Datos inicializados			00200000h
  Datos no inicializados		00210000h
  Bibliotecas				00220000h
  Otros (eh_frame, init, finit, etc)	00250000h
  */
    
  /*Init16 section @VMA = 0xF0000*/
  .Init16 0xF0000 :   
      AT( 0xF0000 )
	{
	  *(.Init16);
	}
	
  /*Init32 section @VMA = 0xF4000*/
  .Init32 0xF4000 :   
      AT( 0xF4000 )
	{
	  *(.Init32);
	}
	
  /*Reset section @VMA = 0xFFFF0*/
  .Reset 0xFFFF0 :   
      AT( 0xFFFF0 )
	{
	  *(.Reset);
	}
}

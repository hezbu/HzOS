#include "../inc/utils32.h"

/*
EXPLICACION DE ATRIBUTOS:

 static: 
                    No exporta el simbolo cuando hace la global_offset_table al momento de linkeado.
 __attribute__((section(".Utils32"))) :
                    Lo carga en la sección Utils32
__asm__:    
                    Se ejectura inline assembly
__volatile__:
                    No aplicar ningún tipo de optimización

*/

__attribute__((section(".Utils32")))  void __memcpy_c(int * src, int * dst, int count)
{

   
    // __asm__ __volatile__ ("lidt (%0)": : "q" (count));
    int i = 0;

    for(i = 0; i < count; i++ )
    {
        __asm__ __volatile__ ("nop");
        dst[i] = src[i];  
    }

}



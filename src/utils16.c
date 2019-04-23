#include "../inc/utils16.h"

void memcpy_c(char * src, char * dst, int count)
{
    int i = 0;

    for(i = 0; i < count; i++ )
    {
        dst[i] = src[i];  
    }
}



unsigned char method(int port)
{
    
    unsigned char ret;

    // asm volatile("inb %1, %0" : "=a"(ret) : "Nd"(port));  
   
    asm volatile ("mov (%0),%%eax": :"d"(port));    
    asm volatile ("inb %%al, (%0)": "=a"(ret) :  ); 
                   

    return ret;
}
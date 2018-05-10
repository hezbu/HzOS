#include "../inc/utils16.h"

void memcpy_c(char * src, char * dst, int count)
{
    int i = 0;

    for(i = 0; i < count; i++ )
    {
        dst[i] = src[i];  
    }
}
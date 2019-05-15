#ifndef __UTILS_32_H__
#define __UTILS_32_H__

extern __attribute__((section(".Utils32"))) void __memcpy_c(int * src, int * dst, int count);

#endif
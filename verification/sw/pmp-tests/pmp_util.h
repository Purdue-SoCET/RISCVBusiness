#ifndef _PMP_UTIL_H_
#define _PMP_UTIL_H_

#include <stdint.h>

#define G 14
#define ADDR_G(addr, g) (pmp_addr_g(addr, g))
#define ADDR_G_NO_SHIFT_2(addr, g) (pmp_addr_g_no_shift2(addr, g))

static inline uint32_t pmp_addr_g_no_shift2(uint32_t addr, uint32_t g) {
    if(g == 0) {
        return addr;
    }
    
    return (addr & ~((1 << g) - 1)) | ((1 << (g - 1)) - 1);
}

static inline uint32_t pmp_addr_g(uint32_t addr, uint32_t g) {
    return pmp_addr_g_no_shift2(addr >> 2, g);
}

#endif

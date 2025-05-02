#ifndef __UTILITY_H__
#define __UTILITY_H__

    #include <stdint.h>

    #define MTIME_ADDR      0xFFFFFFE0
    #define MTIMEH_ADDR     0xFFFFFFE4
    #define MTIMECMP_ADDR   0xFFFFFFE8
    #define MTIMECMPH_ADDR  0xFFFFFFEC
    #define MSIP_ADDR       0xFFFFFFF0
    #define EXT_ADDR_SET    0xFFFFFFF4
    #define EXT_ADDR_CLEAR  0xFFFFFFF8
    #define MAGIC_ADDR      0xFFFFFFFC
    
    // G means (G + 2) bits from the 32 bit address are chopped off for matching
    // i.e. G = 14 means 16 bits are removed
    #define G 14

    #define ADDR_G(addr, g)            (g == 0 ? addr >> 2 : ((addr >> 2) & ~((1 << g) - 1)) | ((1 << (g - 1)) - 1))
    #define ADDR_G_NO_SHIFT_2(addr, g) (g == 0 ? addr : ((addr) & ~((1 << g) - 1)) | ((1 << (g - 1)) - 1))

    void print(char *string);
    void put_uint32_hex(uint32_t hex);

#endif

#ifndef __UTILITY_H__
#define __UTILITY_H__

    #include <stdint.h>

    #define MTIME_ADDR      0x10000
    #define MTIMEH_ADDR     0x10004
    #define MTIMECMP_ADDR   0x10008
    #define MTIMECMPH_ADDR  0x1000C
    #define MSIP_ADDR       0x10010
    #define EXT_ADDR_SET    0x10014
    #define EXT_ADDR_CLEAR  0x10018
    #define MAGIC_ADDR      0x20000
    

    void print(char *string);
    void put_uint32_hex(uint32_t hex);

#endif

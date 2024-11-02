
#include "utility.h"

void print(char *string) {
    volatile char *magic = (volatile char *)MAGIC_ADDR;

    for(int i = 0; string[i]; i++) {
        (*magic) = string[i];
    }
}

void put_uint32_hex(uint32_t x) {
    char buf[10] = {0};
    
    for(int i = 0; i < 8; i++) {
        uint8_t value = (x & 0xF);
        if(value >= 10) {
            buf[7-i] = ((value-10) + 'A');
        } else {
            buf[7-i] = (value + '0');
        }
        x >>= 4;
    }
    print(buf);
}

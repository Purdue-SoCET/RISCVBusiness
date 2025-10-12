#include "fast_amo_emu.h"

uint32_t atomic_add(uint32_t *ptr, uint32_t val) {
    uint32_t d;
    __asm__ volatile("1:\n"
                     "lr.w t0, (%[addr])\n"
                     "add t1, t0, %[src]\n"
                     "sc.w t2, t1, (%[addr])\n"
                     "bnez t2, 1b\n"
                     "mv %[d], t0\n"
                     : [d] "=r"(d)
                     : [addr] "r"(ptr), [src] "r"(val));
    return d;
}

#include "utility.h"

#define N 500

int global = 0;

uint32_t atomic_add(void *ptr, int val) {
    uint32_t d;
    __asm__ volatile("1:\n"
                     "lr.w %[d], (%[addr])\n"
                     "add t0, t1, %[src]\n"
                     "sc.w t2, t0, (%[addr])\n"
                     "bnez t2, 1b\n"
                     : [d] "=r"(d)
                     : [addr] "r"(ptr), [src] "r"(val));
    return d;
}

void hart0_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    while (hart1_done == 0) {}
    flag = global == (N * 2);
}

void hart1_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    hart1_done = 1;
}

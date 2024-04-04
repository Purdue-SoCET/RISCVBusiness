#include "utility.h"

#define N 10

// List so that globals aren't in the same cache lines
int global[4] = {0, 0, 0, 0};

void atomic_add(void *ptr, int val) {
    __asm__ volatile("1:\n"
                     "lr.w t1, (%[addr])\n"
                     "add t0, t1, %[src]\n"
                     "sc.w t0, t0, (%[addr])\n"
                     "bnez t0, 1b\n"
                     :
                     : [addr] "r"(ptr), [src] "r"(val));
}

void hart0_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global[0], 1);
    }
    while (hart1_done == 0) {}
    flag = global[0] == N;
}

void hart1_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global[2], 1);
    }
    hart1_done = global[2] == N;
}

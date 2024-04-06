//A write heavy testcase for dual core system.
//Calculates Pi^2 / 6 based on the Basel Problem

#include "utility.h"

//Number of terms
#define N 5

int global = 0;
double global_sum = 0;
int next_term = 0;


//Performs an atomic add and swap. The old value loaded via lr is stored
//in dest. Addr is the address of the variable to swap with
//src does nothing, but it breaks things when removed
void atomic_swap(uint32_t *dest, uint32_t src, uint32_t addr) {
    uint32_t d;
    __asm__ volatile("1:\n"
                     "lr.w %[d], (%[addr])\n"
                     "addi t0, %[d], 1\n"
                     "sc.w t0, t0, (%[addr])\n"
                     "bnez t0, 1b\n"
                     : [d] "=&r"(d)
                     : [addr] "r"(addr), [src] "r" (src)
                     : "memory", "t0");
    *dest = d;
}

void hart0_main() {
    int prevVal = 0;
    for (int i = 0; i < N; i++) {
        atomic_swap(&prevVal, 1, &global);
    }
    while (hart1_done == 0) {}
    flag = global == (N * 2);
}

void hart1_main() {
    int prevVal = 0;
    for (int i = 0; i < N; i++) {
        atomic_swap(&prevVal, 1, &global);
    }
    hart1_done = 1;
}

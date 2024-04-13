//A write heavy testcase for dual core system.
//Calculates Pi^2 / 6 based on the Basel Problem

#include "utility.h"
#include "mutex.h"

//Number of terms
#define N 6

uint32_t term = 0;
float sum = 0;
mutex sum_lock = {0};

void __attribute__ ((noinline)) calc_term(uint32_t n);

// Atomically increments `ptr` by `val`. Returns previous value.
uint32_t __attribute__ ((noinline)) atomic_add(void *ptr, uint32_t val) {
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

void doWork() {
    uint32_t n = atomic_add(&term, 1);
    while(n <= N) {
        calc_term(n);
        n = atomic_add(&term, 1);
    }
}

void hart0_main() {
    uint32_t start = get_cycles();
    doWork();
    while (hart1_done == 0) {
        __asm__ volatile("");
    }
    uint32_t end = get_cycles();
    uint32_t val = *(uint32_t *)&sum;
    flag = val == 0x3FBEE5D5;
    print("Sum = %x\n", val);
    print("Start cycles = %d, end cycles = %d\n", start, end);
}


void hart1_main() {
    doWork();
    hart1_done = 1;
}

void __attribute__ ((noinline)) calc_term(uint32_t n) {
    if (n == 0) return;
    float term = 1. / (n*n);
    mutex_lock(&sum_lock);
    sum += term;
    mutex_unlock(&sum_lock);
}

//A write heavy testcase for dual core system.
//Calculates Pi^2 / 6 based on the Basel Problem

#include "utility.h"
#include "mutex.h"

//Number of terms
#define N 5

int global = 0;
float global_sum = 0;
mutex global_lock;
int next_term = 0;


//Performs an atomic add and swap. The old value loaded via lr is stored
//in dest. Addr is the address of the variable to swap with
//src does nothing, but it breaks things when removed
void atomic_swap(uint32_t* dest, uint32_t src, uint32_t addr) {
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

/*void atomic_fadd(void *ptr, float val) {
    __asm__ volatile("1:\n"
                     "lr.w ft1, (%[addr])\n"
                     "fadd.s ft0, ft1, %[src]\n"
                     "sc.w t2, ft0, (%[addr])\n"
                     "bnez t2, 1b\n"
                     :
                     : [addr] "r"(ptr), [src] "r"(val));
}*/
void atomic_add(void *ptr, int val) {
    __asm__ volatile("1:\n"
                     "lr.w t1, (%[addr])\n"
                     "add t0, t1, %[src]\n"
                     "sc.w t2, t0, (%[addr])\n"
                     "bnez t2, 1b\n"
                     :
                     : [addr] "r"(ptr), [src] "r"(val));
}

void hart0_main() {
    int prevVal = 0;
    for (int i = 0; i < N; i++) {
        atomic_swap((uint32_t*) &prevVal, 1, (uint32_t) &global);
    }
    while (hart1_done == 0) {}
    flag = global == (N * 2);
}

void hart1_main() {
    int prevVal = 0;
    for (int i = 0; i < N; i++) {
        atomic_swap((uint32_t*) &prevVal, 1, (uint32_t) &global);
    }
    hart1_done = 1;
}

double calc_term(int n)
{
    float val = 1 / (n*n);
    mutex_lock(&global_lock);
    global_sum = global_sum + val;
    mutex_unlock(&global_lock);
}

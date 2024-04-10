//A write heavy testcase for dual core system.
//Calculates Pi^2 / 6 based on the Basel Problem

#include "utility.h"
#include "mutex.h"

//Number of terms
#define N 1

float global_sum = 0;
//int global_sum = 0;
mutex global_lock;
uint32_t next_term = 1;

void calc_term(int n);

//Performs an atomic increment and swap. The old value loaded via lr is stored
//in dest. Addr is the address of the variable to swap with
//src does nothing, but it breaks things when removed
uint32_t atomic_add(void *ptr, uint32_t val) {
    uint32_t d;
    __asm__ volatile("1:\n"
                     "lr.w %[d], (%[addr])\n"
                     "add t0, %[d], %[src]\n"
                     "sc.w t2, t0, (%[addr])\n"
                     "bnez t2, 1b\n"
                     : [d] "=r"(d)
                     : [addr] "r"(ptr), [src] "r"(val));
    return d;
}

void hart0_main() {
    uint32_t prevVal = atomic_add(&next_term, 1);
    while (prevVal < N + 1) {
        calc_term(prevVal);
        prevVal = atomic_add(&next_term, 1);
    }
    while (hart1_done == 0) {}
    calc_term(1);
    print("Sum = %x\n", global_sum);
    flag = *((volatile uint32_t *)&next_term) == (N * 2);
}

void hart1_main() {
    uint32_t prevVal = atomic_add(&next_term, 1);
    while (prevVal < N + 1) {
        calc_term(prevVal);
        prevVal = atomic_add(&next_term, 1);
    }
    hart1_done = 1;
}

void calc_term(int n)
{
    print("Finding term %d\n", n);
    float val = 1 / (n*n); //Missing divide functions?
    print("Got the value for term %d. It's %x\n", n, val);
    mutex_lock(&global_lock);
    print("Got the lock for term %d\n", n);
    //global_sum += 1;
    global_sum += val;
    mutex_unlock(&global_lock);
}

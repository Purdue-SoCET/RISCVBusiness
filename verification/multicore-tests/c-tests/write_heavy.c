//A write heavy testcase for dual core system.
//Calculates Pi^2 / 6 based on the Basel Problem

#include "utility.h"
#include "mutex.h"

//Number of terms
#define N 4

int global = 1;
float global_sum = 0;
int global_sum_int = 0;
mutex global_lock;
uint32_t next_term = 1;

void calc_term(int n);

//Performs an atomic increment and swap. The old value loaded via lr is stored
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
    uint32_t prevVal = 0;
    //for(int i = 0; i < N; i++) {
    while(prevVal < N) {
        atomic_swap((uint32_t*) &prevVal, 1, (uint32_t) &global);
        calc_term(prevVal);
    }
    while (hart1_done == 0) {}
    print("Sum = %x\n", global_sum);
    print("Sum_int = %d\n", global_sum_int);
    flag = 1;
}


void hart1_main() {
    int prevVal = 0;

    hart1_done = 1;
/*
    return;

    for (int i = 0; i < N; i++) {
        atomic_swap((uint32_t*) &prevVal, 1, (uint32_t) &global);
        calc_term(prevVal);
    }
    hart1_done = 1;
*/
}

void calc_term(int n)
{
    print("Finding term %d\n", n);
    float val = 1.0;
    if(n == 0) return;
    //float val = 1 / (n*n); //Missing divide functions?
    print("Term %d is %d\n", n, val);
    mutex_lock(&global_lock);
    print("Got lock for term %d\n", n);
    global_sum_int += 1;
    global_sum += val;
    mutex_unlock(&global_lock);
    print("Freed the lock for term %d\n", n);
}

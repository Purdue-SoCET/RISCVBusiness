
// Calculates Pi^2 / 6 based on the Basel Problem
// Expanded to 8 cores, write-heavy due to shared sum writes.

#include "fast_amo_emu.h"
#include "mutex.h"
#include "utility.h"
#include <stdio.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define N 256         
#define NUM_HART 1    

volatile uint32_t term = 0;
volatile float sum = 0;
mutex sum_lock = {0};

void __attribute__((noinline)) calc_term(uint32_t n) {
    if (n == 0) return;
    float local = 1.0f / (n * n);
    mutex_lock(&sum_lock);
    sum += local;  
    mutex_unlock(&sum_lock);
}

void doWork() {
    uint32_t n = atomic_add((uint32_t *)&term, 1); 
    while (n <= N) {
        calc_term(n);
        n = atomic_add((uint32_t *)&term, 1);
    }
}

void main() {
    int mhartid = get_mhartid();

    doWork();

    if (mhartid == 0) hart_done = 1;
    else if (mhartid == 1) hart1_done = 1;
    else if (mhartid == 2) hart2_done = 1;
    else if (mhartid == 3) hart3_done = 1;
    else if (mhartid == 4) hart4_done = 1;
    else if (mhartid == 5) hart5_done = 1;
    else if (mhartid == 6) hart6_done = 1;
    else if (mhartid == 7) hart7_done = 1;

    wait_for_all_harts_done(NUM_HART);

    if (mhartid == 0) {
        printf("Final Sum ≈ %.6f (Expected %.6f)\n", sum, M_PI * M_PI / 6.0);
    }
}

void hart0_main() { doWork(); hart_done  = 1; }
void hart1_main() { doWork(); hart1_done = 1; }
void hart2_main() { doWork(); hart2_done = 1; }
void hart3_main() { doWork(); hart3_done = 1; }
void hart4_main() { doWork(); hart4_done = 1; }
void hart5_main() { doWork(); hart5_done = 1; }
void hart6_main() { doWork(); hart6_done = 1; }
void hart7_main() { doWork(); hart7_done = 1; }


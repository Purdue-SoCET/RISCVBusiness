// A write heavy testcase for dual core system.
// Calculates Pi^2 / 6 based on the Basel Problem

#include "fast_amo_emu.h"
#include "mutex.h"
#include "utility.h"

// Number of terms
#define N 256

uint32_t term = 0;
float sum = 0;
mutex sum_lock = {0};

void __attribute__((noinline)) calc_term(uint32_t n) {
    if (n == 0)
        return;
    float term = 1. / (n * n);
    mutex_lock(&sum_lock);
    sum += term;
    mutex_unlock(&sum_lock);
}

void doWork() {
    uint32_t n = atomic_add(&term, 1);
    while (n <= N) {
        calc_term(n);
        n = atomic_add(&term, 1);
    }
}

void hart0_main() {
    doWork();
    wait_for_hart1_done();
    flag = 1;
}

void hart1_main() {
    doWork();
    hart1_done = 1;
}

// Calculates Pi^2 / 6 based on the Basel Problem
// Expanded to 8 cores, write-heavy due to shared sum writes.

#include "fast_amo_emu.h"
#include "mutex.h"
#include "utility.h"
#include <stdio.h>
#include <math.h>

#define N 256
#define NUM_HART 1    

float results[N]; 
float verify_data[N]; 
volatile uint32_t term = 0;
volatile float sum = 0;
mutex sum_lock = {0};

void init_verify_data(size_t string) {
    for (size_t i = 0; i < N; i++) {
        verify_data[i] = 1.0f / ((i + 1) * (i + 1));
    }
}

void __attribute__((noinline)) calc_term(uint32_t n) {
    if (n == 0) return;
    float local = 1.0f / (n * n);
    results[n-1] = local;  
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

void warmup() {
	init_verify_data(N);
}


void verifydata_per_core(int coreid, const size_t ncores, float results[], float verify_data[]) {
    size_t start = N / ncores * coreid;
    size_t end   = N / ncores * (coreid + 1);

    print("Verifying result for hart %d.\n", coreid);
    for (size_t i = start; i < end; i++) {
        if (fabs(results[i] - verify_data[i]) > 1e-6f) {
            print("Incorrect data at %d (got %f, expected %f)\n", i, results[i], verify_data[i]);
            return;
        }
    }
    print("Correct data in hart %d!\n", coreid);
}

void verifydata(float results[], float verify_data[]) {
    size_t start = 0;
    size_t end   = N;

    print("Verifying result from hart 0.\n");
    for (size_t i = start; i < end; i++) {
        if (fabs(results[i] - verify_data[i]) > 1e-6f) {
            print("Incorrect data at %d (got %f, expected %f)\n", i, results[i], verify_data[i]);
            return;
        }
    }
    print("Data is correct!\n");
    flag = 1;
}

void hart0_main() {
    warmup();
    int mhartid = 0;
    uint32_t beginning_cycle = get_cycles();
    doWork();
    hart_done = 1;
    wait_for_all_harts_done(NUM_HART);
	
    uint32_t ending_cycle = get_cycles();
    uint32_t cycle = ending_cycle - beginning_cycle;

    verifydata_per_core(0, NUM_HART, results, verify_data);
    verifydata(results, verify_data);

    print("hart0 done\n");
    print("Took %d cycles\n", cycle);
    return;
}

#define HARTN_MAIN(n)                                                         \
    void hart##n##_main() {                                                   \
        warmup();                                                             \
        doWork();     \
        hart##n##_done = 1;                                                   \
        print("hart" #n " done\n");                                           \
        verifydata_per_core(n, NUM_HART, results, verify_data);               \
        return;                                                               \
    }

#if NUM_HART > 1
HARTN_MAIN(1)
#if NUM_HART > 2
HARTN_MAIN(2)
#if NUM_HART > 3
HARTN_MAIN(3)
#if NUM_HART > 4
HARTN_MAIN(4)
#if NUM_HART > 5
HARTN_MAIN(5)
#if NUM_HART > 6
HARTN_MAIN(6)
#if NUM_HART > 7
HARTN_MAIN(7)
#endif
#endif
#endif
#endif
#endif
#endif
#endif

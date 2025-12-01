#include "utility.h"
#include <stddef.h>
#include <stdint.h>

#define ARRAY_SIZE 256
#define DIM_SIZE 16

#define NUM_HART 2

static uint32_t input1_data[ARRAY_SIZE] = {
    0, 3, 2, 0, 3, 1, 0, 3, 2, 3, 2, 0, 3, 3, 1, 2, 3, 0, 0, 1, 1, 1, 2, 3,
    1, 2, 3, 1, 1, 3, 2, 2, 0, 1, 3, 2, 2, 2, 0, 0, 1, 0, 1, 3, 3, 0, 3, 3,
    3, 3, 0, 3, 2, 1, 2, 2, 0, 0, 3, 0, 1, 1, 0, 3, 3, 1, 2, 3, 3, 0, 1, 2,
    1, 0, 1, 2, 2, 1, 0, 3, 1, 0, 2, 2, 1, 1, 1, 1, 1, 1, 2, 0, 3, 1, 1, 2,
    2, 3, 3, 1, 3, 2, 0, 0, 0, 3, 3, 3, 2, 1, 2, 3, 1, 0, 0, 0, 0, 1, 2, 2,
    1, 1, 3, 3, 3, 1, 1, 2, 3, 1, 3, 3, 2, 3, 2, 1, 2, 3, 0, 2, 2, 1, 1, 0,
    0, 0, 0, 0, 1, 3, 3, 1, 1, 1, 2, 2, 3, 2, 1, 1, 1, 1, 3, 0, 2, 2, 1, 3,
    2, 1, 2, 2, 1, 3, 1, 3, 1, 3, 2, 3, 1, 2, 1, 3, 2, 2, 0, 1, 0, 0, 1, 2,
    3, 3, 1, 0, 0, 0, 3, 1, 2, 3, 2, 3, 2, 0, 0, 0, 0, 0, 3, 1, 3, 0, 0, 0,
    3, 1, 1, 1, 1, 2, 1, 2, 3, 2, 0, 0, 2, 2, 3, 0, 3, 0, 0, 3, 0, 3, 1, 3,
    3, 1, 1, 1, 2, 2, 1, 3, 0, 3, 3, 1, 0, 0, 3, 2};

static uint32_t input2_data[ARRAY_SIZE] = {
    1, 1, 0, 3, 1, 2, 0, 0, 0, 0, 0, 2, 1, 2, 3, 0, 0, 3, 3, 2, 2, 1, 2, 3,
    3, 0, 2, 2, 1, 1, 2, 2, 0, 2, 2, 1, 2, 3, 2, 2, 3, 3, 2, 2, 1, 1, 1, 1,
    2, 1, 2, 2, 3, 3, 3, 0, 0, 3, 2, 3, 2, 3, 1, 2, 1, 1, 2, 2, 0, 1, 0, 3,
    2, 1, 1, 1, 2, 0, 1, 2, 2, 0, 2, 1, 3, 3, 2, 3, 2, 0, 3, 1, 3, 3, 2, 0,
    1, 0, 1, 1, 2, 2, 1, 1, 2, 2, 1, 2, 3, 3, 1, 3, 2, 2, 2, 3, 3, 1, 0, 2,
    1, 0, 0, 0, 1, 1, 2, 0, 3, 2, 3, 3, 0, 2, 3, 1, 0, 0, 2, 1, 2, 0, 2, 1,
    1, 2, 3, 1, 3, 2, 1, 0, 0, 0, 0, 0, 2, 2, 0, 2, 1, 2, 0, 3, 2, 2, 0, 0,
    3, 2, 1, 1, 3, 0, 2, 0, 0, 1, 0, 2, 3, 3, 1, 3, 3, 0, 0, 2, 2, 0, 0, 0,
    1, 0, 0, 1, 3, 0, 2, 1, 3, 2, 2, 1, 3, 2, 0, 1, 2, 2, 3, 2, 1, 1, 1, 1,
    3, 0, 1, 3, 2, 2, 3, 1, 1, 2, 0, 2, 1, 1, 2, 3, 1, 0, 1, 0, 1, 1, 0, 0,
    2, 0, 3, 0, 3, 0, 3, 2, 2, 3, 3, 2, 1, 0, 2, 2};

static uint32_t verify_data[ARRAY_SIZE] = {
    36, 44, 57, 50, 54, 36, 38, 46, 55, 25, 38, 34, 51, 30, 40, 32, 37, 34, 38,
    52, 51, 40, 28, 32, 41, 22, 26, 35, 49, 35, 42, 23, 26, 26, 33, 36, 52, 40,
    45, 49, 50, 34, 41, 35, 44, 25, 23, 23, 31, 29, 39, 46, 50, 36, 31, 32, 42,
    32, 34, 41, 44, 33, 43, 30, 31, 28, 39, 46, 50, 40, 35, 37, 43, 35, 33, 43,
    43, 29, 37, 29, 27, 22, 30, 33, 43, 31, 32, 25, 36, 31, 31, 29, 40, 28, 26,
    22, 29, 42, 48, 51, 65, 52, 43, 54, 63, 34, 42, 44, 56, 33, 38, 32, 26, 22,
    23, 38, 49, 32, 26, 30, 43, 22, 24, 27, 45, 24, 26, 17, 35, 35, 47, 51, 59,
    59, 43, 42, 43, 28, 37, 43, 56, 48, 36, 32, 28, 19, 28, 34, 46, 34, 28, 34,
    45, 20, 29, 28, 50, 32, 26, 21, 37, 38, 51, 50, 55, 45, 38, 49, 56, 28, 38,
    40, 50, 29, 44, 26, 32, 35, 50, 43, 53, 44, 41, 41, 34, 24, 35, 34, 39, 33,
    34, 29, 21, 33, 31, 45, 48, 42, 27, 29, 40, 17, 21, 32, 45, 30, 29, 26, 26,
    27, 38, 33, 29, 31, 32, 31, 35, 25, 29, 29, 34, 15, 25, 23, 34, 28, 44, 45,
    41, 41, 37, 45, 45, 17, 34, 44, 46, 30, 43, 29, 31, 36, 37, 50, 54, 44, 28,
    40, 38, 22, 27, 28, 45, 32, 36, 22};

__attribute__((section(".noinit"))) uint32_t results[ARRAY_SIZE];

#pragma GCC optimize("unroll-loops")
void matmul(const size_t coreid, const size_t ncores, const size_t lda,
            const uint32_t A[], const uint32_t B[], uint32_t C[]) {
    size_t i, j, k;
    size_t block = lda / ncores;
    size_t start = block * coreid;

    for (i = 0; i < lda; i++) {
        for (j = start; j < (start + block); j++) {
            uint32_t sum = 0;
            for (k = 0; k < lda; k++) {
            for (k = 0; k < lda; k++) {
                sum += A[j * lda + k] * B[k * lda + i];
            }
            }
            C[i + j * lda] = sum;
        }
    }
}

void verifydata_per_core(int coreid, const size_t ncores, uint32_t results[], uint32_t verify_data[]) {
    size_t start = ARRAY_SIZE / ncores * coreid;
    size_t end = ARRAY_SIZE / ncores * (coreid + 1);

    print("Verifying result for hart %d.\n", coreid);
    for(int i = start; i < end; i++) {
        if (results[i] != verify_data[i]) {
            print("Incorrect data at %d!\n", i);
            print("incorrect data: %d expected data: %d\n", results[i], verify_data[i]);
            return;
        }
    }
    print("Correct data in hart %d!\n", coreid);
}

void warmup() {
    volatile uint32_t temp = 0;
    for(int i = 0; i < ARRAY_SIZE; i ++) {
        temp = input1_data[i];
    }
    for(int i = 0; i < ARRAY_SIZE; i ++) {
        temp = input2_data[i];
    }
}

void verifydata(uint32_t results[], uint32_t verify_data[]) {
    size_t start = 0;
    size_t end = ARRAY_SIZE;

    print("Verifying result from hart 0.\n");
    for(int i = start; i < end; i++) {
        if (results[i] != verify_data[i]) {
            print("Incorrect data at %d!\n", i);
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
    matmul(mhartid, NUM_HART, DIM_SIZE, input1_data, input2_data, results);
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
        matmul(n, NUM_HART, DIM_SIZE, input1_data, input2_data, results);     \
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
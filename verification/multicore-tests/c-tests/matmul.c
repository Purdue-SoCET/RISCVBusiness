#include "utility.h"
#include <stddef.h>
#include <stdint.h>

#define ARRAY_SIZE 256
#define DIM_SIZE 16

#define MULTICORE 0

#if MULTICORE
#define NUM_CORES 2
#else
#define NUM_CORES 1
#endif

#define NUM_HART = 4
#define MAX_HART = 8

static uint32_t input1_data[ARRAY_SIZE] = {
    0, 3, 2, 0, 3, 1, 0, 3, 2, 3, 2, 0, 3, 3, 1, 2, 3, 0, 0, 1, 1, 1, 2, 3, 1, 2, 3, 1, 1, 3, 2, 2,
    0, 1, 3, 2, 2, 2, 0, 0, 1, 0, 1, 3, 3, 0, 3, 3, 3, 3, 0, 3, 2, 1, 2, 2, 0, 0, 3, 0, 1, 1, 0, 3,
    3, 1, 2, 3, 3, 0, 1, 2, 1, 0, 1, 2, 2, 1, 0, 3, 1, 0, 2, 2, 1, 1, 1, 1, 1, 1, 2, 0, 3, 1, 1, 2,
    2, 3, 3, 1, 3, 2, 0, 0, 0, 3, 3, 3, 2, 1, 2, 3, 1, 0, 0, 0, 0, 1, 2, 2, 1, 1, 3, 3, 3, 1, 1, 2,
    3, 1, 3, 3, 2, 3, 2, 1, 2, 3, 0, 2, 2, 1, 1, 0, 0, 0, 0, 0, 1, 3, 3, 1, 1, 1, 2, 2, 3, 2, 1, 1,
    1, 1, 3, 0, 2, 2, 1, 3, 2, 1, 2, 2, 1, 3, 1, 3, 1, 3, 2, 3, 1, 2, 1, 3, 2, 2, 0, 1, 0, 0, 1, 2,
    3, 3, 1, 0, 0, 0, 3, 1, 2, 3, 2, 3, 2, 0, 0, 0, 0, 0, 3, 1, 3, 0, 0, 0, 3, 1, 1, 1, 1, 2, 1, 2,
    3, 2, 0, 0, 2, 2, 3, 0, 3, 0, 0, 3, 0, 3, 1, 3, 3, 1, 1, 1, 2, 2, 1, 3, 0, 3, 3, 1, 0, 0, 3, 2};

static uint32_t input2_data[ARRAY_SIZE] = {
    1, 1, 0, 3, 1, 2, 0, 0, 0, 0, 0, 2, 1, 2, 3, 0, 0, 3, 3, 2, 2, 1, 2, 3, 3, 0, 2, 2, 1, 1, 2, 2,
    0, 2, 2, 1, 2, 3, 2, 2, 3, 3, 2, 2, 1, 1, 1, 1, 2, 1, 2, 2, 3, 3, 3, 0, 0, 3, 2, 3, 2, 3, 1, 2,
    1, 1, 2, 2, 0, 1, 0, 3, 2, 1, 1, 1, 2, 0, 1, 2, 2, 0, 2, 1, 3, 3, 2, 3, 2, 0, 3, 1, 3, 3, 2, 0,
    1, 0, 1, 1, 2, 2, 1, 1, 2, 2, 1, 2, 3, 3, 1, 3, 2, 2, 2, 3, 3, 1, 0, 2, 1, 0, 0, 0, 1, 1, 2, 0,
    3, 2, 3, 3, 0, 2, 3, 1, 0, 0, 2, 1, 2, 0, 2, 1, 1, 2, 3, 1, 3, 2, 1, 0, 0, 0, 0, 0, 2, 2, 0, 2,
    1, 2, 0, 3, 2, 2, 0, 0, 3, 2, 1, 1, 3, 0, 2, 0, 0, 1, 0, 2, 3, 3, 1, 3, 3, 0, 0, 2, 2, 0, 0, 0,
    1, 0, 0, 1, 3, 0, 2, 1, 3, 2, 2, 1, 3, 2, 0, 1, 2, 2, 3, 2, 1, 1, 1, 1, 3, 0, 1, 3, 2, 2, 3, 1,
    1, 2, 0, 2, 1, 1, 2, 3, 1, 0, 1, 0, 1, 1, 0, 0, 2, 0, 3, 0, 3, 0, 3, 2, 2, 3, 3, 2, 1, 0, 2, 2};

static uint32_t verify_data[ARRAY_SIZE] = {
    36, 44, 57, 50, 54, 36, 38, 46, 55, 25, 38, 34, 51, 30, 40, 32, 37, 34, 38, 52, 51, 40, 28, 32,
    41, 22, 26, 35, 49, 35, 42, 23, 26, 26, 33, 36, 52, 40, 45, 49, 50, 34, 41, 35, 44, 25, 23, 23,
    31, 29, 39, 46, 50, 36, 31, 32, 42, 32, 34, 41, 44, 33, 43, 30, 31, 28, 39, 46, 50, 40, 35, 37,
    43, 35, 33, 43, 43, 29, 37, 29, 27, 22, 30, 33, 43, 31, 32, 25, 36, 31, 31, 29, 40, 28, 26, 22,
    29, 42, 48, 51, 65, 52, 43, 54, 63, 34, 42, 44, 56, 33, 38, 32, 26, 22, 23, 38, 49, 32, 26, 30,
    43, 22, 24, 27, 45, 24, 26, 17, 35, 35, 47, 51, 59, 59, 43, 42, 43, 28, 37, 43, 56, 48, 36, 32,
    28, 19, 28, 34, 46, 34, 28, 34, 45, 20, 29, 28, 50, 32, 26, 21, 37, 38, 51, 50, 55, 45, 38, 49,
    56, 28, 38, 40, 50, 29, 44, 26, 32, 35, 50, 43, 53, 44, 41, 41, 34, 24, 35, 34, 39, 33, 34, 29,
    21, 33, 31, 45, 48, 42, 27, 29, 40, 17, 21, 32, 45, 30, 29, 26, 26, 27, 38, 33, 29, 31, 32, 31,
    35, 25, 29, 29, 34, 15, 25, 23, 34, 28, 44, 45, 41, 41, 37, 45, 45, 17, 34, 44, 46, 30, 43, 29,
    31, 36, 37, 50, 54, 44, 28, 40, 38, 22, 27, 28, 45, 32, 36, 22};

uint32_t results[ARRAY_SIZE];

#pragma GCC optimize("unroll-loops")
void matmul(const size_t coreid, const size_t ncores, const size_t lda, const uint32_t A[],
            const uint32_t B[], uint32_t C[]) {
    size_t i, j, k;
    size_t block = lda / ncores;
    size_t start = block * coreid;

    for (i = 0; i < lda; i++) {
        for (j = start; j < (start + block); j++) {
            uint32_t sum = 0;
            for (k = 0; k < lda; k++)
                sum += A[j * lda + k] * B[k * lda + i];
            C[i + j * lda] = sum;
        }
    }
}

void main() {
    mhartid = get_mhartid();
    harts_done = NUM_HART == MAX_HART ? 0 : ~((1 << NUM_HART) - 1);
    matmul(mhartid, NUM_HART, DIM_SIZE, input1_data, input2_data, results);
    
    // Mark completion
    harts_done |= (uint8_t) (1 << mhartid);

    // Verify result
    if(mhartid == 0) {
        for (uint32_t i = 0; i < ARRAY_SIZE; i++) {
            if (results[i] != verify_data[i]) {
                flag = 0;
                return;
            }
        }
    }
    wait_for_all_harts_done();

    return;
}

void hart0_main() {
    matmul(0, NUM_CORES, DIM_SIZE, input1_data, input2_data, results);
    wait_for_hart1_done();
    flag = 1;
    for (uint32_t i = 0; i < ARRAY_SIZE; i++) {
        if (results[i] != verify_data[i]) {
            flag = 0;
            return;
        }
    }
}

void hart1_main() {
#if MULTICORE
    matmul(1, 2, DIM_SIZE, input1_data, input2_data, results);
#endif
    hart1_done = 1;
}

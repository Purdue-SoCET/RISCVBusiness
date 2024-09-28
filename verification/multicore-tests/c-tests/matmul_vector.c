#include "utility.h"
#include <riscv_vector.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define DIM_SIZE 16

#define MULTICORE 1

#if MULTICORE
#define NUM_CORES 2
#else
#define NUM_CORES 1
#endif

#if DIM_SIZE == 2

static uint32_t input1_data[DIM_SIZE][DIM_SIZE] = {
    {16, 16},
    {22, 30},
};
static uint32_t input2_data[DIM_SIZE][DIM_SIZE] = {
    {6, 3},
    {3, 1},
};
static uint32_t verify_data[DIM_SIZE][DIM_SIZE] = {
    {144, 64},
    {222, 96},
};

#elif DIM_SIZE == 3

static uint32_t input1_data[DIM_SIZE][DIM_SIZE] = {
    {3, 2, 1},
    {1, 2, 3},
    {2, 2, 2},
};
static uint32_t input2_data[DIM_SIZE][DIM_SIZE] = {
    {4, 5, 6},
    {6, 5, 4},
    {6, 6, 6},
};
static uint32_t verify_data[DIM_SIZE][DIM_SIZE] = {
    {30, 31, 32},
    {34, 33, 32},
    {32, 32, 32},
};

#elif DIM_SIZE == 4

static uint32_t input1_data[DIM_SIZE][DIM_SIZE] = {
    {12, 10, 1, 21},
    {20, 4, 23, 11},
    {22, 18, 7, 22},
    {16, 8, 13, 12},
};

static uint32_t input2_data[DIM_SIZE][DIM_SIZE] = {
    {12, 19, 5, 16},
    {13, 23, 4, 16},
    {11, 28, 21, 26},
    {23, 30, 2, 15},
};
static uint32_t verify_data[DIM_SIZE][DIM_SIZE] = {
    {768, 1116, 163, 693},
    {798, 1446, 621, 1147},
    {1081, 1688, 373, 1152},
    {715, 1212, 409, 902},
};

#elif DIM_SIZE == 5

static uint32_t input1_data[DIM_SIZE][DIM_SIZE] = {
    {21, 13, 27, 23, 10}, {21, 8, 12, 11, 20},  {13, 6, 23, 6, 13},
    {0, 25, 12, 24, 25},  {10, 13, 25, 29, 23},
};
static uint32_t input2_data[DIM_SIZE][DIM_SIZE] = {
    {5, 18, 25, 3, 15},   {26, 4, 24, 4, 4},  {30, 6, 9, 21, 1},
    {15, 12, 16, 15, 26}, {27, 23, 2, 5, 17},
};
static uint32_t verify_data[DIM_SIZE][DIM_SIZE] = {
    {1868, 1098, 1468, 1077, 1162}, {1378, 1074, 1041, 612, 985},   {1352, 767, 798, 701, 619},
    {2045, 1035, 1142, 837, 1161},  {2194, 1259, 1297, 1157, 1372},
};

#elif DIM_SIZE == 16

static uint32_t input1_data[DIM_SIZE][DIM_SIZE] = {
    {0, 3, 2, 0, 3, 1, 0, 3, 2, 3, 2, 0, 3, 3, 1, 2},
    {3, 0, 0, 1, 1, 1, 2, 3, 1, 2, 3, 1, 1, 3, 2, 2},
    {0, 1, 3, 2, 2, 2, 0, 0, 1, 0, 1, 3, 3, 0, 3, 3},
    {3, 3, 0, 3, 2, 1, 2, 2, 0, 0, 3, 0, 1, 1, 0, 3},
    {3, 1, 2, 3, 3, 0, 1, 2, 1, 0, 1, 2, 2, 1, 0, 3},
    {1, 0, 2, 2, 1, 1, 1, 1, 1, 1, 2, 0, 3, 1, 1, 2},
    {2, 3, 3, 1, 3, 2, 0, 0, 0, 3, 3, 3, 2, 1, 2, 3},
    {1, 0, 0, 0, 0, 1, 2, 2, 1, 1, 3, 3, 3, 1, 1, 2},
    {3, 1, 3, 3, 2, 3, 2, 1, 2, 3, 0, 2, 2, 1, 1, 0},
    {0, 0, 0, 0, 1, 3, 3, 1, 1, 1, 2, 2, 3, 2, 1, 1},
    {1, 1, 3, 0, 2, 2, 1, 3, 2, 1, 2, 2, 1, 3, 1, 3},
    {1, 3, 2, 3, 1, 2, 1, 3, 2, 2, 0, 1, 0, 0, 1, 2},
    {3, 3, 1, 0, 0, 0, 3, 1, 2, 3, 2, 3, 2, 0, 0, 0},
    {0, 0, 3, 1, 3, 0, 0, 0, 3, 1, 1, 1, 1, 2, 1, 2},
    {3, 2, 0, 0, 2, 2, 3, 0, 3, 0, 0, 3, 0, 3, 1, 3},
    {3, 1, 1, 1, 2, 2, 1, 3, 0, 3, 3, 1, 0, 0, 3, 2}};
static uint32_t input2_data[DIM_SIZE][DIM_SIZE] = {
    {1, 1, 0, 3, 1, 2, 0, 0, 0, 0, 0, 2, 1, 2, 3, 0},
    {0, 3, 3, 2, 2, 1, 2, 3, 3, 0, 2, 2, 1, 1, 2, 2},
    {0, 2, 2, 1, 2, 3, 2, 2, 3, 3, 2, 2, 1, 1, 1, 1},
    {2, 1, 2, 2, 3, 3, 3, 0, 0, 3, 2, 3, 2, 3, 1, 2},
    {1, 1, 2, 2, 0, 1, 0, 3, 2, 1, 1, 1, 2, 0, 1, 2},
    {2, 0, 2, 1, 3, 3, 2, 3, 2, 0, 3, 1, 3, 3, 2, 0},
    {1, 0, 1, 1, 2, 2, 1, 1, 2, 2, 1, 2, 3, 3, 1, 3},
    {2, 2, 2, 3, 3, 1, 0, 2, 1, 0, 0, 0, 1, 1, 2, 0},
    {3, 2, 3, 3, 0, 2, 3, 1, 0, 0, 2, 1, 2, 0, 2, 1},
    {1, 2, 3, 1, 3, 2, 1, 0, 0, 0, 0, 0, 2, 2, 0, 2},
    {1, 2, 0, 3, 2, 2, 0, 0, 3, 2, 1, 1, 3, 0, 2, 0},
    {0, 1, 0, 2, 3, 3, 1, 3, 3, 0, 0, 2, 2, 0, 0, 0},
    {1, 0, 0, 1, 3, 0, 2, 1, 3, 2, 2, 1, 3, 2, 0, 1},
    {2, 2, 3, 2, 1, 1, 1, 1, 3, 0, 1, 3, 2, 2, 3, 1},
    {1, 2, 0, 2, 1, 1, 2, 3, 1, 0, 1, 0, 1, 1, 0, 0},
    {2, 0, 3, 0, 3, 0, 3, 2, 2, 3, 3, 2, 1, 0, 2, 2}};
static uint32_t verify_data[DIM_SIZE][DIM_SIZE] = {
    {36, 44, 57, 50, 54, 36, 38, 46, 55, 25, 38, 34, 51, 30, 40, 32},
    {37, 34, 38, 52, 51, 40, 28, 32, 41, 22, 26, 35, 49, 35, 42, 23},
    {26, 26, 33, 36, 52, 40, 45, 49, 50, 34, 41, 35, 44, 25, 23, 23},
    {31, 29, 39, 46, 50, 36, 31, 32, 42, 32, 34, 41, 44, 33, 43, 30},
    {31, 28, 39, 46, 50, 40, 35, 37, 43, 35, 33, 43, 43, 29, 37, 29},
    {27, 22, 30, 33, 43, 31, 32, 25, 36, 31, 31, 29, 40, 28, 26, 22},
    {29, 42, 48, 51, 65, 52, 43, 54, 63, 34, 42, 44, 56, 33, 38, 32},
    {26, 22, 23, 38, 49, 32, 26, 30, 43, 22, 24, 27, 45, 24, 26, 17},
    {35, 35, 47, 51, 59, 59, 43, 42, 43, 28, 37, 43, 56, 48, 36, 32},
    {28, 19, 28, 34, 46, 34, 28, 34, 45, 20, 29, 28, 50, 32, 26, 21},
    {37, 38, 51, 50, 55, 45, 38, 49, 56, 28, 38, 40, 50, 29, 44, 26},
    {32, 35, 50, 43, 53, 44, 41, 41, 34, 24, 35, 34, 39, 33, 34, 29},
    {21, 33, 31, 45, 48, 42, 27, 29, 40, 17, 21, 32, 45, 30, 29, 26},
    {26, 27, 38, 33, 29, 31, 32, 31, 35, 25, 29, 29, 34, 15, 25, 23},
    {34, 28, 44, 45, 41, 41, 37, 45, 45, 17, 34, 44, 46, 30, 43, 29},
    {31, 36, 37, 50, 54, 44, 28, 40, 38, 22, 27, 28, 45, 32, 36, 22}};

#endif

__attribute__((section(".noinit"))) uint32_t results[DIM_SIZE][DIM_SIZE];

void matmul(const size_t coreid, const size_t ncores, const uint32_t A[DIM_SIZE][DIM_SIZE],
            const uint32_t B[DIM_SIZE][DIM_SIZE], uint32_t C[DIM_SIZE][DIM_SIZE]) {
    size_t block = DIM_SIZE / ncores;
    size_t start = block * coreid;
    bool should_handle_tail = DIM_SIZE % 2 && coreid == (ncores - 1);

    size_t vlmax = __riscv_vsetvlmax_e32m1();
    for (size_t row = start; row < (start + block + should_handle_tail); row++) {
        for (size_t col = 0; col < DIM_SIZE; col++) {
            const uint32_t *ptr_a = &A[row][0];
            const uint32_t *ptr_b = &B[0][col];
            int k = DIM_SIZE;
            vuint32m1_t vec_s = __riscv_vmv_v_x_u32m1(0, vlmax);
            vuint32m1_t vec_zero = __riscv_vmv_v_x_u32m1(0, vlmax);
            for (size_t vl; k > 0; k -= vl, ptr_a += vl, ptr_b += (DIM_SIZE * vl)) {
                vl = __riscv_vsetvl_e32m1(k);
                vuint32m1_t vec_a = __riscv_vle32_v_u32m1(ptr_a, vl);
                vuint32m1_t vec_b = __riscv_vlse32_v_u32m1(ptr_b, DIM_SIZE * sizeof(uint32_t), vl);

                vec_s = __riscv_vmacc_vv_u32m1(vec_s, vec_a, vec_b, vl);
            }
            vuint32m1_t vec_sum = __riscv_vredsum_vs_u32m1_u32m1(vec_s, vec_zero, vlmax);
            uint32_t sum = __riscv_vmv_x_s_u32m1_u32(vec_sum);
            C[row][col] = sum;
        }
    }
}

void print_array(const uint32_t results[DIM_SIZE][DIM_SIZE]) {
    for (size_t i = 0; i < DIM_SIZE; i++) {
        for (size_t j = 0; j < DIM_SIZE; j++) {
            print("%d, ", results[i][j]);
        }
        print("\n");
    }
}

void hart0_main() {
    matmul(0, NUM_CORES, input1_data, input2_data, results);
    wait_for_hart1_done();
    flag = 1;

    for (uint32_t i = 0; i < DIM_SIZE; i++) {
        for (uint32_t j = 0; j < DIM_SIZE; j++) {
            if (results[i][j] != verify_data[i][j]) {
                print("i: %d, j: %d, results: %d, verify: %d\n", i, j, results[i][j],
                      verify_data[i][j]);
                print_array(results);
                flag = 0;
                return;
            }
        }
    }
}

void hart1_main() {
#if MULTICORE
    matmul(1, NUM_CORES, input1_data, input2_data, results);
#endif
    hart1_done = 1;
}

#include <stdio.h>
#include <stdint.h>
#include "amo_tests.h"

int test_amo_add() {
    int32_t mem_val = 10;
    int32_t increment = 5;
    int32_t original_val;

    asm volatile (
        "amoadd.w %0, %2, (%1)"
        : "=r" (original_val)
        : "r" (&mem_val), "r" (increment)
        : "memory"
    );

    if (original_val == 10 && mem_val == 15) {
        return 1;
    }
    return 0; 
}


int test_amo_swap() {
    int32_t lock_val = 0;
    int32_t new_val = 1;
    int32_t prev_val;

    asm volatile (
        "amoswap.w %0, %2, (%1)"
        : "=r" (prev_val)
        : "r" (&lock_val), "r" (new_val)
        : "memory"
    );

    if (prev_val == 0 && lock_val == 1) {
        return 1;
    }
    return 0;
}

int test_amo_max() {
    int32_t mem_val = -50;
    int32_t compare_val = 20;
    int32_t returned_val;

    asm volatile (
        "amomax.w %0, %2, (%1)"
        : "=r" (returned_val)
        : "r" (&mem_val), "r" (compare_val)
        : "memory"
    );

    if (returned_val == -50 && mem_val == 20) {
        return 1;
    }
    return 0;
}

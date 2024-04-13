#include "utility.h"

#define N 35

uint32_t global = 0;

void hart0_main() {
    volatile uint32_t *ptr = &global;
    for (int i = 0; i < N; i++) {
        (*ptr)++;
    }
    while (hart1_done == 0) {}
    flag = global == (N * 2);
}

void hart1_main() {
    volatile uint32_t *ptr = &global;
    for (int i = 0; i < N; i++) {
        (*ptr)++;
    }
    hart1_done = 1;
}

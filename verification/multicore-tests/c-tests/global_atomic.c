#include "fast_amo_emu.h"
#include "utility.h"

#define N 500

uint32_t global = 0;

void hart0_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    while (hart1_done == 0) {}
    flag = global == (N * 2);
}

void hart1_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    hart1_done = 1;
}

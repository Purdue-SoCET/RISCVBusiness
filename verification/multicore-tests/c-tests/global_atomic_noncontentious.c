#include "fast_amo_emu.h"
#include "utility.h"

#define N 10

// List so that globals aren't in the same cache lines
uint32_t global[4] = {0, 0, 0, 0};

void hart0_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global[0], 1);
    }
    wait_for_hart1_done();
    flag = (global[0] + global[2]) == (N * 2);
}

void hart1_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global[2], 1);
    }
    hart1_done = global[2] == N;
}

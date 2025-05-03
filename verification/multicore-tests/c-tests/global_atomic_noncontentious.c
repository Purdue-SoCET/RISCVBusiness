#include "fast_amo_emu.h"
#include "utility.h"

#define N 10
#define NUM_HART 1

// List so that globals aren't in the same cache lines
uint32_t global[4] = {0, 0, 0, 0};

void hart0_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global[0], 1);
    }

    hart_done = global[0] == N;

    wait_for_all_harts_done(NUM_HART);

    flag = (global[0] + global[2]) == (N * NUM_HART);
}

void hart1_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global[2], 1);
    }
    hart1_done = global[2] == N;
}

void hart2_main() {}
void hart3_main() {}
void hart4_main() {}
void hart5_main() {}
void hart6_main() {}
void hart7_main() {}
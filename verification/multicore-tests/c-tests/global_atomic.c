#include "fast_amo_emu.h"
#include "utility.h"

#define N 500

uint32_t global = 0;

void hart0_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    wait_for_hart1_done();
    flag = global == (N * 2);
}

void hart1_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    hart1_done = 1;
}

void hart2_main() {}
void hart3_main() {}
void hart4_main() {}
void hart5_main() {}
void hart6_main() {}
void hart7_main() {}
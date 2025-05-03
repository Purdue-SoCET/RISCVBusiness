#include "fast_amo_emu.h"
#include "utility.h"

#define N 256
#define NUM_HART 2

uint32_t global = 0;

void hart0_main() {
    int beginning_cycle = get_cycles();
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    hart_done = 1;
    print("hart 0 waiting for all hart done\n");
    wait_for_all_harts_done(NUM_HART);
    print("all hart done\n");
    int ending_cycle = get_cycles();
    print("%x\n", ending_cycle - beginning_cycle);
    flag = global == (N * NUM_HART);
}

void hart1_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    hart1_done = 1;
    print("hart1 done\n");
}
 
void hart2_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    hart2_done = 1;
    print("hart2 done\n");
}
void hart3_main() {
    for (int i = 0; i < N; i++) {
        atomic_add(&global, 1);
    }
    hart3_done = 1;
    print("hart3 done\n");
}
void hart4_main() {}
void hart5_main() {}
void hart6_main() {}
void hart7_main() {}
#include "fast_amo_emu.h"
#include "utility.h"

#define N 256
#define NUM_HART 8

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

#define HARTN_MAIN(n)                                                          \
    void hart##n##_main() {                                                    \
        for (int i = 0; i < N; i++) {                                          \
            atomic_add(&global, 1);                                            \
        }                                                                      \
        hart##n##_done = 1;                                                    \
        print("hart " #n " done\n");                                           \
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

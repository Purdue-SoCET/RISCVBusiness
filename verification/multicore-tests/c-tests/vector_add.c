// Contentious Vector Add (false-sharing heavy)
// Interleaved writes across harts to maximize coherence traffic
#include "utility.h"
#include <stddef.h>
#include <stdint.h>


#define ARRAY_SIZE 216

#define NUM_HART 1

#define REPEATS 4

static uint32_t A[ARRAY_SIZE];
static uint32_t B[ARRAY_SIZE];
static uint32_t C[ARRAY_SIZE];

static volatile uint32_t start_flag = 0;

static inline void init_data(void) {
    for (size_t i = 0; i < ARRAY_SIZE; i++) {
        A[i] = (uint32_t)((i * 3u + 1u) & 0x3Fu);
        B[i] = (uint32_t)((i * 5u + 7u) & 0x3Fu);
        C[i] = 0;
    }
}

static inline void warmup(void) {
    volatile uint32_t t = 0;
    for (size_t i = 0; i < ARRAY_SIZE; i++) t ^= A[i];
    for (size_t i = 0; i < ARRAY_SIZE; i++) t ^= B[i];
    (void)t;
}

#pragma GCC optimize("unroll-loops")
static void vecadd_interleaved(size_t coreid, size_t ncores) {
    for (int r = 0; r < REPEATS; r++) {
        for (size_t i = coreid; i < ARRAY_SIZE; i += ncores) {
            C[i] = A[i] + B[i];
        }
    }
}

static void verify_per_core(size_t coreid, size_t ncores) {
    size_t start = (ARRAY_SIZE / ncores) * coreid;
    size_t end   = (coreid == ncores - 1) ? ARRAY_SIZE : (ARRAY_SIZE / ncores) * (coreid + 1);
    for (size_t i = start; i < end; i++) {
        uint32_t want = A[i] + B[i];
        if (C[i] != want) {
            print("hart %d verify failed at %d: got %u want %u\n", (int)coreid, (int)i, C[i], want);
            return;
        }
    }
    print("hart %d verify OK on its slice.\n", (int)coreid);
}

static void verify_all(void) {
    for (size_t i = 0; i < ARRAY_SIZE; i++) {
        uint32_t want = A[i] + B[i];
        if (C[i] != want) {
            print("Global verify failed at %d: got %u want %u\n", (int)i, C[i], want);
            return;
        }
    }
    print("Data is correct!\n");
}

void hart0_main() {
    warmup();
    init_data();
    start_flag = 1;

    uint32_t begin = get_cycles();
    vecadd_interleaved(0, NUM_HART);
    hart_done = 1;
    wait_for_all_harts_done(NUM_HART);

    uint32_t end = get_cycles();
    uint32_t cycles = end - begin;

    verify_all();

    print("hart0 done\n");
    print("Took %u cycles (NUM_HART=%d, ARRAY_SIZE=%d, REPEATS=%d)\n",
          (unsigned)cycles, NUM_HART, ARRAY_SIZE, REPEATS);
    flag = 1;
}

#define HARTN_WAIT_START(n)        \
    do {                           \
        while (!start_flag) { ; }  \
    } while (0)

#define HARTN_MAIN(n)                                                         \
    void hart##n##_main() {                                                   \
        warmup();                                                             \
        HARTN_WAIT_START(n);                                                  \
        vecadd_interleaved((n), NUM_HART);                                    \
        hart##n##_done = 1;                                                   \
        print("hart" #n " done\n");                                           \
        verify_per_core((n), NUM_HART);                                       \
        return;                                                               \
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

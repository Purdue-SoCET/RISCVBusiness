#include "utility.h"
#include <stdint.h>
#include <stddef.h>

#define NUM_HART    2
#define ARRAY_SIZE  256

//----HELPER-----
void wfi(void) {
    __asm__ volatile("wfi");
}

//----SHARED-----
//handshake flags (volitile cause they might change between cores)
extern volatile uint32_t hart1_ready_for_initial_sleep = 0;
extern volatile uint32_t hart1_awake_and_worked       = 0;
extern volatile uint32_t hart1_sleep_again_request    = 0;
extern volatile uint32_t hart1_sleeping_again         = 0;

//provided by runtime
extern volatile uint32_t flag;

void do_some_work(int id) {
    volatile uint32_t x = 0;
    for (int i = 0; i < 1000; i++) {
        x += (uint32_t)(i + id);
    }
    (void)x;
}

//----HART 0-----
void hart0_main(void) {
    print("hart0: starting simple WFI handshake test\n");

    print("hart0: waiting for hart1 to signal ready_for_initial_sleep\n");
    while (!hart1_ready_for_initial_sleep) {
    }

    print("hart0: hart1 is ready; requesting it to enter WFI\n");
    hart1_sleep_again_request = 1;

    print("hart0: waiting for hart1 to report it is sleeping (in WFI)\n");
    while (!hart1_sleeping_again) {
    }

    print("hart0: hart1 reports it has entered WFI; marking test complete\n");
    flag = 1;

    return;
}

//----HART 1-----
void hart1_main(void) {
    print("hart1: starting, preparing for initial sleep\n");

    hart1_ready_for_initial_sleep = 1;

    print("hart1: waiting for sleep request from hart0\n");
    while (!hart1_sleep_again_request) {
    }

    print("hart1: received sleep request; entering WFI\n");
    hart1_sleeping_again = 1;

    wfi();

    while (1) {
        wfi();
    }
}

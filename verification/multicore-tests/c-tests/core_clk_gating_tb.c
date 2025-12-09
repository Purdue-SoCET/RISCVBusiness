#include "utility.h"
#include <stdint.h>
#include <stddef.h>

#define NUM_HART    2
#define ARRAY_SIZE  256

#define MSIP_ADDR 0xFFFFFFF0
#define MSIP (*(volatile uint32_t *)MSIP_ADDR)

//----HELPERS-----
void wfi(void) {
    __asm__ volatile("wfi");
}

void set_msip(void) {
    MSIP = 1;
}

void clear_msip(void) {
    MSIP = 0;
}

//----WORK FUNC----
void do_some_work(int id) {
    volatile uint32_t x = 0;
    for (int i = 0; i < 1000; i++) {
        x += (uint32_t)(i + id);
    }
    (void)x;
}

//----HART 0-----
void hart0_main(void) {
    print("hart0: starting clock-gating sleep/wake test\n");
    clear_msip();

    print("hart0: waiting for hart1 to enter initial WFI\n");
    while (!hart1_ready_for_initial_sleep) {
        // spin
    }

    print("hart0: hart1 is sleeping; doing some work while it sleeps\n");
    do_some_work(0);

    print("hart0: raising MSIP to wake hart1\n");
    set_msip();
  
    while (!hart1_awake_and_worked) {
        // spin
    }
    print("hart0: hart1 has woken up and done its work\n");

    print("hart0: requesting hart1 to sleep again and clearing MSIP\n");
    hart1_sleep_again_request = 1;
    clear_msip();

    do_some_work(0);

    while (!hart1_sleeping_again) {
        // spin
    }

    flag = 1;
    print("hart0: test complete, flag set to 1\n");

    return;
}

//----HART 1-----
void hart1_main(void) {
    print("hart1: starting, preparing for initial sleep\n");
    clear_msip();

    hart1_ready_for_initial_sleep = 1;

    print("hart1: entering initial WFI (should gate clock)\n");
    wfi();

    print("hart1: woke up from WFI due to MSIP\n");
    clear_msip();
  
    print("hart1: doing some work after wake\n");
    do_some_work(1);
    hart1_awake_and_worked = 1;

    print("hart1: waiting for hart0 to request second sleep\n");
    while (!hart1_sleep_again_request) {
        // spin
    }

    print("hart1: clearing MSIP and going back to WFI (second sleep)\n");
    clear_msip();
    wfi(); 

    hart1_sleeping_again = 1;
    print("hart1: went back to sleep; staying in low-power loop\n");

    return;
}

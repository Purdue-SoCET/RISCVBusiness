#include <stdint.h>
#include <stddef.h>
#include "utility.h"

static void *resume_addr = NULL;

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    print("Made it to handler!\n");
    flag = 1;
    // Write mepc = resume_addr
    asm volatile("csrw mepc, %0" : : "r"((uint32_t)resume_addr));
}

int main() {
    /**
     * Note: This uses GCC 'labels as values' feature
     * to get the address to return from the interrupt.
     * Can't always assume it will be a 4B instruction,
     * as it could generate multiple instructions or even
     * a 2B load.
     */
    // get the return address stored in global
    resume_addr = &&resume_point;
    uint32_t mtvec_value = (uint32_t)handler;
    uint32_t mstatus_value = 0x8;

    asm volatile("csrw mstatus, %0" : : "r" (mstatus_value));
    asm volatile("csrw mtvec, %0" : : "r" (mtvec_value));

    print("Read 0x0\n");

    // GCC doesn't like us trying to read 0x4
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warray-bounds"
    int x = *(volatile int *)(0x4);
#pragma GCC diagnostic pop
    (void)x;

resume_point:
    if(flag != 1) {
        print("Failed!\n");
    } else {
        print("Bus fault, pass!\n");
    }

    return 0;
}

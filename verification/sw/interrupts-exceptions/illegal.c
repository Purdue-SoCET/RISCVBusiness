
#include <stdint.h>
#include "utility.h"

extern volatile int flag;

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    uint32_t mepc_value;
    asm volatile("csrr %0, mepc" : "=r"(mepc_value));
    mepc_value += 4;
    asm volatile("csrw mepc, %0" : : "r"(mepc_value));

    print("Made it to handler!");
    flag = 1;
}

int main() {
    uint32_t mtvec_value = (uint32_t)handler;
    uint32_t mstatus_value = 0x8;

    asm volatile("csrw mstatus, %0" : : "r"(mstatus_value));
    asm volatile("csrw mtvec, %0" : : "r"(mtvec_value));

    print("Executing illegal instruction\n");
    asm volatile(".word 0xFFFFFFFF");

    print("Flag is 0x");
    put_uint32_hex(flag);
    print("\n");

    return 0;
}
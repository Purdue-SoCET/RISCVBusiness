#include <stdint.h>
#include "utility.h"

extern volatile int flag;

#define PMA_ROM_ADDR 0x100
#define PMA_RAM_ADDR 0x20000000
volatile uint32_t *pma_rom_addr = (uint32_t*) PMA_ROM_ADDR;
volatile uint32_t *pma_ram_addr = (uint32_t*) PMA_RAM_ADDR;

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    // In a real program, a fault should be handled differently
    uint32_t mepc_value;
    asm volatile("csrr %0, mepc" : "=r"(mepc_value));
    mepc_value += 4;
    asm volatile("csrw mepc, %0" : : "r"(mepc_value));

    print("PMA Checker failed (expected)\n");
    flag = 2;
}

int main() {
    uint32_t mtvec_value = (uint32_t) handler;
    uint32_t mstatus_value = 0x8;

    asm volatile("csrw mstatus, %0" : : "r" (mstatus_value));
    asm volatile("csrw mtvec, %0" : : "r" (mtvec_value));

    // This should fail
    *pma_rom_addr = 0xDEADBEEF;

    // This should succeed
    *pma_ram_addr = 0xDEADBEEF;
    flag -= 1;

    return 0;
}

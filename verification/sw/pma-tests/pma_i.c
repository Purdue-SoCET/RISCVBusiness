#include <stdint.h>
#include "utility.h"

extern volatile int flag;
extern void done();

#define PMA_ROM_ADDR 0x100
#define PMA_RAM_ADDR 0x20000000
volatile uint32_t *pma_rom_addr = (uint32_t*) PMA_ROM_ADDR;
volatile uint32_t *pma_ram_addr = (uint32_t*) PMA_RAM_ADDR;

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    // In a real program, a fault should be handled differently
    uint32_t mepc_value;
    uint32_t mtval_value;
    asm volatile("csrr %0, mepc" : "=r"(mepc_value));
    asm volatile("csrr %0, mtval" : "=r"(mtval_value));
    mepc_value = (uint32_t)done; // return to the spot after we did the bad jump
    asm volatile("csrw mepc, %0" : : "r"(mepc_value));

    print("PMA Checker failed (expected)\n");
    print("MTVAL: ");
    put_uint32_hex(mtval_value);
    print("\n");
    flag = 1;
}

int main() {
    uint32_t mtvec_value = (uint32_t) handler;
    uint32_t mstatus_value = 0x8;

    // Disable all permissions for "rom" region of PMA
    uint32_t pma_value = 0x3BF1 & ~(0x3800); // 0x3800 masks out RWX permissions
    asm volatile("csrw 0xBC0, %0" : : "r"(pma_value));

    // Set up interrupts
    asm volatile("csrw mstatus, %0" : : "r" (mstatus_value));
    asm volatile("csrw mtvec, %0" : : "r" (mtvec_value));

    // After jump, instruction fetch will cause instruction fault
    asm volatile("jr %0" : : "r" (pma_rom_addr));

    // Never reached if successful since handler will jump directly to "done"
    return 0;
}

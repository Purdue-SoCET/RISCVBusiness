#include <stdint.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

#define PMA_ROM_ADDR 0x100
#define PMA_RAM_ADDR 0x20000000
volatile uint32_t *pma_rom_addr = (uint32_t*) PMA_ROM_ADDR;
volatile uint32_t *pma_ram_addr = (uint32_t*) PMA_RAM_ADDR;

/*
* PMA Test - check instruction fault on fetch from
* non-executable region. 
*/

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    uint32_t mtval_value = CSRR("mtval");
    set_mepc(&done);

    print("PMA Checker failed (expected)\n");
    print("MTVAL: %x\n", mtval_value);
    flag = 1;
}

int main() {
    uint32_t pma_value = 0x3BF1 & ~(0x3800);
    CSRW("0xBC0", pma_value);

    setup_interrupts_m(handler, 0);

    asm volatile("jr %0" : : "r" (pma_rom_addr));

    return 0;
}

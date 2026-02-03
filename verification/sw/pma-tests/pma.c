#include <stdint.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

#define PMA_ROM_ADDR 0x100
#define PMA_RAM_ADDR 0x20000000
volatile uint32_t *pma_rom_addr = (uint32_t*) PMA_ROM_ADDR;
volatile uint32_t *pma_ram_addr = (uint32_t*) PMA_RAM_ADDR;

/*
* PMA Test - check store fault on store to
* ROM region (rx permissions)
*/

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    advance_mepc(4);
    print("PMA Check failed successfully\n");
    flag = 2;
}

int main() {
    setup_interrupts_m(handler, 0);

    *pma_rom_addr = 0xDEADBEEF;

    *pma_ram_addr = 0xDEADBEEF;
    flag -= 1;

    if (flag == 1) {
        test_pass("PMA write protection test");
    } else {
        test_fail("PMA write protection test");
    }

    return 0;
}

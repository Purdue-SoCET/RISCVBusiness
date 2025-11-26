#include <stdint.h>
#include "csr.h"
#include "format.h"
#include "utility.h"
#include "pmp_util.h"

#define BAD_PMP_BOT 0x40000000
#define BAD_PMP_TOP ((ADDR_G(0x40000020, G + 1) + 1) << 2)

/*
*  Validate PMP TOR (Top-of-Range) mode. 
*/

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    advance_mepc(4);

    uint32_t mtval = CSRR("mtval");
    print("PMP Unit Handler tripped: %x\n", mtval >> 2);
    flag -= 1;
}

int main() {
    volatile uint32_t *bad_pmp_addr_bot = (uint32_t*) BAD_PMP_BOT;
    volatile uint32_t *bad_pmp_addr_top = (uint32_t*) BAD_PMP_TOP;

    setup_interrupts_m(handler, 0);

    flag = 7;

    uint32_t pmp_cfg = 0x1F1F0000;
    CSRW("pmpcfg0", pmp_cfg);
    uint32_t pmp_addr = ADDR_G(0x80000000, 14);
    CSRW("pmpaddr2", pmp_addr);
    pmp_addr = ADDR_G(0xFFFFFFE0, 4);
    CSRW("pmpaddr3", pmp_addr);

    pmp_cfg = 0x00000800;
    CSRS("pmpcfg0", pmp_cfg);
    pmp_addr = (BAD_PMP_TOP >> 2);
    CSRW("pmpaddr1", pmp_addr);
    pmp_addr = (BAD_PMP_BOT >> 2);
    CSRW("pmpaddr0", pmp_addr);
    *(bad_pmp_addr_bot + 4) = 0xDEADBEEF;
    flag -= 1;
    *(bad_pmp_addr_top) = 0xDEADBEEF;
    flag -= 1;

    uint32_t mstatus = 0x20000;
    CSRW("mstatus", mstatus);
    *(bad_pmp_addr_bot + 4) = 0xABCD1234;
    *(bad_pmp_addr_top) = 0xABCD1234;

    CSRC("mstatus", mstatus);
    pmp_cfg = 0x00008000;
    CSRS("pmpcfg0", pmp_cfg);
    *(bad_pmp_addr_bot + 4) = 0x0987FEDC;
    *(bad_pmp_addr_top) = 0x0987FEDC;
    flag -= 1;

    if (flag == 1) {
        test_pass("PMP TOR test");
    } else {
        test_fail("PMP TOR test");
    }

    return 0;
}

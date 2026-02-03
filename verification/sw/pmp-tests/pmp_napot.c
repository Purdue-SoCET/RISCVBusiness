#include <stdint.h>
#include "csr.h"
#include "format.h"
#include "utility.h"
#include "pmp_util.h"

#define BAD_PMP_ADDR 0x40000000
volatile uint32_t *bad_pmp_addr = (uint32_t*) BAD_PMP_ADDR;

/*
*  Validates NAPOT (Naturally Aligned Power-of-Two) PMP
*  region handling. Requires pmp granularity <= 64KB
*/

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    advance_mepc(4);

    uint32_t mtval = CSRR("mtval");
    print("PMP Unit Handler tripped: %x\n", mtval >> 2);
    flag -= 1;
}

int main() {
    setup_interrupts_m(handler, 0);

    flag = 9;

    uint32_t pmp_cfg = 0x001F1F00;
    CSRW("pmpcfg0", pmp_cfg);
    uint32_t pmp_addr = ADDR_G(0x80000000, 14);
    CSRW("pmpaddr1", pmp_addr);
    pmp_addr = ADDR_G(0xFFFFFFE0, 4);
    CSRW("pmpaddr2", pmp_addr);

    pmp_cfg = 0x00000018;
    pmp_addr = ADDR_G(BAD_PMP_ADDR, 14);
    CSRS("pmpcfg0", pmp_cfg);
    CSRW("pmpaddr0", pmp_addr);
    *bad_pmp_addr = 0xDEADBEEF;
    flag -= 1;
    *(bad_pmp_addr + 4) = 0xDEADBEEF;
    flag -= 1;

    pmp_addr = 0xFFFFFFFF;
    CSRW("pmpaddr0", pmp_addr);
    *bad_pmp_addr = 0xBEAD6CFB;
    flag -= 1;
    *(bad_pmp_addr + 4) = 0xBEAD6CFB;
    flag -= 1;

    pmp_addr = ADDR_G(BAD_PMP_ADDR, 14);
    CSRW("pmpaddr0", pmp_addr);
    uint32_t mstatus = 0x20000;
    CSRW("mstatus", mstatus);
    *bad_pmp_addr = 0xABCD1234;
    *(bad_pmp_addr + 4) = 0xABCD1234;

    CSRC("mstatus", mstatus);
    pmp_cfg = 0x00000098;
    CSRS("pmpcfg0", pmp_cfg);
    *bad_pmp_addr = 0x0987FEDC;
    *(bad_pmp_addr + 4) = 0x0987FEDC;

    if (flag == 1) {
        test_pass("PMP NAPOT test");
    } else {
        test_fail("PMP NAPOT test");
    }

    return 0;
}

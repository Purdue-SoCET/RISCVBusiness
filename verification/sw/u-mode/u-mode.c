#include <stdint.h>
#include <stdnoreturn.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    exception_context_t ctx;
    read_exception_context(&ctx);
    print_exception_context(&ctx);

    if (ctx.cause == EX_ECALL_UMODE) {
        CSRS("mstatus", MSTATUS_MPP);
        set_mepc(&done);
    } else {
        advance_mepc(4);
        flag -= 1;
    }
}


noreturn void user_main(void) {
    print("A");

    flag = 0;

    asm volatile("mret");

    uint32_t temp;
    asm volatile("csrr %0, mstatus" : "=r"(temp));

    asm volatile("wfi");

    ecall();

    __builtin_unreachable();
}

int main(void) {
    setup_interrupts_m(handler, 0);

    uint32_t pmp_addr = ((uint32_t) (&flag)) >> 2;
    CSRW("pmpaddr0", pmp_addr);
    uint32_t actual_pmp_addr = CSRR("pmpaddr0");
    if (actual_pmp_addr != pmp_addr) {
        print("Set PMP granularity down to 4 to run this test!\n");
        CSRS("mstatus", MSTATUS_MPP);
        set_mepc(&done);
        asm volatile("mret");
    }

    pmp_addr = 0x20001FFF;
    CSRW("pmpaddr1", pmp_addr);
    uint32_t pmp_cfg = 0x00001F11;
    CSRW("pmpcfg0", pmp_cfg);

    flag = 6;
    set_mepc(user_main);
    asm volatile("mret");

    __builtin_unreachable();
}

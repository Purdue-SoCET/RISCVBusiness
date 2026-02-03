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
    uint32_t csr_val;

    asm volatile("csrr %0, cycle" : "=r"(csr_val));

    asm volatile("csrr %0, time" : "=r"(csr_val));

    ecall();

    __builtin_unreachable();
}

int main(void) {
    if (check_supervisor_mode_available()) {
        print("Supervisor is enabled.\n");
        print("Cycle and time CSR reads will fault in user mode.\n");
        print("Cycle and time CSR reads will not fault in superivsor mode.\n");
        flag = 5;
    } else {
        print("Supervisor is not enabled.\n");
        print("Cycle and time CSR reads will not fault in user mode.\n");
        flag = 3;
    }
    print("Setting flag to %x\n", flag);

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

    uint32_t csr_val_0 = 0x0;
    CSRW("mcycle", csr_val_0);
    csr_val_0 = CSRR("mcycle");
    asm volatile("nop; nop; nop;");
    uint32_t csr_val_1 = CSRR("cycle");

    if (csr_val_1 - csr_val_0 < 30) {
        flag -= 1;
    }

    asm volatile("csrw cycle, %0" : : "r"(csr_val_0));

    set_mepc(user_main);
    asm volatile("mret");

    __builtin_unreachable();
}

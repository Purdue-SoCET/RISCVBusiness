#include <stdint.h>
#include <stdnoreturn.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

void __attribute__((interrupt)) __attribute__((aligned(4))) m_mode_handler (void);
void __attribute__((interrupt)) __attribute__((aligned(4))) s_mode_handler (void);
noreturn void user_main (void);
noreturn void __attribute__((aligned(4))) setup_s_mode (void);

/*
*  csr.c - checks for access control of S-mode, U-mode CSRs.
*  Tests interrupt delegation from M-mode.
*/

void __attribute__((interrupt)) __attribute__((aligned(4))) m_mode_handler() {
    exception_context_t ctx;
    read_exception_context(&ctx);
    print_exception_context(&ctx);

    if (ctx.cause == EX_ECALL_SMODE) {
        CSRS("mstatus", MSTATUS_MPP);
        set_mepc(&done);
    } else {
        advance_mepc(4);
        flag -= 1;
    }
}

void __attribute__((interrupt)) __attribute__((aligned(4))) s_mode_handler() {
    exception_context_t ctx;
    read_exception_context_s(&ctx);
    print_exception_context(&ctx);

    if (ctx.cause == EX_ECALL_UMODE) {
        CSRS("sstatus", MSTATUS_SPP);
        set_sepc(&done);
    } else {
        advance_sepc(4);
        flag -= 1;
    }

    asm volatile("sret");
}

noreturn void user_main(void) {
    uint32_t csr_val;
    csr_val = CSRR("cycle");
    csr_val = CSRR("time");

    (void)csr_val;

    ecall();

    __builtin_unreachable();
}

int main(void) {
    require_supervisor_mode();

    CSRW("mtvec", (uint32_t) m_mode_handler);
    CSRS("mstatus", MSTATUS_MIE);

    CSRW("stvec", (uint32_t) s_mode_handler);
    CSRS("sstatus", 0x08);

    uint32_t pmp_addr = ((uint32_t) (&flag)) >> 2;
    CSRW("pmpaddr0", pmp_addr);
    uint32_t actual_pmp_addr = CSRR("pmpaddr0");
    if (actual_pmp_addr != pmp_addr) {
        print("Set PMP granularity down to 4 to run this test!\n");
        CSRS("mstatus", MSTATUS_MPP);
        set_mepc(&done);
        asm volatile("mret");
    }
    pmp_addr = 0xFFFFFFFF;
    CSRW("pmpaddr1", pmp_addr);
    uint32_t pmp_cfg = 0x00001F17;
    CSRW("pmpcfg0", pmp_cfg);

    flag = 5;

    uint32_t csr_val_0 = 0x0;
    CSRW("mcycle", csr_val_0);
    csr_val_0 = CSRR("mcycle");
    asm volatile("nop; nop; nop;");
    uint32_t csr_val_1 = CSRR("cycle");

    if (csr_val_1 - csr_val_0 < 30) {
        flag -= 1;
    }

    CSRW("cycle", csr_val_0);

    uint32_t medeleg = 0xFFFFFFFF;
    CSRW("medeleg", medeleg);

    set_sepc(user_main);
    asm volatile("sret");

    __builtin_unreachable();
}

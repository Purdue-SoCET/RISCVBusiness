#include <stdint.h>
#include <stdnoreturn.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

/*
*  s-mode.c - tests privilege protection from U-mode to S-mode.
*/

void __attribute__((interrupt)) __attribute__((aligned(4))) m_mode_handler() {
    exception_context_t ctx;
    read_exception_context(&ctx);
    print_exception_context(&ctx);

    // setup S-mode to go back to 'done'
    CSRS("sstatus", SSTATUS_SPP);
    set_sepc(&done);

    flag -= 1;
    // return to S-mode handler that called us
    advance_mepc(4);
    asm volatile("mret");
}

void __attribute__((interrupt)) __attribute__((aligned(4))) s_mode_handler() {
    exception_context_t ctx;
    read_exception_context_s(&ctx);
    print_exception_context(&ctx);

    if (ctx.cause == EX_ECALL_UMODE) {
        ecall();
    } else {
        advance_sepc(4);
        flag -= 1;
    }

    asm volatile("sret");
}

noreturn void user_main(void) {
    print("A"); // MMIO region is not allowed in PMP, should fail

    // flag = 0; // Flag is protected, should fail

    asm volatile("sret"); // privileged instruction

    uint32_t temp = CSRR("mstatus"); // Machine mode CSR
    (void)temp;

    asm volatile("wfi"); // No timeout wait enabled
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

    uint32_t medeleg = ~(1 << 9);
    CSRW("medeleg", medeleg);

    set_sepc(user_main);
    asm volatile("sret");

    __builtin_unreachable();
}

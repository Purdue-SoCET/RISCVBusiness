#include <stdint.h>
#include "utility.h"

extern volatile int flag;
extern volatile int done;

void __attribute__((interrupt)) __attribute__((aligned(4))) m_mode_handler() {
    // Trivial M-mode call to demonstrate that we can
    uint32_t mepc, mtval;
    mcause_t mcause;
    asm volatile("csrr %0, mepc" : "=r"(mepc));
    asm volatile("csrr %0, mtval" : "=r"(mtval));
    asm volatile("csrr %0, mcause" : "=r"((mcause_t) mcause));

    print("mepc: ");
    put_uint32_hex(mepc);
    print("\n");

    print("mtval: ");
    put_uint32_hex(mtval);
    print("\n");

    print("mcause: ");
    put_uint32_hex(mcause.interrupt & 0x1);
    print(" ");
    put_uint32_hex(mcause.ex_code);
    print("\n");

    print("-----\n");

    // Set up S-mode to go to done
    uint32_t mstatus = 0x1800; // set mpp back to M_MODE
    asm volatile("csrs sstatus, %0" : : "r"(mstatus));
    uint32_t sepc = (uint32_t) &done;
    asm volatile("csrw sepc, %0" : : "r"(sepc));

    flag -= 1;
    asm volatile("csrw mepc, %0" : : "r"(mepc+4));
    asm volatile("mret");
}

void __attribute__((interrupt)) __attribute__((aligned(4))) s_mode_handler() {
    uint32_t sepc, stval;
    scause_t scause;
    asm volatile("csrr %0, sepc" : "=r"(sepc));
    asm volatile("csrr %0, stval" : "=r"(stval));
    asm volatile("csrr %0, scause" : "=r"((scause_t) scause));

    print("sepc: ");
    put_uint32_hex(sepc);
    print("\n");

    print("stval: ");
    put_uint32_hex(stval);
    print("\n");

    print("scause: ");
    put_uint32_hex(scause.interrupt & 0x1);
    print(" ");
    put_uint32_hex(scause.ex_code);
    print("\n");

    print("-----\n");

    // Call M-mode handler to demonstrate delegation
    if (~scause.interrupt && scause.ex_code == 8){
        asm volatile("ecall"); // use this to finish up
    }
    else
    {
        sepc += 4;
        flag -= 1;
        asm volatile("csrw sepc, %0" : : "r"(sepc));
    }

    asm volatile("sret");
}

void __attribute__((noreturn)) user_main(void) {
    print("A"); // MMIO region is not allowed in PMP, should fail

    // flag = 0; // Flag is protected, should fail

    asm volatile("sret"); // privileged instruction

    uint32_t temp;
    asm volatile("csrr %0, mstatus" : "=r"(temp)); // Machine mode CSR

    asm volatile("wfi"); // No timeout wait enabled

    asm volatile("ecall"); // ends user_main

    __builtin_unreachable();

}

int main(void) {
    // Setup exceptions
    uint32_t mtvec_value = (uint32_t) m_mode_handler;
    uint32_t mstatus_value = 0x08;
    asm volatile("csrs mstatus, %0" : : "r"(mstatus_value));
    asm volatile("csrw mtvec, %0" : : "r"(mtvec_value));

    // Setup exceptions for S-mode
    uint32_t stvec_value = (uint32_t) s_mode_handler;
    uint32_t sstatus_value = 0x08;
    asm volatile("csrs sstatus, %0" : : "r"(sstatus_value));
    asm volatile("csrw stvec, %0" : : "r"(stvec_value));

    // Setup PMP
    uint32_t pmp_addr = ((uint32_t) (&flag)) >> 2; // Protect flag
    asm volatile("csrw pmpaddr0, %0" : : "r"(pmp_addr));
    // pmp_addr = 0x20001FFF; // Allows for the entire text, bss, stack section
    pmp_addr = 0xFFFFFFFF; // Allows for the entire text, bss, stack section
    asm volatile("csrw pmpaddr1, %0" : : "r"(pmp_addr));
    uint32_t pmp_cfg = 0x00001F17; // [NAPOT, RWX, no L] [NA4, R, no L]
    asm volatile("csrw pmpcfg0, %0" : : "r"(pmp_cfg));

    // Jump to user program
    flag = 5;

    // Set delegation register to use S-mode handler
    // uint32_t medelegh = 0xFFFFFFFF;
    // asm volatile("csrw medelegh, %0" : : "r"(medelegh));
    // uint32_t medeleg = 0xFFFFFFFF;
    uint32_t medeleg = ~(1 << 9); // trap into s-mode everywhere except environment call from s-mode
    asm volatile("csrw medeleg, %0" : : "r"(medeleg));

    // Jump to user program
    uint32_t sepc_value = (uint32_t) user_main;
    asm volatile("csrw sepc, %0" : : "r"(sepc_value));
    asm volatile("sret");

    __builtin_unreachable();

}

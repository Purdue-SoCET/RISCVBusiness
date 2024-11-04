#include <stdint.h>
#include "utility.h"

extern volatile int flag;
extern volatile int done;

void __attribute__((interrupt)) __attribute__((aligned(4))) m_mode_handler() {
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

    if (~mcause.interrupt && mcause.ex_code == 8){
        uint32_t mstatus = 0x1800; // set mpp back to M_MODE
        asm volatile("csrs mstatus, %0" : : "r"(mstatus));
        mepc = (uint32_t) &done;
    }
    else
    {
        mepc += 4;
        flag -= 1;
    }
    asm volatile("csrw mepc, %0" : : "r"(mepc));
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

    if (~scause.interrupt && scause.ex_code == 8){
        uint32_t sstatus = 0x0100; // set spp back to S_MODE
        asm volatile("csrs sstatus, %0" : : "r"(sstatus));
        sepc = (uint32_t) &done;
    }
    else
    {
        sepc += 4;
        flag -= 1;
    }
    asm volatile("csrw sepc, %0" : : "r"(sepc));
}

// U-mode calls M-mode exception handler
void __attribute__((noreturn)) user_main(void) {
    uint32_t csr_val;

    asm volatile("csrr %0, cycle" : "=r"(csr_val));

    asm volatile("csrr %0, time" : "=r"(csr_val));

    asm volatile("ecall"); // ends user_main

    __builtin_unreachable();

}

int main(void) {
    // Setup exceptions for M-mode
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
    pmp_addr = 0x20001FFF; // Allows for the entire text, bss, stack section
    asm volatile("csrw pmpaddr1, %0" : : "r"(pmp_addr));
    uint32_t pmp_cfg = 0x00001F11; // [NAPOT, RWX, no L] [NA4, R, no L]
    asm volatile("csrw pmpcfg0, %0" : : "r"(pmp_cfg));

    flag = 5;

    // Test registers in M_MODE
    uint32_t csr_val_0, csr_val_1;
    csr_val_0 = 0x0;
    asm volatile("csrw mcycle, %0" : : "r"(csr_val_0));
    asm volatile("csrr %0, mcycle" : "=r"(csr_val_0));
    asm volatile("nop; nop; nop;");
    asm volatile("csrr %0, cycle" : "=r"(csr_val_1));

    // TODO: This test is highly dependent on I-fetch speed
    if (csr_val_1 - csr_val_0 < 30) // Are the two cycle counts close?
    {
        flag -= 1;
    }

    asm volatile("csrw cycle, %0" : : "r"(csr_val_0)); // Trying to write to a R/O register


    // Jump to user program by using mret to return from an M-mode trap
    uint32_t mepc_value = (uint32_t) user_main;
    asm volatile("csrw mepc, %0" : : "r"(mepc_value));
    asm volatile("mret");

    // Set delegation register to use S-mode handler
    uint32_t medeleg = 0xFFFFFFFF;
    uint32_t medelegh = 0xFFFFFFFF;
    asm volatile("csrw medeleg, %0" : : "r"(medeleg));
    // asm volatile("csrw medelegh, %0" : : "r"(medelegh));

    // Jump to user program by using sret to return from a S-mode trap
    uint32_t sepc_value = (uint32_t) user_main;
    asm volatile("csrw sepc, %0" : : "r"(sepc_value));
    asm volatile("sret");

    __builtin_unreachable();

}

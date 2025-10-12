#include <stdint.h>
#include <stdnoreturn.h>
#include "utility.h"

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

noreturn void user_main(void) {
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
    // check to see if s-mode is enabled
    // easiest way is to set mstatus.mpp to S-mode and
    // read it to see if its the expected value for S-mode
    // S_MODE = 2'b01, mpp is bits [12:11]
    uint32_t mstatus_value = 0b01 << 11;
    asm volatile("csrs mstatus, %0" : : "r"(mstatus_value));
    asm volatile("csrr %0, mstatus" : "=r"(mstatus_value));

    // If S-mode is not enabled
    if ((mstatus_value & 0x1800) == 0) {
        print("Enable the Supervisor to run this testbench!\n");
        mstatus_value = 0x1800; // set mpp back to M_MODE
        asm volatile("csrs mstatus, %0" : : "r"(mstatus_value));
        asm volatile("csrw mepc, %0" : : "r"((uint32_t) &done));
        asm volatile("mret");
    }
    // set mstatus value back to default
    mstatus_value &= ~0x1800;
    asm volatile("csrw mstatus, %0" : : "r"(mstatus_value));

    // Setup exceptions for M-mode
    uint32_t mtvec_value = (uint32_t) m_mode_handler;
    mstatus_value = 0x08;
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
    uint32_t actual_pmp_addr;
    asm volatile("csrr %0, pmpaddr0" : "=r"(actual_pmp_addr));
    if (actual_pmp_addr != pmp_addr) {
        print("Set PMP granularity down to 4 to run this test!\n");
        mstatus_value = 0x1800; // set mpp back to M_MODE
        asm volatile("csrs mstatus, %0" : : "r"(mstatus_value));
        asm volatile("csrw mepc, %0" : : "r"((uint32_t) &done));
        asm volatile("mret");
    }
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


#include <stdint.h>
#include "utility.h"

extern volatile int flag;

volatile uint32_t *mtime        = (uint32_t *)MTIME_ADDR;
volatile uint32_t *mtimecmp     = (uint32_t *)MTIMECMP_ADDR;
volatile uint32_t *mtimecmph    = (uint32_t *)MTIMECMPH_ADDR;
volatile uint32_t *msip         = (uint32_t *)MSIP_ADDR;
volatile uint32_t *ext_trigger  = (uint32_t *)EXT_ADDR_SET;
volatile uint32_t *ext_clear    = (uint32_t *)EXT_ADDR_CLEAR;

// For this test: need to subtract 0xFE from flag to make flag = 1
// Each handler should be called once. If not, flag will be wrong

/*
 *  RISC-V Vector Layout
 *  0 - reserved/exception (overlap of interrupt cause & exception cause)
 *  1 - S-SW
 *  2 - reserved
 *  3 - M-SW
 *  4 - reserved
 *  5 - S-Timer
 *  6 - reserved
 *  7 - M-Timer
 *  8 - reserved
 *  9 - S-Ext
 *  10- reserved
 *  11- M-Ext
 */

void __attribute__((interrupt)) exception_handler() {
    uint32_t mepc, mcause;
    asm volatile("csrr %0, mepc" : "=r"(mepc));
    asm volatile("csrr %0, mcause" : "=r"(mcause));
    print("Exception with mepc: ");
    put_uint32_hex(mepc);
    print(" mcause: ");
    put_uint32_hex(mcause);
    print("\n");
    mepc += 4; // NOT PORTABLE TO RV32IC
    asm volatile("csrw mepc, %0" : : "r"(mepc));
    flag -= 2;
}

void __attribute__((interrupt)) m_timer_handler() {
    uint32_t mepc, mcause;
    asm volatile("csrr %0, mepc" : "=r"(mepc));
    asm volatile("csrr %0, mcause" : "=r"(mcause));
    print("Time interrupt with mepc: ");
    put_uint32_hex(mepc);
    print(" mcause: ");
    put_uint32_hex(mcause);
    print("\n");
    flag -= 1;
    (*mtimecmph) = 0xFF; // setting mtimecmph makes a very large value
}

void __attribute__((interrupt)) default_handler() {
    uint32_t mcause, mepc;
    asm volatile("csrr %0, mcause" : "=r"(mcause));
    asm volatile("csrr %0, mepc" : "=r"(mepc));
    print("Hit default handler, mepc: \n");
    put_uint32_hex(mcause);
    print(" mcause: ");
    put_uint32_hex(mepc);
    print("\n");
    flag = 0;
    done(); // Go to done and fail test
} // should not end up here, this is a fail!

// mtvec value MUST be aligned
// Note: .align 2 forces the jumps to be on multiple-of-4 boundaries here,
// which is required for vectored mode which computes the address as
// (mtvec.base + cause) x 4
// If this test breaks, it may mean that the alignment is wrong, check the
// disassembly!
void __attribute__((naked)) __attribute__((aligned(4))) handler_dispatch() {
    asm volatile(".align 2; j exception_handler"); // 0
    asm volatile(".align 2; j default_handler");   // 1
    asm volatile(".align 2; j default_handler");   // 2
    asm volatile(".align 2; j default_handler");   // 3
    asm volatile(".align 2; j default_handler");   // 4
    asm volatile(".align 2; j default_handler");   // 5
    asm volatile(".align 2; j default_handler");   // 6
    asm volatile(".align 2; j m_timer_handler");   // 7
    asm volatile(".align 2; j default_handler");   // 8
    asm volatile(".align 2; j default_handler");   // 9
    asm volatile(".align 2; j default_handler");   // 10
    asm volatile(".align 2; j default_handler");   // 11
}

/*

    This test case attempts an exception after an interrupt occurs.
    This was to verify an issue with the previous interrupt/exception handler
      where an exception after an interrupt while in VECTORED mode would
      incorrectly jump to the wrong handler for the exception.
    While that issue is most likely resolved, this case is included for verification.

*/
int main() {
    uint32_t mtvec_value = (uint32_t)handler_dispatch;
    mtvec_value |= 1; // set vectored mode
    uint32_t mie_value = 0x888;
    uint32_t mstatus_value = 0x8;


    // set mtimecmp away so interrupt doesn't fire immediately
    *mtimecmph = 0x00;
    *mtimecmp = 0xFF;

    flag = 4;

    // Setup interrupts
    asm volatile("csrw mtvec, %0" : : "r" (mtvec_value));
    asm volatile("csrw mie, %0" : : "r" (mie_value));
    // Interrupts active
    asm volatile("csrw mstatus, %0" : : "r" (mstatus_value));

    while((*mtime) < 0xFF);

    asm volatile("ecall");

    return 0;
}

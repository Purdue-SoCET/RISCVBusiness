#include <stdint.h>
#include "utility.h"

extern volatile int flag;

#define BAD_PMP_BOT 0x40000000 // This is a 32-bit address
#define BAD_PMP_TOP 0x40000020 // This is a 32-bit address
volatile uint32_t *bad_pmp_addr_top = (uint32_t*) BAD_PMP_TOP;
volatile uint32_t *bad_pmp_addr_bot = (uint32_t*) BAD_PMP_BOT;

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    // In a real program, a fault should be handled differently
    uint32_t mepc_value;
    asm volatile("csrr %0, mepc" : "=r"(mepc_value));
    mepc_value += 4;
    asm volatile("csrw mepc, %0" : : "r"(mepc_value));

    uint32_t mtval;
    asm volatile("csrr %0, mtval" : "=r"(mtval));

    print("PMP Unit Handler tripped: ");
    put_uint32_hex(mtval >> 2);
    flag -= 1;
}

int main() {
    uint32_t mtvec_value = (uint32_t) handler;
    asm volatile("csrw mtvec, %0" : : "r" (mtvec_value));

    flag = 7;

    // 0. Setup the instruction/stack/MMIO regions
    uint32_t pmp_cfg = 0x1F1F0000;
    asm volatile("csrw pmpcfg0, %0" : : "r" (pmp_cfg));
    uint32_t pmp_addr = (0x80000000 >> 2) & ~((1 << 14) - 1) | ((1 << (14 - 1)) - 1);
    asm volatile("csrw pmpaddr2, %0" : : "r" (pmp_addr));
    pmp_addr = (0xFFFFFFE0 >> 2) & ~((1 << 4) - 1) | ((1 << (4 - 1)) - 1);
    asm volatile("csrw pmpaddr3, %0" : : "r" (pmp_addr));

    // 1. Test PMP, TOR in M Mode
    pmp_cfg = 0x00000800; // set pmpcfg0.pmp1cfg to (no L, TOR, no RWX)
    asm volatile("csrs pmpcfg0, %0" : : "r" (pmp_cfg));
    pmp_addr = (BAD_PMP_TOP >> 2); // set pmpaddr1 to the top of range address
    asm volatile("csrw pmpaddr1, %0" : : "r" (pmp_addr));
    pmp_addr = (BAD_PMP_BOT >> 2); // set pmpaddr0 to the bottom of range address
    asm volatile("csrw pmpaddr0, %0" : : "r" (pmp_addr));
    *(bad_pmp_addr_bot + 4) = 0xDEADBEEF; // should succeed
    flag -= 1;
    *(bad_pmp_addr_top + 1) = 0xDEADBEEF; // should succeed
    flag -= 1;

    // 2. Test PMP, NAPOT with MPRV
    uint32_t mstatus = 0x20000; // set mstatus.mprv, mpp should be 2'b00
    asm volatile("csrw mstatus, %0" : : "r" (mstatus));
    *(bad_pmp_addr_bot + 4) = 0xABCD1234; // should fail
    *(bad_pmp_addr_top + 1) = 0xABCD1234; // should fail

    // 3. Test PMP, NAPOT with L register
    asm volatile("csrc mstatus, %0" : : "r" (mstatus)); // clear mstatus.mprv
    pmp_cfg = 0x00008000; // set pmpcfg0.pmp0cfg to (L, TOR, no RWX)
    asm volatile("csrs pmpcfg0, %0" : : "r" (pmp_cfg));
    *(bad_pmp_addr_bot + 4) = 0x0987FEDC; // should fail
    *(bad_pmp_addr_top + 1) = 0x0987FEDC; // should succeed
    flag -= 1;

    return 0;
}

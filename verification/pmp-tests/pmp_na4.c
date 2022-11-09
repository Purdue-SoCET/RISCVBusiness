#include <stdint.h>
#include "utility.h"

extern volatile int flag;

#define BAD_PMP_ADDR 0x40000000 // This is a 32-bit address
volatile uint32_t *bad_pmp_addr = (uint32_t*) BAD_PMP_ADDR;

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    // In a real program, a fault should be handled differently
    uint32_t mepc_value;
    asm volatile("csrr %0, mepc" : "=r"(mepc_value));
    mepc_value += 4;
    asm volatile("csrw mepc, %0" : : "r"(mepc_value));

    print("PMP Unit Handler tripped\n");
    flag -= 1;
}

int main() {
    uint32_t mtvec_value = (uint32_t) handler;
    asm volatile("csrw mtvec, %0" : : "r" (mtvec_value));

    flag = 4;

    // 1. Test PMP, NA4 in M Mode
    uint32_t pmp_cfg = 0x00000010; // set pmpcfg0.pmp0cfg to (no L, NA4, no RWX)
    uint32_t pmp_addr = BAD_PMP_ADDR >> 2; // set pmpaddr0 to the bad address, chop off bottom 2 bits
    asm volatile("csrw pmpcfg0, %0" : : "r" (pmp_cfg));
    asm volatile("csrw pmpaddr0, %0" : : "r" (pmp_addr));
    *bad_pmp_addr = 0xDEADBEEF; // should succeed
    flag -= 1;

    // 2. Test PMP, NA4 with MPRV
    uint32_t mstatus = 0x20000; // set mstatus.mprv, mpp should be 2'b00
    asm volatile("csrw mstatus, %0" : : "r" (mstatus));
    *bad_pmp_addr = 0xABCD1234; // should fail

    // 3. Test PMP, NA4 with L register
    asm volatile("csrc mstatus, %0" : : "r" (mstatus)); // clear mstatus.mprv
    pmp_cfg = 0x00000090; // set pmpcfg0.pmp0cfg to (L, NA4, no RWX)
    asm volatile("csrw pmpcfg0, %0" : : "r" (pmp_cfg));
    *bad_pmp_addr = 0x0987FEDC; // should fail

   
    return 0;
}

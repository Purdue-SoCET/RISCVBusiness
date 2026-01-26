#include <stdint.h>
#include "utility.h"

#define READ_PRINT_HPM(x) do { \
    uint32_t val; \
    asm volatile("csrr %0, hpmcounter" #x : "=r"(val)); \
    print("  count " #x ": "); \
    put_uint32_hex(val); \
    print("\n"); \
} while(0)

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

    // Toggle HPM counting off when trying to analyze the data
    int counter_toggle = 0xFFFFFFFF;
    asm volatile("csrw mcountinhibit, %0" : : "r"(counter_toggle));

    // Counters 0..2: cycle, time, instret
    uint32_t val;
    asm volatile("csrr %0, cycle" : "=r"(val));
    print("  cnt  0 (cycle):           "); put_uint32_hex(val); print("\n");

    asm volatile("csrr %0, time" : "=r"(val));
    print("  cnt  1 (time):            "); put_uint32_hex(val); print("\n");

    asm volatile("csrr %0, instret" : "=r"(val));
    print("  cnt  2 (instret):         "); put_uint32_hex(val); print("\n");

    // Counters 3..31: hpmcounter3 .. hpmcounter31
    asm volatile("csrr %0, hpmcounter3"  : "=r"(val));  print("  cnt  3 (icache miss):     "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter4"  : "=r"(val));  print("  cnt  4 (dcache miss):     "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter5"  : "=r"(val));  print("  cnt  5 (icache hit):      "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter6"  : "=r"(val));  print("  cnt  6 (dcache hit):      "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter7"  : "=r"(val));  print("  cnt  7 (itlb miss):       "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter8"  : "=r"(val));  print("  cnt  8 (dtlb miss):       "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter9"  : "=r"(val));  print("  cnt  9 (itlb hit):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter10" : "=r"(val));  print("  cnt 10 (dtlb hit):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter11" : "=r"(val));  print("  cnt 11 (bus busy):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter12" : "=r"(val));  print("  cnt 12 (branch update):   "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter13" : "=r"(val));  print("  cnt 13 (branch mispred):  "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter14" : "=r"(val));  print("  cnt 14 (fetch stall):     "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter15" : "=r"(val));  print("  cnt 15 (execute stall):   "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter16" : "=r"(val));  print("  cnt 16 (mem stall):       "); put_uint32_hex(val); print("\n");
    print("------------ UNMAPPED HPMS ------------\n");
    asm volatile("csrr %0, hpmcounter17" : "=r"(val));  print("  cnt 17 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter18" : "=r"(val));  print("  cnt 18 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter19" : "=r"(val));  print("  cnt 19 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter20" : "=r"(val));  print("  cnt 20 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter21" : "=r"(val));  print("  cnt 21 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter22" : "=r"(val));  print("  cnt 22 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter23" : "=r"(val));  print("  cnt 23 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter24" : "=r"(val));  print("  cnt 24 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter25" : "=r"(val));  print("  cnt 25 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter26" : "=r"(val));  print("  cnt 26 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter27" : "=r"(val));  print("  cnt 27 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter28" : "=r"(val));  print("  cnt 28 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter29" : "=r"(val));  print("  cnt 29 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter30" : "=r"(val));  print("  cnt 30 (unmapped):        "); put_uint32_hex(val); print("\n");
    asm volatile("csrr %0, hpmcounter31" : "=r"(val));  print("  cnt 31 (unmapped):        "); put_uint32_hex(val); print("\n");

    print("=======================================\n");

    // re-enable HPM counters
    asm volatile("csrw mcountinhibit, %0" : : "r"(~counter_toggle));
    
    // returning back to U-mode or completing test logic
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

void __attribute__((noreturn)) user_main(void) {
    print("A"); // MMIO region is not allowed in PMP, should fail

    flag = 0; // Flag is protected, should fail

    asm volatile("mret"); // privileged instruction

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

    pmp_addr = 0x20001FFF; // Allows for the entire text, bss, stack section
    asm volatile("csrw pmpaddr1, %0" : : "r"(pmp_addr));
    uint32_t pmp_cfg = 0x00001F11; // [NAPOT, RWX, no L] [NA4, R, no L]
    asm volatile("csrw pmpcfg0, %0" : : "r"(pmp_cfg));

    // Jump to user program
    flag = 6;
    uint32_t mepc_value = (uint32_t) user_main;
    asm volatile("csrw mepc, %0" : : "r"(mepc_value));
    asm volatile("mret");

    __builtin_unreachable();

}

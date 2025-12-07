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

    // Replace original 3-value prints with expanded HPM counter reads (31 counters).
    // read_count is the placeholder "x" times to sample all counters.
    int read_count = 5; // placeholder: change this to the desired "x" reads
    for (int r = 0; r < read_count; ++r) {
        print("HPM sample ");
        put_uint32_hex(r);
        print(":\n");

        uint32_t val;

        // Counters 0..2: cycle, time, instret
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
        asm volatile("csrr %0, hpmcounter11" : "=r"(val));  print("  cnt 11 (page walk miss):  "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter12" : "=r"(val));  print("  cnt 12 (page walk count): "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter13" : "=r"(val));  print("  cnt 13 (fetch stall):     "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter14" : "=r"(val));  print("  cnt 14 (execute stall):   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter15" : "=r"(val));  print("  cnt 15 (mem stall):       "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter16" : "=r"(val));  print("  cnt 16 (d snoop):         "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter17" : "=r"(val));  print("  cnt 17 (d snoop hit):     "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter18" : "=r"(val));  print("  cnt 18 (d snoop miss):    "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter19" : "=r"(val));  print("  cnt 19 (branch miss):     "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter20" : "=r"(val));  print("  cnt 20 (branch cond):     "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter21" : "=r"(val));  print("  cnt 21 (bus busy):        "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter22" : "=r"(val));  print("  cnt 22:                   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter23" : "=r"(val));  print("  cnt 23:                   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter24" : "=r"(val));  print("  cnt 24:                   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter25" : "=r"(val));  print("  cnt 25:                   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter26" : "=r"(val));  print("  cnt 26:                   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter27" : "=r"(val));  print("  cnt 27:                   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter28" : "=r"(val));  print("  cnt 28:                   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter29" : "=r"(val));  print("  cnt 29:                   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter30" : "=r"(val));  print("  cnt 30:                   "); put_uint32_hex(val); print("\n");
        asm volatile("csrr %0, hpmcounter31" : "=r"(val));  print("  cnt 31:                   "); put_uint32_hex(val); print("\n");

        print("-----\n");
    }

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

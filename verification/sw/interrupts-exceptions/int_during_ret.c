// This test adds coverage for proper mepc selection when an interrupt is
// triggered on a branching instruction.This test case heavily relies on the
// timing of the interrupt being fired, and the return instruction being
// committed.When making changes to things which change the latency of the core
// (i.e.cache, pipeline, etc), ensure that this test continues to cover
// this bug by manually inspecting the waveforms.
// The general steps for ensuring that this test is up to date is to:
//     1) Compile and run this test
//     2) False negatives are unlikely, but false positives can be common due to how subtle this bug
//     is. Always double check that the test is actually passing by inspecting the waveforms.
//     3) Open up the waveforms and look for the intr signal in the prv_pipe_if. Ensure that it
//     lines up with pc_m in the hazard unit being the address of the first `ret` instruction in
//     `foo`.
//     4) If it does not line up, adjust the value of `mtimecmp` in `main` to trigger the interrupt
//     earlier or later depending on what is needed.
#include <stdint.h>
#include "csr.h"
#include "format.h"
#include "utility.h"


void exception_handler() {
    CSRW("mie", 0x0);
    print("Made it to handler!\n");
    flag = 1;
}

void __attribute__((noinline)) __attribute__((naked)) __attribute__((aligned(16)))
foo() {
    // This function is aligned to a 16B boundary.
    // If the I$ block size exceeds 16B, this test may not work.
    // we *must* be executing the csrsi and ret back-to-back for
    // the interrupt to come in on the same cycle as the ret.
    // The 'nop' allows this to work when block size is 8B.
    asm(".option push\n"
        ".option norvc\n"
        "li t1, 0xFF\n" // offset 0x0
        ".align 3\n" // alignment is 'size-log2', so this is aligning to 2^3 = 8B
        "csrsi mstatus, 0x8\n" // offset 0x8
        "ret\n" // offset 0xC
        "sw t1, %0\n"
        "ret\n"
        ".option pop"
        :
        : "A"(flag));
}

int main() {
    *MTIMECMPH = 0x00;
    *MTIMECMP = 0x148;

    setup_interrupts_m(exception_handler, IE_MTIE);
    // Wait to enable interrupts until right before 'ret'
    foo();

    if (flag == 1) {
        test_pass("Interrupt during return handled");
    } else {
        test_fail("Interrupt during return not handled correctly");
    }

    return 0;
}

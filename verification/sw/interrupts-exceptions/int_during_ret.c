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

void __attribute__((noinline)) __attribute__((naked)) foo() {
    asm("li t1, 0xFF\n"
        "add zero, zero, zero\n"
        "add zero, zero, zero\n"
        "add zero, zero, zero\n"
        "add zero, zero, zero\n"
        "csrsi mstatus, 0x8\n"
        "ret\n"
        "sw t1, %0\n"
        "ret\n"
        :
        : "A"(flag));
}

int main() {
    *MTIMECMPH = 0x00;
    *MTIMECMP = 0x148;

    setup_interrupts_m(exception_handler, IE_MTIE);
    enable_interrupts_m();

    foo();

    if (flag == 1) {
        test_pass("Interrupt during return handled");
    } else {
        test_fail("Interrupt during return not handled correctly");
    }

    return 0;
}

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
#include "utility.h"
#include <stdint.h>

volatile uint32_t *mtime = (uint32_t *)MTIME_ADDR;
volatile uint32_t *mtimecmp = (uint32_t *)MTIMECMP_ADDR;
volatile uint32_t *mtimecmph = (uint32_t *)MTIMECMPH_ADDR;
volatile uint32_t *msip = (uint32_t *)MSIP_ADDR;
volatile uint32_t *ext_trigger = (uint32_t *)EXT_ADDR_SET;
volatile uint32_t *ext_clear = (uint32_t *)EXT_ADDR_CLEAR;

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
    uint32_t mie_value = 0x00;
    asm volatile("csrw mie, %0" : : "r"(mie_value));
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
    // set mtimecmp away so interrupt doesn't fire immediately
    *mtimecmph = 0x00;
    *mtimecmp = 0x148;

    uint32_t mstatus_value = 0x8;
    uint32_t mie_value = 0x80;
    uint32_t mtvec_value = (uint32_t)handler;
    asm volatile("csrw mtvec, %0" : : "r"(mtvec_value));
    asm volatile("csrw mie, %0" : : "r"(mie_value));
    //asm volatile("csrw mstatus, %0" : : "r"(mstatus_value));

    foo();
}

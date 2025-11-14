#include <stdint.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

void advance_mepc(uint32_t by) {
    uint32_t mepc = CSRR("mepc");
    mepc += by;
    CSRW("mepc", mepc);
}

void set_mepc(void *address) {
    CSRW("mepc", (uint32_t)address);
}

void setup_interrupts_m(void *handler_addr, uint32_t mie_value) {
    // Direct mode
    uint32_t mtvec = (uint32_t)handler_addr;
    CSRW("mtvec", mtvec);
    CSRW("mie", mie_value);
}

void setup_interrupt_m_vectored(void *table_addr, uint32_t mie_value) {
    // Vectored mode
    uint32_t mtvec = (uint32_t)table_addr | 0x1;
    CSRW("mtvec", mtvec);
    CSRW("mie", mie_value);
}

void enable_interrupts_m() {
    CSRS("mstatus", MSTATUS_MIE);
}

void disable_interrupts_m() {
    CSRC("mstatus", MSTATUS_MIE);
}

void enable_interrupts_save_m(uint32_t restore) {
    CSRW("mstatus", restore);
}

uint32_t disable_interrupts_save_m() {
    return CSRRC("mstatus", MSTATUS_MIE);
}

bool check_supervisor_mode_available() {
    // check to see if s-mode is enabled
    // easiest way is to set mstatus.mpp to S-mode and
    // read it to see if its the expected value for S-mode
    // S_MODE = 2'b01, mpp is bits [12:11]
    uint32_t mstatus_old = CSRRS("mstatus", (0b01 << 11));
    // Swap old value back in, check if written value indicated
    // supervisor presence
    uint32_t mstatus_value = CSRRW("mstatus", mstatus_old);
    return (mstatus_value & 0x1800) == 0;
}

void require_supervior_mode() {
    if(!check_supervisor_mode_available()) {
        print("Enable Supervisor to run this test");
        flag = -1; // set flag to 0xFFFF_FFFF to indicate fail
        done();
        __builtin_unreachable();
    }
}

void read_exception_context(exception_context_t *ctx) {
    ctx->cycle  = CSRR("cycle");
    ctx->time   = CSRR("time");
    ctx->cause  = CSRR("mcause");
    ctx->epc    = CSRR("mepc");
    ctx->tval   = CSRR("mtval");
    ctx->icache_misses = CSRR("hpmcounter3");
    ctx->dcache_misses = CSRR("hpmcounter4");
}

void read_exception_context_s(exception_context_t *ctx) {
    ctx->cycle  = CSRR("cycle");
    ctx->time   = CSRR("time");
    ctx->cause  = CSRR("scause");
    ctx->epc    = CSRR("sepc");
    ctx->tval   = CSRR("stval");
    ctx->icache_misses = CSRR("hpmcounter3");
    ctx->dcache_misses = CSRR("hpmcounter4");
}

void print_exception_context(exception_context_t *ctx) {
    print("/**** EXCEPTION ****/\n");
    print("cause   : %x\n", ctx->cause);
    print("epc     : %x\n", ctx->epc);
    print("tval    : %x\n", ctx->tval);
    print("cycle   : %d\n", ctx->cycle);
    print("time    : %d\n", ctx->time);
    print("I$ miss : %d\n", ctx->icache_misses);
    print("D$ miss : %d\n", ctx->dcache_misses);
}

void default_handler() __attribute__((interrupt)) {
    exception_context_t ctx;
    read_exception_context(&ctx);
    print_exception_context(&ctx);

    print("Unexpected exception/interrupt; exiting\n");
    done();
}

void unreachable_handler() __attribute__((interrupt)) {
    exception_context_t ctx;
    read_exception_context(&ctx);
    print_exception_context(&ctx);
    print("EMERGENCY: THIS HARDWARE CONDITION DOES NOT EXIST AND CAN **NEVER** HAPPEN!\n");
    done();
}

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U

RVTEST_CODE_BEGIN

main:
    # Set up handler address
    la t0, mtvec_handler
    csrw mtvec, t0

    # Enable Interrupts globally
    addi x3, x0, 0x1
    slli x3, x3, 3
    csrw mstatus, x3

    # Enable timer, software, external interrupts for machine mode
    ori x3, x0, 0x8
    slli x3, x3, 8
    ori x3, x3, 0x88
    csrw mie, x3

    # Load in magic sum: 3 + 7 + 11 corresponds to the values of the cause
    # register for machine software, timer, and external interrupts respectively.
    # This test will only pass if the 3 types are seen exactly once.
    ori x6, x0, 21

loop:
    # Wait for x6 to take on correct value
    bne x6, x0, loop
    RVTEST_PASS

.align 2
mtvec_handler:
    csrr x7, mcause
    andi x7, x7, 0xFF # Mask lower bits -- top bit indicates interrupt vs. exception
    sub x6, x6, x7

    # Reenable interrupts
    #addi x3, x0, 0x1
    #slli x3, x3, 3
    #csrw mstatus, x3
    
    mret

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

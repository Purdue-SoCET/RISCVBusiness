# See LICENSE for license details.

#*****************************************************************************
# vwmulstall.S
#-----------------------------------------------------------------------------
#
# Test behaviour of widening multiply during a stall
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
    
    vsetvli a0, zero, e32, m2, ta, ma

    la x1, ldat
    la x2, sdat

    vsetvli zero, zero, e16, m1, ta, ma
    vle32.v v1, (x1)
    vwmul.vv v2, v1, v1
    vsetvli zero, zero, e32, m2, ta, ma
    vse32.v v2, (x2)
    
    lw x3, 0(x2)
    lw x4, 4(x2)
    lw x5, 8(x2)
    lw x6, 12(x2)
    lw x7, 16(x2)
    lw x8, 20(x2)
    lw x9, 24(x2)
    lw x10, 28(x2)

    TEST_CASE(2, x3, 0x0, NOP)
    TEST_CASE(3, x4, 0x100, NOP)
    TEST_CASE(4, x5, 0x400, NOP)
    TEST_CASE(5, x6, 0x900, NOP)
    TEST_CASE(6, x7, 0x1000, NOP)
    TEST_CASE(7, x8, 0x1900, NOP)
    TEST_CASE(8, x9, 0x2400, NOP)
    TEST_CASE(9, x10, 0x3100, NOP)

    TEST_PASSFAIL

RVTEST_CODE_END

    .data
RVTEST_DATA_BEGIN

    TEST_DATA

ldat:
    .half 0x00
    .half 0x10
    .half 0x20
    .half 0x30
    .half 0x40
    .half 0x50
    .half 0x60
    .half 0x70

sdat:
    .word 0x00000000
    .word 0x00000001
    .word 0x00000002
    .word 0x00000003
    .word 0x00000004
    .word 0x00000005
    .word 0x00000006
    .word 0x00000007

RVTEST_DATA_END

# See LICENSE for license details.

#*****************************************************************************
# vshiftdiv.S
#-----------------------------------------------------------------------------
#
# Test to divide an array by 2 using shifts instead of the divider
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U

RVTEST_CODE_BEGIN

    // Set up arguments
    la a0, input
    la a1, output
    li a2, 6

divby2:
    ble     a2,zero,.L5
    vsetvli a5,zero,e16,m1,ta,ma
    vmv.v.i v3,0
.L3:
    vsetvli a5,a2,e16,m1,ta,ma
    vle16.v v1,0(a0)
    slli    a4,a5,1
    sub     a2,a2,a5
    add     a0,a0,a4
    vmslt.vi        v0,v1,0
    vmerge.vim      v2,v3,-1,v0
    vsub.vv v1,v1,v2
    vsra.vi v1,v1,1
    vse16.v v1,0(a1)
    add     a1,a1,a4
    bne     a2,zero,.L3
.L5:

    // Load and check results
    la a0, output

    lh t0, 0(a0)
    TEST_CASE(1, t0, 100, NOP)

    lh t0, 2(a0)
    TEST_CASE(2, t0, 12500, NOP)

    lh t0, 4(a0)
    TEST_CASE(3, t0, -4, NOP)

    lh t0, 6(a0)
    TEST_CASE(4, t0, 7, NOP)

    lh t0, 8(a0)
    TEST_CASE(5, t0, -15000, NOP)

    lh t0, 10(a0)
    TEST_CASE(6, t0, -2, NOP)

    TEST_PASSFAIL

RVTEST_CODE_END

    .data

RVTEST_DATA_BEGIN

    TEST_DATA

input:
    .half   200
    .half   25000
    .half   -8
    .half   15
    .half   -30000
    .half   -5

    .align 4

output:
    .zero 3

RVTEST_DATA_END

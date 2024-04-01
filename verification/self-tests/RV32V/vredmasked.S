# See LICENSE for license details.

#*****************************************************************************
# vredmasked.S
#-----------------------------------------------------------------------------
#
# Test reductions of different kinds with masked elements
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

# Setup tasks
    li x7, 10
    vsetvli x8, x7, e16, m2

    la x2, array
    vle16.v v4, (x2)  # vs2 = v4

    la x2, ones
    vle16.v v6, (x2)  # vs1 = '1 for AND

    la x2, zeros
    vle16.v v8, (x2)  # vs1 = '0 for OR

    la x2, mask
    vlm.v v0, (x2)

    la x10, and_result
    la x12, or_result

# Perform reductions
    vredand.vs v10, v4, v6, v0.t
    vredor.vs v12, v4, v8, v0.t

# Store results
    vsetivli x8, 1, e16, m2
    vse16.v v10, (x10)
    vse16.v v12, (x12)

# Load and check results
    lw x5, 0(x10)
    TEST_CASE(1, x5, 0x2900, NOP)

    lw x5, 0(x12)
    TEST_CASE(2, x5, 0xffd6, NOP)

    TEST_PASSFAIL

RVTEST_CODE_END

    .data
RVTEST_DATA_BEGIN

    TEST_DATA

ones:
    .word 0xffffffff

zeros:
    .word 0x00000000

array:
    .half 0xff00
    .half 0xfe01  # masked
    .half 0xfd02
    .half 0xfb04

    .half 0xf708  # masked
    .half 0xef10
    .half 0xdf20  # masked
    .half 0xbf40

    .half 0x7f80
    .half 0x00ff  # masked

    .align 4
and_result:
  	.word 0x0
or_result:
    .word 0x0

    .align 4
mask:
    .word 0x1ad

RVTEST_DATA_END

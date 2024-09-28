# See LICENSE for license details.

#*****************************************************************************
# vredlogical.S
#-----------------------------------------------------------------------------
#
# Test multiple back to back reductions of different operations
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

# Setup tasks
    li x7, 5
    vsetvli x8, x7, e16, m2

    la x2, array
    vle16.v v4, (x2)  # vs2 = v4

    la x2, ones
    vle16.v v6, (x2)  # vs1 = '1 for AND

    la x2, zeros
    vle16.v v8, (x2)  # vs1 = '0 for OR/XOR

    la x10, and_result
    la x12, or_result
    la x14, xor_result

# Perform reductions
    vredand.vs v10, v4, v6
    vredor.vs v12, v4, v8
    vredxor.vs v14, v4, v8

# Store results
    vsetivli x8, 1, e16, m2
    vse16.v v10, (x10)
    vse16.v v12, (x12)
    vse16.v v14, (x14)

# Load and check results
    lw x5, 0(x10)
    TEST_CASE(1, x5, 0x8080, NOP)

    lw x5, 0(x12)
    TEST_CASE(2, x5, 0xf7f7, NOP)

    lw x5, 0(x14)
    TEST_CASE(3, x5, 0xb4b4, NOP)

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
    .half 0xf0f0
    .half 0xe1e1
    .half 0xd2d2
    .half 0xc3c3
    .half 0xb4b4

    .align 4

and_result:
  	.word 0x0
or_result:
    .word 0x0
xor_result:
  	.word 0x0

RVTEST_DATA_END

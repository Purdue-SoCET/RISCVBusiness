# See LICENSE for license details.

#*****************************************************************************
# vredmixed.S
#-----------------------------------------------------------------------------
#
# Test multiple back to back reductions of different operations 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

# Setup tasks
    li x7, 10
    vsetvli x8, x7, e16, m2

    la x2, array
    vle16.v v2, (x2)  # vs1 = v2
    vle16.v v4, (x2)  # vs2 = v4

    la x10, min_result
    la x12, minu_result
    la x14, max_result
    la x16, maxu_result

# Perform reductions
    vredmin.vs v10, v4, v2
    vredminu.vs v12, v4, v2
    vredmax.vs v14, v4, v2
    vredmaxu.vs v16, v4, v2

# Store results
    vsetivli x8, 1, e16, m2
    vse16.v v10, (x10)
    vse16.v v12, (x12)
    vse16.v v14, (x14)
    vse16.v v16, (x16)

# Load and check results
    lw x5, 0(x10)
    TEST_CASE(1, x5, 0x8864, NOP)

    lw x5, 0(x12)
    TEST_CASE(2, x5, 0x0003, NOP)

    lw x5, 0(x14)
    TEST_CASE(3, x5, 0x7642, NOP)

    lw x5, 0(x16)
    TEST_CASE(4, x5, 0xffdc, NOP)

    TEST_PASSFAIL

RVTEST_CODE_END

    .data
RVTEST_DATA_BEGIN

    TEST_DATA

array:
    .half 0x0350
    .half 0x0003  # min unsigned
    .half 0xffdc  # max unsigned
    .half 0x4e09
    .half 0x8864  # min signed
    .half 0xa092
    .half 0x7642  # max signed
    .half 0x5286
    .half 0x9431
    .half 0x6974

    .word 0xffffffff

min_result:
  	.word 0x0
minu_result:
    .word 0x0
max_result:
  	.word 0x0
maxu_result:
    .word 0x0

RVTEST_DATA_END

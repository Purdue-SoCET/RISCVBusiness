# See LICENSE for license details.

#*****************************************************************************
# vwredsum.S
#-----------------------------------------------------------------------------
#
# Test multiple back to back reductions of different operations
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

# Setup tasks
    li x7, 25
    vsetvli x8, x7, e8, m2

    la x2, array
    vle8.v v2, (x2)  # vs1 = v2
    vle8.v v4, (x2)  # vs2 = v4

    la x10, redsum_result
    la x12, redsumu_result

# Perform reductions
    vwredsum.vs v10, v4, v2
    vwredsumu.vs v12, v4, v2

# Store results
    vsetivli x8, 1, e16, m2
    vse16.v v10, (x10)
    vse16.v v12, (x12)

# Load and check results
    lh x5, 0(x10)
    TEST_CASE(1, x5, 0x2b65, NOP)

    lh x5, 0(x12)
    TEST_CASE(2, x5, 0x3365, NOP)

    TEST_PASSFAIL

RVTEST_CODE_END

    .data
RVTEST_DATA_BEGIN

    TEST_DATA

array:
    .word 0xd516287e
    .word 0x2c16013b
    .word 0xf17afb53
    .word 0x4410de59
    .word 0x2320ec41
    .word 0xf5deb46f
    .word 0xed99832e

    .align 4
redsum_result:
    .word 0x0
redsumu_result:
    .word 0x0

RVTEST_DATA_END

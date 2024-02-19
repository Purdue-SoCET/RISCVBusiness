# See LICENSE for license details.

#*****************************************************************************
# vcsr.S
#-----------------------------------------------------------------------------
#
# Test vset{i}vl{i} instructions 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

vsetivli x10, 3, e32, m1
NOP
NOP
NOP
NOP
TEST_CASE(1, x10, 3, NOP)



RVTEST_CODE_BEGIN

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

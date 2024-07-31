# See LICENSE for license details.

#*****************************************************************************
# add.S
#-----------------------------------------------------------------------------
#
# Test add instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  TEST_CASE( 7, x14, 0x1, \
    li x1, 0x5;  
    li x2, 0x3;  
    li x3, 0x7;  
    sub x15, x1, x2; \
    czero.eqz x16, x15, x0; \
    sub x17, x3, x1; \
    czero.eqz x18, x17, x0; \
    and x14, x16, x18; \
  )

  TEST_CASE( 8, x14, 0x1, \
    li x1, 0x5;  
    li x2, 0x5;  
    sub x15, x1, x2; \
    czero.eqz x14, x15, x0; \
  )
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

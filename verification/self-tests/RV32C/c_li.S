# See LICENSE for license details.

#*****************************************************************************
# c_li.S
#-----------------------------------------------------------------------------
#
# Test c_li instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_RV32C_LI(2, c.li, 0xffffffff, 0x3f, 0);
  TEST_RV32C_LI(3, c.li, 0x0000001f, 0x1f, 0);
  TEST_RV32C_LI(4, c.li, 0x00000001, 0x10, 4);
  TEST_RV32C_LI(5, c.li, 0xffffffff, 0x20, 20);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

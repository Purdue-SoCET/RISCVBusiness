# See LICENSE for license details.

#*****************************************************************************
# c_lui.S
#-----------------------------------------------------------------------------
#
# Test c_lui instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_RV32C_LUI(2, c.lui, 0x0001f000, 0x1f, 0);
  TEST_RV32C_LUI(3, c.lui, 0xfffff000, 0xfffff, 0);
  TEST_RV32C_LUI(4, c.lui, 0xffffe000, 0xfffe0, 4);
  TEST_RV32C_LUI(5, c.lui, 0xfffffff0, 0xffff0, 12);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

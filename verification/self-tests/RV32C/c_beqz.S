# See LICENSE for license details.

#*****************************************************************************
# c_beqz.S
#-----------------------------------------------------------------------------
#
# Test c_beqz instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_RV32C_BR2_OP_TAKEN( 3, c.beqz,  0);

  TEST_RV32C_BR2_OP_NOTTAKEN( 4, c.beqz,  1);
  TEST_RV32C_BR2_OP_NOTTAKEN( 5, c.beqz,  -1);

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_BR2_SRC_BYPASS( 6,  0, c.beqz, -1);
  TEST_RV32C_BR2_SRC_BYPASS( 7, 1, c.beqz, -1);
  TEST_RV32C_BR2_SRC_BYPASS( 8, 2, c.beqz, -1);

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 9, x8, 3, \
    li  x8, 1; \
    li  x15, 0;
    c.beqz x15, 1f; \
    addi x8, x8, 1; \
    addi x8, x8, 1; \
    addi x8, x8, 1; \
    addi x8, x8, 1; \
1:  addi x8, x8, 1; \
    addi x8, x8, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

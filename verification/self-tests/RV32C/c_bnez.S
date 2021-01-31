# See LICENSE for license details.

#*****************************************************************************
# c_bnez.S
#-----------------------------------------------------------------------------
#
# Test c_bnez instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_RV32C_BR2_OP_TAKEN( 3, c.bnez,  1);
  TEST_RV32C_BR2_OP_TAKEN( 4, c.bnez, -1);

  TEST_RV32C_BR2_OP_NOTTAKEN( 5, c.bnez,  0);

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_BR2_SRC_BYPASS( 6,  0, c.bnez, 0);
  TEST_RV32C_BR2_SRC_BYPASS( 7, 1, c.bnez, 0);
  TEST_RV32C_BR2_SRC_BYPASS( 8, 2, c.bnez, 0);

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 9, x11, 3, \
    li  x11, 1; \
    c.bnez x11, 1f; \
    addi x11, x11, 1; \
    addi x11, x11, 1; \
    addi x11, x11, 1; \
    addi x11, x11, 1; \
1:  addi x11, x11, 1; \
    addi x11, x11, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

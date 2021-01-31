# See LICENSE for license details.

#*****************************************************************************
# c_jal.S
#-----------------------------------------------------------------------------
#
# Test c_jal instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Test 2: Basic test
  #-------------------------------------------------------------

test_2:
  li  TESTNUM, 2
  li  x31, 0

linkaddr_2:
  c.jal target_2
  nop
  nop

  j fail

target_2:
  la  x3, linkaddr_2
  addi x3, x3, 2
  bne x3, x1, fail

  #-------------------------------------------------------------
  # Test 3: Check r0 target and that r31 is not modified
  #-------------------------------------------------------------

test_3:
  li  TESTNUM, 3
  li  x31, 0

linkaddr_3:
  c.jal target_3
  nop

  j fail

target_3:
  bne x31, x0, fail

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_JAL_SRC1_BYPASS( 4, 0, c.jal );
  TEST_RV32C_JAL_SRC1_BYPASS( 5, 1, c.jal );
  TEST_RV32C_JAL_SRC1_BYPASS( 6, 2, c.jal );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 7, x3, 3, \
    li  x3, 1; \
    c.jal 1f; \
    addi x3, x3, 1; \
    addi x3, x3, 1; \
    addi x3, x3, 1; \
    addi x3, x3, 1; \
1:  addi x3, x3, 1; \
    addi x3, x3, 1; \
  )


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

# See LICENSE for license details.

#*****************************************************************************
# ras.S
#-----------------------------------------------------------------------------
#
# Test jalr instruction for ras.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Test 2: Basic test
  #-------------------------------------------------------------
test_1:
  li  TESTNUM, 2
  li  ra, 0

linkaddr_1:
  jal target_1
  nop
  nop

  j fail

target_1:
  la  x2, linkaddr_1
  addi x2, x2, 4
  bne x2, ra, fail

test_2:
  li  TESTNUM, 2
  li  x31, 0
  la  x1, target_2

linkaddr_2:
  jalr x5, x1, 0
  nop
  nop

  j fail

target_2:
  la  x2, linkaddr_2
  addi x2, x2, 4
  bne x2, x5, fail

  #-------------------------------------------------------------
  # Test 3: Check r0 target and that r31 is not modified
  #-------------------------------------------------------------



  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_JALR_SRC1_BYPASS( 4, 0, jalr );
  TEST_JALR_SRC1_BYPASS( 5, 1, jalr );
  TEST_JALR_SRC1_BYPASS( 6, 2, jalr );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

    
   TEST_CASE( 3, x2, 3, \
    li  x2, 1; \
    jal 1f; \
    addi x2, x2, 1; \
    addi x2, x2, 1; \
    addi x2, x2, 1; \
    addi x2, x2, 1; \
1:  addi x2, x2, 1; \
    addi x2, x2, 1; \
  )

  TEST_CASE( 7, x1, 4, \
    li  x1, 1; \
    la  x2, 1f;
    jalr x19, x2, -4; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
1:  addi x1, x1, 1; \
    addi x1, x1, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


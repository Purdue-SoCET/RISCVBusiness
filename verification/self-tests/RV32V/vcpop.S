# See LICENSE for license details.

#*****************************************************************************
# vcpop.S
#-----------------------------------------------------------------------------
#
# Test vcpop instruction 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
  // simple test case 
  vsetivli x0, 4, e32

  la x1, ldat
  vle32.v v1, 0(x1)

  vsetvli x5, x0, e8, m8 // work on all 128 bits

  vcpop.m x3, v1

  TEST_CASE(1, x3, 128, NOP)

  li x6, 32
  vsetvli x5, x6, e8, m8
  vcpop.m x3, v1
  TEST_CASE(2, x3, 32, NOP)



  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

  ldat: 
  .word 0XFFFFFFFF
  .word 0XFFFFFFFF
  .word 0XFFFFFFFF
  .word 0XFFFFFFFF


	sdat:
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF

RVTEST_DATA_END

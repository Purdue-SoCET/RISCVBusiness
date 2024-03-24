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
  
  
  li x6, 20 
  vsetvli x5, x6 , e8, m2 

  vid.v v2 
 
  la x2, sdat
  vse8.v v2, 0(x2) 

  addi x2, x2, 0
  lb x3, 0(x2)
  TEST_CASE(1, x3, 0, NOP)

  addi x2, x2, 1
  lb x3, 0(x2)
  TEST_CASE(2, x3, 1, NOP)

  addi x2, x2, 1
  lb x3, 0(x2)
  TEST_CASE(3, x3, 2, NOP)

  addi x2, x2, 1
  lb x3, 0(x2)
  TEST_CASE(4, x3, 3, NOP)

  addi x2, x2, 1
  lb x3, 0(x2)
  TEST_CASE(5, x3, 4, NOP)
  



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

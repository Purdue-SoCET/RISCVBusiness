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

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(6, x3, 5, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(7, x3, 6, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(8, x3, 7, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(9, x3, 8, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(10, x3, 9, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(11, x3, 10, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(12, x3, 11, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(13, x3, 12, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(14, x3, 13, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(15, x3, 14, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(16, x3, 15, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(17, x3, 16, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(18, x3, 17, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(19, x3, 18, NOP)

addi x2, x2, 1 
lb x3, 0(x2)
TEST_CASE(20, x3, 19, NOP)


  li x6, 4 
  vsetvli x5, x6 , e8, m2 

  vid.v v4


  la x2, sdat
  vse8.v v4, 0(x2) 


  lw x3, 0(x2)
  TEST_CASE(21, x3, 0x03020100, NOP)


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

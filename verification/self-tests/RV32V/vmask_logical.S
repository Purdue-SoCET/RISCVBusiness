# See LICENSE for license details.

#*****************************************************************************
# vmask_logical.S
#-----------------------------------------------------------------------------
#
# Test vector mask logical instructions
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
  
  
  vmset.m v0

  vsetivli x0, 4, e32

  la x1, sdat
  vse32.v v0, 0(x1)

  lw x2, 0(x1)
  TEST_CASE(1, x2, 0xffffffff, NOP)
  lw x2, 4(x1)
  TEST_CASE(2, x2, 0xffffffff, NOP)
  lw x2, 8(x1)
  TEST_CASE(3, x2, 0xffffffff, NOP)
  lw x2, 12(x1)
  TEST_CASE(4, x2, 0xffffffff, NOP)


  vmand.mm v0, v0, v1
  vse32.v v0, 0(x1)

  lw x2, 0(x1)
  TEST_CASE(5, x2, 0x0, NOP)
  lw x2, 4(x1)
  TEST_CASE(6, x2, 0x0, NOP)
  lw x2, 8(x1)
  TEST_CASE(7, x2, 0x0, NOP)
  lw x2, 12(x1)
  TEST_CASE(8, x2, 0x0, NOP)



  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA


	sdat:
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF

RVTEST_DATA_END

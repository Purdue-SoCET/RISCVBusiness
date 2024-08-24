# See LICENSE for license details.

#*****************************************************************************
# vnmsub.S
#-----------------------------------------------------------------------------
#
# Test vnmsub instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 4, e32, m1
  li x1, 36
  la x2, ldat2
	la x3, ldat3
  la x4, sdat
  vle32.v v22, (x2)
  vle32.v v23, (x3)
  vnmsub.vx v23, x1, v22
	vse32.v v23, (x4)
	lw x5, 0(x4)
	lw x6, 4(x4)
	lw x7, 8(x4)
	lw x8, 12(x4)
  TEST_CASE(1, x10, 4, NOP)
	TEST_CASE(2, x5, 67, NOP)
	TEST_CASE(3, x6, -25144, NOP)
	TEST_CASE(4, x7, 720, NOP)
	TEST_CASE(5, x8, -696, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

  ldat2:
  .word 67
  .word 92
  .word 0
  .word -840
  ldat3:
  .word 0
  .word 701
  .word -20
  .word -4

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004

RVTEST_DATA_END

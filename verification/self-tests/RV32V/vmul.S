# See LICENSE for license details.

#*****************************************************************************
# vmul.S
#-----------------------------------------------------------------------------
#
# Test vmul instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 4, e32, m1
  la x1, ldat1
  la x2, ldat2
	la x3, sdat
  vle32.v v1, (x1)
  vle32.v v2, (x2)
  nop
  vmul.vv v3, v1, v2
  nop
	vse32.v v3, (x3)
	nop
	lw x4, 0(x3)
	lw x5, 4(x3)
	lw x6, 8(x3)
	lw x7, 12(x3)
	# lw x8, 16(x3)
	# lw x9, 20(x3)
  TEST_CASE(1, x10, 4, NOP)
	TEST_CASE(2, x4, 20, NOP)
	TEST_CASE(3, x5, 33, NOP)
	TEST_CASE(4, x6, 48, NOP)
	TEST_CASE(5, x7, 65, NOP)
	# TEST_CASE(6, x8, 84, NOP)
	# TEST_CASE(7, x9, 105, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat1:
	.word 2
	.word 3
	.word 4
	.word 5
	.word 6
	.word 7
  ldat2:
  .word 10
  .word 11
  .word 12
  .word 13
  .word 14
  .word 15

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006

RVTEST_DATA_END

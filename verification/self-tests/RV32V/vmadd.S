# See LICENSE for license details.

#*****************************************************************************
# vmadd.S
#-----------------------------------------------------------------------------
#
# Test vmadd instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 4, e32, m1
  la x1, ldat1
  la x2, ldat2
	la x3, ldat3
  la x4, sdat
  vle32.v v1, (x1)
  vle32.v v2, (x2)
  vle32.v v3, (x3)
  vmadd.vv v3, v1, v2
	vse32.v v3, (x4)
	lw x5, 0(x4)
	lw x6, 4(x4)
	lw x7, 8(x4)
	lw x8, 12(x4)
  TEST_CASE(1, x10, 4, NOP)
	TEST_CASE(2, x5, 1502, NOP)
	TEST_CASE(3, x6, 42, NOP)
	TEST_CASE(4, x7, -721, NOP)
	TEST_CASE(5, x8, -29078, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat1:
	.word 13
	.word 567
	.word 0
	.word -3
  ldat2:
  .word 202
  .word 42
  .word -721
  .word -65
  ldat3:
  .word 100
  .word 0
  .word -10
  .word 9671

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004

RVTEST_DATA_END

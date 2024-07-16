# See LICENSE for license details.

#*****************************************************************************
# vcompress.S
#-----------------------------------------------------------------------------
#
# Test vcompress.vm instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x20, 13, e16, m2
  la x1, ldat1
  la x2, ldat2
	la x3, sdat
  vlm.v v2, (x1)
  vle16.v v6, (x2)
  vle16.v v10, (x3)
  vcompress.vm v10, v6, v2
	vse16.v v10, (x3)
	lw x4, 0(x3)
	lw x5, 4(x3)
	lw x6, 8(x3)
	lw x7, 12(x3)
	lw x8, 16(x3)
	lw x9, 20(x3)
	lw x10, 24(x3)
	lw x11, 28(x3)

  TEST_CASE(1, x20, 13, NOP)
	TEST_CASE(2, x4, 0x07060302, NOP)
	TEST_CASE(3, x5, 0x0b0a0908, NOP)
	TEST_CASE(4, x6, 0x15140d0c, NOP)
	TEST_CASE(5, x7, 0x19181716, NOP)
	TEST_CASE(6, x8, 0x55555555, NOP)
	TEST_CASE(7, x9, 0x55555555, NOP)
	TEST_CASE(8, x10, 0x55555555, NOP)
	TEST_CASE(9, x11, 0x55555555, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat1:
	.word 0x0000fc7a
  ldat2:
  .word 0x03020100
  .word 0x07060504
  .word 0x0b0a0908
  .word 0x0f0e0d0c
  .word 0x13121110
  .word 0x17161514
	.word 0x1b1a1918
	.word 0x1f1e1d1c

	sdat:
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555

RVTEST_DATA_END


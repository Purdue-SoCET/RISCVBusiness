# See LICENSE for license details.

#*****************************************************************************
# vslideup_e16.S
#-----------------------------------------------------------------------------
#
# Test vslideup.vx instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

	vsetivli x20, 13, e16, m2
  la x1, ldat
	la x2, sdat
  li x3, 5
  vle16.v v2, (x1)
  vle16.v v4, (x2)
  vslideup.vx v4, v2, x3
  vse16.v v4, (x2)

  lw x4, 0(x2)
  lw x5, 4(x2)
  lw x6, 8(x2)
  lw x7, 12(x2)
  lw x8, 16(x2)
  lw x9, 20(x2)
  lw x10, 24(x2)

  TEST_CASE(1, x20, 0x13, NOP)
	TEST_CASE(2, x4, 0x55555555, NOP)
  TEST_CASE(3, x5, 0x55555555, NOP)
  TEST_CASE(4, x6, 0x01005555, NOP)
  TEST_CASE(5, x7, 0x05040302, NOP)
  TEST_CASE(6, x8, 0x09080706, NOP)
  TEST_CASE(7, x9, 0x0d0c0b0a, NOP)
  TEST_CASE(8, x10, 0x55550f0e, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

  ldat:
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

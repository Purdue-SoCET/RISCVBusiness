# See LICENSE for license details.

#*****************************************************************************
# vslide1down_e16.S
#-----------------------------------------------------------------------------
#
# Test vslide1down.vx instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

	vsetivli x10, 7, e16
  la x1, ldat
	la x2, sdat
  li x3, 0xabcd
  vle16.v v1, (x1)
  vslide1down.vx v2, v1, x3
  vse16.v v2, (x2)

  lw x4, 0(x2)
  lw x5, 4(x2)
  lw x6, 8(x2)
  lw x7, 12(x2)

  TEST_CASE(1, x10, 0x7, NOP)
	TEST_CASE(2, x4, 0x05040302, NOP)
  TEST_CASE(3, x5, 0x09080706, NOP)
  TEST_CASE(4, x6, 0x0d0c0b0a, NOP)
  TEST_CASE(5, x7, 0x5555abcd, NOP)

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

  sdat:
  .word 0x55555555
  .word 0x55555555
  .word 0x55555555
  .word 0x55555555

RVTEST_DATA_END

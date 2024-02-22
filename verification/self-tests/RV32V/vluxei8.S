# See LICENSE for license details.

#*****************************************************************************
# vle32.S
#-----------------------------------------------------------------------------
#
# Test vle32 and vse32 instructions
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 4, e8, m1
  la x1, load_idx_dat
  vle8.v v1, (x1)
  la x2, ldat
  la x3, sdat
  vluxei8.v   v2, (x3), v1
  vse8.v v2, (x3)
	NOP
	NOP
	NOP
	NOP
	lb x3, 0(x3)
	lb x4, 1(x3)
	lb x5, 2(x3)
	lb x6, 3(x3)

	TEST_CASE(1, x10, 4, NOP)
	TEST_CASE(2, x3, 0x11, NOP)
	TEST_CASE(3, x4, 0x22, NOP)
	TEST_CASE(4, x5, 0x33, NOP)
	TEST_CASE(5, x6, 0x44, NOP)


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

    load_idx_dat:
    .word 0x03020100

	ldat:
	.word 0x44332211
	.word 0x000000fe
	.word 0x000000fd
	.word 0x000000fc
	.word 0x000000fb
	.word 0x000000fa

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006

RVTEST_DATA_END


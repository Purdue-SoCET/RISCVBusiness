# See LICENSE for license details.

#*****************************************************************************
# vcomp_mask_set.S
#-----------------------------------------------------------------------------
#
# Test vcomp instructions that set mask bits
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
  
  li x10, 32
  vsetvli x1, x10, e8, m2
  TEST_CASE(1, x1, 32, NOP) 

  la x1, ldat 
  vle8.v v28, 0(x1)

  vmsne.vv v30, v28, v26

  la x2, sdat
  vsm.v v30, 0(x2)

  lw x3, 0(x2)
  TEST_CASE(2, x3, 0xFFFFFFFF, NOP)


  // test with overlapping v0 and masking enabled
  la x1, mask_load
  vle8.v v0, 0(x1)
  vle8.v v2, 0(x1)

  vmseq.vv v0, v0, v2, v0.t
  vsm.v v0, 0(x2)

  lw x3, 0(x2)
  TEST_CASE(3, x3, 0x0000FFFF)


  // compare the different with masking disabled
  vmseq.vv v0, v0, v2
  vsm.v v0, 0(x2)

  lw x3, 0(x2)
  TEST_CASE(4, x3, 0xFFFFFFFF)
  

   

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat:
	.word 0x01010101
	.word 0x01010101
	.word 0x01010101
	.word 0x01010101
	.word 0x01010101
	.word 0x01010101
    .word 0x01010101
    .word 0x01010101


	mask_load:
	.word 0x0000FFFF
    .word 0x00000000
    .word 0x00000000
    .word 0x00000000
    .word 0x00000000
    .word 0x00000000
    .word 0x00000000
    .word 0x00000000

	sdat:
	.word 0x00000000
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006


    reset_data:
    .word 0x00000000 


RVTEST_DATA_END

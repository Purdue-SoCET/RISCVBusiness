# See LICENSE for license details.

#*****************************************************************************
# vadd.S
#-----------------------------------------------------------------------------
#
# Test vadd
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 1, e16
	la x1, ldat
	la x2, sdat
  vle16.v v1, (x1)
  
  vwadd.vv v0, v1, v1

    vse32.v v0, (x2)
    lw x3, 0(x2)
    

    TEST_CASE(1, x3, 0xfffffffe, NOP)
    vadd.vv v5, v1, v1
    vse32.v v5, 0(x2)
    lw x3, 0(x2)
    TEST_CASE(2, x3, 0x0000fffe)


	vsetivli x0, 8, e16 
	la x1, add_dat
	vle16.v v0, 0(x1)
	vle16.v v1, 0(x1)

	vwadd.vv v2, v0, v1

	vse32.v v2, 0(x2)

	lw x3, 0(x2)
	TEST_CASE(3, x3, 2, NOP)   

	lw x3, 4(x2)
	TEST_CASE(4, x3, 2, NOP) 

	lw x3, 8(x2)
	TEST_CASE(5, x3, 2, NOP)   

	lw x3, 12(x2)
	TEST_CASE(6, x3, 2, NOP) 

	lw x3, 16(x2)
	TEST_CASE(7, x3, 2, NOP)   

	add x2, x2, 20  
	lw x3, 0(x2)
	TEST_CASE(8, x3, 2, NOP)  

	add x2, x2, 4  
	lw x3, 0(x2)
	TEST_CASE(9, x3, 2, NOP)   

	add x2, x2, 4  
	lw x3, 0(x2)
	TEST_CASE(10, x3, 2, NOP) 




  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat:
	.word 0x0000ffff
	.word 0x00000000
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006
	.word 0x00000007
	.word 0x00000008


	add_dat: 
	.word 0x00010001
	.word 0x00010001
	.word 0x00010001
	.word 0x00010001
	


RVTEST_DATA_END

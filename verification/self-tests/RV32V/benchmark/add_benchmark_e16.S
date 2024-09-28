# See LICENSE for license details.

#*****************************************************************************
# add_benchmark.S
#-----------------------------------------------------------------------------
#
# benchmarking 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  li x1, 120 // variable N, range is 0 - 120
  li x2, 0 // variable i
  la x3, A_data
  la x4, B_data
  la x5, C_data 

  addi x3, x3, -2
  addi x4, x4, -2
  addi x5, x5, -2
  loop:
    sub x6, x2, x1
    beq x6, x0, exit 

    addi x3, x3, 2
    addi x4, x4, 2
    addi x5, x5, 2

    lh x8, 0(x3)  
    lh x9, 0(x4)
    add x10, x9, x8
    sh x10, 0(x5)
    
    addi x2, x2, 1
    j loop 

exit: 

/*
// checking for errors
li x1, 120 // variable N, range is 0 - 120
  li x2, 0 // variable i
  la x3, A_data
  la x4, B_data
  la x5, C_data 

  addi x3, x3, -2
  addi x4, x4, -2
  addi x5, x5, -2
  sec_loop:
    sub x6, x2, x1
    beq x6, x0, exit2 
	addi TESTNUM, x2, 0

    addi x3, x3, 2
    addi x4, x4, 2
    addi x5, x5, 2

    lh x8, 0(x3)  
    lh x9, 0(x4)
    add x10, x9, x8
	li x14, 0xffff
	and x10, x10, x14
	lh x11, 0(x5)
	and x11, x11, x14
    bne x11, x10, fail
    
    addi x2, x2, 1
    j sec_loop 

  exit2:
*/

	TEST_CASE(1, x0, 0, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

		A_data:
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0x44444444

	B_data:
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0x44444444

    C_data: 
    .word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
    .word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444
	.word 0x44444444


RVTEST_DATA_END

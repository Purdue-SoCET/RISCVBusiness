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
  loop:
    sub x6, x2, x1
    beq x6, x0, exit 
    slli x7, x2, 2
    add x3, x3, x7
    add x4, x4, x7
    add x5, x5, x7

    lw x8, 0(x3)  
    lw x9, 0(x4)
    add x10, x9, x8
    sw x10, 0(x5)
    
    addi x2, x2, 1
    j loop 

  exit:


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

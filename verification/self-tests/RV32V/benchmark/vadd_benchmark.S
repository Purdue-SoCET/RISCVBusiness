# See LICENSE for license details.

#*****************************************************************************
# vadd_benchmark.S
#-----------------------------------------------------------------------------
#
# benchmarking 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  li x1, 120 // loop variable N, range is 0 - 120
  la x2, A_data
  la x3, B_data
  la x4, C_data

  loop:
    vsetvli x5, x1, e32, m8
    vle32.v v0, 0(x2)
    vle32.v v8, 0(x3)
    vadd.vv v16, v0, v8
    vse32.v v16, 0(x4)

    // update pointers 
    slli x6, x5, 2
    add x2, x2, x6
    add x3, x3, x6
    add x4, x4, x6

    // stripmining 
    sub x1, x1, x5
    bne x1,x0, loop
    

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

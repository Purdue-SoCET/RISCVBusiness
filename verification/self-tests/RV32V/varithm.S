# See LICENSE for license details.

#*****************************************************************************
# varith.S
#-----------------------------------------------------------------------------
#
# Test vector arithmetic instructions 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN


  vsetivli x10, 1, e32
	la x1, op_data
  la x2, res_data
  la x20, mask_dis_bits

  vle32.v v1, (x1)
  vle32.v v2, (x1)
  vlm.v v0, 0(x20)

  // test vector addition
  vadd.vv v3, v2, v1
  vmv.x.s x3, v3
  TEST_CASE(1, x3, 2, NOP)

  li x4, 5
  vadd.vx v3, v2, x4
  vmv.x.s x3, v3
  TEST_CASE(2, x3, 6, NOP)

  vadd.vi v3, v2, 10
  vmv.x.s x3, v3
  TEST_CASE(3, x3, 11, NOP)

  vadd.vi v3, v2, 8, v0.t
  vmv.x.s x3, v3
  TEST_CASE(4, x3, 11, NOP)

  la x20, mask_en_bits
  vlm.v v0, (x20)
  vadd.vi v3, v2, 8, v0.t
  vmv.x.s x3, v3
  TEST_CASE(5, x3, 9, NOP)


  // sub instructions
  li x4, 2
  vsub.vx v3, v2, x4
  vmv.x.s x3, v3
  TEST_CASE(6, x3, 0xffffffff, NOP)

  // rsub
  li x4, 2
  vrsub.vx v3, v2, x4
  vmv.x.s x3, v3
  TEST_CASE(7, x3, 1, NOP)


  // widened addition
  vsetivli x10, 1, e16
  li x4, 0xffff
  vmv.s.x v2, x4
  li x4, 1
  vmv.s.x v1, x4
  vwaddu.vv v3, v2, v1
  vsetivli x10, 1, e32
  vmv.x.s x3, v3
  TEST_CASE(8, x3, 0x10000, NOP)


  // integer extension 
  li x4, 0xffff
  vmv.s.x v2, x4
  vzext.vf2 v3, v2
  vmv.x.s x3, v3
  TEST_CASE(9, x3, 0xffff, NOP)

  vsext.vf2 v3, v2
  vmv.x.s x3, v3
  TEST_CASE(10, x3, 0xffffffff, NOP)

  vzext.vf4 v3, v2
  vmv.x.s x3, v3
  TEST_CASE(11, x3, 0xff, NOP)

  vsext.vf4 v3, v2
  vmv.x.s x3, v3
  TEST_CASE(12, x3, 0xffffffff, NOP)


  //add w/ carry
  li x4, 1
  vmv.s.x v2, x4
  vadc.vvm v3, v2, v2, v0
  vmv.x.s x3, v3
  TEST_CASE(13, x3, 3, NOP)

  //produce carry out in mask registe
  vmadc.vv v3, v2, v2
  vmv.x.s x3, v3
  TEST_CASE(14, x3, 2, NOP)

  li x4, 0xffffffff
  vmv.s.x v2, x4
  vmadc.vi v3, v2, 0
  vmv.x.s x3, v3
  TEST_CASE(15, x3, 2, NOP)

  vmadc.vim v3, v2, 0, v0
  vmv.x.s x3, v3
  TEST_CASE(16, x3, 3, NOP)


  //produce difference w/ borrow
  li x4, 2
  vmv.s.x v2, x4
  vsbc.vxm v3, v2, x0, v0
  vmv.x.s x3, v3
  TEST_CASE(17, x3, 1, NOP)


  // produce borrow out
  vmv.s.x v2, x0
  vmsbc.vx v3, v2, x0
  vmv.x.s x3, v3
  TEST_CASE(18, x3, 0, NOP)

  vmsbc.vxm v3, v2, x0, v0
  vmv.x.s x3, v3
  TEST_CASE(19, x3, 1, NOP)



  // bitwise logical instructions 
  li x4, 10
  vmv.s.x v2, x4
  li x4, 3
  vmv.s.x v3, x4

  vand.vv v4, v2, v3
  vmv.x.s x3, v4
  TEST_CASE(20, x3, 2, NOP)

  vor.vv v4, v2, v3
  vmv.x.s x3, v4
  TEST_CASE(21, x3, 11, NOP)

  vxor.vv v4, v2, v3
  vmv.x.s x3, v4
  TEST_CASE(22, x3, 9, NOP)







  




  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA
	
  op_data:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004

	res_data:
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000

  mask_dis_bits:
  .word 0x0

  mask_en_bits:
  .word 0xf

RVTEST_DATA_END

/*
// for loop for checking
  li x6, 0 // index i
  li x7, 4 // loop iterations N 
loop: 
  beq x6, x7, exit
  addi TESTNUM, x6, 0
  slli x8, x6, 2

  add x9, x8, x1
  lw x3, 0(x9) // input operand
  add x3, x3, x3 // expected result

  add x9, x8, x2
  lw x4, 0(x9) // actual result

  bne x4, x3, fail

  addi x6, x6, 1
  j loop
*/
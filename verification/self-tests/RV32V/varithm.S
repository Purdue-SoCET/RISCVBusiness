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


  //vector single width instructions 
  li x4, 0xffffffff
  vmv.s.x v2, x4
  li x4, 0xffffff02
  vmv.s.x v4, x4

  vsll.vv v3, v2, v4
  vmv.x.s x3, v3
  TEST_CASE(23, x3, 0xfffffffc, NOP)

  vsrl.vv v3, v2, v4
  vmv.x.s x3, v3
  TEST_CASE(24, x3, 0x3fffffff, NOP)

  vsra.vv v3, v2, v4
  vmv.x.s x3, v3
  TEST_CASE(25, x3, 0xffffffff, NOP)


  // vector narrowing instructions
  li x4, 0xaaaaaaaa
  vmv.s.x v2, x4
  vsetivli x10, 1, e16
  vnsrl.wi v3, v2, 4 
  vmv.x.s x3, v3
  TEST_CASE(26, x3, 0xffffaaaa, NOP)

  li x4, 20
  vnsrl.wx v3, v2, x4
  vmv.x.s x3, v3
  TEST_CASE(27, x3, 0x00000aaa, NOP)

  vnsra.wx v3, v2, x4
  vmv.x.s x3, v3
  TEST_CASE(28, x3, 0xfffffaaa, NOP)


  // integer min/max instructions
  vsetivli x10, 1, e32
  li x4, -1
  vmv.s.x v2, x4
  vminu.vx v3, v2, x0
  vmv.x.s x3, v3
  TEST_CASE(29, x3, 0, NOP)

  vmin.vx v3, v2, x0
  vmv.x.s x3, v3
  TEST_CASE(30, x3, -1, NOP)

  vmaxu.vx v3, v2, x0
  vmv.x.s x3, v3
  TEST_CASE(31, x3, -1, NOP)

  vmax.vx v3, v2, x0
  vmv.x.s x3, v3
  TEST_CASE(32, x3, 0, NOP)


  // vmerge tests
  vsetivli x10, 4, e32
  la x1, mask_bits
  la x2, op_data
  la x3, op_data2
  vlm.v v0, (x1)
  vle32.v v1, 0(x2)
  vle32.v v2, 0(x3)

  vmerge.vvm v3, v2, v1, v0
  la x4, res_data
  vse32.v v3, 0(x4)

  lw x5, 0(x4)
  TEST_CASE(33, x5, 0x10, NOP)

  lw x5, 4(x4)
  TEST_CASE(34, x5, 0x2, NOP)

  lw x5, 8(x4)
  TEST_CASE(35, x5, 0x3, NOP)

  lw x5, 12(x4)
  TEST_CASE(36, x5, 0x40, NOP)

  // vmerge test with a RAW hazard on v0 
  NOP
  NOP
  NOP
  NOP
  NOP
  vmslt.vi        v0,v1,0 // v0 should be 0b0000
  vmerge.vvm v3, v2, v1, v0
  vse32.v v3, 0(x4)

  lw x5, 0(x4)
  TEST_CASE(37, x5, 0x10, NOP)

  lw x5, 4(x4)
  TEST_CASE(38, x5, 0x20, NOP)

  lw x5, 8(x4)
  TEST_CASE(39, x5, 0x30, NOP)

  lw x5, 12(x4)
  TEST_CASE(40, x5, 0x40, NOP)





  // integer move instruction
  vlm.v v0, (x1)
  vmerge.vvm v3, v2, v1, v0
  la x4, res_data
  vse32.v v3, 0(x4)
  
  vmv.v.v v4, v3
  vse32.v v4, 0(x4)

  lw x5, 0(x4)
  TEST_CASE(41, x5, 0x10, NOP)

  lw x5, 4(x4)
  TEST_CASE(42, x5, 0x2, NOP)

  lw x5, 8(x4)
  TEST_CASE(43, x5, 0x3, NOP)

  lw x5, 12(x4)
  TEST_CASE(44, x5, 0x40, NOP)

  vmv.v.i v4, -1
  vse32.v v4, 0(x4)
  lw x5, 0(x4)
  TEST_CASE(45, x5, -1, NOP)

  lw x5, 4(x4)
  TEST_CASE(46, x5, -1, NOP)

  lw x5, 8(x4)
  TEST_CASE(47, x5, -1, NOP)

  lw x5, 12(x4)
  TEST_CASE(48, x5, -1, NOP)


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

  op_data2: 
  .word 0x00000010
	.word 0x00000020
	.word 0x00000030
	.word 0x00000040

	res_data:
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000

  mask_dis_bits:
  .word 0x0

  mask_bits: 
  .word 0x6

  mask_en_bits:
  .word 0xf

RVTEST_DATA_END

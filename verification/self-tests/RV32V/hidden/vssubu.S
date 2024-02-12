# See LICENSE for license details.

#*****************************************************************************
# vssubu.S
#-----------------------------------------------------------------------------
#
# Test vssubu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

#if __riscv_vsew == 32

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vssubu.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 3,  vssubu.vv, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VV_OP( 4,  vssubu.vv, 0x00000000, 0x00000003, 0x00000007 );

  TEST_VV_OP( 5,  vssubu.vv, 0x00000000, 0x00000000, 0xffff8000 );
  TEST_VV_OP( 6,  vssubu.vv, 0x80000000, 0x80000000, 0x00000000 );
  TEST_VV_OP( 7,  vssubu.vv, 0x00000000, 0x80000000, 0xffff8000 );

  TEST_VV_OP( 8,  vssubu.vv, 0x00000000, 0x00000000, 0x00007fff );
  TEST_VV_OP( 9,  vssubu.vv, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_VV_OP( 10, vssubu.vv, 0x7fff8000, 0x7fffffff, 0x00007fff );

  TEST_VV_OP( 11, vssubu.vv, 0x7fff8001, 0x80000000, 0x00007fff );
  TEST_VV_OP( 12, vssubu.vv, 0x00000000, 0x7fffffff, 0xffff8000 );

  TEST_VV_OP( 13, vssubu.vv, 0x00000000, 0x00000000, 0xffffffff );
  TEST_VV_OP( 14, vssubu.vv, 0xfffffffe, 0xffffffff, 0x00000001 );
  TEST_VV_OP( 15, vssubu.vv, 0x00000000, 0xffffffff, 0xffffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 16, vssubu.vx, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VX_OP( 17, vssubu.vx, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VX_OP( 18, vssubu.vx, 0x00000000, 0x00000003, 0x00000007 );

  TEST_VX_OP( 19, vssubu.vx, 0x00000000, 0x00000000, 0xffff8000 );
  TEST_VX_OP( 20, vssubu.vx, 0x80000000, 0x80000000, 0x00000000 );
  TEST_VX_OP( 21, vssubu.vx, 0x00000000, 0x80000000, 0xffff8000 );

  TEST_VX_OP( 22, vssubu.vx, 0x00000000, 0x00000000, 0x00007fff );
  TEST_VX_OP( 23, vssubu.vx, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_VX_OP( 24, vssubu.vx, 0x7fff8000, 0x7fffffff, 0x00007fff );

  TEST_VX_OP( 25, vssubu.vx, 0x7fff8001, 0x80000000, 0x00007fff );
  TEST_VX_OP( 26, vssubu.vx, 0x00000000, 0x7fffffff, 0xffff8000 );

  TEST_VX_OP( 27, vssubu.vx, 0x00000000, 0x00000000, 0xffffffff );
  TEST_VX_OP( 28, vssubu.vx, 0xfffffffe, 0xffffffff, 0x00000001 );
  TEST_VX_OP( 29, vssubu.vx, 0x00000000, 0xffffffff, 0xffffffff );
	
#endif

#if __riscv_vsew == 64

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vssubu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vssubu.vv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 4,  vssubu.vv, 0x0000000000000000, 0x0000000000000003, 0x0000000000000007 );

  TEST_VV_OP( 5,  vssubu.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VV_OP( 6,  vssubu.vv, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VV_OP( 7,  vssubu.vv, 0x0000000000000000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vssubu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000007fff );
  TEST_VV_OP( 9,  vssubu.vv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VV_OP( 10, vssubu.vv, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VV_OP( 11, vssubu.vv, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vssubu.vv, 0x0000000000000000, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VV_OP( 13, vssubu.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 14, vssubu.vv, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VV_OP( 15, vssubu.vv, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 16, vssubu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 17, vssubu.vx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 18, vssubu.vx, 0x0000000000000000, 0x0000000000000003, 0x0000000000000007 );

  TEST_VX_OP( 19, vssubu.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VX_OP( 20, vssubu.vx, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VX_OP( 21, vssubu.vx, 0x0000000000000000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VX_OP( 22, vssubu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000007fff );
  TEST_VX_OP( 23, vssubu.vx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VX_OP( 24, vssubu.vx, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VX_OP( 25, vssubu.vx, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VX_OP( 26, vssubu.vx, 0x0000000000000000, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VX_OP( 27, vssubu.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 28, vssubu.vx, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VX_OP( 29, vssubu.vx, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

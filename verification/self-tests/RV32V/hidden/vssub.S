# See LICENSE for license details.

#*****************************************************************************
# vssub.S
#-----------------------------------------------------------------------------
#
# Test vssub instructions.
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

  TEST_VV_OP( 2,  vssub.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 3,  vssub.vv, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VV_OP( 4,  vssub.vv, 0xfffffffc, 0x00000003, 0x00000007 );

  TEST_VV_OP( 5,  vssub.vv, 0x00008000, 0x00000000, 0xffff8000 );
  TEST_VV_OP( 6,  vssub.vv, 0x80000000, 0x80000000, 0x00000000 );
  TEST_VV_OP( 7,  vssub.vv, 0x80008000, 0x80000000, 0xffff8000 );

  TEST_VV_OP( 8,  vssub.vv, 0xffff8001, 0x00000000, 0x00007fff );
  TEST_VV_OP( 9,  vssub.vv, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_VV_OP( 10, vssub.vv, 0x7fff8000, 0x7fffffff, 0x00007fff );

  TEST_VV_OP( 11, vssub.vv, 0x80000000, 0x80000000, 0x00007fff );
  TEST_VV_OP( 12, vssub.vv, 0x7fffffff, 0x7fffffff, 0xffff8000 );

  TEST_VV_OP( 13, vssub.vv, 0x00000001, 0x00000000, 0xffffffff );
  TEST_VV_OP( 14, vssub.vv, 0xfffffffe, 0xffffffff, 0x00000001 );
  TEST_VV_OP( 15, vssub.vv, 0x00000000, 0xffffffff, 0xffffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 16, vssub.vx, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VX_OP( 17, vssub.vx, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VX_OP( 18, vssub.vx, 0xfffffffc, 0x00000003, 0x00000007 );

  TEST_VX_OP( 19, vssub.vx, 0x00008000, 0x00000000, 0xffff8000 );
  TEST_VX_OP( 20, vssub.vx, 0x80000000, 0x80000000, 0x00000000 );
  TEST_VX_OP( 21, vssub.vx, 0x80008000, 0x80000000, 0xffff8000 );

  TEST_VX_OP( 22, vssub.vx, 0xffff8001, 0x00000000, 0x00007fff );
  TEST_VX_OP( 23, vssub.vx, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_VX_OP( 24, vssub.vx, 0x7fff8000, 0x7fffffff, 0x00007fff );

  TEST_VX_OP( 25, vssub.vx, 0x80000000, 0x80000000, 0x00007fff );
  TEST_VX_OP( 26, vssub.vx, 0x7fffffff, 0x7fffffff, 0xffff8000 );

  TEST_VX_OP( 27, vssub.vx, 0x00000001, 0x00000000, 0xffffffff );
  TEST_VX_OP( 28, vssub.vx, 0xfffffffe, 0xffffffff, 0x00000001 );
  TEST_VX_OP( 29, vssub.vx, 0x00000000, 0xffffffff, 0xffffffff );
	
#endif

#if __riscv_vsew == 64

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vssub.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vssub.vv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 4,  vssub.vv, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_VV_OP( 5,  vssub.vv, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VV_OP( 6,  vssub.vv, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VV_OP( 7,  vssub.vv, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vssub.vv, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_VV_OP( 9,  vssub.vv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VV_OP( 10, vssub.vv, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VV_OP( 11, vssub.vv, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vssub.vv, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VV_OP( 13, vssub.vv, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 14, vssub.vv, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VV_OP( 15, vssub.vv, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 16, vssub.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 17, vssub.vx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 18, vssub.vx, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_VX_OP( 19, vssub.vx, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VX_OP( 20, vssub.vx, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VX_OP( 21, vssub.vx, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VX_OP( 22, vssub.vx, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_VX_OP( 23, vssub.vx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VX_OP( 24, vssub.vx, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VX_OP( 25, vssub.vx, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VX_OP( 26, vssub.vx, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VX_OP( 27, vssub.vx, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 28, vssub.vx, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VX_OP( 29, vssub.vx, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );	

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

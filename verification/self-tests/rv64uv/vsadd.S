# See LICENSE for license details.

#*****************************************************************************
# vsadd.S
#-----------------------------------------------------------------------------
#
# Test vsadd instructions.
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

  TEST_VV_OP( 2,  vsadd.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 3,  vsadd.vv, 0x00000002, 0x00000001, 0x00000001 );
  TEST_VV_OP( 4,  vsadd.vv, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_VV_OP( 5,  vsadd.vv, 0xffff8000, 0x00000000, 0xffff8000 );
  TEST_VV_OP( 6,  vsadd.vv, 0x80000000, 0x80000000, 0x00000000 );
  TEST_VV_OP( 7,  vsadd.vv, 0x80000000, 0x80000000, 0xffff8000 );

  TEST_VV_OP( 8,  vsadd.vv, 0x00007fff, 0x00000000, 0x00007fff );
  TEST_VV_OP( 9,  vsadd.vv, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_VV_OP( 10, vsadd.vv, 0x7fffffff, 0x7fffffff, 0x00007fff );

  TEST_VV_OP( 11, vsadd.vv, 0x80007fff, 0x80000000, 0x00007fff );
  TEST_VV_OP( 12, vsadd.vv, 0x7fff7fff, 0x7fffffff, 0xffff8000 );

  TEST_VV_OP( 13, vsadd.vv, 0xffffffff, 0x00000000, 0xffffffff );
  TEST_VV_OP( 14, vsadd.vv, 0x00000000, 0xffffffff, 0x00000001 );
  TEST_VV_OP( 15, vsadd.vv, 0xfffffffe, 0xffffffff, 0xffffffff );

  TEST_VV_OP( 16, vsadd.vv, 0x7fffffff, 0x00000001, 0x7fffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vsadd.vx, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VX_OP( 18, vsadd.vx, 0x00000002, 0x00000001, 0x00000001 );
  TEST_VX_OP( 19, vsadd.vx, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_VX_OP( 20, vsadd.vx, 0xffff8000, 0x00000000, 0xffff8000 );
  TEST_VX_OP( 21, vsadd.vx, 0x80000000, 0x80000000, 0x00000000 );
  TEST_VX_OP( 22, vsadd.vx, 0x80000000, 0x80000000, 0xffff8000 );

  TEST_VX_OP( 23, vsadd.vx, 0x00007fff, 0x00000000, 0x00007fff );
  TEST_VX_OP( 24, vsadd.vx, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_VX_OP( 25, vsadd.vx, 0x7fffffff, 0x7fffffff, 0x00007fff );

  TEST_VX_OP( 26, vsadd.vx, 0x80007fff, 0x80000000, 0x00007fff );
  TEST_VX_OP( 27, vsadd.vx, 0x7fff7fff, 0x7fffffff, 0xffff8000 );

  TEST_VX_OP( 28, vsadd.vx, 0xffffffff, 0x00000000, 0xffffffff );
  TEST_VX_OP( 29, vsadd.vx, 0x00000000, 0xffffffff, 0x00000001 );
  TEST_VX_OP( 30, vsadd.vx, 0xfffffffe, 0xffffffff, 0xffffffff );

  TEST_VX_OP( 31, vsadd.vx, 0x7fffffff, 0x00000001, 0x7fffffff );
	
  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_VI_OP( 32, vsadd.vi, 0x00000000, 0x00000000, 0x0 );
  TEST_VI_OP( 33, vsadd.vi, 0x00000002, 0x00000001, 0x1 );
  TEST_VI_OP( 34, vsadd.vi, 0x0000000a, 0x00000003, 0x7 );

  TEST_VI_OP( 35, vsadd.vi, 0xfffffff8, 0xfffffff0, 0x8 );
  TEST_VI_OP( 36, vsadd.vi, 0x80000000, 0x80000000, 0x0 );
  TEST_VI_OP( 37, vsadd.vi, 0x7fff8000, 0x7fff7ff8, 0x8 );

  TEST_VI_OP( 38, vsadd.vi, 0x00000007, 0x00000000, 0x7 );
  TEST_VI_OP( 39, vsadd.vi, 0x7fffffff, 0x7fffffff, 0x0 );
  TEST_VI_OP( 40, vsadd.vi, 0x7fffffff, 0x7fffffff, 0x7 );

  TEST_VI_OP( 41, vsadd.vi, 0x8000800d, 0x80008006, 0x7 );
  TEST_VI_OP( 42, vsadd.vi, 0x7fff7fff, 0x7fff7ff7, 0x8 );

  TEST_VI_OP( 43, vsadd.vi, 0x0000000f, 0x00000000, 0xf );
  TEST_VI_OP( 44, vsadd.vi, 0x00000000, 0xffffffff, 0x1 );
  TEST_VI_OP( 45, vsadd.vi, 0x0000000e, 0xffffffff, 0xf );

  TEST_VI_OP( 46, vsadd.vi, 0x00000008, 0x00000001, 0x7 );

#endif

#if __riscv_vsew == 64

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vsadd.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vsadd.vv, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 4,  vsadd.vv, 0x000000000000000a, 0x0000000000000003, 0x0000000000000007 );

  TEST_VV_OP( 5,  vsadd.vv, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VV_OP( 6,  vsadd.vv, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VV_OP( 7,  vsadd.vv, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vsadd.vv, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_VV_OP( 9,  vsadd.vv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VV_OP( 10, vsadd.vv, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VV_OP( 11, vsadd.vv, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vsadd.vv, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VV_OP( 13, vsadd.vv, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 14, vsadd.vv, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VV_OP( 15, vsadd.vv, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_VV_OP( 16, vsadd.vv, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );

  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vsadd.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 18, vsadd.vx, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 19, vsadd.vx, 0x000000000000000a, 0x0000000000000003, 0x0000000000000007 );

  TEST_VX_OP( 20, vsadd.vx, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VX_OP( 21, vsadd.vx, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VX_OP( 22, vsadd.vx, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VX_OP( 23, vsadd.vx, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_VX_OP( 24, vsadd.vx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VX_OP( 25, vsadd.vx, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VX_OP( 26, vsadd.vx, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VX_OP( 27, vsadd.vx, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VX_OP( 28, vsadd.vx, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 29, vsadd.vx, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VX_OP( 30, vsadd.vx, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_VX_OP( 31, vsadd.vx, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_VI_OP( 32, vsadd.vi, 0x00000000, 0x00000000, 0x0 );
  TEST_VI_OP( 33, vsadd.vi, 0x00000002, 0x00000001, 0x1 );
  TEST_VI_OP( 34, vsadd.vi, 0x0000000a, 0x00000003, 0x7 );

  TEST_VI_OP( 35, vsadd.vi, 0xfffffffffffffff8, 0xfffffffffffffff0, 0x8 );
  TEST_VI_OP( 36, vsadd.vi, 0xffffffff80000000, 0xffffffff80000000, 0x0 );
  TEST_VI_OP( 37, vsadd.vi, 0xffffffff7fff8000, 0xffffffff7fff7ff8, 0x8 );

  TEST_VI_OP( 38, vsadd.vi, 0x0000000000000007, 0x0000000000000000, 0x7 );
  TEST_VI_OP( 39, vsadd.vi, 0x000000007fffffff, 0x000000007fffffff, 0x0 );
  TEST_VI_OP( 40, vsadd.vi, 0x0000000080000006, 0x000000007fffffff, 0x7 );

  TEST_VI_OP( 41, vsadd.vi, 0xffffffff8000800d, 0xffffffff80008006, 0x7 );
  TEST_VI_OP( 42, vsadd.vi, 0x000000007fff7fff, 0x000000007fff7ff7, 0x8 );

  TEST_VI_OP( 43, vsadd.vi, 0x000000000000000f, 0x0000000000000000, 0xf );
  TEST_VI_OP( 44, vsadd.vi, 0x0000000000000000, 0xffffffffffffffff, 0x1 );
  TEST_VI_OP( 45, vsadd.vi, 0x000000000000000e, 0xffffffffffffffff, 0xf );

  TEST_VI_OP( 46, vsadd.vi, 0x0000000000000008, 0x0000000000000001, 0x7 );
	
#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

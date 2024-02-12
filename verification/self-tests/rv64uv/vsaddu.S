# See LICENSE for license details.

#*****************************************************************************
# vsaddu.S
#-----------------------------------------------------------------------------
#
# Test vsaddu instructions.
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

  TEST_VV_OP( 2,  vsaddu.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 3,  vsaddu.vv, 0x00000002, 0x00000001, 0x00000001 );
  TEST_VV_OP( 4,  vsaddu.vv, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_VV_OP( 5,  vsaddu.vv, 0xffff8000, 0x00000000, 0xffff8000 );
  TEST_VV_OP( 6,  vsaddu.vv, 0x80000000, 0x80000000, 0x00000000 );
  TEST_VV_OP( 7,  vsaddu.vv, 0xffffffff, 0x80000000, 0xffff8000 );

  TEST_VV_OP( 8,  vsaddu.vv, 0x00007fff, 0x00000000, 0x00007fff );
  TEST_VV_OP( 9,  vsaddu.vv, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_VV_OP( 10, vsaddu.vv, 0x80007FFE, 0x7fffffff, 0x00007fff );

  TEST_VV_OP( 11, vsaddu.vv, 0x80007fff, 0x80000000, 0x00007fff );
  TEST_VV_OP( 12, vsaddu.vv, 0xffffffff, 0x7fffffff, 0xffff8000 );

  TEST_VV_OP( 13, vsaddu.vv, 0xffffffff, 0x00000000, 0xffffffff );
  TEST_VV_OP( 14, vsaddu.vv, 0xffffffff, 0xffffffff, 0x00000001 );
  TEST_VV_OP( 15, vsaddu.vv, 0xffffffff, 0xffffffff, 0xffffffff );

  TEST_VV_OP( 16, vsaddu.vv, 0x80000000, 0x00000001, 0x7fffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vsaddu.vx, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VX_OP( 18, vsaddu.vx, 0x00000002, 0x00000001, 0x00000001 );
  TEST_VX_OP( 19, vsaddu.vx, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_VX_OP( 20, vsaddu.vx, 0xffff8000, 0x00000000, 0xffff8000 );
  TEST_VX_OP( 21, vsaddu.vx, 0x80000000, 0x80000000, 0x00000000 );
  TEST_VX_OP( 22, vsaddu.vx, 0xffffffff, 0x80000000, 0xffff8000 );

  TEST_VX_OP( 23, vsaddu.vx, 0x00007fff, 0x00000000, 0x00007fff );
  TEST_VX_OP( 24, vsaddu.vx, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_VX_OP( 25, vsaddu.vx, 0x80007FFE, 0x7fffffff, 0x00007fff );

  TEST_VX_OP( 26, vsaddu.vx, 0x80007fff, 0x80000000, 0x00007fff );
  TEST_VX_OP( 27, vsaddu.vx, 0xffffffff, 0x7fffffff, 0xffff8000 );

  TEST_VX_OP( 28, vsaddu.vx, 0xffffffff, 0x00000000, 0xffffffff );
  TEST_VX_OP( 29, vsaddu.vx, 0xffffffff, 0xffffffff, 0x00000001 );
  TEST_VX_OP( 30, vsaddu.vx, 0xffffffff, 0xffffffff, 0xffffffff );

  TEST_VX_OP( 31, vsaddu.vx, 0x80000000, 0x00000001, 0x7fffffff );
	
  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_VI_OP( 32, vsaddu.vi, 0x00000000, 0x00000000, 0x0 );
  TEST_VI_OP( 33, vsaddu.vi, 0x00000002, 0x00000001, 0x1 );
  TEST_VI_OP( 34, vsaddu.vi, 0x0000000a, 0x00000003, 0x7 );

  TEST_VI_OP( 35, vsaddu.vi, 0xfffffff8, 0xfffffff0, 0x8 );
  TEST_VI_OP( 36, vsaddu.vi, 0x80000000, 0x80000000, 0x0 );
  TEST_VI_OP( 37, vsaddu.vi, 0x7fff8000, 0x7fff7ff8, 0x8 );

  TEST_VI_OP( 38, vsaddu.vi, 0x00000007, 0x00000000, 0x7 );
  TEST_VI_OP( 39, vsaddu.vi, 0x7fffffff, 0x7fffffff, 0x0 );
  TEST_VI_OP( 40, vsaddu.vi, 0x80000006, 0x7fffffff, 0x7 );

  TEST_VI_OP( 41, vsaddu.vi, 0x8000800d, 0x80008006, 0x7 );
  TEST_VI_OP( 42, vsaddu.vi, 0x7fff7fff, 0x7fff7ff7, 0x8 );

  TEST_VI_OP( 43, vsaddu.vi, 0x0000000f, 0x00000000, 0xf );
  TEST_VI_OP( 44, vsaddu.vi, 0xffffffff, 0xffffffff, 0x1 );
  TEST_VI_OP( 45, vsaddu.vi, 0xffffffff, 0xffffffff, 0xf );

  TEST_VI_OP( 46, vsaddu.vi, 0x00000008, 0x00000001, 0x7 );

#endif

#if __riscv_vsew == 64

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vsaddu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vsaddu.vv, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 4,  vsaddu.vv, 0x000000000000000a, 0x0000000000000003, 0x0000000000000007 );

  TEST_VV_OP( 5,  vsaddu.vv, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VV_OP( 6,  vsaddu.vv, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VV_OP( 7,  vsaddu.vv, 0xffffffffffffffff, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vsaddu.vv, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_VV_OP( 9,  vsaddu.vv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VV_OP( 10, vsaddu.vv, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VV_OP( 11, vsaddu.vv, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vsaddu.vv, 0xffffffffffffffff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VV_OP( 13, vsaddu.vv, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 14, vsaddu.vv, 0xffffffffffffffff, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VV_OP( 15, vsaddu.vv, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_VV_OP( 16, vsaddu.vv, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );

  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vsaddu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 18, vsaddu.vx, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 19, vsaddu.vx, 0x000000000000000a, 0x0000000000000003, 0x0000000000000007 );

  TEST_VX_OP( 20, vsaddu.vx, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VX_OP( 21, vsaddu.vx, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VX_OP( 22, vsaddu.vx, 0xffffffffffffffff, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VX_OP( 23, vsaddu.vx, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_VX_OP( 24, vsaddu.vx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VX_OP( 25, vsaddu.vx, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VX_OP( 26, vsaddu.vx, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VX_OP( 27, vsaddu.vx, 0xffffffffffffffff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VX_OP( 28, vsaddu.vx, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 29, vsaddu.vx, 0xffffffffffffffff, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VX_OP( 30, vsaddu.vx, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_VX_OP( 31, vsaddu.vx, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_VI_OP( 32, vsaddu.vi, 0x00000000, 0x00000000, 0x0 );
  TEST_VI_OP( 33, vsaddu.vi, 0x00000002, 0x00000001, 0x1 );
  TEST_VI_OP( 34, vsaddu.vi, 0x0000000a, 0x00000003, 0x7 );

  TEST_VI_OP( 35, vsaddu.vi, 0xfffffffffffffff8, 0xfffffffffffffff0, 0x8 );
  TEST_VI_OP( 36, vsaddu.vi, 0xffffffff80000000, 0xffffffff80000000, 0x0 );
  TEST_VI_OP( 37, vsaddu.vi, 0xffffffff7fff8000, 0xffffffff7fff7ff8, 0x8 );

  TEST_VI_OP( 38, vsaddu.vi, 0x0000000000000007, 0x0000000000000000, 0x7 );
  TEST_VI_OP( 39, vsaddu.vi, 0x000000007fffffff, 0x000000007fffffff, 0x0 );
  TEST_VI_OP( 40, vsaddu.vi, 0x0000000080000006, 0x000000007fffffff, 0x7 );

  TEST_VI_OP( 41, vsaddu.vi, 0xffffffff8000800d, 0xffffffff80008006, 0x7 );
  TEST_VI_OP( 42, vsaddu.vi, 0x000000007fff7fff, 0x000000007fff7ff7, 0x8 );

  TEST_VI_OP( 43, vsaddu.vi, 0x000000000000000f, 0x0000000000000000, 0xf );
  TEST_VI_OP( 44, vsaddu.vi, 0xffffffffffffffff, 0xffffffffffffffff, 0x1 );
  TEST_VI_OP( 45, vsaddu.vi, 0xffffffffffffffff, 0xffffffffffffffff, 0xf );

  TEST_VI_OP( 46, vsaddu.vi, 0x0000000000000008, 0x0000000000000001, 0x7 );
	
#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

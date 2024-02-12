# See LICENSE for license details.

#*****************************************************************************
# vadd.S
#-----------------------------------------------------------------------------
#
# Test vadd instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vadd.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 3,  vadd.vv, 0x00000002, 0x00000001, 0x00000001 );
  TEST_VV_OP( 4,  vadd.vv, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_VV_OP( 5,  vadd.vv, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VV_OP( 6,  vadd.vv, 0xffffffff80000000, 0xffffffff80000000, 0x00000000 );
  TEST_VV_OP( 7,  vadd.vv, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vadd.vv, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_VV_OP( 9,  vadd.vv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VV_OP( 10, vadd.vv, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VV_OP( 11, vadd.vv, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vadd.vv, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VV_OP( 13, vadd.vv, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 14, vadd.vv, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VV_OP( 15, vadd.vv, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_VV_OP( 16, vadd.vv, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vadd.vx, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VX_OP( 18, vadd.vx, 0x00000002, 0x00000001, 0x00000001 );
  TEST_VX_OP( 19, vadd.vx, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_VX_OP( 20, vadd.vx, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VX_OP( 21, vadd.vx, 0xffffffff80000000, 0xffffffff80000000, 0x00000000 );
  TEST_VX_OP( 22, vadd.vx, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VX_OP( 23, vadd.vx, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_VX_OP( 24, vadd.vx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VX_OP( 25, vadd.vx, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VX_OP( 26, vadd.vx, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VX_OP( 27, vadd.vx, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VX_OP( 28, vadd.vx, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 29, vadd.vx, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VX_OP( 30, vadd.vx, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_VX_OP( 31, vadd.vx, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_VI_OP( 32, vadd.vi, 0x00000000, 0x00000000, 0x0 );
  TEST_VI_OP( 33, vadd.vi, 0x00000002, 0x00000001, 0x1 );
  TEST_VI_OP( 34, vadd.vi, 0x0000000a, 0x00000003, 0x7 );

  TEST_VI_OP( 35, vadd.vi, 0xfffffffffffffff8, 0xfffffffffffffff0, 0x8 );
  TEST_VI_OP( 36, vadd.vi, 0xffffffff80000000, 0xffffffff80000000, 0x0 );
  TEST_VI_OP( 37, vadd.vi, 0xffffffff7fff8000, 0xffffffff7fff7ff8, 0x8 );

  TEST_VI_OP( 38, vadd.vi, 0x0000000000000007, 0x0000000000000000, 0x7 );
  TEST_VI_OP( 39, vadd.vi, 0x000000007fffffff, 0x000000007fffffff, 0x0 );
  TEST_VI_OP( 40, vadd.vi, 0x0000000080000006, 0x000000007fffffff, 0x7 );

  TEST_VI_OP( 41, vadd.vi, 0xffffffff8000800d, 0xffffffff80008006, 0x7 );
  TEST_VI_OP( 42, vadd.vi, 0x000000007fff7fff, 0x000000007fff7ff7, 0x8 );

  TEST_VI_OP( 43, vadd.vi, 0x000000000000000f, 0x0000000000000000, 0xf );
  TEST_VI_OP( 44, vadd.vi, 0x0000000000000000, 0xffffffffffffffff, 0x1 );
  TEST_VI_OP( 45, vadd.vi, 0x000000000000000e, 0xffffffffffffffff, 0xf );

  TEST_VI_OP( 46, vadd.vi, 0x000000000000008, 0x0000000000000001, 0x7 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

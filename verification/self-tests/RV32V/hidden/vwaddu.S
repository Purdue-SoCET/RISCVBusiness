# See LICENSE for license details.

#*****************************************************************************
# vwaddu.S
#-----------------------------------------------------------------------------
#
# Test vwaddu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP( 2,  vwaddu.vv, 0x0000000000000000, 0x0000000000000000, 0x00000000 );
  TEST_W_VV_OP( 3,  vwaddu.vv, 0x0000000000000002, 0x0000000000000001, 0x00000001 );
  TEST_W_VV_OP( 4,  vwaddu.vv, 0x000000000000000a, 0x0000000000000003, 0x00000007 );

  TEST_W_VV_OP( 5,  vwaddu.vv, 0x00000000ffff8000, 0x0000000000000000, 0xffff8000 );
  TEST_W_VV_OP( 6,  vwaddu.vv, 0x0000000080000000, 0xffffffff80000000, 0x00000000 );
  TEST_W_VV_OP( 7,  vwaddu.vv, 0x000000017FFF8000, 0xffffffff80000000, 0xffff8000 );

  TEST_W_VV_OP( 8,  vwaddu.vv, 0x0000000000007fff, 0x0000000000000000, 0x00007fff );
  TEST_W_VV_OP( 9,  vwaddu.vv, 0x000000007fffffff, 0x000000007fffffff, 0x00000000 );
  TEST_W_VV_OP( 10, vwaddu.vv, 0x0000000080007ffe, 0x000000007fffffff, 0x00007fff );

  TEST_W_VV_OP( 11, vwaddu.vv, 0x0000000080007fff, 0xffffffff80000000, 0x00007fff );
  TEST_W_VV_OP( 12, vwaddu.vv, 0x000000017FFF7FFF, 0x000000007fffffff, 0xffff8000 );

  TEST_W_VV_OP( 13, vwaddu.vv, 0x00000000ffffffff, 0x0000000000000000, 0xffffffff );
  TEST_W_VV_OP( 14, vwaddu.vv, 0x0000000100000000, 0xffffffffffffffff, 0x00000001 );
  TEST_W_VV_OP( 15, vwaddu.vv, 0x00000001fffffffe, 0xffffffffffffffff, 0xffffffff );

  TEST_W_VV_OP( 16, vwaddu.vv, 0x0000000080000000, 0x0000000000000001, 0x7fffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP( 17, vwaddu.vx, 0x0000000000000000, 0x0000000000000000, 0x00000000 );
  TEST_W_VX_OP( 18, vwaddu.vx, 0x0000000000000002, 0x0000000000000001, 0x00000001 );
  TEST_W_VX_OP( 19, vwaddu.vx, 0x000000000000000a, 0x0000000000000003, 0x00000007 );

  TEST_W_VX_OP( 20, vwaddu.vx, 0x00000000ffff8000, 0x0000000000000000, 0xffff8000 );
  TEST_W_VX_OP( 21, vwaddu.vx, 0x0000000080000000, 0xffffffff80000000, 0x00000000 );
  TEST_W_VX_OP( 22, vwaddu.vx, 0x000000017FFF8000, 0xffffffff80000000, 0xffff8000 );

  TEST_W_VX_OP( 23, vwaddu.vx, 0x0000000000007fff, 0x0000000000000000, 0x00007fff );
  TEST_W_VX_OP( 24, vwaddu.vx, 0x000000007fffffff, 0x000000007fffffff, 0x00000000 );
  TEST_W_VX_OP( 25, vwaddu.vx, 0x0000000080007ffe, 0x000000007fffffff, 0x00007fff );

  TEST_W_VX_OP( 26, vwaddu.vx, 0x0000000080007fff, 0xffffffff80000000, 0x00007fff );
  TEST_W_VX_OP( 27, vwaddu.vx, 0x000000017FFF7FFF, 0x000000007fffffff, 0xffff8000 );

  TEST_W_VX_OP( 28, vwaddu.vx, 0x00000000ffffffff, 0x0000000000000000, 0xffffffff );
  TEST_W_VX_OP( 29, vwaddu.vx, 0x0000000100000000, 0xffffffffffffffff, 0x00000001 );
  TEST_W_VX_OP( 30, vwaddu.vx, 0x00000001fffffffe, 0xffffffffffffffff, 0xffffffff );

  TEST_W_VX_OP( 31, vwaddu.vx, 0x0000000080000000, 0x0000000000000001, 0x7fffffff );
	
  #-------------------------------------------------------------
  # WV Tests
  #-------------------------------------------------------------

  // mse - most signficant element from widening/doubling element width
  // mse is sign-extended from the result if not specified in comments
  TEST_W_WVU_OP( 32, vwaddu.wv, 0x0000000000000000, 0x0000000000000000, 0x00000000 );
  TEST_W_WVU_OP( 33, vwaddu.wv, 0x0000000000000002, 0x0000000000000001, 0x00000001 );
  TEST_W_WVU_OP( 34, vwaddu.wv, 0x000000000000000a, 0x0000000000000003, 0x00000007 );

  TEST_W_WVU_OP( 35, vwaddu.wv, 0x00000000ffff8000, 0x0000000000000000, 0xffff8000 );
  TEST_W_WVU_OP( 36, vwaddu.wv, 0xffffffff80000001, 0xffffffff80000000, 0x00000000 );
  TEST_W_WVU_OP( 37, vwaddu.wv, 0x000000007fff8001, 0xffffffff80000000, 0xffff8000 ); // mse = 0x0000000000001	

  TEST_W_WVU_OP( 38, vwaddu.wv, 0x0000000000007fff, 0x0000000000000000, 0x00007fff );
  TEST_W_WVU_OP( 39, vwaddu.wv, 0x000000007fffffff, 0x000000007fffffff, 0x00000000 );
  TEST_W_WVU_OP( 40, vwaddu.wv, 0x0000000080007ffe, 0x000000007fffffff, 0x00007fff );

  TEST_W_WVU_OP( 41, vwaddu.wv, 0xffffffff80008000, 0xffffffff80000000, 0x00007fff );
  TEST_W_WVU_OP( 42, vwaddu.wv, 0x000000017FFF7FFF, 0x000000007fffffff, 0xffff8000 ); // mse = 0x0000000000001

  TEST_W_WVU_OP( 43, vwaddu.wv, 0x00000000ffffffff, 0x0000000000000000, 0xffffffff );
  TEST_W_WVU_OP( 44, vwaddu.wv, 0xffffffff80008002, 0xffffffff80008000, 0x00000001 ); // mse = 0x0000000000001
  TEST_W_WVU_OP( 45, vwaddu.wv, 0x00000000fffffffe, 0xffffffffffffffff, 0xffffffff ); // mse = 0x0000000000001

  TEST_W_WVU_OP( 46, vwaddu.wv, 0x0000000080000000, 0x0000000000000001, 0x7fffffff );
	
  #-------------------------------------------------------------
  # WX Tests
  #-------------------------------------------------------------

  // mse - most signficant element from widening/doubling element width
  // mse is sign-extended from the result if not specified in comments
  TEST_W_WXU_OP( 47, vwaddu.wx, 0x0000000000000000, 0x0000000000000000, 0x00000000 );
  TEST_W_WXU_OP( 48, vwaddu.wx, 0x0000000000000002, 0x0000000000000001, 0x00000001 );
  TEST_W_WXU_OP( 49, vwaddu.wx, 0x000000000000000a, 0x0000000000000003, 0x00000007 );

  TEST_W_WXU_OP( 50, vwaddu.wx, 0x00000000ffff8000, 0x0000000000000000, 0xffff8000 );
  TEST_W_WXU_OP( 51, vwaddu.wx, 0xffffffff80000001, 0xffffffff80000000, 0x00000000 );
  TEST_W_WXU_OP( 52, vwaddu.wx, 0x000000007fff8001, 0xffffffff80000000, 0xffff8000 ); // mse = 0x0000000000001

  TEST_W_WXU_OP( 53, vwaddu.wx, 0x0000000000007fff, 0x0000000000000000, 0x00007fff );
  TEST_W_WXU_OP( 54, vwaddu.wx, 0x000000007fffffff, 0x000000007fffffff, 0x00000000 );
  TEST_W_WXU_OP( 55, vwaddu.wx, 0x0000000080007ffe, 0x000000007fffffff, 0x00007fff );

  TEST_W_WXU_OP( 56, vwaddu.wx, 0xffffffff80008000, 0xffffffff80000000, 0x00007fff );
  TEST_W_WXU_OP( 57, vwaddu.wx, 0x000000017FFF7FFF, 0x000000007fffffff, 0xffff8000 ); // mse = 0x0000000000001

  TEST_W_WXU_OP( 58, vwaddu.wx, 0x00000000ffffffff, 0x0000000000000000, 0xffffffff );
  TEST_W_WXU_OP( 59, vwaddu.wx, 0xffffffff80008002, 0xffffffff80008000, 0x00000001 ); // mse = 0x0000000000001
  TEST_W_WXU_OP( 60, vwaddu.wx, 0x00000000fffffffe, 0xffffffffffffffff, 0xffffffff ); // mse = 0x0000000000001

  TEST_W_WXU_OP( 61, vwaddu.wx, 0x0000000080000000, 0x0000000000000001, 0x7fffffff );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

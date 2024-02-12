# See LICENSE for license details.

#*****************************************************************************
# vwadd.S
#-----------------------------------------------------------------------------
#
# Test vwadd instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP( 2, vwadd.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_W_VV_OP( 3, vwadd.vv, 0x00000002, 0x00000001, 0x00000001 );
  TEST_W_VV_OP( 4, vwadd.vv, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_W_VV_OP( 5,  vwadd.vv, 0xffffffffffff8000, 0x00000000, 0xffff8000 );
  TEST_W_VV_OP( 6,  vwadd.vv, 0xffffffff80000000, 0x80000000, 0x00000000 );
  TEST_W_VV_OP( 7,  vwadd.vv, 0xffffffff7fff8000, 0x80000000, 0xffff8000 );

  TEST_W_VV_OP( 8,  vwadd.vv, 0x0000000000007fff, 0x00000000, 0x00007fff );
  TEST_W_VV_OP( 9,  vwadd.vv, 0x000000007fffffff, 0x7fffffff, 0x00000000 );
  TEST_W_VV_OP( 10, vwadd.vv, 0x0000000080007ffe, 0x7fffffff, 0x00007fff );

  TEST_W_VV_OP( 11, vwadd.vv, 0xffffffff80007fff, 0x80000000, 0x00007fff );
  TEST_W_VV_OP( 12, vwadd.vv, 0x000000007fff7fff, 0x7fffffff, 0xffff8000 );

  TEST_W_VV_OP( 13, vwadd.vv, 0xffffffffffffffff, 0x00000000, 0xffffffff );
  TEST_W_VV_OP( 14, vwadd.vv, 0x0000000000000000, 0xffffffff, 0x00000001 );
  TEST_W_VV_OP( 15, vwadd.vv, 0xfffffffffffffffe, 0xffffffff, 0xffffffff );

  TEST_W_VV_OP( 16, vwadd.vv, 0x0000000080000000, 0x00000001, 0x7fffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP( 17, vwadd.vx, 0x00000000, 0x00000000, 0x00000000 );
  TEST_W_VX_OP( 18, vwadd.vx, 0x00000002, 0x00000001, 0x00000001 );
  TEST_W_VX_OP( 19, vwadd.vx, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_W_VX_OP( 20, vwadd.vx, 0xffffffffffff8000, 0x00000000, 0xffff8000 );
  TEST_W_VX_OP( 21, vwadd.vx, 0xffffffff80000000, 0x80000000, 0x00000000 );
  TEST_W_VX_OP( 22, vwadd.vx, 0xffffffff7fff8000, 0x80000000, 0xffff8000 );

  TEST_W_VX_OP( 23, vwadd.vx, 0x0000000000007fff, 0x00000000, 0x00007fff );
  TEST_W_VX_OP( 24, vwadd.vx, 0x000000007fffffff, 0x7fffffff, 0x00000000 );
  TEST_W_VX_OP( 25, vwadd.vx, 0x0000000080007ffe, 0x7fffffff, 0x00007fff );

  TEST_W_VX_OP( 26, vwadd.vx, 0xffffffff80007fff, 0x80000000, 0x00007fff );
  TEST_W_VX_OP( 27, vwadd.vx, 0x000000007fff7fff, 0x7fffffff, 0xffff8000 );

  TEST_W_VX_OP( 28, vwadd.vx, 0xffffffffffffffff, 0x00000000, 0xffffffff );
  TEST_W_VX_OP( 29, vwadd.vx, 0x0000000000000000, 0xffffffff, 0x00000001 );
  TEST_W_VX_OP( 30, vwadd.vx, 0xfffffffffffffffe, 0xffffffff, 0xffffffff );

  TEST_W_VX_OP( 31, vwadd.vx, 0x0000000080000000, 0x00000001, 0x7fffffff );
	
  #-------------------------------------------------------------
  # WV Tests
  #-------------------------------------------------------------

  // mse - most signficant element from widening/doubling element width
  // mse is sign-extended from the result if not specified in comments
  TEST_W_WV_OP( 32, vwadd.wv, 0x0000000000000000, 0x0000000000000000, 0x00000000 );
  TEST_W_WV_OP( 33, vwadd.wv, 0x0000000000000002, 0x0000000000000001, 0x00000001 );
  TEST_W_WV_OP( 34, vwadd.wv, 0x000000000000000a, 0x0000000000000003, 0x00000007 );

  TEST_W_WV_OP( 35, vwadd.wv, 0xffffffffffff8000, 0x0000000000000000, 0xffff8000 );
  TEST_W_WV_OP( 36, vwadd.wv, 0xffffffff80000000, 0xffffffff80000000, 0x00000000 );	
  TEST_W_WV_OP( 37, vwadd.wv, 0xFFFFFFFF7FFF8000, 0xffffffff80000000, 0xffff8000 ); // mse = 0x0000000000001

  TEST_W_WV_OP( 38, vwadd.wv, 0x0000000000007fff, 0x0000000000000000, 0x00007fff );
  TEST_W_WV_OP( 39, vwadd.wv, 0x000000007fffffff, 0x000000007fffffff, 0x00000000 );
  TEST_W_WV_OP( 40, vwadd.wv, 0x0000000080007ffe, 0x000000007fffffff, 0x00007fff );

  TEST_W_WV_OP( 41, vwadd.wv, 0xffffffff80007fff, 0xffffffff80000000, 0x00007fff );
  TEST_W_WV_OP( 42, vwadd.wv, 0x000000007FFF7FFF, 0x000000007fffffff, 0xffff8000 ); // mse = 0x0000000000001

  TEST_W_WV_OP( 43, vwadd.wv, 0xffffffff7fffffff, 0xffffffff00000000, 0xffffffff );
  TEST_W_WV_OP( 44, vwadd.wv, 0x0000000000000000, 0xffffffffffffffff, 0x00000001 ); // mse = 0x0000000000001
  TEST_W_WV_OP( 45, vwadd.wv, 0xFFFFFFFFFFFFFFFE, 0xffffffffffffffff, 0xffffffff ); // mse = 0x0000000000001

  TEST_W_WV_OP( 46, vwadd.wv, 0x0000000080000000, 0x0000000000000001, 0x7fffffff );	

  #-------------------------------------------------------------
  # WX Tests
  # Spike not support vwadd.wx yet (2021/10/21).
  #-------------------------------------------------------------

  // mse - most signficant element from widening/doubling element width
  // mse is sign-extended from the result if not specified in comments
  TEST_W_WX_OP( 47, vwadd.wx, 0x0000000000000000, 0x0000000000000000, 0x00000000 );
  TEST_W_WX_OP( 48, vwadd.wx, 0x0000000000000002, 0x0000000000000001, 0x00000001 );
  TEST_W_WX_OP( 49, vwadd.wx, 0x000000000000000a, 0x0000000000000003, 0x00000007 );

  TEST_W_WX_OP( 50, vwadd.wx, 0xffffffffffff8000, 0x0000000000000000, 0xffff8000 );
  TEST_W_WX_OP( 51, vwadd.wx, 0xffffffff80000000, 0xffffffff80000000, 0x0000000 );
  TEST_W_WX_OP( 52, vwadd.wx, 0xFFFFFFFF7FFF8000, 0xffffffff80000000, 0xffff8000 ); // mse = 0x0000000000001

  TEST_W_WX_OP( 53, vwadd.wx, 0x0000000000007fff, 0x0000000000000000, 0x00007fff );
  TEST_W_WX_OP( 54, vwadd.wx, 0x000000007fffffff, 0x000000007fffffff, 0x00000000 );
  TEST_W_WX_OP( 55, vwadd.wx, 0x0000000080007ffe, 0x000000007fffffff, 0x00007fff );

  TEST_W_WX_OP( 56, vwadd.wx, 0xffffffff80007fff, 0xffffffff80000000, 0x00007fff );
  TEST_W_WX_OP( 57, vwadd.wx, 0x000000007FFF7FFF, 0x000000007fffffff, 0xffff8000 ); // mse = 0x0000000000001

  TEST_W_WX_OP( 58, vwadd.wx, 0xffffffff7fffffff, 0xffffffff00000000, 0xffffffff );
  TEST_W_WX_OP( 59, vwadd.wx, 0x0000000000000000, 0xffffffffffffffff, 0x00000001 ); // mse = 0x0000000000001
  TEST_W_WX_OP( 60, vwadd.wx, 0xFFFFFFFFFFFFFFFE, 0xffffffffffffffff, 0xffffffff ); // mse = 0x0000000000001

  TEST_W_WX_OP( 61, vwadd.wx, 0x0000000080000000, 0x0000000000000001, 0x7fffffff );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

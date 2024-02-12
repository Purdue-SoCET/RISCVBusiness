# See LICENSE for license details.

#*****************************************************************************
# vwsubu.S
#-----------------------------------------------------------------------------
#
# Test vwsubu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP( 2,  vwsubu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_W_VV_OP( 3,  vwsubu.vv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_W_VV_OP( 4,  vwsubu.vv, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_W_VV_OP( 5,  vwsubu.vv, 0xffffffff00008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_W_VV_OP( 6,  vwsubu.vv, 0x0000000080000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_W_VV_OP( 7,  vwsubu.vv, 0xFFFFFFFF80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_W_VV_OP( 8,  vwsubu.vv, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_W_VV_OP( 9,  vwsubu.vv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_W_VV_OP( 10, vwsubu.vv, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_W_VV_OP( 11, vwsubu.vv, 0x000000007fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_W_VV_OP( 12, vwsubu.vv, 0xffffffff80007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_W_VV_OP( 13, vwsubu.vv, 0xffffffff00000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_W_VV_OP( 14, vwsubu.vv, 0x00000000fffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_W_VV_OP( 15, vwsubu.vv, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP( 16, vwsubu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_W_VX_OP( 17, vwsubu.vx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_W_VX_OP( 18, vwsubu.vx, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_W_VX_OP( 19, vwsubu.vx, 0xffffffff00008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_W_VX_OP( 20, vwsubu.vx, 0x0000000080000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_W_VX_OP( 21, vwsubu.vx, 0xFFFFFFFF80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_W_VX_OP( 22, vwsubu.vx, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_W_VX_OP( 23, vwsubu.vx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_W_VX_OP( 24, vwsubu.vx, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_W_VX_OP( 25, vwsubu.vx, 0x000000007fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_W_VX_OP( 26, vwsubu.vx, 0xffffffff80007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_W_VX_OP( 27, vwsubu.vx, 0xffffffff00000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_W_VX_OP( 28, vwsubu.vx, 0x00000000fffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_W_VX_OP( 29, vwsubu.vx, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # WV Tests
  #-------------------------------------------------------------

  // mse - most signficant element from widening/doubling element width
  TEST_W_WVU_OP( 30, vwsubu.wv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WVU_OP( 31, vwsubu.wv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 ); // mse = 0x0
  TEST_W_WVU_OP( 32, vwsubu.wv, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 ); // mse = 0xffffffffffffffff

  TEST_W_WVU_OP( 33, vwsubu.wv, 0xffffffff00008000, 0x0000000000000000, 0xffffffffffff8000 ); // mse = 0x0
  TEST_W_WVU_OP( 34, vwsubu.wv, 0xffffffff80000001, 0xffffffff80000000, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WVU_OP( 35, vwsubu.wv, 0xFFFFFFFE80008001, 0xffffffff80000000, 0xffffffffffff8000 ); // mse = 0x0

  TEST_W_WVU_OP( 36, vwsubu.wv, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff ); // mse = 0xffffffffffffffff
  TEST_W_WVU_OP( 37, vwsubu.wv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WVU_OP( 38, vwsubu.wv, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff ); // mse = 0x0

  TEST_W_WVU_OP( 39, vwsubu.wv, 0xffffffff7fff8002, 0xffffffff80000000, 0x0000000000007fff ); // mse = 0xffffffffffffffff
  TEST_W_WVU_OP( 40, vwsubu.wv, 0xffffffff80007fff, 0x000000007fffffff, 0xffffffffffff8000 ); // mse = 0xffffffffffffffff

  TEST_W_WVU_OP( 41, vwsubu.wv, 0xffffffff00000001, 0x0000000000000000, 0xffffffffffffffff ); // mse = 0x0100000000000000
  TEST_W_WVU_OP( 42, vwsubu.wv, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 ); // mse = 0x0
  TEST_W_WVU_OP( 43, vwsubu.wv, 0xffffffff00000000, 0xffffffffffffffff, 0xffffffffffffffff ); // mse = 0x0
	
  #-------------------------------------------------------------
  # WX Tests
  #-------------------------------------------------------------

  // mse - most signficant element from widening/doubling element width
  TEST_W_WXU_OP( 44, vwsubu.wx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WXU_OP( 45, vwsubu.wx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 ); // mse = 0x0
  TEST_W_WXU_OP( 46, vwsubu.wx, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 ); // mse = 0xffffffffffffffff

  TEST_W_WXU_OP( 47, vwsubu.wx, 0xffffffff00008000, 0x0000000000000000, 0xffffffffffff8000 ); // mse = 0x0
  TEST_W_WXU_OP( 48, vwsubu.wx, 0xffffffff80000001, 0xffffffff80000000, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WXU_OP( 49, vwsubu.wx, 0xFFFFFFFE80008001, 0xffffffff80000000, 0xffffffffffff8000 ); // mse = 0x0

  TEST_W_WXU_OP( 50, vwsubu.wx, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff ); // mse = 0xffffffffffffffff
  TEST_W_WXU_OP( 51, vwsubu.wx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WXU_OP( 52, vwsubu.wx, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff ); // mse = 0x0

  TEST_W_WXU_OP( 53, vwsubu.wx, 0xffffffff7fff8002, 0xffffffff80000000, 0x0000000000007fff ); // mse = 0xffffffffffffffff
  TEST_W_WXU_OP( 54, vwsubu.wx, 0xffffffff80007fff, 0x000000007fffffff, 0xffffffffffff8000 ); // mse = 0xffffffffffffffff

  TEST_W_WXU_OP( 55, vwsubu.wx, 0xffffffff00000001, 0x0000000000000000, 0xffffffffffffffff ); // mse = 0x0100000000000000
  TEST_W_WXU_OP( 56, vwsubu.wx, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 ); // mse = 0x0
  TEST_W_WXU_OP( 57, vwsubu.wx, 0xffffffff00000000, 0xffffffffffffffff, 0xffffffffffffffff ); // mse = 0x0
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

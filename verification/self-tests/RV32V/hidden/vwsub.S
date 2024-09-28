# See LICENSE for license details.

#*****************************************************************************
# vwsub.S
#-----------------------------------------------------------------------------
#
# Test vwsub instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP( 2,  vwsub.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_W_VV_OP( 3,  vwsub.vv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_W_VV_OP( 4,  vwsub.vv, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_W_VV_OP( 5,  vwsub.vv, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_W_VV_OP( 6,  vwsub.vv, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_W_VV_OP( 7,  vwsub.vv, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_W_VV_OP( 8,  vwsub.vv, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_W_VV_OP( 9,  vwsub.vv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_W_VV_OP( 10, vwsub.vv, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_W_VV_OP( 11, vwsub.vv, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_W_VV_OP( 12, vwsub.vv, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_W_VV_OP( 13, vwsub.vv, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_W_VV_OP( 14, vwsub.vv, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_W_VV_OP( 15, vwsub.vv, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP( 16, vwsub.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_W_VX_OP( 17, vwsub.vx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_W_VX_OP( 18, vwsub.vx, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_W_VX_OP( 19, vwsub.vx, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_W_VX_OP( 20, vwsub.vx, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_W_VX_OP( 21, vwsub.vx, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_W_VX_OP( 22, vwsub.vx, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_W_VX_OP( 23, vwsub.vx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_W_VX_OP( 24, vwsub.vx, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_W_VX_OP( 25, vwsub.vx, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_W_VX_OP( 26, vwsub.vx, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_W_VX_OP( 27, vwsub.vx, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_W_VX_OP( 28, vwsub.vx, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_W_VX_OP( 29, vwsub.vx, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # WV Tests
  #-------------------------------------------------------------

  // mse - most signficant element from widening/doubling element width
  TEST_W_WV_OP( 30, vwsub.wv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WV_OP( 31, vwsub.wv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 ); // mse = 0x0
  TEST_W_WV_OP( 32, vwsub.wv, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 ); // mse = 0xffffffffffffffff

  TEST_W_WV_OP( 33, vwsub.wv, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 ); // mse = 0x0
  TEST_W_WV_OP( 34, vwsub.wv, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 ); // mse = 0xffffffffffffffff
  TEST_W_WV_OP( 35, vwsub.wv, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 ); // mse = 0xffffffffffffffff

  TEST_W_WV_OP( 36, vwsub.wv, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff ); // mse = 0xffffffffffffffff
  TEST_W_WV_OP( 37, vwsub.wv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WV_OP( 38, vwsub.wv, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff ); // mse = 0x0

  TEST_W_WV_OP( 39, vwsub.wv, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff ); // mse = 0xffffffffffffffff
  TEST_W_WV_OP( 40, vwsub.wv, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 ); // mse = 0x0

  TEST_W_WV_OP( 41, vwsub.wv, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff ); // mse = 0x0
  TEST_W_WV_OP( 42, vwsub.wv, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 ); // mse = 0xffffffffffffffff
  TEST_W_WV_OP( 43, vwsub.wv, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff ); // mse = 0x0
	
  #-------------------------------------------------------------
  # WX Tests
  #-------------------------------------------------------------

  // mse - most signficant element from widening/doubling element width
  TEST_W_WX_OP( 44, vwsub.wx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WX_OP( 45, vwsub.wx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 ); // mse = 0x0
  TEST_W_WX_OP( 46, vwsub.wx, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 ); // mse = 0xffffffffffffffff

  TEST_W_WX_OP( 47, vwsub.wx, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 ); // mse = 0x0
  TEST_W_WX_OP( 48, vwsub.wx, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 ); // mse = 0xffffffffffffffff
  TEST_W_WX_OP( 49, vwsub.wx, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 ); // mse = 0xffffffffffffffff

  TEST_W_WX_OP( 50, vwsub.wx, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff ); // mse = 0xffffffffffffffff
  TEST_W_WX_OP( 51, vwsub.wx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 ); // mse = 0x0
  TEST_W_WX_OP( 52, vwsub.wx, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff ); // mse = 0x0

  TEST_W_WX_OP( 53, vwsub.wx, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff ); // mse = 0xffffffffffffffff
  TEST_W_WX_OP( 54, vwsub.wx, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 ); // mse = 0x0

  TEST_W_WX_OP( 55, vwsub.wx, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff ); // mse = 0x0
  TEST_W_WX_OP( 56, vwsub.wx, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 ); // mse = 0xffffffffffffffff
  TEST_W_WX_OP( 57, vwsub.wx, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff ); // mse = 0x0
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

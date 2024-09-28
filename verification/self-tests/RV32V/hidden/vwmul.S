# See LICENSE for license details.

#*****************************************************************************
# vwmul.S
#-----------------------------------------------------------------------------
#
# Test vwmul instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP( 2,  vwmul.vv, 0x0000000000000000, 0x00000000, 0x00000000 );
  TEST_W_VV_OP( 3,  vwmul.vv, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VV_OP( 4,  vwmul.vv, 0x000000fffee00051, 0x000ffff7, 0x000ffff7 );

  TEST_W_VV_OP( 5,  vwmul.vv, 0x0000000000000000, 0x00000000, 0xffffffff );
  TEST_W_VV_OP( 6,  vwmul.vv, 0xffffffffffffffff, 0x00000001, 0xffffffff ); # mse: 0x0000000000000000
  TEST_W_VV_OP( 7,  vwmul.vv, 0xffffffffffff0000, 0x00000002, 0xffff8000 ); # mse: 0x0000000000000001

  TEST_W_VV_OP( 8,  vwmul.vv, 0x0000000040000000, 0xffff8000, 0xffff8000 );
  TEST_W_VV_OP( 9,  vwmul.vv, 0x0000000000000001, 0x00000001, 0x00000001 ); # mse: 0xe100000000000001
  TEST_W_VV_OP( 10, vwmul.vv, 0x0000000000000000, 0x00000001, 0x00000000 ); # mse: 0xe100000000000000

  TEST_W_VV_OP( 11, vwmul.vv, 0xffffc00080000000, 0x80000000, 0x00007fff );
  TEST_W_VV_OP( 12, vwmul.vv, 0xffffffffffff8001, 0xffffffff, 0x00007fff );
  TEST_W_VV_OP( 13, vwmul.vv, 0x0000000000000001, 0xffffffff, 0xffffffff ); # mse: 0x00ffffffffffffff

  TEST_W_VV_OP( 14, vwmul.vv, 0x3fffffff00000001, 0x7fffffff, 0x7fffffff );
  TEST_W_VV_OP( 15, vwmul.vv, 0x0000000000000000, 0x00000000, 0x7fffffff ); # mse: 0x0000000077ffffff
  TEST_W_VV_OP( 16, vwmul.vv, 0x0000000000000000, 0x00000000, 0x00000000 );
	                          
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP( 17, vwmul.vx, 0x0000000000000000, 0x00000000, 0x00000000 );
  TEST_W_VX_OP( 18, vwmul.vx, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VX_OP( 19, vwmul.vx, 0x000000fffee00051, 0x000ffff7, 0x000ffff7 );

  TEST_W_VX_OP( 20, vwmul.vx, 0x0000000000000000, 0x00000000, 0xffffffff );
  TEST_W_VX_OP( 21, vwmul.vx, 0xffffffffffffffff, 0x00000001, 0xffffffff ); # mse: 0x0000000000000000
  TEST_W_VX_OP( 22, vwmul.vx, 0xffffffffffff0000, 0x00000002, 0xffff8000 ); # mse: 0x0000000000000001

  TEST_W_VX_OP( 23, vwmul.vx, 0x0000000040000000, 0xffff8000, 0xffff8000 );
  TEST_W_VX_OP( 24, vwmul.vx, 0x0000000000000001, 0x00000001, 0x00000001 ); # mse: 0xe100000000000001
  TEST_W_VX_OP( 25, vwmul.vx, 0x0000000000000000, 0x00000001, 0x00000000 ); # mse: 0xe100000000000000

  TEST_W_VX_OP( 26, vwmul.vx, 0xffffc00080000000, 0x80000000, 0x00007fff );
  TEST_W_VX_OP( 27, vwmul.vx, 0xffffffffffff8001, 0xffffffff, 0x00007fff );
  TEST_W_VX_OP( 28, vwmul.vx, 0x0000000000000001, 0xffffffff, 0xffffffff ); # mse: 0x00ffffffffffffff

  TEST_W_VX_OP( 29, vwmul.vx, 0x3fffffff00000001, 0x7fffffff, 0x7fffffff );
  TEST_W_VX_OP( 30, vwmul.vx, 0x0000000000000000, 0x00000000, 0x7fffffff ); # mse: 0x0000000077ffffff
  TEST_W_VX_OP( 31, vwmul.vx, 0x0000000000000000, 0x00000000, 0x00000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

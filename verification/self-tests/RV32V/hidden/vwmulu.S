# See LICENSE for license details.

#*****************************************************************************
# vwmulu.S
#-----------------------------------------------------------------------------
#
# Test vwmulu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP( 2,  vwmulu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_W_VV_OP( 3,  vwmulu.vv, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_W_VV_OP( 4,  vwmulu.vv, 0x000000fffee00051, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_W_VV_OP( 5,  vwmulu.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_W_VV_OP( 6,  vwmulu.vv, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff ); # mse: 0x0000000000000000
  TEST_W_VV_OP( 7,  vwmulu.vv, 0xffffffffffff0000, 0x0000000000000002, 0xffffffffffff8000 ); # mse: 0x0000000000000001

  TEST_W_VV_OP( 8,  vwmulu.vv, 0x0000000040000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_W_VV_OP( 9,  vwmulu.vv, 0xe000000000000001, 0xf000000000000001, 0xf000000000000001 ); # mse: 0xe100000000000001
  TEST_W_VV_OP( 10, vwmulu.vv, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 ); # mse: 0xe100000000000000

  TEST_W_VV_OP( 11, vwmulu.vv, 0x00003fff80000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_W_VV_OP( 12, vwmulu.vv, 0xefffffffffff8001, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_W_VV_OP( 13, vwmulu.vv, 0xe000000000000001, 0x0fffffffffffffff, 0x0fffffffffffffff ); # mse: 0x00ffffffffffffff

  TEST_W_VV_OP( 14, vwmulu.vv, 0x3fffffff00000001, 0x000000007fffffff, 0x000000007fffffff );
  TEST_W_VV_OP( 15, vwmulu.vv, 0x1000000000000000, 0xf000000000000000, 0x000000007fffffff ); # mse: 0x0000000077ffffff
  TEST_W_VV_OP( 16, vwmulu.vv, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP( 17, vwmulu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_W_VX_OP( 18, vwmulu.vx, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_W_VX_OP( 19, vwmulu.vx, 0x000000fffee00051, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_W_VX_OP( 20, vwmulu.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_W_VX_OP( 21, vwmulu.vx, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff ); # mse: 0x0000000000000000
  TEST_W_VX_OP( 22, vwmulu.vx, 0xffffffffffff0000, 0x0000000000000002, 0xffffffffffff8000 ); # mse: 0x0000000000000001

  TEST_W_VX_OP( 23, vwmulu.vx, 0x0000000040000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_W_VX_OP( 24, vwmulu.vx, 0xe000000000000001, 0xf000000000000001, 0xf000000000000001 ); # mse: 0xe100000000000001
  TEST_W_VX_OP( 25, vwmulu.vx, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 ); # mse: 0xe100000000000000

  TEST_W_VX_OP( 26, vwmulu.vx, 0x00003fff80000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_W_VX_OP( 27, vwmulu.vx, 0xefffffffffff8001, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_W_VX_OP( 28, vwmulu.vx, 0xe000000000000001, 0x0fffffffffffffff, 0x0fffffffffffffff ); # mse: 0x00ffffffffffffff

  TEST_W_VX_OP( 29, vwmulu.vx, 0x3fffffff00000001, 0x000000007fffffff, 0x000000007fffffff );
  TEST_W_VX_OP( 30, vwmulu.vx, 0x1000000000000000, 0xf000000000000000, 0x000000007fffffff ); # mse: 0x0000000077ffffff
  TEST_W_VX_OP( 31, vwmulu.vx, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

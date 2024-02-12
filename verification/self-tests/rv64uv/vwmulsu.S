# See LICENSE for license details.

#*****************************************************************************
# vwmul.S
#-----------------------------------------------------------------------------
#
# Test vwmulsu instructions.
# TEST_VV(X)_OP( testnum, inst, result, val1, val2 )
#   val1: signed, val2: unsigned
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP( 2,  vwmulsu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_W_VV_OP( 3,  vwmulsu.vv, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_W_VV_OP( 4,  vwmulsu.vv, 0x000000fffee00051, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_W_VV_OP( 5,  vwmulsu.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_W_VV_OP( 6,  vwmulsu.vv, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff ); # mse: 0x0000000000000000
  TEST_W_VV_OP( 7,  vwmulsu.vv, 0xffffffffffff0000, 0x0000000000000002, 0xffffffffffff8000 ); # mse: 0x0000000000000001

  TEST_W_VV_OP( 8,  vwmulsu.vv, 0x0000000040000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_W_VV_OP( 9,  vwmulsu.vv, 0xe000000000000001, 0xf000000000000001, 0xf000000000000001 ); # mse: 0xe100000000000001
  TEST_W_VV_OP( 10, vwmulsu.vv, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 ); # mse: 0xe100000000000000

  TEST_W_VV_OP( 11, vwmulsu.vv, 0x00003fff80000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_W_VV_OP( 12, vwmulsu.vv, 0xefffffffffff8001, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_W_VV_OP( 13, vwmulsu.vv, 0xe000000000000001, 0x0fffffffffffffff, 0x0fffffffffffffff ); # mse: 0x00ffffffffffffff

  TEST_W_VV_OP( 14, vwmulsu.vv, 0x3fffffff00000001, 0x000000007fffffff, 0x000000007fffffff );
  TEST_W_VV_OP( 15, vwmulsu.vv, 0x1000000000000000, 0xf000000000000000, 0x000000007fffffff ); # mse: 0x0000000077ffffff
  TEST_W_VV_OP( 16, vwmulsu.vv, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP( 17, vwmulsu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_W_VX_OP( 18, vwmulsu.vx, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_W_VX_OP( 19, vwmulsu.vx, 0x000000fffee00051, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_W_VX_OP( 20, vwmulsu.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_W_VX_OP( 21, vwmulsu.vx, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff ); # mse: 0x0000000000000000
  TEST_W_VX_OP( 22, vwmulsu.vx, 0xffffffffffff0000, 0x0000000000000002, 0xffffffffffff8000 ); # mse: 0x0000000000000001

  TEST_W_VX_OP( 23, vwmulsu.vx, 0x0000000040000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_W_VX_OP( 24, vwmulsu.vx, 0xe000000000000001, 0xf000000000000001, 0xf000000000000001 ); # mse: 0xe100000000000001
  TEST_W_VX_OP( 25, vwmulsu.vx, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 ); # mse: 0xe100000000000000

  TEST_W_VX_OP( 26, vwmulsu.vx, 0x00003fff80000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_W_VX_OP( 27, vwmulsu.vx, 0xefffffffffff8001, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_W_VX_OP( 28, vwmulsu.vx, 0xe000000000000001, 0x0fffffffffffffff, 0x0fffffffffffffff ); # mse: 0x00ffffffffffffff

  TEST_W_VX_OP( 29, vwmulsu.vx, 0x3fffffff00000001, 0x000000007fffffff, 0x000000007fffffff );
  TEST_W_VX_OP( 30, vwmulsu.vx, 0x1000000000000000, 0xf000000000000000, 0x000000007fffffff ); # mse: 0x0000000077ffffff
  TEST_W_VX_OP( 31, vwmulsu.vx, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

# See LICENSE for license details.

#*****************************************************************************
# vmsle.S
#-----------------------------------------------------------------------------
#
# Test vmsle instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VVM_OP( 2,  vmsle.vv,  1, 0x0000000000000000, 0x0000000000000000 );
  TEST_VVM_OP( 3,  vmsle.vv,  1, 0x0000000000000000, 0x0000000000000001 );
  TEST_VVM_OP( 4,  vmsle.vv,  0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VVM_OP( 5,  vmsle.vv,  1, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VVM_OP( 6,  vmsle.vv,  1, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VVM_OP( 7,  vmsle.vv,  0, 0xffffffffffffffff, 0xfffffffffffffffe );
  TEST_VVM_OP( 8,  vmsle.vv,  1, 0xfffffffffffffffe, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VXM_OP(  9,  vmsle.vx,  1, 0x0000000000000000, 0x0000000000000000 );
  TEST_VXM_OP( 10,  vmsle.vx,  1, 0x0000000000000000, 0x0000000000000001 );
  TEST_VXM_OP( 11,  vmsle.vx,  0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VXM_OP( 12,  vmsle.vx,  1, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VXM_OP( 13,  vmsle.vx,  1, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VXM_OP( 14,  vmsle.vx,  0, 0xffffffffffffffff, 0xfffffffffffffffe );
  TEST_VXM_OP( 15,  vmsle.vx,  1, 0xfffffffffffffffe, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VIM_OP( 16,  vmsle.vi,  1, 0x0000000000000000, 0x0 );
  TEST_VIM_OP( 17,  vmsle.vi,  1, 0x0000000000000000, 0x1 );
  TEST_VIM_OP( 18,  vmsle.vi,  0, 0x0000000000000000, 0x1f );
  TEST_VIM_OP( 19,  vmsle.vi,  1, 0xffffffffffffffff, 0x0 );
  TEST_VIM_OP( 20,  vmsle.vi,  1, 0xffffffffffffffff, 0xf );
  TEST_VIM_OP( 21,  vmsle.vi,  0, 0xffffffffffffffff, 0x1e );
  TEST_VIM_OP( 22,  vmsle.vi,  1, 0xfffffffffffffffe, 0x1f );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

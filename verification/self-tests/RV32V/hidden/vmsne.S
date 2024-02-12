# See LICENSE for license details.

#*****************************************************************************
# vmsne.S
#-----------------------------------------------------------------------------
#
# Test vmsne instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VVM_OP(  2,  vmsne.vv,  0, 0x0000000000000000, 0x0000000000000000 );
  TEST_VVM_OP(  3,  vmsne.vv,  1, 0x0000000000000000, 0x0000000000000001 );
  TEST_VVM_OP(  4,  vmsne.vv,  1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VVM_OP(  5,  vmsne.vv,  1, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VVM_OP(  6,  vmsne.vv,  0, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VXM_OP(  7,  vmsne.vx,  0, 0x0000000000000000, 0x0000000000000000 );
  TEST_VXM_OP(  8,  vmsne.vx,  1, 0x0000000000000000, 0x0000000000000001 );
  TEST_VXM_OP(  9,  vmsne.vx,  1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VXM_OP( 10,  vmsne.vx,  1, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VXM_OP( 11,  vmsne.vx,  0, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VIM_OP( 12,  vmsne.vi,  0, 0x0000000000000000, 0x0 );
  TEST_VIM_OP( 13,  vmsne.vi,  1, 0x0000000000000000, 0x1 );
  TEST_VIM_OP( 14,  vmsne.vi,  1, 0x0000000000000000, 0xf );
  TEST_VIM_OP( 15,  vmsne.vi,  1, 0xffffffffffffffff, 0x0 );
  TEST_VIM_OP( 16,  vmsne.vi,  0, 0xffffffffffffffff, 0x1f );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

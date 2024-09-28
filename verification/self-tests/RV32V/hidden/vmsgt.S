# See LICENSE for license details.

#*****************************************************************************
# vmsgt.S
#-----------------------------------------------------------------------------
#
# Test vmsgt instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VXM_OP( 2,  vmsgt.vx,  0, 0x0000000000000000, 0x0000000000000000 );
  TEST_VXM_OP( 3,  vmsgt.vx,  0, 0x0000000000000000, 0x0000000000000001 );
  TEST_VXM_OP( 4,  vmsgt.vx,  1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VXM_OP( 5,  vmsgt.vx,  0, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VXM_OP( 6,  vmsgt.vx,  0, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VXM_OP( 7,  vmsgt.vx,  1, 0xffffffffffffffff, 0xfffffffffffffffe );
  TEST_VXM_OP( 8,  vmsgt.vx,  0, 0xfffffffffffffffe, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VIM_OP(  9,  vmsgt.vi,  0, 0x0000000000000000, 0x0 );
  TEST_VIM_OP( 10,  vmsgt.vi,  0, 0x0000000000000000, 0x1 );
  TEST_VIM_OP( 11,  vmsgt.vi,  1, 0x0000000000000000, 0x1f );
  TEST_VIM_OP( 12,  vmsgt.vi,  0, 0xffffffffffffffff, 0x0 );
  TEST_VIM_OP( 13,  vmsgt.vi,  0, 0xffffffffffffffff, 0xf );
  TEST_VIM_OP( 14,  vmsgt.vi,  1, 0xffffffffffffffff, 0x1e );
  TEST_VIM_OP( 15,  vmsgt.vi,  0, 0xfffffffffffffffe, 0xff );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

# See LICENSE for license details.

#*****************************************************************************
# vmsgtu.S
#-----------------------------------------------------------------------------
#
# Test vmsgtu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VXM_OP( 2,  vmsgtu.vx,  0, 0x0000000000000000, 0x0000000000000000 );
  TEST_VXM_OP( 3,  vmsgtu.vx,  0, 0x0000000000000000, 0x0000000000000001 );
  TEST_VXM_OP( 4,  vmsgtu.vx,  0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VXM_OP( 5,  vmsgtu.vx,  1, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VXM_OP( 6,  vmsgtu.vx,  0, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VXM_OP( 7,  vmsgtu.vx,  1, 0xffffffffffffffff, 0xfffffffffffffffe );
  TEST_VXM_OP( 8,  vmsgtu.vx,  0, 0xfffffffffffffffe, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VIM_OP(  9,  vmsgtu.vi,  0, 0x0000000000000000, 0x0 );
  TEST_VIM_OP( 10,  vmsgtu.vi,  0, 0x0000000000000000, 0x1 );
  TEST_VIM_OP( 11,  vmsgtu.vi,  0, 0x0000000000000000, 0xf );
  TEST_VIM_OP( 12,  vmsgtu.vi,  1, 0xffffffffffffffff, 0x0 );
  TEST_VIM_OP( 13,  vmsgtu.vi,  1, 0xffffffffffffffff, 0xf );
  TEST_VIM_OP( 14,  vmsgtu.vi,  1, 0xffffffffffffffff, 0xe );
  TEST_VIM_OP( 15,  vmsgtu.vi,  1, 0xfffffffffffffffe, 0xf );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

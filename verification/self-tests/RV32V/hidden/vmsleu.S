# See LICENSE for license details.

#*****************************************************************************
# vmsleu.S
#-----------------------------------------------------------------------------
#
# Test vmsleu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VVM_OP( 2,  vmsleu.vv,  1, 0x0000000000000000, 0x0000000000000000 );
  TEST_VVM_OP( 3,  vmsleu.vv,  1, 0x0000000000000000, 0x0000000000000001 );
  TEST_VVM_OP( 4,  vmsleu.vv,  1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VVM_OP( 5,  vmsleu.vv,  0, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VVM_OP( 6,  vmsleu.vv,  1, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VVM_OP( 7,  vmsleu.vv,  0, 0xffffffffffffffff, 0xfffffffffffffffe );
  TEST_VVM_OP( 8,  vmsleu.vv,  1, 0xfffffffffffffffe, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VXM_OP(  9,  vmsleu.vx,  1, 0x0000000000000000, 0x0000000000000000 );
  TEST_VXM_OP( 10,  vmsleu.vx,  1, 0x0000000000000000, 0x0000000000000001 );
  TEST_VXM_OP( 11,  vmsleu.vx,  1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VXM_OP( 12,  vmsleu.vx,  0, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VXM_OP( 13,  vmsleu.vx,  1, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VXM_OP( 14,  vmsleu.vx,  0, 0xffffffffffffffff, 0xfffffffffffffffe );
  TEST_VXM_OP( 15,  vmsleu.vx,  1, 0xfffffffffffffffe, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VIM_OP( 16,  vmsleu.vi,  1, 0x0000000000000000, 0x0 );
  TEST_VIM_OP( 17,  vmsleu.vi,  1, 0x0000000000000000, 0x1 );
  TEST_VIM_OP( 18,  vmsleu.vi,  1, 0x0000000000000000, 0xf );
  TEST_VIM_OP( 19,  vmsleu.vi,  0, 0xffffffffffffffff, 0x0 );
  TEST_VIM_OP( 20,  vmsleu.vi,  1, 0xffffffffffffffff, 0x1f );
  TEST_VIM_OP( 21,  vmsleu.vi,  0, 0xffffffffffffffff, 0xe );
  TEST_VIM_OP( 22,  vmsleu.vi,  1, 0xfffffffffffffffe, 0x1f );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

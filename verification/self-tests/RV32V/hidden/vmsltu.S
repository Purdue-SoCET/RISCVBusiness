# See LICENSE for license details.

#*****************************************************************************
# vmsltu.S
#-----------------------------------------------------------------------------
#
# Test vmsltu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VVM_OP(  2,  vmsltu.vv,  0, 0x0000000000000000, 0x0000000000000000 );
  TEST_VVM_OP(  3,  vmsltu.vv,  1, 0x0000000000000000, 0x0000000000000001 );
  TEST_VVM_OP(  4,  vmsltu.vv,  1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VVM_OP(  5,  vmsltu.vv,  0, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VVM_OP(  6,  vmsltu.vv,  0, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VVM_OP(  7,  vmsltu.vv,  0, 0xffffffffffffffff, 0xfffffffffffffffe );
  TEST_VVM_OP(  8,  vmsltu.vv,  1, 0xfffffffffffffffe, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VXM_OP(  9,  vmsltu.vx,  0, 0x0000000000000000, 0x0000000000000000 );
  TEST_VXM_OP( 10,  vmsltu.vx,  1, 0x0000000000000000, 0x0000000000000001 );
  TEST_VXM_OP( 11,  vmsltu.vx,  1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VXM_OP( 12,  vmsltu.vx,  0, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VXM_OP( 13,  vmsltu.vx,  0, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VXM_OP( 14,  vmsltu.vx,  0, 0xffffffffffffffff, 0xfffffffffffffffe );
  TEST_VXM_OP( 15,  vmsltu.vx,  1, 0xfffffffffffffffe, 0xffffffffffffffff );
		
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

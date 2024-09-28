# See LICENSE for license details.

#*****************************************************************************
# vminu.S
#-----------------------------------------------------------------------------
#
# Test vminu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vminu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vminu.vv, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VV_OP( 4,  vminu.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 5,  vminu.vv, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VV_OP( 6,  vminu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001 );
  TEST_VV_OP( 7,  vminu.vv, 0x000000000000000f, 0x000000000000000f, 0x00000000000000ff );
  TEST_VV_OP( 8,  vminu.vv, 0xffffffffffffffce, 0xffffffffffffffce, 0xffffffffffffffe7 );
  TEST_VV_OP( 9,  vminu.vv, 0x0000000000000032, 0xffffffffffffffce, 0x0000000000000032 );
	
  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VX_OP( 10,  vminu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 11,  vminu.vx, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VX_OP( 12,  vminu.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 13,  vminu.vx, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VX_OP( 14,  vminu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001 );
  TEST_VX_OP( 15,  vminu.vx, 0x000000000000000f, 0x000000000000000f, 0x00000000000000ff );
  TEST_VX_OP( 16,  vminu.vx, 0xffffffffffffffce, 0xffffffffffffffce, 0xffffffffffffffe7 );
  TEST_VX_OP( 17,  vminu.vx, 0x0000000000000032, 0xffffffffffffffce, 0x0000000000000032 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

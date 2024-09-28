# See LICENSE for license details.

#*****************************************************************************
# vmaxu.S
#-----------------------------------------------------------------------------
#
# Test vmaxu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vmaxu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vmaxu.vv, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VV_OP( 4,  vmaxu.vv, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 5,  vmaxu.vv, 0xffffffffffffffff, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VV_OP( 6,  vmaxu.vv, 0x0000000000000001, 0x0000000000000000, 0x0000000000000001 );
  TEST_VV_OP( 7,  vmaxu.vv, 0x00000000000000ff, 0x000000000000000f, 0x00000000000000ff );
  TEST_VV_OP( 8,  vmaxu.vv, 0xffffffffffffffe7, 0xffffffffffffffce, 0xffffffffffffffe7 );
  TEST_VV_OP( 9,  vmaxu.vv, 0xffffffffffffffce, 0xffffffffffffffce, 0x0000000000000032 );
	
  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VX_OP( 10,  vmaxu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 11,  vmaxu.vx, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VX_OP( 12,  vmaxu.vx, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 13,  vmaxu.vx, 0xffffffffffffffff, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VX_OP( 14,  vmaxu.vx, 0x0000000000000001, 0x0000000000000000, 0x0000000000000001 );
  TEST_VX_OP( 15,  vmaxu.vx, 0x00000000000000ff, 0x000000000000000f, 0x00000000000000ff );
  TEST_VX_OP( 16,  vmaxu.vx, 0xffffffffffffffe7, 0xffffffffffffffce, 0xffffffffffffffe7 );
  TEST_VX_OP( 17,  vmaxu.vx, 0xffffffffffffffce, 0xffffffffffffffce, 0x0000000000000032 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

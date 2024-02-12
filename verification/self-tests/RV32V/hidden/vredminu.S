# See LICENSE for license details.

#*****************************************************************************
# vredminu.S
#-----------------------------------------------------------------------------
#
# Test vredminu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET


  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vredminu.vs, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vredminu.vs, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );
  TEST_VV_OP( 4,  vredminu.vs, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 5,  vredminu.vs, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VV_OP( 6,  vredminu.vs, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001 );
  TEST_VV_OP( 7,  vredminu.vs, 0x000000000000000f, 0x000000000000000f, 0x00000000000000ff );
  TEST_VV_OP( 8,  vredminu.vs, 0xffffffffffffffce, 0xffffffffffffffce, 0xffffffffffffffe7 );
  TEST_VV_OP( 9,  vredminu.vs, 0x0000000000000032, 0xffffffffffffffce, 0x0000000000000032 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

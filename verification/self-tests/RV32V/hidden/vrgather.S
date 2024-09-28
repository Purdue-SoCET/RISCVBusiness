# See LICENSE for license details.

#*****************************************************************************
# vrgather.S
#-----------------------------------------------------------------------------
#
# Test vrgather instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vrgather.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 3,  vrgather.vv, 0x00000003, 0x00000003, 0x00000000 );
  TEST_VV_OP( 4,  vrgather.vv, 0x00000000, 0x00000003, 0xffffffff );

  TEST_VV_OP( 5,  vrgatherei16.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 6,  vrgatherei16.vv, 0x00000003, 0x00000003, 0x00000000 );
  TEST_VV_OP( 7,  vrgatherei16.vv, 0x00000000, 0x00000003, 0xffffffff );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VX_OP( 8,  vrgather.vx, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VX_OP( 9,  vrgather.vx, 0x00000003, 0x00000003, 0x00000000 );
  TEST_VX_OP(10,  vrgather.vx, 0x00000000, 0x00000003, 0xffffffff );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VI_OP(11,  vrgather.vi, 0x00000000, 0x00000000, 0 );
  TEST_VI_OP(12,  vrgather.vi, 0x00000003, 0x00000003, 0 );
  TEST_VI_OP(13,  vrgather.vi, 0x00000000, 0x00000003, 5 );


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

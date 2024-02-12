# See LICENSE for license details.

#*****************************************************************************
# vfmax.S
#-----------------------------------------------------------------------------
#
# Test vfmax instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_FP_VV_OP( 2,  vfmax.vv, 0,         2.5,        2.5,        1.0 );
  TEST_FP_VV_OP( 3,  vfmax.vv, 0,         1.1,    -1235.1,        1.1 );
  TEST_FP_VV_OP( 4,  vfmax.vv, 0,         1.1,        1.1,    -1235.1 );
  TEST_FP_VV_OP( 5,  vfmax.vv, 0,     -1235.1,        NaN,    -1235.1 );
  TEST_FP_VV_OP( 6,  vfmax.vv, 0,  3.14159265, 3.14159265, 0.00000001 );
  TEST_FP_VV_OP( 7,  vfmax.vv, 0,        -1.0,       -1.0,       -2.0 );

  #-------------------------------------------------------------
  # VF Tests
  #-------------------------------------------------------------

  TEST_FP_VF_OP( 8,  vfmax.vf, 0,         2.5,        2.5,        1.0 );
  TEST_FP_VF_OP( 9,  vfmax.vf, 0,         1.1,    -1235.1,        1.1 );
  TEST_FP_VF_OP(10,  vfmax.vf, 0,         1.1,        1.1,    -1235.1 );
  TEST_FP_VF_OP(11,  vfmax.vf, 0,     -1235.1,        NaN,    -1235.1 );
  TEST_FP_VF_OP(12,  vfmax.vf, 0,  3.14159265, 3.14159265, 0.00000001 );
  TEST_FP_VF_OP(13,  vfmax.vf, 0,        -1.0,       -1.0,       -2.0 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

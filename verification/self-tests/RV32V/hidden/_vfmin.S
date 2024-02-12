# See LICENSE for license details.

#*****************************************************************************
# vfmin.S
#-----------------------------------------------------------------------------
#
# Test vfmin instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_FP_VV_OP( 2,  vfmin.vv, 0,         1.0,        2.5,        1.0 );
  TEST_FP_VV_OP( 3,  vfmin.vv, 0,     -1235.1,    -1235.1,        1.1 );
  TEST_FP_VV_OP( 4,  vfmin.vv, 0,     -1235.1,        1.1,    -1235.1 );
  TEST_FP_VV_OP( 5,  vfmin.vv, 0,     -1235.1,        NaN,    -1235.1 );
  TEST_FP_VV_OP( 6,  vfmin.vv, 0,  0.00000001, 3.14159265, 0.00000001 );
  TEST_FP_VV_OP( 7,  vfmin.vv, 0,        -2.0,       -1.0,       -2.0 );

  #-------------------------------------------------------------
  # VF Tests
  #-------------------------------------------------------------

  TEST_FP_VF_OP( 8,  vfmin.vf, 0,         1.0,        2.5,        1.0 );
  TEST_FP_VF_OP( 9,  vfmin.vf, 0,     -1235.1,    -1235.1,        1.1 );
  TEST_FP_VF_OP(10,  vfmin.vf, 0,     -1235.1,        1.1,    -1235.1 );
  TEST_FP_VF_OP(11,  vfmin.vf, 0,     -1235.1,        NaN,    -1235.1 );
  TEST_FP_VF_OP(12,  vfmin.vf, 0,  0.00000001, 3.14159265, 0.00000001 );
  TEST_FP_VF_OP(13,  vfmin.vf, 0,        -2.0,       -1.0,       -2.0 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

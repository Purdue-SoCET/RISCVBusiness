# See LICENSE for license details.

#*****************************************************************************
# vfmacc
#-----------------------------------------------------------------------------
#
# Test vfmacc instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_FP_VV_OP( 2,  vfmacc.vv, 0,             2.5,        2.5,        1.0 );
  TEST_FP_VV_OP( 3,  vfmacc.vv, 0,          1235.1,    -1235.1,       -1.0 );
  TEST_FP_VV_OP( 4,  vfmacc.vv, 1,             1.1,       11.0,        0.1 );

  #-------------------------------------------------------------
  # VF Tests
  #-------------------------------------------------------------

  TEST_FP_VF_OP_RV( 5,  vfmacc.vf, 0,              2.5,        2.5,        1.0 );
  TEST_FP_VF_OP_RV( 6,  vfmacc.vf, 0,           1235.1,    -1235.1,       -1.0 );
  TEST_FP_VF_OP_RV( 7,  vfmacc.vf, 1,              1.1,       11.0,        0.1 );
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

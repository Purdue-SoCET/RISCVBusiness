# See LICENSE for license details.

#*****************************************************************************
# vfwmul
#-----------------------------------------------------------------------------
#
# Test vfwmul instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_FP_VV_OP( 2,  vfwmul.vv, fmul.d, 0,        2.5,        1.0 );
  TEST_W_FP_VV_OP( 3,  vfwmul.vv, fmul.d, 0,      -1235,        1.1 );
  TEST_W_FP_VV_OP( 4,  vfwmul.vv, fmul.d, 0, 3.14159265, 0.00000001 );

  #-------------------------------------------------------------
  # VF Tests
  #-------------------------------------------------------------

  TEST_W_FP_VF_OP( 5,  vfwmul.vf, fmul.d, 0,        2.5,        1.0 );
  TEST_W_FP_VF_OP( 6,  vfwmul.vf, fmul.d, 0,    -1235.1,        1.1 );
  TEST_W_FP_VF_OP( 7,  vfwmul.vf, fmul.d, 0, 3.14159265, 0.00000001 );

  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

# See LICENSE for license details.

#*****************************************************************************
# vfwnmsac
#-----------------------------------------------------------------------------
#
# Test vfwnmsac instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_FP_VV_OP_NEGRESULT( 2,  vfwnmsac.vv, fmul.d, 0,        2.5,        1.0 );
  TEST_W_FP_VV_OP_NEGRESULT( 3,  vfwnmsac.vv, fmul.d, 0,    -1235.1,       -1.0 );
  TEST_W_FP_VV_OP_NEGRESULT( 4,  vfwnmsac.vv, fmul.d, 0,       11.0,        0.1 );

  #-------------------------------------------------------------
  # VF Tests
  #-------------------------------------------------------------

  TEST_W_FP_VF_OP_RV_NEGRESULT( 5,  vfwnmsac.vf, fmul.d, 0,         2.5,        1.0 );
  TEST_W_FP_VF_OP_RV_NEGRESULT( 6,  vfwnmsac.vf, fmul.d, 0,     -1235.1,       -1.0 );
  TEST_W_FP_VF_OP_RV_NEGRESULT( 7,  vfwnmsac.vf, fmul.d, 0,        11.0,        0.1 );
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

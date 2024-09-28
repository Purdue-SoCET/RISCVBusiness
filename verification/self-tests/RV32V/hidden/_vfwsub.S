# See LICENSE for license details.

#*****************************************************************************
# vfwsub
#-----------------------------------------------------------------------------
#
# Test vfwsub instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_FP_VV_OP( 2,  vfwsub.vv, fsub.d, 0,        2.5,        1.0 );
  TEST_W_FP_VV_OP( 3,  vfwsub.vv, fsub.d, 0,      -1235,        1.1 );
  TEST_W_FP_VV_OP( 4,  vfwsub.vv, fsub.d, 0, 3.14159265, 0.00000001 );

  #-------------------------------------------------------------
  # VF Tests
  #-------------------------------------------------------------

  TEST_W_FP_VF_OP( 5,  vfwsub.vf, fsub.d, 0,        2.5,        1.0 );
  TEST_W_FP_VF_OP( 6,  vfwsub.vf, fsub.d, 0,    -1235.1,        1.1 );
  TEST_W_FP_VF_OP( 7,  vfwsub.vf, fsub.d, 0, 3.14159265, 0.00000001 );

  #-------------------------------------------------------------
  # WV Tests
  #-------------------------------------------------------------

  TEST_W_FP_WV_OP( 8,  vfwsub.wv, fsub.d, 0,        2.5,        1.0 );
  TEST_W_FP_WV_OP( 9,  vfwsub.wv, fsub.d, 0,    -1235.1,        1.1 );
  TEST_W_FP_WV_OP(10,  vfwsub.wv, fsub.d, 0, 3.14159265, 0.00000001 );

  #-------------------------------------------------------------
  # WF Tests
  #-------------------------------------------------------------

  TEST_W_FP_WF_OP(11,  vfwsub.wf, fsub.d, 0,         2.5,        1.0 );
  TEST_W_FP_WF_OP(12,  vfwsub.wf, fsub.d, 0,     -1235.1,        1.1 );
  TEST_W_FP_WF_OP(13,  vfwsub.wf, fsub.d, 0,  3.14159265, 0.00000001 );
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

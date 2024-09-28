# See LICENSE for license details.

#*****************************************************************************
# vfredmax
#-----------------------------------------------------------------------------
#
# Test vfredmax instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  
  TEST_FP_VV_OP( 2,  vfredmax.vs, 0,                2.5,        2.5,        1.0 );
  TEST_FP_VV_OP( 3,  vfredmax.vs, 0,                1.1,    -1235.1,        1.1 );
  TEST_FP_VV_OP( 4,  vfredmax.vs, 0,                1.1,        1.1,    -1235.1 );
  TEST_FP_VV_OP( 5,  vfredmax.vs, 0,            -1235.1,        NaN,    -1235.1 );
  TEST_FP_VV_OP( 6,  vfredmax.vs, 0,         3.14159265, 3.14159265, 0.00000001 );
  TEST_FP_VV_OP( 7,  vfredmax.vs, 0,               -1.0,       -1.0,       -2.0 );

  


  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

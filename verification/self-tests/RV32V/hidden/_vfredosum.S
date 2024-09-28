# See LICENSE for license details.

#*****************************************************************************
# vfredosum
#-----------------------------------------------------------------------------
#
# Test vfredosum instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_FP_VV_OP( 2,  vfredosum.vs, 0,                3.5,        2.5,        1.0 );
  TEST_FP_VV_OP( 3,  vfredosum.vs, 1,              -1234,    -1235.1,        1.1 );
  TEST_FP_VV_OP( 4,  vfredosum.vs, 1,         3.14159265, 3.14159265, 0.00000001 );


  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

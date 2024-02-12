# See LICENSE for license details.

#*****************************************************************************
# vfsub, vfrsub
#-----------------------------------------------------------------------------
#
# Test vfsub, vfrsub instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_FP_VV_OP( 2,  vfsub.vv, 0,                1.5,        2.5,        1.0 );
  TEST_FP_VV_OP( 3,  vfsub.vv, 1,              -1234,    -1235.1,       -1.1 );
  TEST_FP_VV_OP( 4,  vfsub.vv, 1,         3.14159265, 3.14159265, 0.00000001 );

  #-------------------------------------------------------------
  # VF Tests
  #-------------------------------------------------------------

  TEST_FP_VF_OP( 5,  vfsub.vf, 0,                1.5,        2.5,        1.0 );
  TEST_FP_VF_OP( 6,  vfsub.vf, 1,              -1234,    -1235.1,       -1.1 );
  TEST_FP_VF_OP( 7,  vfsub.vf, 1,         3.14159265, 3.14159265, 0.00000001 );

  #-------------------------------------------------------------
  # VFR Tests
  #-------------------------------------------------------------

  TEST_FP_VF_OP( 8,  vfrsub.vf, 0,               1.5,        1.0,        2.5 );
  TEST_FP_VF_OP( 9,  vfrsub.vf, 1,             -1234,       -1.1,    -1235.1 );
  TEST_FP_VF_OP(10,  vfrsub.vf, 1,        3.14159265, 0.00000001, 3.14159265 );
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

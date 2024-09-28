# See LICENSE for license details.

#*****************************************************************************
# vfsgnj.S
#-----------------------------------------------------------------------------
#
# Test vfsgnj, vfsgnjn, vfsgnjx instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vfsgnj.VV Tests
  #-------------------------------------------------------------

  TEST_FP_VV_OP( 2,  vfsgnj.vv , 0,           2.5,        2.5,        1.0 );
  TEST_FP_VV_OP( 3,  vfsgnj.vv , 0,        1235.1,    -1235.1,        1.0 );
  TEST_FP_VV_OP( 4,  vfsgnj.vv , 0,          -2.5,        2.5,       -1.0 );
  TEST_FP_VV_OP( 5,  vfsgnj.vv , 0,       -1235.1,    -1235.1,       -1.0 );

  #-------------------------------------------------------------
  # vfsgnj.VF Tests
  #-------------------------------------------------------------

  TEST_FP_VF_OP( 6,  vfsgnj.vf , 0,           2.5,        2.5,        1.0 );
  TEST_FP_VF_OP( 7,  vfsgnj.vf , 0,        1235.1,    -1235.1,        1.0 );
  TEST_FP_VF_OP( 8,  vfsgnj.vf , 0,          -2.5,        2.5,       -1.0 );
  TEST_FP_VF_OP( 9,  vfsgnj.vf , 0,       -1235.1,    -1235.1,       -1.0 );

    #-------------------------------------------------------------
  # vfsgnjn.VV Tests
  #-------------------------------------------------------------

  TEST_FP_VV_OP(10,  vfsgnjn.vv , 0,          -2.5,        2.5,        1.0 );
  TEST_FP_VV_OP(11,  vfsgnjn.vv , 0,       -1235.1,    -1235.1,        1.0 );
  TEST_FP_VV_OP(12,  vfsgnjn.vv , 0,           2.5,        2.5,       -1.0 );
  TEST_FP_VV_OP(13,  vfsgnjn.vv , 0,        1235.1,    -1235.1,       -1.0 );

  #-------------------------------------------------------------
  # vfsgnjn.VF Tests
  #-------------------------------------------------------------

  TEST_FP_VF_OP(14,  vfsgnjn.vf , 0,          -2.5,        2.5,        1.0 );
  TEST_FP_VF_OP(15,  vfsgnjn.vf , 0,       -1235.1,    -1235.1,        1.0 );
  TEST_FP_VF_OP(16,  vfsgnjn.vf , 0,           2.5,        2.5,       -1.0 );
  TEST_FP_VF_OP(17,  vfsgnjn.vf , 0,        1235.1,    -1235.1,       -1.0 );

    #-------------------------------------------------------------
  # vfsgnjx.VV Tests
  #-------------------------------------------------------------

  TEST_FP_VV_OP(18,  vfsgnjx.vv , 0,           2.5,        2.5,        1.0 );
  TEST_FP_VV_OP(19,  vfsgnjx.vv , 0,       -1235.1,    -1235.1,        1.0 );
  TEST_FP_VV_OP(20,  vfsgnjx.vv , 0,          -2.5,        2.5,       -1.0 );
  TEST_FP_VV_OP(21,  vfsgnjx.vv , 0,        1235.1,    -1235.1,       -1.0 );

  #-------------------------------------------------------------
  # vfsgnjx.VF Tests
  #-------------------------------------------------------------

  TEST_FP_VF_OP(22,  vfsgnjx.vf , 0,           2.5,        2.5,        1.0 );
  TEST_FP_VF_OP(23,  vfsgnjx.vf , 0,       -1235.1,    -1235.1,        1.0 );
  TEST_FP_VF_OP(24,  vfsgnjx.vf , 0,          -2.5,        2.5,       -1.0 );
  TEST_FP_VF_OP(25,  vfsgnjx.vf , 0,        1235.1,    -1235.1,       -1.0 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

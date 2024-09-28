# See LICENSE for license details.

#*****************************************************************************
# vwfredsum
#-----------------------------------------------------------------------------
#
# Test vfwredosum, vfwredusum instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vfwredosum Tests
  #-------------------------------------------------------------

  TEST_W_FP_WV_OP_DS( 2,  vfwredosum.vs, fadd.d, 0,        1.0,        2.0 );
  TEST_W_FP_WV_OP_DS( 3,  vfwredosum.vs, fadd.d, 0,     -12.34,       2.98 );
  TEST_W_FP_WV_OP_DS( 4,  vfwredosum.vs, fadd.d, 0, 3.14159268,   0.000001 );
  TEST_W_FP_WV_OP_DS( 5,  vfwredosum.vs, fadd.d, 0,      -1235,        1.1 );
  TEST_W_FP_WV_OP_DS( 6,  vfwredosum.vs, fadd.d, 0, 3.14159265, 0.00000001 );

  #-------------------------------------------------------------
  # vfwredusum Tests
  # Raise opcode `vfwredusum.vs v14,v2,v1'
  #-------------------------------------------------------------

  #TEST_W_FP_WV_OP_DS( 7,  vfwredusum.vs, fadd.d, 0,        1.0,        2.0 );
  #TEST_W_FP_WV_OP_DS( 8,  vfwredusum.vs, fadd.d, 0,     -12.34,       2.98 );
  #TEST_W_FP_WV_OP_DS( 9,  vfwredusum.vs, fadd.d, 0, 3.14159268,   0.000001 );
  #TEST_W_FP_WV_OP_DS(10,  vfwredusum.vs, fadd.d, 0,      -1235,        1.1 );
  #TEST_W_FP_WV_OP_DS(11,  vfwredusum.vs, fadd.d, 0, 3.14159265, 0.00000001 );
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

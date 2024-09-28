# See LICENSE for license details.

#*****************************************************************************
# vmflt.S
#-----------------------------------------------------------------------------
#
# Test vmflt, vmfle instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vmflt.VV tests
  #-------------------------------------------------------------

  #TEST_FP_VVM_OP(  2,  vmflt.vv,     0,  1,  -1.36,     0 );
  #TEST_FP_VVM_OP(  3,  vmflt.vv,     0,  0,  -1.36, -1.36 );
  #TEST_FP_VVM_OP(  4,  vmflt.vv,     0,  1,  -1.37, -1.36 );
  #TEST_FP_VVM_OP(  5,  vmflt.vv,  0x10,  0,    NaN,     0 );
  #TEST_FP_VVM_OP(  6,  vmflt.vv,  0x10,  0,    NaN,   NaN );

  #-------------------------------------------------------------
  # vmflt.VF tests
  #-------------------------------------------------------------

  #TEST_FP_VFM_OP(  7,  vmflt.vf,     0,  1,  -1.36,     0 );
  #TEST_FP_VFM_OP(  8,  vmflt.vf,     0,  0,  -1.36, -1.36 );
  #TEST_FP_VFM_OP(  9,  vmflt.vf,     0,  1,  -1.37, -1.36 );
  #TEST_FP_VFM_OP( 10,  vmflt.vf,  0x10,  0,    NaN,     0 );
  #TEST_FP_VFM_OP( 11,  vmflt.vf,  0x10,  0,    NaN,   NaN );

  #-------------------------------------------------------------
  # vmfle.VV tests
  #-------------------------------------------------------------

  #TEST_FP_VVM_OP( 12,  vmfle.vv,     0,  1,  -1.36,     0 );
  #TEST_FP_VVM_OP( 13,  vmfle.vv,     0,  1,  -1.36, -1.36 );
  #TEST_FP_VVM_OP( 14,  vmfle.vv,     0,  1,  -1.37, -1.36 );
  #TEST_FP_VVM_OP( 15,  vmfle.vv,  0x10,  0,    NaN,     0 );
  #TEST_FP_VVM_OP( 16,  vmfle.vv,  0x10,  0,    NaN,   NaN );

  #-------------------------------------------------------------
  # vmfle.VF tests
  #-------------------------------------------------------------

  #TEST_FP_VFM_OP( 17,  vmfle.vf,     0,  1,  -1.36,     0 );
  #TEST_FP_VFM_OP( 18,  vmfle.vf,     0,  1,  -1.36, -1.36 );
  #TEST_FP_VFM_OP( 19,  vmfle.vf,     0,  1,  -1.37, -1.36 );
  #TEST_FP_VFM_OP( 20,  vmfle.vf,  0x10,  0,    NaN,     0 );
  #TEST_FP_VFM_OP( 21,  vmfle.vf,  0x10,  0,    NaN,   NaN );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

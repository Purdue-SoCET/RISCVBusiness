# See LICENSE for license details.

#*****************************************************************************
# vmfeq.S
#-----------------------------------------------------------------------------
#
# Test vmfeq, vmfne instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vmfeq.VV tests
  #-------------------------------------------------------------

  #TEST_FP_VVM_OP(  2,  vmfeq.vv,  0,  0,  -1.36,     0 );
  #TEST_FP_VVM_OP(  3,  vmfeq.vv,  0,  1,  -1.36, -1.36 );
  #TEST_FP_VVM_OP(  4,  vmfeq.vv,  0,  0,  -1.37, -1.36 );
  #TEST_FP_VVM_OP(  5,  vmfeq.vv,  0,  0,    NaN,     0 );
  #TEST_FP_VVM_OP(  6,  vmfeq.vv,  0,  0,    NaN,   NaN );

  #-------------------------------------------------------------
  # vmfeq.VF tests
  #-------------------------------------------------------------

  #TEST_FP_VFM_OP(  7,  vmfeq.vf,  0,  0,  -1.36,     0 );
  #TEST_FP_VFM_OP(  8,  vmfeq.vf,  0,  1,  -1.36, -1.36 );
  #TEST_FP_VFM_OP(  9,  vmfeq.vf,  0,  0,  -1.37, -1.36 );
  #TEST_FP_VFM_OP( 10,  vmfeq.vf,  0,  0,    NaN,     0 );
  #TEST_FP_VFM_OP( 11,  vmfeq.vf,  0,  0,    NaN,   NaN );

  #-------------------------------------------------------------
  # vmfne.VV tests
  #-------------------------------------------------------------

  #TEST_FP_VVM_OP( 12,  vmfne.vv,  0,  1,  -1.36,     0 );
  #TEST_FP_VVM_OP( 13,  vmfne.vv,  0,  0,  -1.36, -1.36 );
  #TEST_FP_VVM_OP( 14,  vmfne.vv,  0,  1,  -1.37, -1.36 );
  #TEST_FP_VVM_OP( 15,  vmfne.vv,  0,  1,    NaN,     0 );
  #TEST_FP_VVM_OP( 16,  vmfne.vv,  0,  1,    NaN,   NaN );

  #-------------------------------------------------------------
  # vmfne.VF tests
  #-------------------------------------------------------------

  #TEST_FP_VFM_OP( 17,  vmfne.vf,  0,  1,  -1.36,     0 );
  #TEST_FP_VFM_OP( 18,  vmfne.vf,  0,  0,  -1.36, -1.36 );
  #TEST_FP_VFM_OP( 19,  vmfne.vf,  0,  1,  -1.37, -1.36 );
  #TEST_FP_VFM_OP( 20,  vmfne.vf,  0,  1,    NaN,     0 );
  #TEST_FP_VFM_OP( 21,  vmfne.vf,  0,  1,    NaN,   NaN );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

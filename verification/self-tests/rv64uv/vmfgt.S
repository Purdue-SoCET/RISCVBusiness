# See LICENSE for license details.

#*****************************************************************************
# vmfgt.S
#-----------------------------------------------------------------------------
#
# Test vmfgt, vmfge instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vmfgt.VF tests
  #-------------------------------------------------------------

  #TEST_FP_VFM_OP(  2,  vmfgt.vf,     0,  0,  -1.36,     0 );
  #TEST_FP_VFM_OP(  3,  vmfgt.vf,     0,  0,  -1.36, -1.36 );
  #TEST_FP_VFM_OP(  4,  vmfgt.vf,     0,  0,  -1.37, -1.36 );
  #TEST_FP_VFM_OP(  5,  vmfgt.vf,  0x10,  0,    NaN,     0 );
  #TEST_FP_VFM_OP(  6,  vmfgt.vf,  0x10,  0,    NaN,   NaN );

  #-------------------------------------------------------------
  # vmfge.VF tests
  #-------------------------------------------------------------

  #TEST_FP_VFM_OP(  7,  vmfge.vf,     0,  0,  -1.36,     0 );
  #TEST_FP_VFM_OP(  8,  vmfge.vf,     0,  1,  -1.36, -1.36 );
  #TEST_FP_VFM_OP(  9,  vmfge.vf,     0,  0,  -1.37, -1.36 );
  #TEST_FP_VFM_OP( 10,  vmfge.vf,  0x10,  0,    NaN,     0 );
  #TEST_FP_VFM_OP( 11,  vmfge.vf,  0x10,  0,    NaN,   NaN );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

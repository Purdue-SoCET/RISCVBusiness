# See LICENSE for license details.

#*****************************************************************************
# vfmerge.S
#-----------------------------------------------------------------------------
#
# Test vfmerge.vfm instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vfmerge.vfm tests
  #-------------------------------------------------------------

  TEST_FP_VF_OP_AFTER_VMSEQ( 2,  0,   2.0,   1.0,   2.0,  1,  1 )
  TEST_FP_VF_OP_AFTER_VMSEQ( 3,  0,   1.0,   1.0,   2.0,  1,  2 )
  TEST_FP_VF_OP_AFTER_VMSEQ( 4,  0,   2.0,   1.5,   2.0,  1,  1 )
  TEST_FP_VF_OP_AFTER_VMSEQ( 5,  0,  -2.0,  -1.0,  -2.0,  1,  1 )
  TEST_FP_VF_OP_AFTER_VMSEQ( 6,  0,  -1.0,  -1.0,  -2.0,  2,  1 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

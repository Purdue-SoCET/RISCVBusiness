# See LICENSE for license details.

#*****************************************************************************
# vmseq.S
#-----------------------------------------------------------------------------
#
# Test vmseq instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VVM_OP( 2,  vmseq.vv,  1, 0x0000000000000000, 0x0000000000000000 );
  TEST_VVM_OP( 3,  vmseq.vv,  0, 0x0000000000000000, 0x0000000000000001 );
  TEST_VVM_OP( 4,  vmseq.vv,  0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VVM_OP( 5,  vmseq.vv,  0, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VVM_OP( 6,  vmseq.vv,  1, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VXM_OP(  7,  vmseq.vx,  1, 0x0000000000000000, 0x0000000000000000 );
  TEST_VXM_OP(  8,  vmseq.vx,  0, 0x0000000000000000, 0x0000000000000001 );
  TEST_VXM_OP(  9,  vmseq.vx,  0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VXM_OP( 10,  vmseq.vx,  0, 0xffffffffffffffff, 0x0000000000000000 );
  TEST_VXM_OP( 11,  vmseq.vx,  1, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VIM_OP( 12,  vmseq.vi,  1, 0x0000000000000000, 0x0 );
  TEST_VIM_OP( 13,  vmseq.vi,  0, 0x0000000000000000, 0x1 );
  TEST_VIM_OP( 14,  vmseq.vi,  0, 0x0000000000000000, 0xf );
  TEST_VIM_OP( 15,  vmseq.vi,  0, 0xffffffffffffffff, 0x0 );
  TEST_VIM_OP( 16,  vmseq.vi,  0, 0xffffffffffffffff, 0xf );
  TEST_VIM_OP( 17,  vmseq.vi,  1, 0xffffffffffffffff, 0x1f );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

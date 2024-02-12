# See LICENSE for license details.

#*****************************************************************************
# vredsum.S
#-----------------------------------------------------------------------------
#
# Test vredsum instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2, vredsum.vs, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 3, vredsum.vs, 0x00000002, 0x00000001, 0x00000001 );
  TEST_VV_OP( 4, vredsum.vs, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_VV_OP( 5, vredsum.vs, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VV_OP( 6, vredsum.vs, 0xffffffff80000000, 0xffffffff80000000, 0x00000000 );
  TEST_VV_OP( 7, vredsum.vs, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VV_OP( 8, vredsum.vs, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_VV_OP( 9, vredsum.vs, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VV_OP( 10, vredsum.vs, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VV_OP( 11, vredsum.vs, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vredsum.vs, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VV_OP( 13, vredsum.vs, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 14, vredsum.vs, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VV_OP( 15, vredsum.vs, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_VV_OP( 16, vredsum.vs, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

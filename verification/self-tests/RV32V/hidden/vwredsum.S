# See LICENSE for license details.

#*****************************************************************************
# vwredsum.S
#-----------------------------------------------------------------------------
#
# Test vwredsum instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

 
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP_WITH_INIT( 2, vwredsum.vs, 0x00000000, 0x00000000, 0x00000000 );
  TEST_W_VV_OP_WITH_INIT( 3, vwredsum.vs, 0x00000002, 0x00000001, 0x00000001 );
  TEST_W_VV_OP_WITH_INIT( 4, vwredsum.vs, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_W_VV_OP_WITH_INIT( 5, vwredsum.vs, 0x00000000ffff8000, 0x00000000, 0xffff8000);
  TEST_W_VV_OP_WITH_INIT( 6, vwredsum.vs, 0xffffffff80000000, 0x80000000, 0x00000000 );
  TEST_W_VV_OP_WITH_INIT( 7, vwredsum.vs, 0x000000007fff8000, 0x80000000, 0xffffffffffff8000 );

  TEST_W_VV_OP_WITH_INIT( 8, vwredsum.vs, 0x0000000000007fff, 0x00000000, 0x00007fff );
  TEST_W_VV_OP_WITH_INIT( 9, vwredsum.vs, 0x000000007fffffff, 0x7fffffff, 0x00000000 );
  TEST_W_VV_OP_WITH_INIT( 10, vwredsum.vs, 0x0000000080007ffe, 0x7fffffff, 0x00007fff );

  TEST_W_VV_OP_WITH_INIT( 11, vwredsum.vs, 0xffffffff80007fff, 0x80000000, 0x00007fff );
  TEST_W_VV_OP_WITH_INIT( 12, vwredsum.vs, 0x000000017fff7fff, 0x7fffffff, 0xffff8000 );

  TEST_W_VV_OP_WITH_INIT( 13, vwredsum.vs, 0x00000000ffffffff, 0x00000000, 0xffffffff );
  TEST_W_VV_OP_WITH_INIT( 14, vwredsum.vs, 0x0000000000000000, 0xffffffff, 0x00000001 );
  TEST_W_VV_OP_WITH_INIT( 15, vwredsum.vs, 0x00000000fffffffe, 0xffffffff, 0xffffffff );

  TEST_W_VV_OP_WITH_INIT( 16, vwredsum.vs, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
	
  
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

# See LICENSE for license details.

#*****************************************************************************
# vwredsumu.S
#-----------------------------------------------------------------------------
#
# Test vwredsumu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

 
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP( 2, vwredsumu.vs, 0x00000000, 0x00000000, 0x00000000 );
  TEST_W_VV_OP( 3, vwredsumu.vs, 0x00000002, 0x00000001, 0x00000001 );
  TEST_W_VV_OP( 4, vwredsumu.vs, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_W_VV_OP( 5, vwredsumu.vs, 0x00000000ffff8000, 0x00000000, 0xffff8000 );
  TEST_W_VV_OP( 6, vwredsumu.vs, 0x0000000080000000, 0x80000000, 0x00000000 );
  TEST_W_VV_OP( 7, vwredsumu.vs, 0x000000017fff8000, 0x80000000, 0xffff8000 );

  TEST_W_VV_OP( 8, vwredsumu.vs, 0x0000000000007fff, 0x00000000, 0x00007fff );
  TEST_W_VV_OP( 9, vwredsumu.vs, 0x000000007fffffff, 0x7fffffff, 0x00000000 );
  TEST_W_VV_OP( 10, vwredsumu.vs, 0x0000000080007ffe, 0x7fffffff, 0x00007fff );

  TEST_W_VV_OP( 11, vwredsumu.vs, 0x0000000080007fff, 0x80000000, 0x0000000000007fff );
  TEST_W_VV_OP( 12, vwredsumu.vs, 0x000000017fff7fff, 0x7fffffff, 0xffff8000 );

  TEST_W_VV_OP( 13, vwredsumu.vs, 0x00000000ffffffff, 0x00000000, 0xffffffff );
  TEST_W_VV_OP( 14, vwredsumu.vs, 0x0000000100000000, 0xffffffff, 0x00000001 );
  TEST_W_VV_OP( 15, vwredsumu.vs, 0x00000001fffffffe, 0xffffffff, 0xffffffff );

  TEST_W_VV_OP( 16, vwredsumu.vs, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
	
  
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

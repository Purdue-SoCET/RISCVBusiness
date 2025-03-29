# See LICENSE for license details.

#*****************************************************************************
# add.S
#-----------------------------------------------------------------------------
#
# Test add instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # x5 will hold the value of larger/smaller value between x1/x2

  TEST_CASE( 1, x5, 1, \
    li x1, 3;       
    li x2, 1; 
    sub x3, x1, x2;
    srli x4, x3, 31; 
    czero.eqz x5, x1, x4; 
    czero.nez x6, x2, x4; 
    or x5, x5, x6;
  )

  TEST_CASE( 2, x5, 7, \
    li x1, 7;       
    li x2, 2; 
    sub x3, x1, x2;
    srli x4, x3, 31; 
    czero.nez x5, x1, x4;
    czero.eqz x6, x2, x4; 
    or x5, x5, x6;
  )

  TEST_CASE( 3, x5, 5, \
    li x1, 10;       
    li x2, 5; 
    sub x3, x1, x2;
    srli x4, x3, 31; 
    czero.eqz x5, x1, x4; 
    czero.nez x6, x2, x4; 
    or x5, x5, x6;
  )

  TEST_CASE( 4, x5, 9, \
    li x1, 9;       
    li x2, 1; 
    sub x3, x1, x2;
    srli x4, x3, 31; 
    czero.nez x5, x1, x4;
    czero.eqz x6, x2, x4; 
    or x5, x5, x6;
  )


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
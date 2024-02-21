# See LICENSE for license details.

#*****************************************************************************
# vcsr.S
#-----------------------------------------------------------------------------
#
# Test vset{i}vl{i} instructions 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U



RVTEST_CODE_BEGIN

  vsetivli x10, 5, e16, m2
  TEST_CASE(1, x10, 5, NOP)
  csrr x10, vtype
  TEST_CASE(2, x10, 9, NOP)
  csrr x10, vl
  TEST_CASE(3, x10, 5, NOP)

  // set illegal vtype setting 
  vsetivli x10, 5, e64, m1
  NOP
  csrr x10, vtype
  srli x10, x10, 31
  TEST_CASE(4, x10, 1, NOP)
  
  // set vl > VLMAX and check 
  vsetivli x10, 10, e32
  TEST_CASE(5, x10, 4, NOP)

  // test with vsetvl{i} with rs1=0, rd=0. vl should keep its prev value
  li x10, 9 // e16, m2
  vsetvl x0, x0, x10
  csrr x11, vl
  TEST_CASE(6, x11, 4, NOP)



  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

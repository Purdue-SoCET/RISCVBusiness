# See LICENSE for license details.

#*****************************************************************************
# vcsr.S
#-----------------------------------------------------------------------------
#
# Test vset{i}vl{i} instructions 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32UV

# vsetvl 
# vsetvli
# vsetivli


RVTEST_CODE_BEGIN

  vsetivli x10, 5, e16, m2
  NOP
  NOP
  NOP
  TEST_CASE(1, x10, 5, NOP)
  csrr x10, vtype
  TEST_CASE(2, x10, 9, NOP)
  csrr x10, vl
  TEST_CASE(3, x10, 5, NOP)

  // set illegal vtype setting 
  vsetivli x10, 5, e64, m1
  NOP
  NOP
  NOP
  csrr x10, vtype
  srli x10, x10, 31
  TEST_CASE(4, x10, 1, NOP)

  // set vl > VLMAX and check 
  vsetivli x10, 10, e32, 1
  NOP
  NOP
  NOP
  TEST_CASE(5, x10, 4, NOP)

  li x10, 3
  vsetvli x11, x11, e32
  NOP
  NOP
  NOP

  




  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

//test that goes from 00->01 back to 00
#initialize registers
main:
    li t0, 1
    li t1, 10
    
    //not taken
    blt t1, t0, main

    //taken
    blt t0, t1, one
one:
    //not taken
    blt t1, t0, main


RVTEST_CODE_END
  .data

RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END
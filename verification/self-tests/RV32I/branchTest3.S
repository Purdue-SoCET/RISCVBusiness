#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN


#initialize registers
main:
    li t0, 1
    li t1, 20
    
loop:
    addi t0, t0, 1
    blt t0, t1, loop

end:

RVTEST_CODE_END
  .data

RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END

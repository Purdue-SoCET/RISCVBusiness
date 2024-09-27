#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

main:
    li t0, 0

outer_loop:
    li t1, 100
    bge t0, t1, end
    li t2, 0

inner_loop:
    li t3, 3
    bge t2, t3, end_inner
    addi t2, t2, 1
    j inner_loop

end_inner:
    addi t0, t0, 1
    j outer_loop

end:
RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

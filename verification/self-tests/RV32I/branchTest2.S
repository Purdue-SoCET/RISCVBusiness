#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN


#initialize registers
main:
    li t0, 0
    li t1, 20
    li t2, 40
    li t3, 60
    li t4, 61
    
#increment t0 untill it equals t1    
loop1:
    beq t0, t1, loop2
    addi t0, t0, 1
    j loop1

#increment t0 untill it's greater than or equal to t2
loop2:
    bge t0, t2, loop3
    addi t0, t0, 1
    j loop2

#increment t0 untill t3 is less than it
loop3:
    blt t3, t0, loop4
    addi t0, t0, 1
    j loop3

#this loop will only run once, when it begins t0 = t4
loop4:
    bne t0, t4, end
    addi t0, t0, 1
    j loop4

end:

RVTEST_CODE_END
  .data

RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END

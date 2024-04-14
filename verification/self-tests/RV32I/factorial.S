#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

main:
    li a0, 20
    jal add_n
    jal end
add_n:        		 # arg: n in a0, returns sum(n) in a1
    addi  sp, sp, -8     # reserve our stack area
    sw ra, 0(sp)      	 # save the return address
    li t0, 0		
    blt a0, t0, ret_zero # if n=0 return zero
    sw a0, 4(sp)    	 # save n
    addi a0, a0, -1
    jal add_n            # call factorial (n-1)
                     	 # a1 = factorial(n-1)
    lw t0, 4(sp)    	 # t0 = n
    add a1, t0, a1  	 # a1 = n * factorial(n-1)
    j _restore
ret_zero:
    li a1, 0
_restore:
    lw ra, 0(sp)    	# restore return address from stack
    addi sp, sp, 8  	# free our stack frame
    jr ra           	# and return	
end:
RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


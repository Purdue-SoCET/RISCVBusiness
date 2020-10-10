# See LICENSE for license details.

#*****************************************************************************
# sparce_skip_range.S
#-----------------------------------------------------------------------------
#
# This test ensures that each skip range works for the sparce module.
# The block of CREATE_SASA_MEMORY_ENTRIES at the bottom first constructs
# the SASA data. Then for every loop the STORE_SASA_FROM_MEM macro 
# stores one entry to the SASA table.
#
# When the PC reaches 'skip_point', it skips x instructions based on the
# SASA entry. Then JAL to 'check_skip_range' subroutine to check if it
# is skipping from the expected address by reading the ra register.
#
# Register usage:
# x1 (ra) = return address
# x3, x4  = input regs to SASA entries
# x5 (t0) = loop counter/jump range (0 to 31)
# x6, x7 (t1, t2) = temp regs passed to macro
# x8      = addr of the start of skip region
# x9      = number of test cases (start from 0)
# x10     = temp

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

li  TESTNUM, 1
ori x3, x0, 0 
ori x4, x0, 0
ori t0, x0, 0        # loop counter (0 to 31)
ori x9, x0, 31       # number of test cases (start from 0)
la  x8, skip_point   # loads addr of skip_point

loop_start:
blt x9, t0, sasa_test_case_end  # end test if num of test cases < loop_counter

STORE_SASA_FROM_MEM(sasa_entry_0, t0, t1, t2)  # creates new SASA entry for the same PC
                                               # but +1 skip range for every loop
nop
nop
skip_point:
  nop
  jal check_skip_range    # skip 0 instructions
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range    
  jal check_skip_range    # skip 5 instructions
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range    # skip 10 instructions
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range    # skip 15 instructions
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range    # skip 20 instructions
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range    # skip 25 instructions
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range
  jal check_skip_range     # skip 31 instructions
  j   sasa_test_case_end_fail
  j   sasa_test_case_end_fail
  j   sasa_test_case_end_fail
  j   sasa_test_case_end_fail
  j   sasa_test_case_end_fail

check_skip_range:
  slli x10, t0, 2      # x10 = (loop_counter * 4)
  addi ra, ra, -8      # ra - 8 - x10
  sub  ra, ra, x10
  addi t0, t0, 1       # increment loop counter
  beq  ra, x8, loop_start  # expects ra - 4 - (loop_counter * 4) = skip_point


sasa_test_case_end_fail:
li TESTNUM, 0

sasa_test_case_end:

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN
sasa_entry_0:
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 0)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 1)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 2)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 3)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 4)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 5)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 6)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 7)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 8)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 9)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 10)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 11)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 12)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 13)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 14)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 15)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 16)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 17)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 18)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 19)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 20)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 21)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 22)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 23)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 24)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 25)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 26)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 27)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 28)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 29)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 30)
CREATE_SASA_MEMORY_ENTRIES(skip_point, 3, 4, SASA_COND_AND, 31)

TEST_DATA

RVTEST_DATA_END

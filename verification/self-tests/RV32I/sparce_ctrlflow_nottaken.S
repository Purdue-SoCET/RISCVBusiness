# See LICENSE for license details.

#*****************************************************************************
# sparce_ctrlflow_nottaken.S
#-----------------------------------------------------------------------------
#
# This test ensures that the instruction AT the SASA preceding PC will be 
# executed but does not affect the skipping conditions.
#
# Register usage:
# x3, x4  = condition regs to SASA entries
# x5 (t0) = word address offset to access the SASA data
# x6, x7 (t1, t2) = temp regs passed to macro

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

li  TESTNUM, 1
ori x3, x0, 0
ori x4, x0, 0
ori t0, x0, 0

STORE_SASA_FROM_MEM(sasa_entry_0, t0, t1, t2)  
addi t0, t0, 1
STORE_SASA_FROM_MEM(sasa_entry_0, t0, t1, t2)  
addi t0, t0, 1
STORE_SASA_FROM_MEM(sasa_entry_0, t0, t1, t2)  
nop
nop

skip_point_0:       # SASA_AND: 0,0 -> skip 2 instructions
  bne x0, x0, sasa_test_case_end_fail
  j   skip_point_1
  j   sasa_test_case_end_fail

skip_point_1:       # SASA_AND: 0,0 -> skip 2 instructions
  beq x5, x0, sasa_test_case_end_fail
  j   skip_point_2
  j   sasa_test_case_end_fail
  j   sasa_test_case_end_fail
  j   sasa_test_case_end_fail

skip_point_2:       # SASA_OR: 0,0 -> skip 2 instructions
  blt x5, x0, sasa_test_case_end_fail
  j   sasa_test_case_end
  j   sasa_test_case_end_fail

sasa_test_case_end_fail:
li TESTNUM, 0

sasa_test_case_end:

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN
sasa_entry_0:
CREATE_SASA_MEMORY_ENTRIES(skip_point_0, 3, 4, SASA_COND_AND, 2)
CREATE_SASA_MEMORY_ENTRIES(skip_point_1, 3, 4, SASA_COND_AND, 2)
CREATE_SASA_MEMORY_ENTRIES(skip_point_2, 3, 4, SASA_COND_OR, 2)

TEST_DATA

RVTEST_DATA_END

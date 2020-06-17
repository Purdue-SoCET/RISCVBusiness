/*
*   Copyright 2016 Purdue University
*   
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*   
*       http://www.apache.org/licenses/LICENSE-2.0
*   
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     basic_branch.S
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 07/01/2016
*   Description:  Test of basic branching behavior
*/

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U


RVTEST_CODE_BEGIN


main:
  # Define trap vector address
  la t0, mtvec_handler
  csrw mtvec, t0

  addi x6, x0, 0xFF
  addi x7, x0, 0xFF
  addi x3, x0, 0x1
  slli x3, x3, 3
  csrw mstatus, x3
  nop
  nop
  nop
  nop
  la x1, mtime
  lw x2, 0(x1)
  nop
  nop
  nop
  nop
  addi x2, x2, 50 // NOTE: Potential data hazard with lw instruction
  la x1, mtimecmp
  sw x2, 0(x1)
  ori x3, x0, 0x80
  csrw mie, x3
idle_loop:
  beq x6, x7, idle_loop
  RVTEST_PASS

.align 2
mtvec_handler:
  # Write to mtimecmp using the zero register
  # Check that nothing happened to interrupt
  # Actually write to mtimecmp
  # Check that the interrupt cleared
  # Change sigil to show interrupt was entered
  ori x6, x0, 0x0F
  # Return
  mret

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END
  

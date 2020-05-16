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
*   Filename:     ext_interrupt.S
*
*   Created by:   Enes Shaltami
*   Email:        ashaltam@purdue.edu
*   Date Created: 03/15/2020
*   Description:  Test of external interrupts
*/

#include "riscv_test.h"
#include "test_macros.h"
// NOTE: You should modify this code to make it for external interrupts

RVTEST_RV32U

// TODO: Comment more to understand where these packages come from

RVTEST_CODE_BEGIN

// xlen is 32 bits since each instruction has a size of 32 bits
main:
  li TESTNUM, 1 // load the global test num value
  la t0, mtvec_handler # load in address of mtvec_handler
  csrw mtvec, t0 # encoded as csrrw x0, csr(mtvec), rs1(t0). write t0 into mtvec
// mtvec stands for Machine Trap-Vector Base-Address Register

  addi x6, x0, 0xFF // store FF into x6
  addi x7, x0, 0xFF // store FF into x7
  addi x3, x0, 0x1 // store 1 into x3
  csrw mstatus, x3 // write value of 1 into mstatus register, enable the current interrupt via UIE


  addi x3, x0, 0x1
  addi x4, x0, 0x1
  slli x3, x3, 11 // store 0x800 into x3 and x4
  slli x4, x4, 11


  csrw mip, x3 
  csrw mie, x4 // Write value of 0x800 into mie, external interrupt enable for M-mode

  RVTEST_PASS

// Loop is commented out to analyze the structure prior
/*
idle_loop: // infinite while loop to wait until interrupt passes
  //la x1, mcause
  //lw x2, 0(x1)
  li TESTNUM, 0
  csrs mcause, x2
  srli x5, x2, 0x1F // obtain the MSB to determine if it was an interrupt instead of an exception
  andi x6, x2, 0xB // find the source which should be EXT_INT (or hex value of 0xB)
  li TESTNUM, 1
  beq x5, x0, idle_loop // keep looping until an interrupt is received

  RVTEST_PASS // denote this as a passed test
*/




.align 2
mtvec_handler: // TODO: What is mtvec_handler??
  # Write to mtimecmp using the zero register
  # Check that nothing happened to interrupt
  # Actually write to mtimecmp
  # Check that the interrupt cleared
  # Change sigil to show interrupt was entered
  //ori x6, x0, 0x0F
  # Return
  mret


RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END
  

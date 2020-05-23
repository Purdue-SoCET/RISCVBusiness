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
  la t0, mtvec_handler // load in address of mtvec_handler
  ori t0, t0, 0x1 // or in the MODE (Vectored)
  csrw mtvec, t0 // assign the supported vector handler into mtvec

  addi x3, x0, 0x1
  slli x3, x3, 11 // store 0x800 into x3 and x4
  csrw mie, x3 // Write value of 0x800 into mie, external interrupt enable for M-mode
  ori x7, x0, 0xAB

  ori x4, x0, 0x1
  slli x4, x4, 3
  csrw mstatus, x4 // turn on the mie bit within mstatus

idle_loop:
  beq x6, x7, idle_loop // infinite loop will only finish once the external interrupt ISR has completed properly

  RVTEST_PASS

.align 2
mtvec_handler: // General vector table for all exceptions and interrupts
  // Interrupts must be disabled at entry to handler, could have jumps to different parts of code, potentially
IRQ_0:
  j exception_handler // FIXME: PC for exception handler and user software interrupt handler are the same!!
IRQ_1:
  j supervisor_software_interrupt_handler
IRQ_2:
  j machine_software_interrupt_handler
IRQ_3:
  j user_timer_interrupt_handler
IRQ_4:
  j supervisor_timer_interrupt_handler
IRQ_5:
  j machine_timer_interrupt_handler
IRQ_6:
  j user_external_interrupt_handler
IRQ_7:
  j supervisor_external_interrupt_handler
IRQ_8:
  j machine_external_interrupt_handler

exception_handler: // manage all exceptions here
supervisor_software_interrupt_handler: 
machine_software_interrupt_handler:
user_timer_interrupt_handler:
supervisor_timer_interrupt_handler:
machine_timer_interrupt_handler:
user_external_interrupt_handler: 
supervisor_external_interrupt_handler:
    mret

machine_external_interrupt_handler:
    ori x6, x0, 0xAB
    mret


RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END
  

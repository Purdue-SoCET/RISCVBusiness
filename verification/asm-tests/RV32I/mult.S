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
*   Filename:     mult.S
*
*   Created by:   Wengyan Chan
*   Email:        cwengyan@purdue.edu
*   Date Created: 04/17/2019
*   Description:  Function that multiplies 2 numbers
*/

#include "riscv_test.h"

RVTEST_DATA_DUMP_BEGIN

RVTEST_INTVEC_USER_BEGIN
  nop
RVTEST_INTVEC_SUPER_BEGIN
  nop
RVTEST_INTVEC_HYPER_BEGIN
  nop
RVTEST_INTVEC_MACH_BEGIN
  nop

RVTEST_CODE_BEGIN

main:
  la  x5, tdat0
  ori x1, x0, 0x03       // numbers to multiply
  ori x2, x0, 0x06       

mult:
  andi x3, x2, 1         // if reg2 is odd
  beq  x3, x0, shift
  add  x4, x4, x1        // solution stored in reg4

shift:
  slli x1, x1, 1
  srli x2, x2, 1
  bne  x2, x0, mult
  sw   x4, 0(x5)

RVTEST_CODE_END

.data
#test data goes here
tdat0:  .word 0xdeadcafe

RVTEST_DATA_DUMP_END


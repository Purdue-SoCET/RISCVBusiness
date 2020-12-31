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
*   Filename:     sparce.S
*
*   Created by:   Wengyan Chan
*   Email:        cwengyan@purdue.edu
*   Date Created: 04/07/2019
*   Description:  Preliminary test for sparcity
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
    ori x1, x0, 0xf0
    ori x2, x0, 0x55
    ori x3, x0, 0x00
    ori x5, x0, 0x00

    // generate sparse and nonsparse values
    and x6, x1, x2
    and x7, x1, x3

    or  x8, x3, x5
    or  x9, x3, x1

RVTEST_CODE_END


RVTEST_DATA_DUMP_END




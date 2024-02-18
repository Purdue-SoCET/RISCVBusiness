/*
* Copyright (c) 2012-2015, The Regents of the University of California (Regents).
* All Rights Reserved.
* 
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
* 1. Redistributions of source code must retain the above copyright
*    notice, this list of conditions and the following disclaimer.
* 2. Redistributions in binary form must reproduce the above copyright
*    notice, this list of conditions and the following disclaimer in the
*    documentation and/or other materials provided with the distribution.
* 3. Neither the name of the Regents nor the
*    names of its contributors may be used to endorse or promote products
*    derived from this software without specific prior written permission.
* 
* IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
* SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING
* OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF REGENTS HAS
* BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* 
* REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
* THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
* PURPOSE. THE SOFTWARE AND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
* HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
* MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
*/

#ifndef _ENV_SIMPLE_PHYSICAL_SINGLE_CORE_H
#define _ENV_SIMPLE_PHYSICAL_SINGLE_CORE_H

#include "../encoding.h"

#define __RISCVEL 1

#define RVTEST_RV32U                                                    \
  .macro init;                                                          \
  .endm

//-----------------------------------------------------------------------
// Text Section Macro
//-----------------------------------------------------------------------

#define RVTEST_INTVEC_USER_BEGIN \
  .text;                    \
  .align 6;                 
 
#define RVTEST_INTVEC_SUPER_BEGIN \
  .align 6;            

#define RVTEST_INTVEC_HYPER_BEGIN \
  .align 6;           

#define RVTEST_INTVEC_MACH_BEGIN \
  .align 6;           

#define RVTEST_CODE_BEGIN   \
  .align  6; \
  .globl _start; \
  start_: \
  j _thread_one; \
  j _thread_two; \
  j _thread_three; 
  
#define RVTEST_CODE_END \
  li x1, 1; \
  li x2, 1; \
  sw x2, tohost, x1; \
  done:  \
  j done

#endif // merged in

//-----------------------------------------------------------------------
// Pass/Fail Macro
//-----------------------------------------------------------------------

#define RVTEST_PASS                                                     \
        fence;                                                          \
        li TESTNUM, 1;                                                  \
        j done

#define TESTNUM t3
#define RVTEST_FAIL                                                     \
        fence;                                                          \
1:      beqz TESTNUM, 1b;                                               \
        sll TESTNUM, TESTNUM, 1;                                        \
        or TESTNUM, TESTNUM, 1;                                         \
        j done


//-----------------------------------------------------------------------
// Threads Macros
//-----------------------------------------------------------------------

#define CHECK_THREAD_PASSED( thread_num )                            \
      bne x0, TESTNUM, thread_passed_ ## thread_num;                  \
      fence;                                                          \
1:    beqz TESTNUM, 1b;                                               \
      sll TESTNUM, TESTNUM, 1;                                        \
      or TESTNUM, TESTNUM, 1;                                         \
      j check_thread_done_ ## thread_num;                             \
  thread_passed_ ## thread_num: \
      fence;                                                          \
      li TESTNUM, 1;                                                  \
  check_thread_done_ ## thread_num:                                                  

#define RVTEST_THREAD_ONE_BEGIN \
  .globl _thread_one;  \
  _thread_one:

#define RVTEST_THREAD_ONE_END \
  _thread_one_end: \
  CHECK_THREAD_PASSED(one); \
  la t0, t_count; \
  li t1, 1; \
  sw t1, 0(t0); \
  j thread_wait; 

#define RVTEST_THREAD_TWO_BEGIN \
  .globl _thread_two;  \
  _thread_two: 

#define RVTEST_THREAD_TWO_END \
  _thread_two_end: \
  CHECK_THREAD_PASSED(two); \
  la t0, t_count; \
  li t1, 1; \
  sw t1, 4(t0); \
  j thread_wait; 

#define RVTEST_THREAD_THREE_BEGIN \
  .globl _thread_three;  \
  _thread_three: 

#define RVTEST_THREAD_THREE_END \
  _thread_three_end: \
  CHECK_THREAD_PASSED(three); \
  la t0, t_count; \
  li t1, 1; \
  sw t1, 8(t0); \
  j thread_wait; 

#define RVTEST_THREAD_WAIT \
  .globl thread_wait;  \
  thread_wait: \
  la   t0, t_count; \
  li t1, 3; /* 3 threads*/ \
  li t2, 0; /* 0 threads done*/ \
  li t5, 0; /* counter */ \
  thread_add_loop: \
  lw   t4, 0(t0); \
  addi t0, t0, 4; \
  add t2, t2, t4; \
  addi t5, t5, 1; \
  bne  t5, t1, thread_add_loop; \
  bne t2, t1, thread_loop; \
  threads_done: \
  j done; \
  thread_loop:  \
  nop; \
  j thread_loop;

//-----------------------------------------------------------------------
// End Macro
//-----------------------------------------------------------------------

//#define RVTEST_CODE_END                                                 \
//ecall:  ecall;                                                          \
//        j ecall


//-----------------------------------------------------------------------
// Data Section Macro
//-----------------------------------------------------------------------

#define EXTRA_DATA

#define RVTEST_DATA_BEGIN EXTRA_DATA .align 4; .global begin_signature; begin_signature: \
    .align 6; .global t_count; t_count: .dword 0;

#define RVTEST_DATA_END .align 4; .global end_signature; end_signature: \
 .align 6; .global tohost; tohost: .dword 0; \
 .align 6; .global fromhost; fromhost: .dword 0; \
 .align 6; .global mtime; mtime: .dword 0; \
 .align 6; .global mtimecmp; mtimecmp: .dword 0; \


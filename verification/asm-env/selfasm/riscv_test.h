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
  .globl _start;          \
_start:
  

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

#define TESTNUM x28
#define RVTEST_FAIL                                                     \
        fence;                                                          \
1:      beqz TESTNUM, 1b;                                               \
        sll TESTNUM, TESTNUM, 1;                                        \
        or TESTNUM, TESTNUM, 1;                                         \
        j done


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

#define RVTEST_DATA_BEGIN EXTRA_DATA .align 4; .global begin_signature; begin_signature:
#define RVTEST_DATA_END .align 4; .global end_signature; end_signature: \
 .align 6; .global tohost; tohost: .dword 0; \
 .align 6; .global fromhost; fromhost: .dword 0; \
 .align 6; .global mtime; mtime: .dword 0; \
 .align 6; .global mtimecmp; mtimecmp: .dword 0; \


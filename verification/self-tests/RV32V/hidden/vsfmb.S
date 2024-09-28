# See LICENSE for license details.

#*****************************************************************************
# vsfmb.S
#-----------------------------------------------------------------------------
#
# Test Vector Set First Mask Bit instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  # if __riscv_vsew == 32 
  #-------------------------------------------------------------
  # set-before-first tests
  #-------------------------------------------------------------

  TEST_VSFMB_OP( 2,  vmsbf.m,     2, src1dat );
  TEST_VSFMB_OP( 3,  vmsbf.m,     1, src2dat );
  TEST_VSFMB_OP( 4,  vmsbf.m,     0, src3dat );
  TEST_VSFMB_OP( 5,  vmsbf.m,     4, src4dat );

  #-------------------------------------------------------------
  # set-including-first tests
  #-------------------------------------------------------------

  TEST_VSFMB_OP( 6,  vmsif.m,     3, src1dat );
  TEST_VSFMB_OP( 7,  vmsif.m,     2, src2dat );
  TEST_VSFMB_OP( 8,  vmsif.m,     1, src3dat );
  TEST_VSFMB_OP( 9,  vmsif.m,     4, src4dat );

  #-------------------------------------------------------------
  # set-only-first tests
  #-------------------------------------------------------------

  TEST_VSFMB_OP(10,  vmsof.m,     1, src1dat );
  TEST_VSFMB_OP(11,  vmsof.m,     1, src2dat );
  TEST_VSFMB_OP(12,  vmsof.m,     1, src3dat );
  TEST_VSFMB_OP(13,  vmsof.m,     0, src4dat );
  #endif 
  #-------------------------------------------------------------
  #if __riscv_vsew == 64 
  TEST_VSFMB_OP_64( 14,  vmsbf.m,     2, src1dat );
  TEST_VSFMB_OP_64( 15,  vmsbf.m,     2, src2dat );
  TEST_VSFMB_OP_64( 16,  vmsbf.m,     2, src3dat );
  TEST_VSFMB_OP_64( 17,  vmsbf.m,     2, src4dat );

  #-------------------------------------------------------------
  # set-including-first tests
  #-------------------------------------------------------------

  TEST_VSFMB_OP_64( 18,  vmsif.m,     2, src1dat );
  TEST_VSFMB_OP_64( 19,  vmsif.m,     2, src2dat );
  TEST_VSFMB_OP_64( 20,  vmsif.m,     2, src3dat );
  TEST_VSFMB_OP_64( 21,  vmsif.m,     2, src4dat );

  #-------------------------------------------------------------
  # set-only-first tests
  #-------------------------------------------------------------

  TEST_VSFMB_OP_64(22,  vmsof.m,     0, src1dat );
  TEST_VSFMB_OP_64(23,  vmsof.m,     0, src2dat );
  TEST_VSFMB_OP_64(24,  vmsof.m,     0, src3dat );
  TEST_VSFMB_OP_64(25,  vmsof.m,     0, src4dat );
  #endif 
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1dat:
src1dat1:  .word 0x00000000
src1dat2:  .word 0x00000000
src1dat3:  .word 0x00000001
src1dat4:  .word 0x00000001

src2dat:
src2dat1:  .word 0x00000000
src2dat2:  .word 0x00000001
src2dat3:  .word 0x00000000
src2dat4:  .word 0x00000001

src3dat:
src3dat1:  .word 0x00000001
src3dat2:  .word 0x00000001
src3dat3:  .word 0x00000001
src3dat4:  .word 0x00000001

src4dat:
src4dat1:  .word 0x00000000
src4dat2:  .word 0x00000000
src4dat3:  .word 0x00000000
src4dat4:  .word 0x00000000

RVTEST_DATA_END

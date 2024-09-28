# See LICENSE for license details.

#*****************************************************************************
# viota.S
#-----------------------------------------------------------------------------
#
# Test viota, vid instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # viota tests
  #-------------------------------------------------------------

  TEST_VIOTA_OP( 2,  viota.m, ans1dat, src1dat );
  TEST_VIOTA_OP( 3,  viota.m, ans2dat, src2dat );
#if __riscv_vsew < 64
  TEST_VIOTA_OP( 4,  viota.m, ans3dat, src3dat );
#endif

#if __riscv_vsew == 64
TEST_VIOTA_OP( 5,  viota.m, ans5dat, src3dat );
#endif
TEST_VIOTA_OP( 6,  viota.m, ans4dat, src4dat );
  #-------------------------------------------------------------
  # vid tests
  # Raise illegal operands `vid.v v14,v0`
  #-------------------------------------------------------------
#if __riscv_vsew < 64
  TEST_VID_OP( 7,  vid.v, ans3dat, src1dat );
#endif 

#if __riscv_vsew == 64
  #TEST_VID_OP_64( 8,  vid.v, ans6dat, src1dat );
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

ans1dat:
ans1dat1:  .word 0x00000000
ans1dat2:  .word 0x00000000
ans1dat3:  .word 0x00000000
ans1dat4:  .word 0x00000001

src2dat:
src2dat1:  .word 0x00000000
src2dat2:  .word 0x00000001
src2dat3:  .word 0x00000000
src2dat4:  .word 0x00000001

ans2dat:
ans2dat1:  .word 0x00000000
ans2dat2:  .word 0x00000000
ans2dat3:  .word 0x00000001
ans2dat4:  .word 0x00000001

src3dat:
src3dat1:  .word 0x00000001
src3dat2:  .word 0x00000001
src3dat3:  .word 0x00000001
src3dat4:  .word 0x00000001

ans3dat:
ans3dat1:  .word 0x00000000
ans3dat2:  .word 0x00000001
ans3dat3:  .word 0x00000002
ans3dat4:  .word 0x00000003

src4dat:
src4dat1:  .word 0x00000000
src4dat2:  .word 0x00000000
src4dat3:  .word 0x00000000
src4dat4:  .word 0x00000000

ans4dat:
ans4dat1:  .word 0x00000000
ans4dat2:  .word 0x00000000
ans4dat3:  .word 0x00000000
ans4dat4:  .word 0x00000000

ans5dat:
ans5dat1:  .word 0x00000000
ans5dat2:  .word 0x00000000
ans5dat3:  .word 0x00000000
ans5dat4:  .word 0x00000000

ans6dat:
ans6dat1:  .word 0x00000001
ans6dat2:  .word 0x00000000
ans6dat3:  .word 0x00000000
ans6dat4:  .word 0x00000000 

RVTEST_DATA_END

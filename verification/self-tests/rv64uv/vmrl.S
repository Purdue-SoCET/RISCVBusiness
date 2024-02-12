# See LICENSE for license details.

#*****************************************************************************
# vmrl.S
#-----------------------------------------------------------------------------
#
# Test Vector Mask-Register Logical instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # and tests
  #-------------------------------------------------------------

  TEST_VMRL_OP( 2,  vmand.mm,  32,  1, src1dat, src2dat );
  TEST_VMRL_OP( 3,  vmand.mm,  32,  1, src2dat, src1dat );
  TEST_VMRL_OP( 4,  vmand.mm,  32,  2, src1dat, src1dat );
  TEST_VMRL_OP( 5,  vmand.mm,  32,  2, src2dat, src2dat );

  #-------------------------------------------------------------
  # nand tests
  #-------------------------------------------------------------

  TEST_VMRL_OP(  7, vmnand.mm, 32,  3, src1dat, src2dat );
  TEST_VMRL_OP(  8, vmnand.mm, 32,  3, src2dat, src1dat );
  TEST_VMRL_OP(  9, vmnand.mm, 32,  2, src1dat, src1dat );
  TEST_VMRL_OP( 10, vmnand.mm, 32,  2, src2dat, src2dat );

  #-------------------------------------------------------------
  # andnot tests
  #-------------------------------------------------------------

  TEST_VMRL_OP( 11, vmandnot.mm,32, 1, src1dat, src2dat );
  TEST_VMRL_OP( 12, vmandnot.mm,32, 1, src2dat, src1dat );
  TEST_VMRL_OP( 13, vmandnot.mm,32, 0, src1dat, src1dat );
  TEST_VMRL_OP( 14, vmandnot.mm,32, 0, src2dat, src2dat );

  #-------------------------------------------------------------
  # xor tests
  #-------------------------------------------------------------

  TEST_VMRL_OP( 15, vmxor.mm,   32, 2, src1dat, src2dat );
  TEST_VMRL_OP( 16, vmxor.mm,   32, 2, src2dat, src1dat );
  TEST_VMRL_OP( 17, vmxor.mm,   32, 0, src1dat, src1dat );
  TEST_VMRL_OP( 18, vmxor.mm,   32, 0, src2dat, src2dat );

  #-------------------------------------------------------------
  # or tests
  #-------------------------------------------------------------

  TEST_VMRL_OP( 19, vmor.mm,    32, 3, src1dat, src2dat );
  TEST_VMRL_OP( 20, vmor.mm,    32, 3, src2dat, src1dat );
  TEST_VMRL_OP( 21, vmor.mm,    32, 2, src1dat, src1dat );
  TEST_VMRL_OP( 22, vmor.mm,    32, 2, src2dat, src2dat );

  #-------------------------------------------------------------
  # nor tests
  #-------------------------------------------------------------

  TEST_VMRL_OP( 23, vmnor.mm,   32, 1, src1dat, src2dat );
  TEST_VMRL_OP( 24, vmnor.mm,   32, 1, src2dat, src1dat );
  TEST_VMRL_OP( 25, vmnor.mm,   32, 2, src1dat, src1dat );
  TEST_VMRL_OP( 26, vmnor.mm,   32, 2, src2dat, src2dat );

  #-------------------------------------------------------------
  # ornot tests
  #-------------------------------------------------------------

  TEST_VMRL_OP( 27, vmornot.mm, 32, 3, src1dat, src2dat );
  TEST_VMRL_OP( 28, vmornot.mm, 32, 3, src2dat, src1dat );
  TEST_VMRL_OP( 29, vmornot.mm, 32, 4, src1dat, src1dat );
  TEST_VMRL_OP( 30, vmornot.mm, 32, 4, src2dat, src2dat );

  #-------------------------------------------------------------
  # xnor tests
  #-------------------------------------------------------------

  TEST_VMRL_OP( 31, vmxnor.mm,  32, 2, src1dat, src2dat );
  TEST_VMRL_OP( 32, vmxnor.mm,  32, 2, src2dat, src1dat );
  TEST_VMRL_OP( 33, vmxnor.mm,  32, 4, src1dat, src1dat );
  TEST_VMRL_OP( 34, vmxnor.mm,  32, 4, src2dat, src2dat );

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
src3dat1:  .word 0x00000000
src3dat2:  .word 0x00000000
src3dat3:  .word 0x00000000
src3dat4:  .word 0x00000000
src3dat5:  .word 0x00000001
src3dat6:  .word 0x00000000
src3dat7:  .word 0x00000001
src3dat8:  .word 0x00000000

src4dat:
src4dat1:  .word 0x00000000
src4dat2:  .word 0x00000000
src4dat3:  .word 0x00000001
src4dat4:  .word 0x00000000
src4dat5:  .word 0x00000000
src4dat6:  .word 0x00000000
src4dat7:  .word 0x00000001
src4dat8:  .word 0x00000000

RVTEST_DATA_END

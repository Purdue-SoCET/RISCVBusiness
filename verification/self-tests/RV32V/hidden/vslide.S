# See LICENSE for license details.

#*****************************************************************************
# vslide.S
#-----------------------------------------------------------------------------
#
# Test vslideup instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vslideup.VX
  #-------------------------------------------------------------

  TEST_VSLIDE_VX_OP( 2, vslideup.vx, 0x00000001, 0x00000000, tdat1 );
  TEST_VSLIDE_VX_OP( 3, vslideup.vx, 0x00000001, 0x00000001, tdat1 );

  #-------------------------------------------------------------
  # vslideup.VI
  #-------------------------------------------------------------

  TEST_VSLIDE_VI_OP( 4, vslideup.vi, 0x00000001, 0, tdat1 );
  TEST_VSLIDE_VI_OP( 5, vslideup.vi, 0x00000001, 1, tdat1 );

  #-------------------------------------------------------------
  # vslidedown.VX
  #-------------------------------------------------------------

  TEST_VSLIDE_VX_OP( 6, vslidedown.vx, 0x00000001, 0x00000000, tdat1 );
  TEST_VSLIDE_VX_OP( 7, vslidedown.vx, 0x00000000, 0x00000001, tdat1 );
  TEST_VSLIDE_VX_OP( 8, vslidedown.vx, 0x00000002, 0x00000002, tdat1 );
  TEST_VSLIDE_VX_OP( 9, vslidedown.vx, 0x00000003, 0x00000003, tdat1 );

  #-------------------------------------------------------------
  # vslidedown.VI
  #-------------------------------------------------------------

  TEST_VSLIDE_VI_OP(10, vslidedown.vi, 0x00000001, 0, tdat1 );
  TEST_VSLIDE_VI_OP(11, vslidedown.vi, 0x00000000, 1, tdat1 );
  TEST_VSLIDE_VI_OP(12, vslidedown.vi, 0x00000002, 2, tdat1 );
  TEST_VSLIDE_VI_OP(13, vslidedown.vi, 0x00000003, 3, tdat1 );

  #-------------------------------------------------------------
  # vslide1up.VX
  #-------------------------------------------------------------

  TEST_VSLIDE_VX_OP(14, vslide1up.vx, 0x00000000, 0x00000000, tdat1 );
  TEST_VSLIDE_VX_OP(15, vslide1up.vx, 0x00000001, 0x00000001, tdat1 );
  TEST_VSLIDE_VX_OP(16, vslide1up.vx, 0x0000000a, 0x0000000a, tdat1 );

  #-------------------------------------------------------------
  # vslide1up.VF
  #-------------------------------------------------------------

  #TEST_VSLIDE_VF_OP(17, vfslide1up.vf, 0, 0x40490FCF, fdat1, fdat5 );
  #TEST_VSLIDE_VF_OP(18, vfslide1up.vf, 0, 0x40490FCF, fdat1, fdat5 );
  #TEST_VSLIDE_VF_OP(19, vfslide1up.vf, 0, 0x40490FCF, fdat1, fdat5 );

  #-------------------------------------------------------------
  # vslide1down.VX
  #-------------------------------------------------------------

  TEST_VSLIDE_VX_OP(20, vslide1down.vx, 0x00000000, 0x00000000, tdat1 );
  TEST_VSLIDE_VX_OP(21, vslide1down.vx, 0x00000000, 0x00000001, tdat1 );
  TEST_VSLIDE_VX_OP(22, vslide1down.vx, 0x00000000, 0x0000000a, tdat1 );

  #-------------------------------------------------------------
  # vfslide1down.VF
  #-------------------------------------------------------------

  #TEST_VSLIDE_VF_OP(23, vfslide1down.vf, 0, 0x3E4CCCCC, fdat1, fdat5 );
  #TEST_VSLIDE_VF_OP(24, vfslide1down.vf, 0, 0x3E4CCCCC, fdat1, fdat5 );
  #TEST_VSLIDE_VF_OP(25, vfslide1down.vf, 0, 0x3E4CCCCC, fdat1, fdat5 );
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

tdat:
tdat1:  .word 0x00000001
tdat2:  .word 0x00000000
tdat3:  .word 0x00000002
tdat4:  .word 0x00000003

tdat5:  .word 0x00000004
tdat6:  .word 0x00000005
tdat7:  .word 0x00000006
tdat8:  .word 0x00000007

tdat9:  .word 0x00000008
tdat10: .word 0x00000009
tdat11: .word 0x0000000a
tdat12: .word 0x0000000b

fdat:
fdat1:  .word 0x3DCCCCCC
fdat2:  .word 0x3E4CCCCC
fdat3:  .word 0x3E999999
fdat4:  .word 0x3ECCCCCC

fdat5:  .word 0x40490FCF

RVTEST_DATA_END

# See LICENSE for license details.

#*****************************************************************************
# vmv.S
#-----------------------------------------------------------------------------
#
# Test vmv, vfmv instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vmv Tests
  #-------------------------------------------------------------

  TEST_VMV_OP( 2, 0x00000000 );
  TEST_VMV_OP( 3, 0x00000002 );
  TEST_VMV_OP( 4, 0x0000000a );
  TEST_VMV_OP( 5, 0xffff8000 );
  TEST_VMV_OP( 6, 0xffffffff );

  #-------------------------------------------------------------
  # vfmv.f.s Tests
  #-------------------------------------------------------------

  #TEST_VFMVF_OP( 7, fdat1 );
  #TEST_VFMVF_OP( 8, fdat2 );
  #TEST_VFMVF_OP( 9, fdat3 );
  #TEST_VFMVF_OP( 10,fdat4 );
  #TEST_VFMVF_OP( 11,fdat5 );

  #-------------------------------------------------------------
  # vfmv.v.f Tests
  #-------------------------------------------------------------

  #TEST_VFMVF_OP( 12,fdat1 );
  #TEST_VFMVF_OP( 13,fdat2 );
  #TEST_VFMVF_OP( 14,fdat3 );
  #TEST_VFMVF_OP( 15,fdat4 );
  #TEST_VFMVF_OP( 16,fdat5 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

fdat:
fdat1:  .word 0x3DCCCCCC
fdat2:  .word 0x3E4CCCCC
fdat3:  .word 0x3E999999
fdat4:  .word 0x3ECCCCCC

fdat5:  .word 0x40490FCF
fdat6:  .word 0x3DCCCCCC
fdat7:  .word 0x3E4CCCCC
fdat8:  .word 0x3E999999

RVTEST_DATA_END

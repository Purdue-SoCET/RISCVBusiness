# See LICENSE for license details.

#*****************************************************************************
# vsse.S
#-----------------------------------------------------------------------------
#
# Test vsse instruction.
# vsse64 only support when VSEW >= 64
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vsse8
  #-------------------------------------------------------------

  TEST_VSSE_OP( 2, vlse8.v, vsse8.v, 8, 0xaa, 1, 0  + tdat );
  TEST_VSSE_OP( 3, vlse8.v, vsse8.v, 8, 0x00, 1, 4  + tdat );
  TEST_VSSE_OP( 4, vlse8.v, vsse8.v, 8, 0xa0, 1, 8  + tdat );
  TEST_VSSE_OP( 5, vlse8.v, vsse8.v, 8, 0x0a, 1, 12 + tdat );
  TEST_VSSE_OP( 6, vlse8.v, vsse8.v, 8, 0xaa, 1, -12 + tdat8 );
  TEST_VSSE_OP( 7, vlse8.v, vsse8.v, 8, 0x00, 1, -8  + tdat8 );
  TEST_VSSE_OP( 8, vlse8.v, vsse8.v, 8, 0xa0, 1, -4  + tdat8 );
  TEST_VSSE_OP( 9, vlse8.v, vsse8.v, 8, 0x0a, 1, 0   + tdat8 );

  #-------------------------------------------------------------
  # vsse16
  #-------------------------------------------------------------

  TEST_VSSE_OP( 10, vlse16.v, vsse16.v, 16, 0x00aa, 2, 0  + tdat );
  TEST_VSSE_OP( 11, vlse16.v, vsse16.v, 16, 0xaa00, 2, 4  + tdat );
  TEST_VSSE_OP( 12, vlse16.v, vsse16.v, 16, 0x0aa0, 2, 8  + tdat );
  TEST_VSSE_OP( 13, vlse16.v, vsse16.v, 16, 0xa00a, 2, 12 + tdat );
  TEST_VSSE_OP( 14, vlse16.v, vsse16.v, 16, 0x00aa, 2, -12 + tdat8 );
  TEST_VSSE_OP( 15, vlse16.v, vsse16.v, 16, 0xaa00, 2, -8  + tdat8 );
  TEST_VSSE_OP( 16, vlse16.v, vsse16.v, 16, 0x0aa0, 2, -4  + tdat8 );
  TEST_VSSE_OP( 17, vlse16.v, vsse16.v, 16, 0xa00a, 2, 0   + tdat8 );

  #-------------------------------------------------------------
  # vsse32
  #-------------------------------------------------------------

  TEST_VSSE_OP( 18, vlse32.v, vsse32.v, 32, 0x00aa00aa, 4, 0  + tdat );
  TEST_VSSE_OP( 19, vlse32.v, vsse32.v, 32, 0xaa00aa00, 4, 4  + tdat );
  TEST_VSSE_OP( 20, vlse32.v, vsse32.v, 32, 0x0aa00aa0, 4, 8  + tdat );
  TEST_VSSE_OP( 21, vlse32.v, vsse32.v, 32, 0xa00aa00a, 4, 12 + tdat );
  TEST_VSSE_OP( 22, vlse32.v, vsse32.v, 32, 0x00aa00aa, 4, -12 + tdat8 );
  TEST_VSSE_OP( 23, vlse32.v, vsse32.v, 32, 0xaa00aa00, 4, -8  + tdat8 );
  TEST_VSSE_OP( 24, vlse32.v, vsse32.v, 32, 0x0aa00aa0, 4, -4  + tdat8 );
  TEST_VSSE_OP( 25, vlse32.v, vsse32.v, 32, 0xa00aa00a, 4, 0   + tdat8 );

  #-------------------------------------------------------------
  # vsse64
  # Only support when VSEW >= 64
  #-------------------------------------------------------------

#if __riscv_vsew >= 64

  TEST_VSSE_OP( 26, vlse64.v, vsse64.v, 64, 0xaa00aa0000aa00aa, 8, 0  + tdat );
  TEST_VSSE_OP( 27, vlse64.v, vsse64.v, 64, 0xa00aa00a0aa00aa0, 8, 8  + tdat );
  TEST_VSSE_OP( 28, vlse64.v, vsse64.v, 64, 0xaa00aa0000aa00aa, 8, -12 + tdat8 );
  TEST_VSSE_OP( 29, vlse64.v, vsse64.v, 64, 0xa00aa00a0aa00aa0, 8, -4  + tdat8 );

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

tdat:
tdat1:  .word 0xdeadbeef
tdat2:  .word 0xdeadbeef
tdat3:  .word 0xdeadbeef
tdat4:  .word 0xdeadbeef
tdat5:  .word 0xdeadbeef
tdat6:  .word 0xdeadbeef
tdat7:  .word 0xdeadbeef
tdat8:  .word 0xdeadbeef
tdat9:  .word 0xdeadbeef
tdat10: .word 0xdeadbeef

RVTEST_DATA_END

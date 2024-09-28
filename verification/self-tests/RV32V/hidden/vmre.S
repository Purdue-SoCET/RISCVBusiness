# See LICENSE for license details.

#*****************************************************************************
# vlre.S
#-----------------------------------------------------------------------------
#
# Test vmv<nr>r.v instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vmv1r.v
  #-------------------------------------------------------------

  TEST_VMRE1_OP( 2, vmv1r.v, 0x00ff00ff,  tdat1 );
  TEST_VMRE1_OP( 3, vmv1r.v, 0xf00ff00f,  tdat4 );
  TEST_VMRE1_OP( 4, vmv1r.v, 0xff00ff00,  tdat8 );


  #-------------------------------------------------------------
  # vmv2r.v
  #-------------------------------------------------------------

  TEST_VMRE2_OP( 6, vmv2r.v, 0x00ff00ff,  tdat1 );
  TEST_VMRE2_OP( 7, vmv2r.v, 0xff00ff00,  tdat4 );
  TEST_VMRE2_OP( 8, vmv2r.v, 0xf00ff00f,  tdat8 );
  
  #-------------------------------------------------------------
  # vmv4r.v
  #-------------------------------------------------------------

  TEST_VMRE4_OP( 9, vmv4r.v, 0x00ff00ff,  tdat1 );
  TEST_VMRE4_OP(10, vmv4r.v, 0xff00ff00,  tdat4 );
  TEST_VMRE4_OP(11, vmv4r.v, 0xf00ff00f,  tdat8 );

  #-------------------------------------------------------------
  # vmv8r.v
  #-------------------------------------------------------------

  TEST_VMRE8_OP(12, vmv8r.v, 0x00ff00ff,  tdat1 );
  TEST_VMRE8_OP(13, vmv8r.v, 0xff00ff00,  tdat4 );
  TEST_VMRE8_OP(14, vmv8r.v, 0x00000000,  tdat8 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

tdat:
tdat1:  .word 0x00ff00ff
tdat2:  .word 0xff00ff00
tdat3:  .word 0x0ff00ff0
tdat4:  .word 0xf00ff00f

tdat5:  .word 0x00ff00ff
tdat6:  .word 0x0ff00ff0
tdat7:  .word 0x00ff00ff
tdat8:  .word 0xff00ff00

tdat9:  .word 0x00ff00ff
tdat10:  .word 0xff00ff00
tdat11:  .word 0x0ff00ff0
tdat12:  .word 0xf00ff00f

tdat13:  .word 0x00ff00ff
tdat14:  .word 0x0ff00ff0
tdat15:  .word 0x00ff00ff
tdat16:  .word 0xff00ff00

tdat17:  .word 0x00ff00ff
tdat18:  .word 0xff00ff00
tdat19:  .word 0x0ff00ff0
tdat20:  .word 0xf00ff00f

tdat21:  .word 0x00ff00ff
tdat22:  .word 0x0ff00ff0
tdat23:  .word 0x00ff00ff
tdat24:  .word 0xff00ff00

tdat25:  .word 0x00ff00ff
tdat26:  .word 0xff00ff00
tdat27:  .word 0x0ff00ff0
tdat28:  .word 0xf00ff00f

tdat29:  .word 0x00ff00ff
tdat30:  .word 0x0ff00ff0
tdat31:  .word 0x00ff00ff
tdat32:  .word 0xff00ff00

RVTEST_DATA_END

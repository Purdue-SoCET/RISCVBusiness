# See LICENSE for license details.

#*****************************************************************************
# vssseg.S
#-----------------------------------------------------------------------------
#
# Test vssseg3e instruction.
# vssseg3e64 only support when VSEW >= 64
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vssseg3e8
  #-------------------------------------------------------------

  #TEST_VSSSEG1_OP( 2, vlsseg1e8.v, vssseg1e8.v, 8, 0xff, 1,  0  + tdat  );
  TEST_VSSSEG1_OP( 3, vlsseg2e8.v, vssseg2e8.v, 8, 0x0f, 1,  12 + tdat  );
  TEST_VSSSEG3_OP( 4, vlsseg3e8.v, vssseg3e8.v, 8, 0xff, 0x00, 0xff, 1, -12 + tdat4 );
  TEST_VSSSEG3_OP( 5, vlsseg4e8.v, vssseg4e8.v, 8, 0x0f, 0xf0, 0x0f, 1,  0  + tdat4 );
  TEST_VSSSEG3_OP( 6, vlsseg5e8.v, vssseg5e8.v, 8, 0x0f, 0xf0, 0x0f, 1,  0  + tdat4 );
  TEST_VSSSEG3_OP( 7, vlsseg6e8.v, vssseg6e8.v, 8, 0x0f, 0xf0, 0x0f, 1,  0  + tdat4 );
  TEST_VSSSEG3_OP( 8, vlsseg7e8.v, vssseg7e8.v, 8, 0x0f, 0xf0, 0x0f, 1,  0  + tdat4 );
  TEST_VSSSEG3_OP( 9, vlsseg8e8.v, vssseg8e8.v, 8, 0x0f, 0xf0, 0x0f, 1,  0  + tdat4 );

  #-------------------------------------------------------------
  # vssseg3e16
  #-------------------------------------------------------------

  #TEST_VSSSEG1_OP(10, vlsseg1e16.v, vssseg1e16.v, 16, 0x00ff, 2,  0  + tdat  );
  TEST_VSSSEG1_OP(11, vlsseg2e16.v, vssseg2e16.v, 16, 0x0ff0, 2,  8  + tdat  );
  TEST_VSSSEG3_OP(12, vlsseg3e16.v, vssseg3e16.v, 16, 0x00ff, 0x00ff, 0xff00, 2, -12 + tdat4 );
  TEST_VSSSEG3_OP(13, vlsseg4e16.v, vssseg4e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, 2, -4  + tdat4 );
  TEST_VSSSEG3_OP(14, vlsseg5e16.v, vssseg5e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, 2, -4  + tdat4 );
  TEST_VSSSEG3_OP(15, vlsseg6e16.v, vssseg6e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, 2, -4  + tdat4 );
  TEST_VSSSEG3_OP(16, vlsseg7e16.v, vssseg7e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, 2, -4  + tdat4 );
  TEST_VSSSEG3_OP(17, vlsseg8e16.v, vssseg8e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, 2, -4  + tdat4 );

  #-------------------------------------------------------------
  # vssseg3e32
  #-------------------------------------------------------------

  #TEST_VSSSEG1_OP(18, vlsseg1e32.v, vssseg1e32.v, 32, 0x00ff00ff, 4,  0  + tdat  );
  TEST_VSSSEG1_OP(19, vlsseg2e32.v, vssseg2e32.v, 32, 0xff00ff00, 4, -8  + tdat4 );
  TEST_VSSSEG3_OP(20, vlsseg3e32.v, vssseg3e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );
  TEST_VSSSEG3_OP(21, vlsseg4e32.v, vssseg4e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );
  TEST_VSSSEG3_OP(22, vlsseg5e32.v, vssseg5e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );
  TEST_VSSSEG3_OP(23, vlsseg6e32.v, vssseg6e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );
  TEST_VSSSEG3_OP(24, vlsseg7e32.v, vssseg7e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );
  TEST_VSSSEG3_OP(25, vlsseg8e32.v, vssseg8e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );

  #-------------------------------------------------------------
  # vssseg3e64
  # Only support when VSEW >= 64
  # In spike, when emul=1, vstore_3nf_seg will invlove 6 register, can't pass test
  #-------------------------------------------------------------

#if __riscv_vsew >= 64

  #TEST_VLSEG_OP(26, vlsseg3e64.v, vssseg3e64.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0x0ff00ff000ff00ff, 8, 0  + tdat );

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

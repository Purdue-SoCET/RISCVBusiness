# See LICENSE for license details.

#*****************************************************************************
# vsseg.S
#-----------------------------------------------------------------------------
#
# Test vsseg3e instruction.
# vsseg<nf>e64 only support when VSEW >= 64
# For simplicity, all vsseg test use 3 fields
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vssege8
  #-------------------------------------------------------------

  #TEST_VSSEG1_OP( 2, vlseg1e8.v, vsseg1e8.v, 8, 0xff, 0  + tdat  );
  TEST_VSSEG1_OP( 3, vlseg2e8.v, vsseg2e8.v, 8, 0xff, 0  + tdat  );
  TEST_VSSEG3_OP( 4, vlseg3e8.v, vsseg3e8.v, 8, 0xff, 0x00, 0xff,  0  + tdat  );
  TEST_VSSEG3_OP( 5, vlseg4e8.v, vsseg4e8.v, 8, 0xff, 0x00, 0xff,  0  + tdat  );
  TEST_VSSEG3_OP( 6, vlseg5e8.v, vsseg5e8.v, 8, 0xff, 0x00, 0xff,  0  + tdat  );
  TEST_VSSEG3_OP( 7, vlseg6e8.v, vsseg6e8.v, 8, 0x0f, 0xf0, 0x0f,  12 + tdat  );
  TEST_VSSEG3_OP( 8, vlseg7e8.v, vsseg7e8.v, 8, 0xff, 0x00, 0xff, -12 + tdat4 );
  TEST_VSSEG3_OP( 9, vlseg8e8.v, vsseg8e8.v, 8, 0x0f, 0xf0, 0x0f,  0  + tdat4 );

  #-------------------------------------------------------------
  # vsseg<nf>e16
  #-------------------------------------------------------------

  #TEST_VSSEG1_OP(10, vlseg1e16.v, vsseg1e16.v, 16, 0x00ff, 0  + tdat  );
  TEST_VSSEG1_OP(11, vlseg2e16.v, vsseg2e16.v, 16, 0x00ff, 0  + tdat  );
  TEST_VSSEG3_OP(12, vlseg3e16.v, vsseg3e16.v, 16, 0x00ff, 0x00ff, 0xff00,  0  + tdat  );
  TEST_VSSEG3_OP(13, vlseg4e16.v, vsseg4e16.v, 16, 0x00ff, 0x00ff, 0xff00,  0  + tdat  );
  TEST_VSSEG3_OP(14, vlseg5e16.v, vsseg5e16.v, 16, 0x00ff, 0x00ff, 0xff00,  0  + tdat  );
  TEST_VSSEG3_OP(15, vlseg6e16.v, vsseg6e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f,  8  + tdat  );
  TEST_VSSEG3_OP(16, vlseg7e16.v, vsseg7e16.v, 16, 0x00ff, 0x00ff, 0xff00, -12 + tdat4 );
  TEST_VSSEG3_OP(17, vlseg8e16.v, vsseg8e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, -4  + tdat4 );

  #-------------------------------------------------------------
  # vsseg<nf>e32
  #-------------------------------------------------------------

  #TEST_VSSEG1_OP(18, vlseg1e32.v, vsseg1e32.v, 32, 0x00ff00ff, 0  + tdat  );
  TEST_VSSEG1_OP(19, vlseg2e32.v, vsseg2e32.v, 32, 0x00ff00ff, 0  + tdat  );
  TEST_VSSEG3_OP(20, vlseg3e32.v, vsseg3e32.v, 32, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0,  0  + tdat  );
  TEST_VSSEG3_OP(21, vlseg4e32.v, vsseg4e32.v, 32, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0,  0  + tdat  );
  TEST_VSSEG3_OP(22, vlseg5e32.v, vsseg5e32.v, 32, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0,  0  + tdat  );
  TEST_VSSEG3_OP(23, vlseg6e32.v, vsseg6e32.v, 32, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0,  0  + tdat  );
  TEST_VSSEG3_OP(24, vlseg7e32.v, vsseg7e32.v, 32, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0,  0  + tdat  );
  TEST_VSSEG3_OP(25, vlseg8e32.v, vsseg8e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, -8  + tdat4 );

  #-------------------------------------------------------------
  # vsseg<nf>e64
  # Only support when VSEW >= 64
  # In spike, when emul=1, vstore_3nf_seg will invlove 6 register, can't pass test
  #-------------------------------------------------------------

#if __riscv_vsew >= 64

  #TEST_VLSEG_OP( 12, vlseg3e64.v, vsseg3e64.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0x0ff00ff000ff00ff, 0  + tdat );

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

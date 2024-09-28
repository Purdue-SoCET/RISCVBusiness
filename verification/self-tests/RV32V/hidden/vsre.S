# See LICENSE for license details.

#*****************************************************************************
# vsre.S
#-----------------------------------------------------------------------------
#
# Test vsre instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vs1r.v
  #-------------------------------------------------------------

  TEST_VSRE1_OP( 2, vl1re8.v,  vs1r.v, 8,  0xff,  0  + tdat  );
  TEST_VSRE1_OP( 3, vl1re16.v, vs1r.v, 16, 0x00ff,  12 + tdat  );
  TEST_VSRE1_OP( 4, vl1re32.v, vs1r.v, 32, 0x00ff00ff, -12 + tdat4 );
  #TEST_VSRE1_OP( 5, vl1re64.v, vs1r.v, 64, 0xff00ff0000ff00ff,  0  + tdat5 );
  
  #-------------------------------------------------------------
  # vs2r.v
  #-------------------------------------------------------------

  TEST_VSRE2_OP( 6, vl2re8.v,  vs2r.v, 8,  0xff, 0x00,  0  + tdat  );
  TEST_VSRE2_OP( 7, vl2re16.v, vs2r.v, 16, 0x00ff, 0x00ff,  12 + tdat  );
  TEST_VSRE2_OP( 8, vl2re32.v, vs2r.v, 32, 0x00ff00ff, 0xff00ff00, -12 + tdat4 );
  #TEST_VSRE2_OP( 9, vl2re64.v, vs2r.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0,  0  + tdat5 );

  #-------------------------------------------------------------
  # vs4r.v
  #-------------------------------------------------------------

  TEST_VSRE2_OP(10, vl4re8.v,  vs4r.v, 8,  0xff, 0x00,  0  + tdat  );
  TEST_VSRE2_OP(11, vl4re16.v, vs4r.v, 16, 0x00ff, 0x00ff,  12 + tdat  );
  TEST_VSRE2_OP(12, vl4re32.v, vs4r.v, 32, 0x00ff00ff, 0xff00ff00, -12 + tdat4 );
  #TEST_VSRE2_OP(13, vl4re64.v, vs4r.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0,  0  + tdat5 );

  #-------------------------------------------------------------
  # vs8r.v
  #-------------------------------------------------------------

  TEST_VSRE2_OP(14, vl8re8.v,  vs8r.v, 8,  0xff, 0x00,  0  + tdat  );
  TEST_VSRE2_OP(15, vl8re16.v, vs8r.v, 16, 0x00ff, 0x00ff,  12 + tdat  );
  TEST_VSRE2_OP(16, vl8re32.v, vs8r.v, 32, 0x00ff00ff, 0xff00ff00, -12 + tdat4 );
  #TEST_VSRE2_OP(17, vl8re64.v, vs8r.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0,  0  + tdat5 );

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

RVTEST_DATA_END

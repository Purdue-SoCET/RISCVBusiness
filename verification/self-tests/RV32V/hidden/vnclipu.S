# See LICENSE for license details.

#*****************************************************************************
# vnclipu.S
#-----------------------------------------------------------------------------
#
# Test vnclipu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

#if __riscv_vsew <= 32

 #-------------------------------------------------------------
  # wv Tests
  #-------------------------------------------------------------

  TEST_W_AVG_WV_OP( 2, vnclipu.wv, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0  );
  TEST_W_AVG_WV_OP( 3, vnclipu.wv, 0x40000000, 0x40000000, 0x40000000, 0x40000000, 0x80000000, 1  );
  TEST_W_AVG_WV_OP( 4, vnclipu.wv, 0x01000000, 0x01000000, 0x01000000, 0x01000000, 0x80000000, 7  );
  TEST_W_AVG_WV_OP( 5, vnclipu.wv, 0x00020000, 0x00020000, 0x00020000, 0x00020000, 0x80000000, 14 );
  TEST_W_AVG_WV_OP( 6, vnclipu.wv, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x80000000, 31 );
  
  TEST_W_AVG_WV_OP( 7, vnclipu.wv, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0  );
  TEST_W_AVG_WV_OP( 8, vnclipu.wv, 0x80000000, 0x80000000, 0x7fffffff, 0x7fffffff, 0xffffffff, 1  );
  TEST_W_AVG_WV_OP( 9, vnclipu.wv, 0x02000000, 0x02000000, 0x01ffffff, 0x01ffffff, 0xffffffff, 7  );
  TEST_W_AVG_WV_OP(10, vnclipu.wv, 0x00040000, 0x00040000, 0x0003ffff, 0x0003ffff, 0xffffffff, 14 );
  TEST_W_AVG_WV_OP(11, vnclipu.wv, 0x00000002, 0x00000002, 0x00000001, 0x00000001, 0xffffffff, 31 );

  TEST_W_AVG_WV_OP(12, vnclipu.wv, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0  );
  TEST_W_AVG_WV_OP(13, vnclipu.wv, 0x10909091, 0x10909090, 0x10909090, 0x10909091, 0x21212121, 1  );
  TEST_W_AVG_WV_OP(14, vnclipu.wv, 0x00424242, 0x00424242, 0x00424242, 0x00424243, 0x21212121, 7  );
  TEST_W_AVG_WV_OP(15, vnclipu.wv, 0x00008485, 0x00008485, 0x00008484, 0x00008485, 0x21212121, 14 );
  TEST_W_AVG_WV_OP(16, vnclipu.wv, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x21212121, 31 );
	
  #-------------------------------------------------------------
  # wx Tests
  #-------------------------------------------------------------

  TEST_W_AVG_WX_OP(17, vnclipu.wx, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0  );
  TEST_W_AVG_WX_OP(18, vnclipu.wx, 0x40000000, 0x40000000, 0x40000000, 0x40000000, 0x80000000, 1  );
  TEST_W_AVG_WX_OP(19, vnclipu.wx, 0x01000000, 0x01000000, 0x01000000, 0x01000000, 0x80000000, 7  );
  TEST_W_AVG_WX_OP(20, vnclipu.wx, 0x00020000, 0x00020000, 0x00020000, 0x00020000, 0x80000000, 14 );
  TEST_W_AVG_WX_OP(21, vnclipu.wx, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x80000000, 31 );
  
  TEST_W_AVG_WX_OP(22, vnclipu.wx, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0  );
  TEST_W_AVG_WX_OP(23, vnclipu.wx, 0x80000000, 0x80000000, 0x7fffffff, 0x7fffffff, 0xffffffff, 1  );
  TEST_W_AVG_WX_OP(24, vnclipu.wx, 0x02000000, 0x02000000, 0x01ffffff, 0x01ffffff, 0xffffffff, 7  );
  TEST_W_AVG_WX_OP(25, vnclipu.wx, 0x00040000, 0x00040000, 0x0003ffff, 0x0003ffff, 0xffffffff, 14 );
  TEST_W_AVG_WX_OP(26, vnclipu.wx, 0x00000002, 0x00000002, 0x00000001, 0x00000001, 0xffffffff, 31 );

  TEST_W_AVG_WX_OP(27, vnclipu.wx, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0  );
  TEST_W_AVG_WX_OP(28, vnclipu.wx, 0x10909091, 0x10909090, 0x10909090, 0x10909091, 0x21212121, 1  );
  TEST_W_AVG_WX_OP(29, vnclipu.wx, 0x00424242, 0x00424242, 0x00424242, 0x00424243, 0x21212121, 7  );
  TEST_W_AVG_WX_OP(30, vnclipu.wx, 0x00008485, 0x00008485, 0x00008484, 0x00008485, 0x21212121, 14 );
  TEST_W_AVG_WX_OP(31, vnclipu.wx, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x21212121, 31 );

  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_W_AVG_WI_OP(32, vnclipu.wi, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0  );
  TEST_W_AVG_WI_OP(33, vnclipu.wi, 0x40000000, 0x40000000, 0x40000000, 0x40000000, 0x80000000, 1  );
  TEST_W_AVG_WI_OP(34, vnclipu.wi, 0x01000000, 0x01000000, 0x01000000, 0x01000000, 0x80000000, 7  );
  TEST_W_AVG_WI_OP(35, vnclipu.wi, 0x00020000, 0x00020000, 0x00020000, 0x00020000, 0x80000000, 14 );
  TEST_W_AVG_WI_OP(36, vnclipu.wi, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x80000000, 31 );
  
  TEST_W_AVG_WI_OP(37, vnclipu.wi, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0  );
  TEST_W_AVG_WI_OP(38, vnclipu.wi, 0x80000000, 0x80000000, 0x7fffffff, 0x7fffffff, 0xffffffff, 1  );
  TEST_W_AVG_WI_OP(39, vnclipu.wi, 0x02000000, 0x02000000, 0x01ffffff, 0x01ffffff, 0xffffffff, 7  );
  TEST_W_AVG_WI_OP(40, vnclipu.wi, 0x00040000, 0x00040000, 0x0003ffff, 0x0003ffff, 0xffffffff, 14 );
  TEST_W_AVG_WI_OP(41, vnclipu.wi, 0x00000002, 0x00000002, 0x00000001, 0x00000001, 0xffffffff, 31 );

  TEST_W_AVG_WI_OP(42, vnclipu.wi, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0  );
  TEST_W_AVG_WI_OP(43, vnclipu.wi, 0x10909091, 0x10909090, 0x10909090, 0x10909091, 0x21212121, 1  );
  TEST_W_AVG_WI_OP(44, vnclipu.wi, 0x00424242, 0x00424242, 0x00424242, 0x00424243, 0x21212121, 7  );
  TEST_W_AVG_WI_OP(45, vnclipu.wi, 0x00008485, 0x00008485, 0x00008484, 0x00008485, 0x21212121, 14 );
  TEST_W_AVG_WI_OP(46, vnclipu.wi, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x21212121, 31 );
	
#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

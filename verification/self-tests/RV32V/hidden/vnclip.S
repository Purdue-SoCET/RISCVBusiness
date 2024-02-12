# See LICENSE for license details.

#*****************************************************************************
# vnclip.S
#-----------------------------------------------------------------------------
#
# Test vnclip instructions.
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

  TEST_W_AVG_WV_OP( 2, vnclip.wv, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x80000000, 0  );
  TEST_W_AVG_WV_OP( 3, vnclip.wv, 0x40000000, 0x40000000, 0x40000000, 0x40000000, 0x80000000, 1  );
  TEST_W_AVG_WV_OP( 4, vnclip.wv, 0x01000000, 0x01000000, 0x01000000, 0x01000000, 0x80000000, 7  );
  TEST_W_AVG_WV_OP( 5, vnclip.wv, 0x00020000, 0x00020000, 0x00020000, 0x00020000, 0x80000000, 14 );
  TEST_W_AVG_WV_OP( 6, vnclip.wv, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x80000000, 31 );
  
  TEST_W_AVG_WV_OP( 7, vnclip.wv, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0xffffffff, 0  );
  TEST_W_AVG_WV_OP( 8, vnclip.wv, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0xffffffff, 1  );
  TEST_W_AVG_WV_OP( 9, vnclip.wv, 0x02000000, 0x02000000, 0x01ffffff, 0x01ffffff, 0xffffffff, 7  );
  TEST_W_AVG_WV_OP(10, vnclip.wv, 0x00040000, 0x00040000, 0x0003ffff, 0x0003ffff, 0xffffffff, 14 );
  TEST_W_AVG_WV_OP(11, vnclip.wv, 0x00000002, 0x00000002, 0x00000001, 0x00000001, 0xffffffff, 31 );

  TEST_W_AVG_WV_OP(12, vnclip.wv, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0  );
  TEST_W_AVG_WV_OP(13, vnclip.wv, 0x10909091, 0x10909090, 0x10909090, 0x10909091, 0x21212121, 1  );
  TEST_W_AVG_WV_OP(14, vnclip.wv, 0x00424242, 0x00424242, 0x00424242, 0x00424243, 0x21212121, 7  );
  TEST_W_AVG_WV_OP(15, vnclip.wv, 0x00008485, 0x00008485, 0x00008484, 0x00008485, 0x21212121, 14 );
  TEST_W_AVG_WV_OP(16, vnclip.wv, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x21212121, 31 );
	
  #-------------------------------------------------------------
  # wx Tests
  #-------------------------------------------------------------

  TEST_W_AVG_WX_OP(17, vnclip.wx, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x80000000, 0  );
  TEST_W_AVG_WX_OP(18, vnclip.wx, 0x40000000, 0x40000000, 0x40000000, 0x40000000, 0x80000000, 1  );
  TEST_W_AVG_WX_OP(19, vnclip.wx, 0x01000000, 0x01000000, 0x01000000, 0x01000000, 0x80000000, 7  );
  TEST_W_AVG_WX_OP(20, vnclip.wx, 0x00020000, 0x00020000, 0x00020000, 0x00020000, 0x80000000, 14 );
  TEST_W_AVG_WX_OP(21, vnclip.wx, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x80000000, 31 );
  
  TEST_W_AVG_WX_OP(22, vnclip.wx, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0xffffffff, 0  );
  TEST_W_AVG_WX_OP(23, vnclip.wx, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0xffffffff, 1  );
  TEST_W_AVG_WX_OP(24, vnclip.wx, 0x02000000, 0x02000000, 0x01ffffff, 0x01ffffff, 0xffffffff, 7  );
  TEST_W_AVG_WX_OP(25, vnclip.wx, 0x00040000, 0x00040000, 0x0003ffff, 0x0003ffff, 0xffffffff, 14 );
  TEST_W_AVG_WX_OP(26, vnclip.wx, 0x00000002, 0x00000002, 0x00000001, 0x00000001, 0xffffffff, 31 );

  TEST_W_AVG_WX_OP(27, vnclip.wx, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0  );
  TEST_W_AVG_WX_OP(28, vnclip.wx, 0x10909091, 0x10909090, 0x10909090, 0x10909091, 0x21212121, 1  );
  TEST_W_AVG_WX_OP(29, vnclip.wx, 0x00424242, 0x00424242, 0x00424242, 0x00424243, 0x21212121, 7  );
  TEST_W_AVG_WX_OP(30, vnclip.wx, 0x00008485, 0x00008485, 0x00008484, 0x00008485, 0x21212121, 14 );
  TEST_W_AVG_WX_OP(31, vnclip.wx, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x21212121, 31 );

  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_W_AVG_WI_OP(32, vnclip.wi, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x80000000, 0  );
  TEST_W_AVG_WI_OP(33, vnclip.wi, 0x40000000, 0x40000000, 0x40000000, 0x40000000, 0x80000000, 1  );
  TEST_W_AVG_WI_OP(34, vnclip.wi, 0x01000000, 0x01000000, 0x01000000, 0x01000000, 0x80000000, 7  );
  TEST_W_AVG_WI_OP(35, vnclip.wi, 0x00020000, 0x00020000, 0x00020000, 0x00020000, 0x80000000, 14 );
  TEST_W_AVG_WI_OP(36, vnclip.wi, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x80000000, 31 );
  
  TEST_W_AVG_WI_OP(37, vnclip.wi, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0xffffffff, 0  );
  TEST_W_AVG_WI_OP(38, vnclip.wi, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, 0xffffffff, 1  );
  TEST_W_AVG_WI_OP(39, vnclip.wi, 0x02000000, 0x02000000, 0x01ffffff, 0x01ffffff, 0xffffffff, 7  );
  TEST_W_AVG_WI_OP(40, vnclip.wi, 0x00040000, 0x00040000, 0x0003ffff, 0x0003ffff, 0xffffffff, 14 );
  TEST_W_AVG_WI_OP(41, vnclip.wi, 0x00000002, 0x00000002, 0x00000001, 0x00000001, 0xffffffff, 31 );

  TEST_W_AVG_WI_OP(42, vnclip.wi, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0  );
  TEST_W_AVG_WI_OP(43, vnclip.wi, 0x10909091, 0x10909090, 0x10909090, 0x10909091, 0x21212121, 1  );
  TEST_W_AVG_WI_OP(44, vnclip.wi, 0x00424242, 0x00424242, 0x00424242, 0x00424243, 0x21212121, 7  );
  TEST_W_AVG_WI_OP(45, vnclip.wi, 0x00008485, 0x00008485, 0x00008484, 0x00008485, 0x21212121, 14 );
  TEST_W_AVG_WI_OP(46, vnclip.wi, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x21212121, 31 );
	
#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

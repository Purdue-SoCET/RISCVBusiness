# See LICENSE for license details.

#*****************************************************************************
# vssrl.S
#-----------------------------------------------------------------------------
#
# Test vssrl instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

#if __riscv_vsew == 32

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2, vssrl.vv, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0  );
  TEST_AVG_VV_OP( 3, vssrl.vv, 0x40000000, 0x40000000, 0x40000000, 0x40000000, 0x80000000, 1  );
  TEST_AVG_VV_OP( 4, vssrl.vv, 0x01000000, 0x01000000, 0x01000000, 0x01000000, 0x80000000, 7  );
  TEST_AVG_VV_OP( 5, vssrl.vv, 0x00020000, 0x00020000, 0x00020000, 0x00020000, 0x80000000, 14 );
  TEST_AVG_VV_OP( 6, vssrl.vv, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x80000000, 31 );
  
  TEST_AVG_VV_OP( 7, vssrl.vv, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0  );
  TEST_AVG_VV_OP( 8, vssrl.vv, 0x80000000, 0x80000000, 0x7fffffff, 0x7fffffff, 0xffffffff, 1  );
  TEST_AVG_VV_OP( 9, vssrl.vv, 0x02000000, 0x02000000, 0x01ffffff, 0x01ffffff, 0xffffffff, 7  );
  TEST_AVG_VV_OP(10, vssrl.vv, 0x00040000, 0x00040000, 0x0003ffff, 0x0003ffff, 0xffffffff, 14 );
  TEST_AVG_VV_OP(11, vssrl.vv, 0x00000002, 0x00000002, 0x00000001, 0x00000001, 0xffffffff, 31 );

  TEST_AVG_VV_OP(12, vssrl.vv, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0  );
  TEST_AVG_VV_OP(13, vssrl.vv, 0x10909091, 0x10909090, 0x10909090, 0x10909091, 0x21212121, 1  );
  TEST_AVG_VV_OP(14, vssrl.vv, 0x00424242, 0x00424242, 0x00424242, 0x00424243, 0x21212121, 7  );
  TEST_AVG_VV_OP(15, vssrl.vv, 0x00008485, 0x00008485, 0x00008484, 0x00008485, 0x21212121, 14 );
  TEST_AVG_VV_OP(16, vssrl.vv, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x21212121, 31 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP(17, vssrl.vx, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0  );
  TEST_AVG_VX_OP(18, vssrl.vx, 0x40000000, 0x40000000, 0x40000000, 0x40000000, 0x80000000, 1  );
  TEST_AVG_VX_OP(19, vssrl.vx, 0x01000000, 0x01000000, 0x01000000, 0x01000000, 0x80000000, 7  );
  TEST_AVG_VX_OP(20, vssrl.vx, 0x00020000, 0x00020000, 0x00020000, 0x00020000, 0x80000000, 14 );
  TEST_AVG_VX_OP(21, vssrl.vx, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x80000000, 31 );
  
  TEST_AVG_VX_OP(22, vssrl.vx, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0  );
  TEST_AVG_VX_OP(23, vssrl.vx, 0x80000000, 0x80000000, 0x7fffffff, 0x7fffffff, 0xffffffff, 1  );
  TEST_AVG_VX_OP(24, vssrl.vx, 0x02000000, 0x02000000, 0x01ffffff, 0x01ffffff, 0xffffffff, 7  );
  TEST_AVG_VX_OP(25, vssrl.vx, 0x00040000, 0x00040000, 0x0003ffff, 0x0003ffff, 0xffffffff, 14 );
  TEST_AVG_VX_OP(26, vssrl.vx, 0x00000002, 0x00000002, 0x00000001, 0x00000001, 0xffffffff, 31 );

  TEST_AVG_VX_OP(27, vssrl.vx, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0  );
  TEST_AVG_VX_OP(28, vssrl.vx, 0x10909091, 0x10909090, 0x10909090, 0x10909091, 0x21212121, 1  );
  TEST_AVG_VX_OP(29, vssrl.vx, 0x00424242, 0x00424242, 0x00424242, 0x00424243, 0x21212121, 7  );
  TEST_AVG_VX_OP(30, vssrl.vx, 0x00008485, 0x00008485, 0x00008484, 0x00008485, 0x21212121, 14 );
  TEST_AVG_VX_OP(31, vssrl.vx, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x21212121, 31 );

  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_AVG_VI_OP(32, vssrl.vi, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0x80000000, 0  );
  TEST_AVG_VI_OP(33, vssrl.vi, 0x40000000, 0x40000000, 0x40000000, 0x40000000, 0x80000000, 1  );
  TEST_AVG_VI_OP(34, vssrl.vi, 0x01000000, 0x01000000, 0x01000000, 0x01000000, 0x80000000, 7  );
  TEST_AVG_VI_OP(35, vssrl.vi, 0x00020000, 0x00020000, 0x00020000, 0x00020000, 0x80000000, 14 );
  TEST_AVG_VI_OP(36, vssrl.vi, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x80000000, 31 );
  
  TEST_AVG_VI_OP(37, vssrl.vi, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0  );
  TEST_AVG_VI_OP(38, vssrl.vi, 0x80000000, 0x80000000, 0x7fffffff, 0x7fffffff, 0xffffffff, 1  );
  TEST_AVG_VI_OP(39, vssrl.vi, 0x02000000, 0x02000000, 0x01ffffff, 0x01ffffff, 0xffffffff, 7  );
  TEST_AVG_VI_OP(40, vssrl.vi, 0x00040000, 0x00040000, 0x0003ffff, 0x0003ffff, 0xffffffff, 14 );
  TEST_AVG_VI_OP(41, vssrl.vi, 0x00000002, 0x00000002, 0x00000001, 0x00000001, 0xffffffff, 31 );

  TEST_AVG_VI_OP(42, vssrl.vi, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0x21212121, 0  );
  TEST_AVG_VI_OP(43, vssrl.vi, 0x10909091, 0x10909090, 0x10909090, 0x10909091, 0x21212121, 1  );
  TEST_AVG_VI_OP(44, vssrl.vi, 0x00424242, 0x00424242, 0x00424242, 0x00424243, 0x21212121, 7  );
  TEST_AVG_VI_OP(45, vssrl.vi, 0x00008485, 0x00008485, 0x00008484, 0x00008485, 0x21212121, 14 );
  TEST_AVG_VI_OP(46, vssrl.vi, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x21212121, 31 );
	
#endif

#if __riscv_vsew == 64

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2, vssrl.vv, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_AVG_VV_OP( 3, vssrl.vv, 0x7fffffffc0000000, 0x7fffffffc0000000, 0x7fffffffc0000000, 0x7fffffffc0000000, 0xffffffff80000000, 1  );
  TEST_AVG_VV_OP( 4, vssrl.vv, 0x01ffffffff000000, 0x01ffffffff000000, 0x01ffffffff000000, 0x01ffffffff000000, 0xffffffff80000000, 7  );
  TEST_AVG_VV_OP( 5, vssrl.vv, 0x0003fffffffe0000, 0x0003fffffffe0000, 0x0003fffffffe0000, 0x0003fffffffe0000, 0xffffffff80000000, 14 );
  TEST_AVG_VV_OP( 6, vssrl.vv, 0x00000001ffffffff, 0x00000001ffffffff, 0x00000001ffffffff, 0x00000001ffffffff, 0xffffffff80000000, 31 );
  
  TEST_AVG_VV_OP( 7, vssrl.vv, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_AVG_VV_OP( 8, vssrl.vv, 0x8000000000000000, 0x8000000000000000, 0x7fffffffffffffff, 0x7fffffffffffffff, 0xffffffffffffffff, 1  );
  TEST_AVG_VV_OP( 9, vssrl.vv, 0x0200000000000000, 0x0200000000000000, 0x01ffffffffffffff, 0x01ffffffffffffff, 0xffffffffffffffff, 7  );
  TEST_AVG_VV_OP(10, vssrl.vv, 0x0004000000000000, 0x0004000000000000, 0x0003ffffffffffff, 0x0003ffffffffffff, 0xffffffffffffffff, 14 );
  TEST_AVG_VV_OP(11, vssrl.vv, 0x0000000200000000, 0x0000000200000000, 0x00000001ffffffff, 0x00000001ffffffff, 0xffffffffffffffff, 31 );

  TEST_AVG_VV_OP(12, vssrl.vv, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_AVG_VV_OP(13, vssrl.vv, 0x0000000010909091, 0x0000000010909090, 0x0000000010909090, 0x0000000010909091, 0x0000000021212121, 1  );
  TEST_AVG_VV_OP(14, vssrl.vv, 0x0000000000424242, 0x0000000000424242, 0x0000000000424242, 0x0000000000424243, 0x0000000021212121, 7  );
  TEST_AVG_VV_OP(15, vssrl.vv, 0x0000000000008485, 0x0000000000008485, 0x0000000000008484, 0x0000000000008485, 0x0000000021212121, 14 );
  TEST_AVG_VV_OP(16, vssrl.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001, 0x0000000021212121, 31 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP(17, vssrl.vx, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_AVG_VX_OP(18, vssrl.vx, 0x7fffffffc0000000, 0x7fffffffc0000000, 0x7fffffffc0000000, 0x7fffffffc0000000, 0xffffffff80000000, 1  );
  TEST_AVG_VX_OP(19, vssrl.vx, 0x01ffffffff000000, 0x01ffffffff000000, 0x01ffffffff000000, 0x01ffffffff000000, 0xffffffff80000000, 7  );
  TEST_AVG_VX_OP(20, vssrl.vx, 0x0003fffffffe0000, 0x0003fffffffe0000, 0x0003fffffffe0000, 0x0003fffffffe0000, 0xffffffff80000000, 14 );
  TEST_AVG_VX_OP(21, vssrl.vx, 0x00000001ffffffff, 0x00000001ffffffff, 0x00000001ffffffff, 0x00000001ffffffff, 0xffffffff80000000, 31 );

  TEST_AVG_VX_OP(22, vssrl.vx, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_AVG_VX_OP(23, vssrl.vx, 0x8000000000000000, 0x8000000000000000, 0x7fffffffffffffff, 0x7fffffffffffffff, 0xffffffffffffffff, 1  );
  TEST_AVG_VX_OP(24, vssrl.vx, 0x0200000000000000, 0x0200000000000000, 0x01ffffffffffffff, 0x01ffffffffffffff, 0xffffffffffffffff, 7  );
  TEST_AVG_VX_OP(25, vssrl.vx, 0x0004000000000000, 0x0004000000000000, 0x0003ffffffffffff, 0x0003ffffffffffff, 0xffffffffffffffff, 14 );
  TEST_AVG_VX_OP(26, vssrl.vx, 0x0000000200000000, 0x0000000200000000, 0x00000001ffffffff, 0x00000001ffffffff, 0xffffffffffffffff, 31 );

  TEST_AVG_VX_OP(27, vssrl.vx, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_AVG_VX_OP(28, vssrl.vx, 0x0000000010909091, 0x0000000010909090, 0x0000000010909090, 0x0000000010909091, 0x0000000021212121, 1  );
  TEST_AVG_VX_OP(29, vssrl.vx, 0x0000000000424242, 0x0000000000424242, 0x0000000000424242, 0x0000000000424243, 0x0000000021212121, 7  );
  TEST_AVG_VX_OP(30, vssrl.vx, 0x0000000000008485, 0x0000000000008485, 0x0000000000008484, 0x0000000000008485, 0x0000000021212121, 14 );
  TEST_AVG_VX_OP(31, vssrl.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001, 0x0000000021212121, 31 );

  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_AVG_VI_OP(32, vssrl.vi, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_AVG_VI_OP(33, vssrl.vi, 0x7fffffffc0000000, 0x7fffffffc0000000, 0x7fffffffc0000000, 0x7fffffffc0000000, 0xffffffff80000000, 1  );
  TEST_AVG_VI_OP(34, vssrl.vi, 0x01ffffffff000000, 0x01ffffffff000000, 0x01ffffffff000000, 0x01ffffffff000000, 0xffffffff80000000, 7  );
  TEST_AVG_VI_OP(35, vssrl.vi, 0x0003fffffffe0000, 0x0003fffffffe0000, 0x0003fffffffe0000, 0x0003fffffffe0000, 0xffffffff80000000, 14 );
  TEST_AVG_VI_OP(36, vssrl.vi, 0x00000001ffffffff, 0x00000001ffffffff, 0x00000001ffffffff, 0x00000001ffffffff, 0xffffffff80000000, 31 );
  
  TEST_AVG_VI_OP(37, vssrl.vi, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_AVG_VI_OP(38, vssrl.vi, 0x8000000000000000, 0x8000000000000000, 0x7fffffffffffffff, 0x7fffffffffffffff, 0xffffffffffffffff, 1  );
  TEST_AVG_VI_OP(39, vssrl.vi, 0x0200000000000000, 0x0200000000000000, 0x01ffffffffffffff, 0x01ffffffffffffff, 0xffffffffffffffff, 7  );
  TEST_AVG_VI_OP(40, vssrl.vi, 0x0004000000000000, 0x0004000000000000, 0x0003ffffffffffff, 0x0003ffffffffffff, 0xffffffffffffffff, 14 );
  TEST_AVG_VI_OP(41, vssrl.vi, 0x0000000200000000, 0x0000000200000000, 0x00000001ffffffff, 0x00000001ffffffff, 0xffffffffffffffff, 31 );

  TEST_AVG_VI_OP(42, vssrl.vi, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_AVG_VI_OP(43, vssrl.vi, 0x0000000010909091, 0x0000000010909090, 0x0000000010909090, 0x0000000010909091, 0x0000000021212121, 1  );
  TEST_AVG_VI_OP(44, vssrl.vi, 0x0000000000424242, 0x0000000000424242, 0x0000000000424242, 0x0000000000424243, 0x0000000021212121, 7  );
  TEST_AVG_VI_OP(45, vssrl.vi, 0x0000000000008485, 0x0000000000008485, 0x0000000000008484, 0x0000000000008485, 0x0000000021212121, 14 );
  TEST_AVG_VI_OP(46, vssrl.vi, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001, 0x0000000021212121, 31 );

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

# See LICENSE for license details.

#*****************************************************************************
# vsrl.S
#-----------------------------------------------------------------------------
#
# Test vsrl/vnsrl instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

#define TEST_SRLVV(n, v, a) \
  TEST_VV_OP(n, vsrl.vv, ((v) & ((1 << (__riscv_vsew-1) << 1) - 1)) >> (a), v, a)

#define TEST_SRLVX(n, v, a) \
  TEST_VX_OP(n, vsrl.vx, ((v) & ((1 << (__riscv_vsew-1) << 1) - 1)) >> (a), v, a)

#define TEST_SRLVI(n, v, a) \
  TEST_VI_OP(n, vsrl.vi, ((v) & ((1 << (__riscv_vsew-1) << 1) - 1)) >> (a), v, a)	

#define TEST_SRLWV(n, v, a) \
  TEST_VV_OP(n, vnsrl.wv, ((v) & ((1 << (__riscv_vsew-1) << 1) - 1)) >> (a), v, a)

#define TEST_SRLWX(n, v, a) \
  TEST_VX_OP(n, vnsrl.wx, ((v) & ((1 << (__riscv_vsew-1) << 1) - 1)) >> (a), v, a)

#define TEST_SRLWI(n, v, a) \
  TEST_VI_OP(n, vnsrl.wi, ((v) & ((1 << (__riscv_vsew-1) << 1) - 1)) >> (a), v, a)	

	
  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------	

  TEST_SRLVV( 2,  0xffffffff80000000, 0  );
  TEST_SRLVV( 3,  0xffffffff80000000, 1  );
  TEST_SRLVV( 4,  0xffffffff80000000, 7  );
  TEST_SRLVV( 5,  0xffffffff80000000, 14 );
  TEST_SRLVV( 6,  0xffffffff80000001, 31 );

  TEST_SRLVV( 7,  0xffffffffffffffff, 0  );
  TEST_SRLVV( 8,  0xffffffffffffffff, 1  );
  TEST_SRLVV( 9,  0xffffffffffffffff, 7  );
  TEST_SRLVV( 10, 0xffffffffffffffff, 14 );
  TEST_SRLVV( 11, 0xffffffffffffffff, 31 );

  TEST_SRLVV( 12, 0x0000000021212121, 0  );
  TEST_SRLVV( 13, 0x0000000021212121, 1  );
  TEST_SRLVV( 14, 0x0000000021212121, 7  );
  TEST_SRLVV( 15, 0x0000000021212121, 14 );
  TEST_SRLVV( 16, 0x0000000021212121, 31 );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------	

  TEST_SRLVX( 17, 0xffffffff80000000, 0  );
  TEST_SRLVX( 18, 0xffffffff80000000, 1  );
  TEST_SRLVX( 19, 0xffffffff80000000, 7  );
  TEST_SRLVX( 20, 0xffffffff80000000, 14 );
  TEST_SRLVX( 21, 0xffffffff80000001, 31 );

  TEST_SRLVX( 22, 0xffffffffffffffff, 0  );
  TEST_SRLVX( 23, 0xffffffffffffffff, 1  );
  TEST_SRLVX( 24, 0xffffffffffffffff, 7  );
  TEST_SRLVX( 25, 0xffffffffffffffff, 14 );
  TEST_SRLVX( 26, 0xffffffffffffffff, 31 );

  TEST_SRLVX( 27, 0x0000000021212121, 0  );
  TEST_SRLVX( 28, 0x0000000021212121, 1  );
  TEST_SRLVX( 29, 0x0000000021212121, 7  );
  TEST_SRLVX( 30, 0x0000000021212121, 14 );
  TEST_SRLVX( 31, 0x0000000021212121, 31 );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------	

  TEST_SRLVI( 32, 0xffffffff80000000, 0  );
  TEST_SRLVI( 33, 0xffffffff80000000, 1  );
  TEST_SRLVI( 34, 0xffffffff80000000, 7  );
  TEST_SRLVI( 35, 0xffffffff80000000, 14 );

  TEST_SRLVI( 36, 0xffffffffffffffff, 0  );
  TEST_SRLVI( 37, 0xffffffffffffffff, 1  );
  TEST_SRLVI( 38, 0xffffffffffffffff, 7  );
  TEST_SRLVI( 39, 0xffffffffffffffff, 14 );

  TEST_SRLVI( 40, 0x0000000021212121, 0  );
  TEST_SRLVI( 41, 0x0000000021212121, 1  );
  TEST_SRLVI( 42, 0x0000000021212121, 7  );
  TEST_SRLVI( 43, 0x0000000021212121, 14 );

#if __riscv_vsew <= 32

  #-------------------------------------------------------------
  # WV tests
  #-------------------------------------------------------------	

  TEST_SRLWV( 44, 0xffffffff80000000, 0  );
  TEST_SRLWV( 45, 0xffffffff80000000, 1  );
  TEST_SRLWV( 46, 0xffffffff80000000, 7  );
  TEST_SRLWV( 47, 0xffffffff80000000, 14 );
  TEST_SRLWV( 48, 0xffffffff80000001, 31 );

  TEST_SRLWV( 49, 0xffffffffffffffff, 0  );
  TEST_SRLWV( 50, 0xffffffffffffffff, 1  );
  TEST_SRLWV( 51, 0xffffffffffffffff, 7  );
  TEST_SRLWV( 52, 0xffffffffffffffff, 14 );
  TEST_SRLWV( 53, 0xffffffffffffffff, 31 );

  TEST_SRLWV( 54, 0x0000000021212121, 0  );
  TEST_SRLWV( 55, 0x0000000021212121, 1  );
  TEST_SRLWV( 56, 0x0000000021212121, 7  );
  TEST_SRLWV( 57, 0x0000000021212121, 14 );
  TEST_SRLWV( 58, 0x0000000021212121, 31 );

  #-----------------------------------------------------------
  # WX tests
  #-----------------------------------------------------------	

  TEST_SRLWX( 59, 0xffffffff80000000, 0  );
  TEST_SRLWX( 60, 0xffffffff80000000, 1  );
  TEST_SRLWX( 61, 0xffffffff80000000, 7  );
  TEST_SRLWX( 62, 0xffffffff80000000, 14 );
  TEST_SRLWX( 63, 0xffffffff80000001, 31 );

  TEST_SRLWX( 64, 0xffffffffffffffff, 0  );
  TEST_SRLWX( 65, 0xffffffffffffffff, 1  );
  TEST_SRLWX( 66, 0xffffffffffffffff, 7  );
  TEST_SRLWX( 67, 0xffffffffffffffff, 14 );
  TEST_SRLWX( 68, 0xffffffffffffffff, 31 );

  TEST_SRLWX( 69, 0x0000000021212121, 0  );
  TEST_SRLWX( 70, 0x0000000021212121, 1  );
  TEST_SRLWX( 71, 0x0000000021212121, 7  );
  TEST_SRLWX( 72, 0x0000000021212121, 14 );
  TEST_SRLWX( 73, 0x0000000021212121, 31 );

  #-----------------------------------------------------------
  # WI tests
  #-----------------------------------------------------------	

  TEST_SRLWI( 74, 0xffffffff80000000, 0  );
  TEST_SRLWI( 75, 0xffffffff80000000, 1  );
  TEST_SRLWI( 76, 0xffffffff80000000, 7  );
  TEST_SRLWI( 77, 0xffffffff80000000, 14 );

  TEST_SRLWI( 78, 0xffffffffffffffff, 0  );
  TEST_SRLWI( 79, 0xffffffffffffffff, 1  );
  TEST_SRLWI( 80, 0xffffffffffffffff, 7  );
  TEST_SRLWI( 81, 0xffffffffffffffff, 14 );

  TEST_SRLWI( 82, 0x0000000021212121, 0  );
  TEST_SRLWI( 83, 0x0000000021212121, 1  );
  TEST_SRLWI( 84, 0x0000000021212121, 7  );
  TEST_SRLWI( 85, 0x0000000021212121, 14 );

#endif
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

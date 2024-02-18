# See LICENSE for license details.

#*****************************************************************************
# and.S multithreaded version
#-----------------------------------------------------------------------------
#
# Test and instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

# -------------------------------------------------------------
# THREAD ONE BEGINS
# -------------------------------------------------------------

RVTEST_THREAD_ONE_BEGIN


RVTEST_THREAD_ONE_END

# -------------------------------------------------------------
# THREAD TWO BEGINS
# -------------------------------------------------------------

RVTEST_THREAD_TWO_BEGIN


RVTEST_THREAD_TWO_END

# -------------------------------------------------------------
# THREAD THREE  BEGINS
# -------------------------------------------------------------
RVTEST_THREAD_THREE_BEGIN

RVTEST_THREAD_THREE_END

RVTEST_THREAD_WAIT

TEST_PASSFAIL
RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

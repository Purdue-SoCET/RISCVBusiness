#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

    # Record original MISA value
    csrr x1, misa

    # Make a bad value for MISA
    ori x2, x0, -1

    # Attempt to write, read back
    csrw misa, x2
    csrr x2, misa

    bne x1, x2, failure

    # Attempt to write a good value to MISA - Enable "A" extension
    csrr x2, misa
    ori x2, x2, 0x1
    csrw misa, x2
    csrr x1, misa

    bne x1, x2, failure

    RVTEST_PASS

failure:
    RVTEST_FAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

#include <stdint.h>
#include "csr.h"
#include "format.h"
#include "utility.h"
#include "pmp_util.h"

/*
*  Validate PMP CSR handling including WARL behavior,
*  accounting for PMP granularity
*/

int main() {
    flag = 9;

    uint32_t pmp_addr = 0xDEADBEEF;
    uint32_t expected = ADDR_G_NO_SHIFT_2(0xDEADBEEF, G);
    CSRW("pmpaddr0", pmp_addr);
    pmp_addr = 0x0;
    pmp_addr = CSRR("pmpaddr0");
    if (pmp_addr == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 0 wrong value\n");
        print("Expected: %x\n", expected);
        print("Got: %x\n", pmp_addr);
    }

    uint32_t pmp_cfg = 0x00170017;
    expected = G == 0 ? 0x00170017 : 0x001F001F;
    CSRW("pmpcfg0", pmp_cfg);
    pmp_cfg = 0x0;
    pmp_cfg = CSRR("pmpcfg0");
    if (pmp_cfg == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 1 wrong value\n");
        print("Expected: %x\n", expected);
        print("Got: %x\n", pmp_cfg);
    }

    pmp_cfg = 0x001A0027;
    expected = 0x00180007;
    CSRW("pmpcfg1", pmp_cfg);
    pmp_cfg = 0x0;
    pmp_cfg = CSRR("pmpcfg1");
    if (pmp_cfg == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 2 wrong value\n");
        print("Expected: %x\n", expected);
        print("Got: %x\n", pmp_cfg);
    }

    pmp_cfg = 0x00000088;
    expected = 0x00000088;
    CSRW("pmpcfg2", pmp_cfg);
    pmp_cfg = 0x00000007;
    CSRS("pmpcfg2", pmp_cfg);
    pmp_cfg = 0x0;
    pmp_cfg = CSRR("pmpcfg2");
    if (pmp_cfg == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 3.0 wrong value\n");
        print("Expected: %x\n", expected);
        print("Got: %x\n", pmp_cfg);
    }
    pmp_cfg = 0x00070000;
    expected = 0x00070088;
    CSRS("pmpcfg2", pmp_cfg);
    pmp_cfg = 0x0;
    pmp_cfg = CSRR("pmpcfg2");
    if (pmp_cfg == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 3.2 wrong value\n");
        print("Expected: %x\n", expected);
        print("Got: %x\n", pmp_cfg);
    }

    pmp_addr = 0xDEADBEEF;
    expected = 0x00000000;
    CSRW("pmpaddr8", pmp_addr);
    pmp_addr = 0x0;
    pmp_addr = CSRR("pmpaddr8");
    if (pmp_addr == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 4.0 wrong value\n");
        print("Expected: %x\n", expected);
        print("Got: %x\n", pmp_addr);
    }
    pmp_addr = 0xDEADBEEF;
    expected = 0x00000000;
    CSRW("pmpaddr7", pmp_addr);
    pmp_addr = 0x0;
    pmp_addr = CSRR("pmpaddr7");
    if (pmp_addr == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 4.2 wrong value\n");
        print("Expected: %x\n", expected);
        print("Got: %x\n", pmp_addr);
    }
    pmp_addr = 0xDEADBEEF;
    expected = ADDR_G_NO_SHIFT_2(0xDEADBEEF, G);
    CSRW("pmpaddr9", pmp_addr);
    pmp_addr = 0x0;
    pmp_addr = CSRR("pmpaddr9");
    if (pmp_addr == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 4.4 wrong value\n");
        print("Expected: %x\n", expected);
        print("Got: %x\n", pmp_addr);
    }

    if (flag == 1) {
        test_pass("PMP CSR test");
    } else {
        test_fail("PMP CSR test");
    }

    return 0;
}

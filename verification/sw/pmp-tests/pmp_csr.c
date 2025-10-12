#include <stdint.h>
#include "utility.h"
#include "pmp_util.h"

int main() {
    flag = 9;

    // 0.0 Try to write a valid value to the pmpaddr0 register
    uint32_t pmp_addr = 0xDEADBEEF;
    uint32_t expected = ADDR_G_NO_SHIFT_2(0xDEADBEEF, G);
    asm volatile("csrw pmpaddr0, %0" : : "r"(pmp_addr));
    // 0.0 Read the value back
    pmp_addr = 0x0;
    asm volatile("csrr %0, pmpaddr0" : "=r"(pmp_addr));
    if (pmp_addr == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 0 wrong value\n");
        print("Expected: ");
        put_uint32_hex(expected);
        print("Got: ");
        put_uint32_hex(pmp_addr);
    }

    // 1.0 Try to write a valid configuration to the pmpcfg0 register
    uint32_t pmp_cfg = 0x00170017;
    expected = G == 0 ? 0x00170017 : 0x001F001F;
    asm volatile("csrw pmpcfg0, %0" : : "r"(pmp_cfg));
    // 1.1 Read the value back
    pmp_cfg = 0x0;
    asm volatile("csrr %0, pmpcfg0" : "=r"(pmp_cfg));
    if (pmp_cfg == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 1 wrong value\n");
        print("Expected: ");
        put_uint32_hex(expected);
        print("Got: ");
        put_uint32_hex(pmp_cfg);
    }

    // 2.0 Try to write an invalid configuration to the pmpcfg1 register
    pmp_cfg = 0x001A0027; // pmp4cfg has a non-0 reserved field, pmp6cfg has an invalid permission
    expected = 0x00180007;
    asm volatile("csrw pmpcfg1, %0" : : "r"(pmp_cfg));
    // 2.1 Read the value back
    pmp_cfg = 0x0;
    asm volatile("csrr %0, pmpcfg1" : "=r"(pmp_cfg));
    if (pmp_cfg == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 2 wrong value\n");
        print("Expected: ");
        put_uint32_hex(expected);
        print("Got: ");
        put_uint32_hex(pmp_cfg);
    }

    // 3.0 Lock and try to write a configuration to the pmpcfg2 register
    pmp_cfg = 0x00000088;
    expected = 0x00000088;
    asm volatile("csrw pmpcfg2, %0" : : "r"(pmp_cfg));
    pmp_cfg = 0x00000007;
    asm volatile("csrs pmpcfg2, %0" : : "r"(pmp_cfg));
    // 3.1 Try to read the value back
    pmp_cfg = 0x0;
    asm volatile("csrr %0, pmpcfg2" : "=r"(pmp_cfg));
    if (pmp_cfg == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 3.0 wrong value\n");
        print("Expected: ");
        put_uint32_hex(expected);
        print("Got: ");
        put_uint32_hex(pmp_cfg);
    }
    // 3.2 Try to write a neighbor config
    pmp_cfg = 0x00070000;
    expected = 0x00070088;
    asm volatile("csrs pmpcfg2, %0" : : "r"(pmp_cfg));
    // 3.3 Read and verify the second one wrote
    pmp_cfg = 0x0;
    asm volatile("csrr %0, pmpcfg2" : "=r"(pmp_cfg));
    if (pmp_cfg == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 3.2 wrong value\n");
        print("Expected: ");
        put_uint32_hex(expected);
        print("Got: ");
        put_uint32_hex(pmp_cfg);
    }

    // 4.0 Try to write a value to the pmpaddr8 register
    pmp_addr = 0xDEADBEEF;
    expected = 0x00000000;
    asm volatile("csrw pmpaddr8, %0" : : "r"(pmp_addr));
    // 4.1 Try to read it back
    pmp_addr = 0x0;
    asm volatile("csrr %0, pmpaddr8" : "=r"(pmp_addr));
    if (pmp_addr == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 4.0 wrong value\n");
        print("Expected: ");
        put_uint32_hex(expected);
        print("Got: ");
        put_uint32_hex(pmp_addr);
    }
    // 4.2 Try to write a value to the pmpaddr7 register
    //   this should fail because pmp8cfg is TOR
    pmp_addr = 0xDEADBEEF;
    expected = 0x00000000;
    asm volatile("csrw pmpaddr7, %0" : : "r"(pmp_addr));
    // 4.3 Try to read it back
    pmp_addr = 0x0;
    asm volatile("csrr %0, pmpaddr7" : "=r"(pmp_addr));
    if (pmp_addr == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 4.2 wrong value\n");
        print("Expected: ");
        put_uint32_hex(expected);
        print("Got: ");
        put_uint32_hex(pmp_addr);
    }
    // 4.4 Write to a different address
    pmp_addr = 0xDEADBEEF;
    expected = ADDR_G_NO_SHIFT_2(0xDEADBEEF, G);
    asm volatile("csrw pmpaddr9, %0" : : "r"(pmp_addr));
    // 4.5 Read and verify 
    pmp_addr = 0x0;
    asm volatile("csrr %0, pmpaddr9" : "=r"(pmp_addr));
    if (pmp_addr == expected)
    {
        flag -= 1;
    }
    else
    {
        print("Case 4.4 wrong value\n");
        print("Expected: ");
        put_uint32_hex(expected);
        print("Got: ");
        put_uint32_hex(pmp_addr);
    }

    return 0;
}

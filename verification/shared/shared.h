#ifndef SHARED_H
#define SHARED_H

// Simple macros for verification tests
#define TEST_PASS 0
#define TEST_FAIL 1

#define ASSERT_EQ(expected, actual) \
    if ((expected) != (actual)) { return TEST_FAIL; }

#define ASSERT_TRUE(condition) \
    if (!(condition)) { return TEST_FAIL; }

#endif // SHARED_H

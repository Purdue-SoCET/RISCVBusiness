
#include "utility.h"
#include "format.h"

void test_pass(const char *msg) {
    print("%s\n", msg);
    flag = 1;
}

void test_fail(const char *msg) {
    print("%s\n", msg);
    flag = 0;
}

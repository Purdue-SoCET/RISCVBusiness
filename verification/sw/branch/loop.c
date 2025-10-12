
#include "utility.h"

int x[] = {0, 1, 2, 3, 4, 5};
int y[] = {0, 0, 0, 0, 0, 0};

extern int flag;

int main() {
    int sum = 0;
    for(int i = 0; i < 6; i++) {
        y[i] = x[i]*3;
        sum += y[i];
    }

    for(int i = 0; i < 6; i++) {
        print("Value: "); put_uint32_hex(y[i]); print("\n");
    }

    if(sum == 45) {
        flag = 1;
    }

    return 0;
}

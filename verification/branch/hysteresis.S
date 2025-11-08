
.extern flag

// Adds only *even* numbers:
// for(i = 999 downto 0):
//   if(isEven(i)) acc += i;
//
// This should cause the 1b branch predictor to thrash,
// updating its prediction of the 'if' each time to the wrong
// value. The hysteresis of the 2b predictor will allow it ~50%
// correct predictions.
.global main
main:
    li t0, 0
    li t1, 999

outer:
    andi t2, t1, 0x1
    bnez t2, 1f
    add t0, t0, t1
1:
    addi t1, t1, -1
    bnez t1, outer

    // expected sum: 249500
    li t2, 249499
    sub t0, t0, t2
    la t2, flag
    sw t0, 0(t2)
    li a0, 0
    ret

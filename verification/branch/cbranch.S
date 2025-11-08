
.extern flag

// does a loop for summing numbers 0 - 999
// expected result is 499500 
// for branches, the loop should mispredict 3x for btb2,
// twice to go to 'taken' state, once when it exits
// This version is modified to use a 'c' branch.
.global main
main:
    li a0, 999
    li t2, 0
    
loop:
    add t2, t2, a0 
    addi a0, a0, -1
    c.bnez a0, loop

done:
    li t3, 499499
    sub t2, t2, t3 // result is '1' if correct sum
    la t3, flag
    sw t2, 0(t3) 
    li a0, 0
    ret

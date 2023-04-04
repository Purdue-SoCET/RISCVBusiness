

.global main
main:
    li x10, 5
    li x20, 0
main_loop:
    wfi
    addi x20, x20, 1
    bne x10, x20, main_loop

main_done:
    li x28, 1
    la x29, flag
    sw x28, 0(x29)
    ret

#include "riscv_test.h"

RVTEST_DATA_DUMP_BEGIN

RVTEST_INTVEC_USER_BEGIN
  nop
RVTEST_INTVEC_SUPER_BEGIN
  nop
RVTEST_INTVEC_HYPER_BEGIN
  nop
RVTEST_INTVEC_MACH_BEGIN
  nop

RVTEST_CODE_BEGIN

main:
    la x1, tdat0 			#loads the tdat0 address
    la x2, tdat1			#loads the tdat1 address
    
    lw x3, 0(x2)			#loads the value at tdat1 address, which is beefbeef
    
    amoswap.w x4, x3, (x1)		#puts the value in x3 (beefbeef) into the tdat0 memory address in x1
					#moves the value of the tdat0 mem address (deadcafe) to x4
 
    
    sw x4, 4(x2)			#then deadcafe in x4 is stored into the second word of tdat1
    lw x5, 0(x1)			#then x5 gets the value beefbeef from the tdat0 memory address in x1
    sw x5, 8(x2)			#then beefbeef in x5 is stored into the third word of tdat1

RVTEST_CODE_END				#check x4 and x5 for deadcafe and beefbeef, respectively
					#or check the memory location of tdat1 

.data
#test data goes here
tdat0:  .word 0xdeadcafe
tdat1:  .word 0xbeefbeef
	.word 0x00000000
        .word 0x00000000

RVTEST_DATA_DUMP_END

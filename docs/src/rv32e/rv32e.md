# RV32E Base ISA
The RV32E base ISA is identical to the RV32I base, except the number of integer registers is halved; that is,
instructions may only use x0 - x15. x0 is still a hardwired 0 register, so RV32E provides 15 GPRs. Encodings
using x16-x31 are specified as *reserved* encodings.

## Implementation
The RV32E implementation simply adds a parameter bit to the file `standard_core/rv32i_reg_file.sv` to control
the number of integer registers available. 

As the specification notes, the behavior of decoding a reserved encoding is "UNSPECIFIED". For most instructions
in this RISC-V core, reserved encodings will cause a trap. However, for RV32E, the implementation cost of identifying
all reserved encodings is too high to do this. This is because it would require modifying the `control_unit.sv` and all
its sub-decoders to identify which instructions are making use of the registers (as, for example, an I-type instruction
could have an immediate field overlapping with the rs2 field). 

**Therefore, this RV32E implementation opts to treat register selectors x16 - x31 as *aliases* for x0-x15 (the top bit
of the register select is ignored entirely).** 

This should not cause a problem for normal software (as the compiler/assembler will not emit these instructions), 
but has the potential to complicate debugging as attempting to execute binaries compiled for RV32I, or incorrectly
executing a data region with data that appears to be encodings using x16 - x31 will cause silent failures.

# Testing
Currently, the TB check register x28 for the success/failure value in some tests. This register naturally aliases to x12
when using RV32E as the base ISA. For tests targeting RV32E, the flag value should be loaded into x12 for compatibility
with the TB.

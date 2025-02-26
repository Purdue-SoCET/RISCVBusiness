`ifndef ADDR_SPACE_SV
`define ADDR_SPACE_SV

package addr_space;
    // INSTRUCTION AND DATA AGENT ADDRESS MAP
    parameter INSTR_START_ADDR_SPACE = 32'h0000_0000;
    parameter INSTR_END_ADDR_SPACE   = 32'h0FFF_FFFF;  // 256 MB for instructions

    // Calculate the midpoint to split the address range for each core
    localparam INSTR_MID_ADDR_SPACE  = (INSTR_START_ADDR_SPACE + INSTR_END_ADDR_SPACE) >> 1;

    // Instruction address space for each core
    parameter CORE1_INSTR_START_ADDR = INSTR_START_ADDR_SPACE;
    parameter CORE1_INSTR_END_ADDR   = INSTR_MID_ADDR_SPACE;  // Core 1: First half of the range

    parameter CORE2_INSTR_START_ADDR = INSTR_MID_ADDR_SPACE + 1;
    parameter CORE2_INSTR_END_ADDR   = INSTR_END_ADDR_SPACE;  // Core 2: Second half of the range

    // DATA IS A SHARED SPACE BETWEEN CORES
    parameter DATA_START_ADDR_SPACE  = 32'h1000_0000;
    parameter DATA_END_ADDR_SPACE    = 32'h1FFF_FFFF;  // 256 MB for data
endpackage


`endif

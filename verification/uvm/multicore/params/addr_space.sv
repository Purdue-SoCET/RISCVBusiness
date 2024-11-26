`ifndef ADDR_SPACE_SV
`define ADDR_SPACE_SV

    // INSTRUCTION AND DATA ADDRESS MAP
    parameter INSTR_START_ADDR_SPACE = 32'h0000_0000;
    parameter INSTR_END_ADDR_SPACE   = 32'h0FFF_FFFF;  // 256 MB for instructions

    parameter DATA_START_ADDR_SPACE  = 32'h1000_0000;
    parameter DATA_END_ADDR_SPACE    = 32'h1FFF_FFFF;  // 256 MB for data
`endif

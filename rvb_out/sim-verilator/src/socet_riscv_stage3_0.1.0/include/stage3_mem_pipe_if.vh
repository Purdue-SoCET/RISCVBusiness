`ifndef __STAGE3_MEM_PIPE_IF__
`define __STAGE3_MEM_PIPE_IF__

interface stage3_mem_pipe_if();

    import rv32i_types_pkg::*;
    import stage3_types_pkg::*;

    logic reg_write;
    logic [4:0] rd_m;
    ex_mem_t ex_mem_reg;
    word_t brj_addr;
    word_t reg_wdata;
    word_t pc4; // For flush in case of fence_i, CSR, etc.

    modport fetch(
        input brj_addr, pc4
    );


    modport execute(
        input reg_wdata, reg_write, rd_m,
        output ex_mem_reg
    );

    modport mem(
        input ex_mem_reg,
        output brj_addr, reg_wdata, reg_write, rd_m, pc4
    );

endinterface


`endif

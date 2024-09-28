`ifndef __STAGE4_FORWARD_UNIT_VH__
`define __STAGE4_FORWARD_UNIT_VH__

interface stage4_forwarding_unit_if();
   
    rv32i_types_pkg::regsel_t rd_m;
    rv32i_types_pkg::regsel_t rs1_e;
    rv32i_types_pkg::regsel_t rs2_e;
    logic reg_write;
    logic load;
    logic fwd_rs1;
    logic fwd_rs2;
    rv32i_types_pkg::word_t rd_mem_data;

    modport execute(
        input fwd_rs1, fwd_rs2, rd_mem_data,
        output rs1_e, rs2_e
    );

    modport mem(
        output rd_m, rd_mem_data, reg_write, load
    );

    modport fw_unit(
        input rs1_e, rs2_e, rd_m, reg_write, load,
        output fwd_rs1, fwd_rs2
    );

endinterface


`endif
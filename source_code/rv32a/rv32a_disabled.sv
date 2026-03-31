module rv32a_disabled(
    input CLK,
    input nRST,
    input logic amo_en, mem_ready,
    input logic [3:0] alu_op, //need to change to type
    input logic [31:0] mem_output, rs2_data,
    output logic stall_amo_en, read_mem_en, write_mem_en,
    output logic [31:0] mem_input, writeback_data
);

    assign stall_amo_en = 0;
    assign read_mem_en = 0;
    assign write_mem_en = 0;
    assign mem_input = '0;
    assign writeback_data = '0;
endmodule

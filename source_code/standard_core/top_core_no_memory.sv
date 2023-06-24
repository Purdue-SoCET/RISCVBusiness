`include "core_interrupt_if.vh"
`include "generic_bus_if.vh"
`include "component_selection_defines.vh"

module top_core #(
    parameter logic [31:0] RESET_PC = 32'h80000000
) (
    input CLK,
    nRST,
    output wfi,
    halt,

    // I-bus
    input i_busy,
    input [31:0] i_rdata,
    output i_ren,
    output i_wen,
    output [3:0] i_byte_en,
    output [31:0] i_addr,
    output [31:0] i_wdata,

    // D-bus
    input d_busy,
    input [31:0] d_rdata,
    output d_ren,
    output d_wen,
    output [3:0] d_byte_en,
    output [31:0] d_addr,
    output [31:0] d_wdata,

    // core_interrupt_if
    input ext_int,
    ext_int_clear,
    input soft_int,
    soft_int_clear,
    input timer_int,
    timer_int_clear
);


    function [31:0] get_x28;
        // verilator public
        get_x28 = CORE.pipeline.execute_stage_i.g_rfile_select.rf.registers[28];
    endfunction

    bind stage3_mem_stage cpu_tracker cpu_track1 (
        .CLK(CLK),
        .wb_stall(wb_stall),
        .instr(ex_mem_if.ex_mem_reg.instr),
        .pc(ex_mem_if.ex_mem_reg.pc),
        .opcode(rv32i_types_pkg::opcode_t'(ex_mem_if.ex_mem_reg.instr[6:0])),
        .funct3(funct3),
        .funct12(funct12),
        .rs1(ex_mem_if.ex_mem_reg.instr[19:15]),
        .rs2(ex_mem_if.ex_mem_reg.instr[24:20]),
        .rd(ex_mem_if.ex_mem_reg.rd_m),
        .imm_S(ex_mem_if.ex_mem_reg.tracker_signals.imm_S), // TODO: Extract constants. Maybe we could pass these in the pipeline and they'd be removed by synthesis?
        .imm_I(ex_mem_if.ex_mem_reg.tracker_signals.imm_I),
        .imm_U(ex_mem_if.ex_mem_reg.tracker_signals.imm_U),
        .imm_UJ(ex_mem_if.ex_mem_reg.tracker_signals.imm_UJ),
        .imm_SB(ex_mem_if.ex_mem_reg.tracker_signals.imm_SB),
        .instr_30(instr_30)
    );


	bind branch_predictor_wrapper branch_tracker branch_track1 (
		.CLK(CLK),
		.nRST(nRST),
		.update_predictor(predict_if.update_predictor),
		.prediction(predict_if.prediction),
		.branch_result(predict_if.branch_result)
	);

    core_interrupt_if interrupt_if ();
    assign interrupt_if.ext_int = ext_int;
    assign interrupt_if.ext_int_clear = ext_int_clear;
    assign interrupt_if.soft_int = soft_int;
    assign interrupt_if.soft_int_clear = soft_int_clear;
    assign interrupt_if.timer_int = timer_int;
    assign interrupt_if.timer_int_clear = timer_int_clear;


    generic_bus_if igen_bus_if ();
    assign igen_bus_if.busy  = i_busy;
    assign igen_bus_if.rdata = i_rdata;
    assign i_ren              = igen_bus_if.ren;
    assign i_wen              = igen_bus_if.wen;
    assign i_byte_en          = igen_bus_if.byte_en;
    assign i_addr             = igen_bus_if.addr;
    assign i_wdata            = igen_bus_if.wdata;

    generic_bus_if dgen_bus_if ();
    assign dgen_bus_if.busy  = d_busy;
    assign dgen_bus_if.rdata = d_rdata;
    assign d_ren              = dgen_bus_if.ren;
    assign d_wen              = dgen_bus_if.wen;
    assign d_byte_en          = dgen_bus_if.byte_en;
    assign d_addr             = dgen_bus_if.addr;
    assign d_wdata            = dgen_bus_if.wdata;



    RISCVBusiness_no_memory #(.RESET_PC(RESET_PC)) CORE (.*);

endmodule

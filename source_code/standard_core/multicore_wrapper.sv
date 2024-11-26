`ifndef MULTICORE_WRAPPER_SV
`define MULTICORE_WRAPPER_SV

`include "bus_if.vh"
`include "cache_coherence_if.vh"
`include "component_selection_defines.vh"
`include "risc_mgmt_if.vh"
`include "cache_control_if.vh"
`include "sparce_pipeline_if.vh"
`include "tspp_fetch_execute_if.vh"
`include "tspp_hazard_unit_if.vh"
`include "core_interrupt_if.vh"
`include "rv32c_if.vh"
`include "bus_ctrl_if.vh"
`include "multicore_if.vh"

`include "RISCVBusiness.sv"
`include "memory_controller.sv"
`include "generic_nonpipeline.sv"

module multicore_wrapper #(
    parameter logic [31:0] RESET_PC = 32'h80000000,
    parameter NUM_HARTS = 1
) (
    input logic CLK, nRST,
    multicore_if.dut_mp mcif
);
    bus_ctrl_if bus_ctrl_if();
    generic_bus_if pipeline_trans_if ();

    memory_controller #(
        .NUM_HARTS(NUM_HARTS)
    ) mc (
        .CLK(CLK),
        .nRST(nRST),
        .out_gen_bus_if(pipeline_trans_if),
        .bcif(bus_ctrl_if)
    );

    logic [NUM_HARTS-1:0] pipeline_halts;
    logic [NUM_HARTS-1:0] wb_stall;
    logic [NUM_HARTS-1:0] [31:0] instr;
    logic [NUM_HARTS-1:0] [31:0] pc;
    logic [NUM_HARTS-1:0] [2:0] funct3;
    logic [NUM_HARTS-1:0] [11:0] funct12;
    logic [NUM_HARTS-1:0] [4:0] rs1;
    logic [NUM_HARTS-1:0] [4:0] rs2;
    logic [NUM_HARTS-1:0] [4:0] rd;
    logic [NUM_HARTS-1:0] instr_30;
    rv32i_types_pkg::opcode_t [NUM_HARTS-1:0] opcode;
    logic [NUM_HARTS-1:0] [12:0] imm_SB;
    logic [NUM_HARTS-1:0] [11:0] imm_S;
    logic [NUM_HARTS-1:0] [11:0] imm_I;
    logic [NUM_HARTS-1:0] [20:0] imm_UJ;
    logic [NUM_HARTS-1:0] [31:0] imm_U;
    cache_coherence_statistics_t cache_statistics [(NUM_HARTS * 2)-1:0];

    // This requires that all x28s are 1 in order to pass tests
    logic [31:0] x28;
    logic [NUM_HARTS-1:0] x28s;

    assign mcif.halt = &pipeline_halts;

    assign x28 = &x28s;

    genvar HART_ID;
    generate
        for (HART_ID = 0; HART_ID < NUM_HARTS; HART_ID = HART_ID + 1) begin
            logic pipeline_wfi;

            RISCVBusiness #(
                .RESET_PC(RESET_PC),
                .HART_ID(HART_ID)
            ) hart (
                .CLK(CLK),
                .nRST(nRST),
                .mtime(mcif.mtime),
                .wfi(pipeline_wfi),
                .halt(pipeline_halts[HART_ID]),
                .icache_statistics(cache_statistics[HART_ID * 2]),
                .dcache_statistics(cache_statistics[HART_ID * 2 + 1]),
                .interrupt_if(interrupt_if),
                .bus_ctrl_if(bus_ctrl_if)
            );

            always_comb begin
                wb_stall[HART_ID] = hart.pipeline.mem_stage_i.wb_stall || pipeline_halts[HART_ID];
                instr[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.instr;
                pc[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.pc;
                funct3[HART_ID] = hart.pipeline.mem_stage_i.funct3;
                funct12[HART_ID] = hart.pipeline.mem_stage_i.funct12;
                rs1[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.instr[19:15];
                rs2[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.instr[24:20];
                rd[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.rd_m;
                instr_30[HART_ID] = hart.pipeline.mem_stage_i.instr_30;
                opcode[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.tracker_signals.opcode;
                imm_SB[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.tracker_signals.imm_SB;
                imm_S[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.tracker_signals.imm_S;
                imm_I[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.tracker_signals.imm_I;
                imm_UJ[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.tracker_signals.imm_UJ;
                imm_U[HART_ID] = hart.pipeline.mem_pipe_if.ex_mem_reg.tracker_signals.imm_U;
            end

            assign x28s[HART_ID] = hart.pipeline.execute_stage_i.g_rfile_select.rf.registers[28] == 32'b1;
        end
    endgenerate

    // Instantiate the chosen bus interface
    generic_nonpipeline bt (
        .CLK(CLK),
        .nRST(nRST),
        .pipeline_trans_if(pipeline_trans_if),
        .out_gen_bus_if(mcif.gen_bus_if)
    );

endmodule


`endif
`include "generic_bus_if.vh"
`include "component_selection_defines.vh"
`include "risc_mgmt_if.vh"
`include "cache_control_if.vh"
`include "sparce_pipeline_if.vh"
`include "tspp_fetch_execute_if.vh"
`include "tspp_hazard_unit_if.vh"
`include "core_interrupt_if.vh"
`include "rv32c_if.vh"
`include "bus_ctrl_if.vh"

module multicore_wrapper #(
    parameter logic [31:0] RESET_PC = 32'h80000000,
    parameter NUM_HARTS
) (
    input logic CLK, nRST,
    input logic [63:0] mtime,
    output logic wfi,
    halt,
    core_interrupt_if.core interrupt_if,
`ifdef BUS_INTERFACE_GENERIC_BUS
    generic_bus_if.cpu gen_bus_if
`elsif BUS_INTERFACE_AHB
    ahb_if.manager ahb_manager
`elsif BUS_INTERFACE_APB
    apb_if.requester apb_requester
`endif
);
    bus_ctrl_if bus_ctrl_if();
    generic_bus_if pipeline_trans_if ();

    memory_controller #(
        .NUM_HARTS(NUM_HARTS)
    ) mc (
        .CLK(CLK),
        .nRST(nRST),
        .out_gen_bus_if(pipeline_trans_if),
        .bcif(bus_ctrl_if),
        .abort_bus(abort_bus)
    );

    logic [NUM_HARTS-1:0] pipeline_halts;

    // Hart 0's x28
    logic [31:0] x28;

    assign halt = &pipeline_halts;

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
                .mtime(mtime),
                .wfi(pipeline_wfi),
                .halt(pipeline_halts[HART_ID]),
                .interrupt_if(interrupt_if),
                .bus_ctrl_if(bus_ctrl_if)
            );

            if (HART_ID == 0) begin
                assign x28 = hart.pipeline.execute_stage_i.g_rfile_select.rf.registers[28];
            end
        end
    endgenerate

    // Instantiate the chosen bus interface
    generate
        case (BUS_INTERFACE_TYPE)
            "generic_bus_if": begin : g_generic_bus_if
                generic_nonpipeline bt (
                    .CLK(CLK),
                    .nRST(nRST),
                    .pipeline_trans_if(pipeline_trans_if),
                    .out_gen_bus_if(gen_bus_if)
                );
            end
            "ahb_if": begin : g_ahb_if
                ahb bt (
                    .CLK(CLK),
                    .nRST(nRST),
                    .out_gen_bus_if(pipeline_trans_if),
                    .ahb_m(ahb_manager)
                );
            end
            "apb_if": begin : g_apb_if
                apb bt(
                    .CLK(CLK),
                    .nRST(nRST),
                    .out_gen_bus_if(pipeline_trans_if),
                    .apbif(apb_requester)
                );
            end
        endcase
    endgenerate
endmodule

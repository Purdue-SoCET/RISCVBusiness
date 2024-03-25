/*
*   Copyright 2016 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     RISCVBusiness.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/01/2016
*   Description:  Top level module for RISCVBusiness
*/

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

module RISCVBusiness #(
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
            // Interface instantiations
            generic_bus_if tspp_icache_gen_bus_if ();
            generic_bus_if tspp_dcache_gen_bus_if ();
            generic_bus_if #(.BLOCK_SIZE(ICACHE_BLOCK_SIZE)) icache_mc_if ();
            generic_bus_if #(.BLOCK_SIZE(DCACHE_BLOCK_SIZE)) dcache_mc_if ();
            risc_mgmt_if rm_if ();
            predictor_pipeline_if predict_if ();
            prv_pipeline_if prv_pipe_if ();
            cache_control_if cc_if ();
            sparce_pipeline_if sparce_if ();
            rv32c_if rv32cif ();

            //Added for coherency
            cache_coherence_if i_cache_coherency_if ();
            cache_coherence_if d_cache_coherency_if ();

            //interface instantiations
            tspp_fetch_execute_if fetch_ex_if ();
            tspp_hazard_unit_if hazard_if ();

            logic pipeline_wfi;

            stage3 #(.RESET_PC(RESET_PC)) pipeline(
                .CLK(CLK),
                .nRST(nRST),
                .igen_bus_if(tspp_icache_gen_bus_if),
                .dgen_bus_if(tspp_dcache_gen_bus_if),
                .prv_pipe_if(prv_pipe_if),
                .predict_if(predict_if),
                .cc_if(cc_if),
                .sparce_if(sparce_if),
                .rv32cif(rv32cif),
                .halt(pipeline_halts[HART_ID]),
                .wfi(pipeline_wfi)
            );

            if (HART_ID == 0) begin
                assign x28 = pipeline.execute_stage_i.g_rfile_select.rf.registers[28];
            end

            // Module Instantiations
            branch_predictor_wrapper branch_predictor_i (
                .CLK(CLK),
                .nRST(nRST),
                .predict_if(predict_if)
            );

            priv_wrapper #(.HART_ID(HART_ID)) priv_wrapper_i (
                .CLK(CLK),
                .nRST(nRST),
                .prv_pipe_if(prv_pipe_if),
                .interrupt_if,
                .mtime(mtime)
            );

            /* TODO: Adding back RISC-MGMT to 3-stage pipeline
            risc_mgmt_wrapper rmgmt (
                .CLK  (CLK),
                .nRST (nRST),
                .rm_if(rm_if)
            );

            caches_wrapper caches (
                .CLK(CLK),
                .nRST(nRST),
                .icache_proc_gen_bus_if(tspp_icache_gen_bus_if),
                .icache_mem_gen_bus_if(icache_mc_if),
                .dcache_proc_gen_bus_if(tspp_dcache_gen_bus_if),
                .dcache_mem_gen_bus_if(dcache_mc_if),
                .cc_if(cc_if)
            );
            */

            logic abort_bus;
            separate_caches sep_caches (
                .CLK(CLK),
                .nRST(nRST),
                .icache_proc_gen_bus_if(tspp_icache_gen_bus_if),
                .icache_mem_gen_bus_if(icache_mc_if),
                .dcache_proc_gen_bus_if(tspp_dcache_gen_bus_if),
                .dcache_mem_gen_bus_if(dcache_mc_if),
                .i_cache_coherency_if(i_cache_coherency_if),
                .d_cache_coherency_if(d_cache_coherency_if),
                .abort_bus(abort_bus)
            );

            coherency_unit #(
                .CPUID(HART_ID * 2)
            ) i_coherence_unit (
                .CLK(CLK),
                .nRST(nRST),
                .ccif(i_cache_coherency_if),
                .bcif(bus_ctrl_if),
                .gbif(icache_mc_if)
            );

            coherency_unit #(
                .CPUID(HART_ID * 2 + 1)
            ) d_coherence_unit (
                .CLK(CLK),
                .nRST(nRST),
                .ccif(d_cache_coherency_if),
                .bcif(bus_ctrl_if),
                .gbif(dcache_mc_if)
            );

            /*
            sparce_wrapper sparce_wrapper_i (
                .CLK(CLK),
                .nRST(nRST),
                .sparce_if(sparce_if)
            );*/

            sparce_disabled sparce_disabled_i (
                .CLK(CLK),
                .nRST(nRST),
                .sparce_if(sparce_if)
            );

            rv32c_wrapper rv32c (
                .CLK(CLK),
                .nRST(nRST),
                .rv32cif(rv32cif)
            );
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
            /*"apb_if": begin : g_apb_if
                apb bt(
                    .CLK(CLK),
                    .nRST(nRST),
                    .out_gen_bus_if(pipeline_trans_if),
                    .apbif(apb_requester)
                );
            end*/
        endcase
    endgenerate
endmodule

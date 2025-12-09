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
`include "cache_control_if.vh"
`include "core_interrupt_if.vh"
`include "bus_ctrl_if.vh"

module RISCVBusiness #(
    parameter logic [31:0] RESET_PC = 32'h80000000,
    parameter HART_ID = 0
) (
    input logic CLK, nRST,
    input logic [63:0] mtime,
    output logic wfi, halt, abort_bus,
    core_interrupt_if.core interrupt_if,
    front_side_bus_if dcache_bus_ctrl_if,
    front_side_bus_if icache_bus_ctrl_if
);
    // Interface instantiations
    generic_bus_if icache_gen_bus_if ();
    generic_bus_if dcache_gen_bus_if ();
    generic_bus_if #(.BLOCK_SIZE(ICACHE_BLOCK_SIZE)) icache_mc_if ();
    generic_bus_if #(.BLOCK_SIZE(DCACHE_BLOCK_SIZE)) dcache_mc_if ();
    predictor_pipeline_if predict_if ();
    prv_pipeline_if prv_pipe_if ();
    cache_control_if control_if ();

    // Clock-gating signals
    logic core_clk_en;
    logic pipeline_clk;
    logic soft_irq;

    assign soft_irq = interrupt_if.soft_int[HART_ID];

    core_clk_gating core_clk_gating_i (
        .clk        (CLK),
        .rst_n      (nRST),
        .wfi_in     (wfi), //takes wfi from stage3 mem stage
        .irq_in     (soft_irq),
        .core_clk_en(core_clk_en)
    );

    assign pipeline_clk = CLK & core_clk_en;

    stage3 #(.RESET_PC(RESET_PC), .HART_ID(HART_ID)) pipeline(
        .CLK(pipeline_clk),
        .nRST(nRST),
        .igen_bus_if(icache_gen_bus_if),
        .dgen_bus_if(dcache_gen_bus_if),
        .prv_pipe_if(prv_pipe_if),
        .predict_if(predict_if),
        .cc_if(control_if),
        .halt(halt),
        .wfi(wfi)
    );

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

    /* 
    caches_wrapper caches (
        .CLK(CLK),
        .nRST(nRST),
        .icache_proc_gen_bus_if(icache_gen_bus_if),
        .icache_mem_gen_bus_if(icache_mc_if),
        .dcache_proc_gen_bus_if(dcache_gen_bus_if),
        .dcache_mem_gen_bus_if(dcache_mc_if),
        .cc_if(cc_if)
    );
    */

    separate_caches sep_caches (
        .CLK(CLK),
        .nRST(nRST),
        .icache_proc_gen_bus_if(icache_gen_bus_if),
        .icache_mem_gen_bus_if(icache_mc_if),
        .dcache_proc_gen_bus_if(dcache_gen_bus_if),
        .dcache_mem_gen_bus_if(dcache_mc_if),
        .control_if(control_if),
        .prv_pipe_if(prv_pipe_if),
        .dcache_bus_ctrl_if(dcache_bus_ctrl_if),
        .icache_bus_ctrl_if(icache_bus_ctrl_if),
        .abort_bus(abort_bus),
        .icache_miss(prv_pipe_if.icache_miss),
        .dcache_miss(prv_pipe_if.dcache_miss)
    );

endmodule

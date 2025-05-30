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
    parameter HART_ID
) (
    input logic CLK, nRST,
    input logic [63:0] mtime,
    output logic wfi, halt, abort_bus,
    core_interrupt_if.core interrupt_if,
    bus_ctrl_if bus_ctrl_if
);
    // Interface instantiations
    generic_bus_if tspp_icache_gen_bus_if ();
    generic_bus_if tspp_dcache_gen_bus_if ();
    generic_bus_if #(.BLOCK_SIZE(ICACHE_BLOCK_SIZE)) icache_mc_if ();
    generic_bus_if #(.BLOCK_SIZE(DCACHE_BLOCK_SIZE)) dcache_mc_if ();
    risc_mgmt_if rm_if ();
    predictor_pipeline_if predict_if ();
    prv_pipeline_if prv_pipe_if ();
    cache_control_if control_if ();
    sparce_pipeline_if sparce_if ();
    rv32c_if rv32cif ();

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
        .cc_if(control_if),
        .sparce_if(sparce_if),
        .rv32cif(rv32cif),
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

    separate_caches #(
        .HART_ID(HART_ID)
    ) sep_caches (
        .CLK(CLK),
        .nRST(nRST),
        .icache_proc_gen_bus_if(tspp_icache_gen_bus_if),
        .icache_mem_gen_bus_if(icache_mc_if),
        .dcache_proc_gen_bus_if(tspp_dcache_gen_bus_if),
        .dcache_mem_gen_bus_if(dcache_mc_if),
        .control_if(control_if),
        .prv_pipe_if(prv_pipe_if),
        .bus_ctrl_if(bus_ctrl_if),
        .abort_bus(abort_bus),
        .icache_miss(prv_pipe_if.icache_miss),
        .dcache_miss(prv_pipe_if.dcache_miss)
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
endmodule

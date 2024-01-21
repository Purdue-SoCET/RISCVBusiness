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

module RISCVBusiness_no_memory (
    input logic CLK,
    nRST,
    output logic wfi,
    halt,
    core_interrupt_if.core interrupt_if,
    generic_bus_if.cpu igen_bus_if,
    generic_bus_if.cpu dgen_bus_if

);

    parameter logic [31:0] RESET_PC = 32'h80000000;

    // Interface instantiations
    function logic [31:0] get_x28();
        // verilator public
        return pipeline.execute_stage_i.g_rfile_select.rf.registers[28];
    endfunction

    risc_mgmt_if rm_if ();
    predictor_pipeline_if predict_if ();
    prv_pipeline_if prv_pipe_if ();
    cache_control_if cc_if ();
    sparce_pipeline_if sparce_if ();
    rv32c_if rv32cif ();

    //interface instantiations
    tspp_fetch_execute_if fetch_ex_if ();
    tspp_hazard_unit_if hazard_if ();

    stage4 #(.RESET_PC(RESET_PC)) pipeline(
        .*
    );

    // hardwire cache control signals
    assign cc_if.iflush_done = 1'b1;
    assign cc_if.iclear_done = 1'b1;
    assign cc_if.dflush_done = 1'b1;
    assign cc_if.dclear_done = 1'b1;

    // Module Instantiations
    /*
  pipeline_wrapper pipeline (
    .CLK(CLK),
    .nRST(nRST),
    .halt(halt),
    .igen_bus_if(tspp_icache_gen_bus_if),
    .dgen_bus_if(tspp_dcache_gen_bus_if),
    .prv_pipe_if(prv_pipe_if), // TODO: Look at the communications between pipeline_wrapper and priv_wrapper
    .predict_if(predict_if),
    .rm_if(rm_if),
    .cc_if(cc_if),
    .sparce_if(sparce_if)
  );
*/

/*
    tspp_fetch_stage #(
        .RESET_PC(RESET_PC)
    ) fetch_stage_i (
        .CLK(CLK),
        .nRST(nRST),
        .fetch_ex_if(fetch_ex_if),
        .hazard_if(hazard_if),
        .predict_if(predict_if),
        .igen_bus_if(tspp_icache_gen_bus_if),
        .sparce_if(sparce_if),
        .rv32cif(rv32cif),
        .prv_pipe_if(prv_pipe_if)
    );

    tspp_execute_stage execute_stage_i (
        .CLK(CLK),
        .nRST(nRST),
        .fetch_ex_if(fetch_ex_if),
        .hazard_if(hazard_if),
        .predict_if(predict_if),
        .dgen_bus_if(tspp_dcache_gen_bus_if),
        .prv_pipe_if(prv_pipe_if),
        .halt(halt),
        .rm_if(rm_if),
        .cc_if(cc_if),
        .sparce_if(sparce_if),
        .rv32cif(rv32cif),
        .wfi(wfi)
    );

    tspp_hazard_unit hazard_unit_i (
        .hazard_if(hazard_if),
        .prv_pipe_if(prv_pipe_if),
        .rm_if(rm_if),
        .sparce_if(sparce_if)
    );
*/

    branch_predictor_wrapper branch_predictor_i (
        .CLK(CLK),
        .nRST(nRST),
        .predict_if(predict_if)
    );

    priv_wrapper priv_wrapper_i (
        .CLK(CLK),
        .nRST(nRST),
        .prv_pipe_if(prv_pipe_if),
        .interrupt_if
    );

    risc_mgmt_wrapper rmgmt (
        .CLK  (CLK),
        .nRST (nRST),
        .rm_if(rm_if)
    );

    /*
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

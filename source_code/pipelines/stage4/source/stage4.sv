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
*   Filename:     stage4.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/01/2016
*   Description:  Four stage pipeline with micro-op queue, contains vector unit(s)
*/

`include "stage4_hazard_unit_if.vh"
`include "predictor_pipeline_if.vh"
`include "generic_bus_if.vh"
`include "prv_pipeline_if.vh"
//`include "risc_mgmt_if.vh"
`include "cache_control_if.vh"
`include "sparce_pipeline_if.vh"
`include "rv32c_if.vh"
`include "rv32v_shadow_csr_if.vh"

import stage4_types_pkg::*;

module stage4 #(
    RESET_PC = 32'h80000000
)(
    input CLK,
    input nRST,
    output logic halt,
    output logic wfi,
    generic_bus_if.cpu igen_bus_if,
    generic_bus_if.cpu dgen_bus_if,
    prv_pipeline_if prv_pipe_if,
    predictor_pipeline_if predict_if,
    //risc_mgmt_if rm_if,
    cache_control_if cc_if,
    sparce_pipeline_if sparce_if,
    rv32c_if rv32cif
);

    fetch_out_t fetch_out; 
    uop_t ex_in; 

    //interface instantiations
    stage4_mem_stage_if mem_pipe_if();
    stage4_hazard_unit_if hazard_if();
    stage4_forwarding_unit_if fw_if();
    rv32v_shadow_csr_if shadow_if(); 

    // decode & queue signals
    logic queue_wen; 
    uop_t uop_out;
    uop_t [0:0] ctrls; 
    logic [4:0] num_uops; 

    assign ctrls[0] = uop_out; 
    assign num_uops = 1; 

    assign shadow_if.flush_decode = hazard_if.flush_decode; 

    //module instantiations
    stage4_fetch_stage #(.RESET_PC(RESET_PC)) fetch_stage_i(.mem_fetch_if(mem_pipe_if), .fetch_out(fetch_out), .*);

    stage4_decode_stage decode(
        .CLK(CLK), .nRST(nRST), 
        .hazard_if(hazard_if), 
        .fetch_out(fetch_out), 
        .uop_out(uop_out), 
        .queue_wen(queue_wen), 
        .rv32cif(rv32cif), 
        .shadow_if(shadow_if)
    ); 

    stage4_queue queue(
        .CLK(CLK), 
        .nRST(nRST), 
        .ctrls(ctrls),
        .num_uops(num_uops), 
        .hazard_if(hazard_if), 
        .ex_in(ex_in), 
        .queue_wen(queue_wen)
    );

    stage4_execute_stage execute_stage_i(.ex_mem_if(mem_pipe_if),.ex_in(ex_in), .shadow_if(shadow_if), .*);
    // stage4_mem_stage mem_stage_i(.ex_mem_if(mem_pipe_if), .shadow_if(shadow_if), .*);
    stage4_mem_stage_coalescing mem_stage_i(.ex_mem_if(mem_pipe_if), .shadow_if(shadow_if), .*);
    stage4_hazard_unit hazard_unit_i(.*);
    stage4_forwarding_unit forward_unit_i(.*);

endmodule

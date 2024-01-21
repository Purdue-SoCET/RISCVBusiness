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
*   Filename:     stage3.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/01/2016
*   Description:  Two Stage In-Order Pipeline
*/

`include "stage3_fetch_execute_if.vh"
`include "stage3_hazard_unit_if.vh"
`include "predictor_pipeline_if.vh"
`include "generic_bus_if.vh"
`include "prv_pipeline_if.vh"
//`include "risc_mgmt_if.vh"
`include "cache_control_if.vh"
`include "sparce_pipeline_if.vh"
`include "rv32c_if.vh"

module stage3 #(
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
    //interface instantiations
    stage3_fetch_execute_if fetch_ex_if();
    stage3_mem_pipe_if mem_pipe_if();
    stage3_hazard_unit_if hazard_if();
    stage3_forwarding_unit_if fw_if();

    //module instantiations
    stage3_fetch_stage #(.RESET_PC(RESET_PC)) fetch_stage_i(.mem_fetch_if(mem_pipe_if), .*);
    stage3_execute_stage execute_stage_i(.ex_mem_if(mem_pipe_if), .*);
    stage3_mem_stage mem_stage_i(.ex_mem_if(mem_pipe_if), .*);
    stage3_hazard_unit hazard_unit_i(.*);
    stage3_forwarding_unit forward_unit_i(.*);

endmodule

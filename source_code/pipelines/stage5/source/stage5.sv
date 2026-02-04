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
*   Filename:     stage5.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Five Stage In-Order Pipeline
*/

`include "stage5_fetch_decode_if.vh"
`include "stage5_decode_execute_if.vh"
`include "stage5_execute_mem_if.vh"
`include "stage5_mem_wb_if.vh"
`include "stage5_hazard_unit_if.vh"
`include "stage5_forwarding_unit_if.vh"
`include "predictor_pipeline_if.vh"
`include "generic_bus_if.vh"
`include "prv_pipeline_if.vh"
`include "cache_control_if.vh"

module stage5 #(
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
    cache_control_if cc_if
);
    //interface instantiations
    stage5_fetch_decode_if fetch_decode_if();
    stage5_decode_execute_if decode_ex_if();
    stage5_execute_mem_if ex_mem_if();
    stage5_mem_wb_if mem_wb_if();
    stage5_hazard_unit_if hazard_if();
    stage5_forwarding_unit_if fw_if();

    // Fetch
    stage5_fetch_stage #(.RESET_PC(RESET_PC)) fetch_stage_i (.*);

    // Decoding + WB
    stage5_decode_stage decode_stage_i (.*);

    // Execute
    stage5_execute_stage execute_stage_i (.*);

    // Memory
    stage5_mem_stage mem_stage_i (.*);

    // Hazards
    stage5_hazard_unit hazard_unit_i (.*);

    // Forwarding regs
    stage5_forwarding_unit forward_unit_i (.*);

endmodule

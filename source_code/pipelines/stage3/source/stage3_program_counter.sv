/*
*   Copyright 2023 Purdue University
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
*   Filename:     stage3_program_counter.sv
*
*   Created by:   Rohan Gangaraju
*   Email:        rgangar@purdue.edu
*   Date Created: 11/20/2023
*   Description:  Program counter for 3-stage pipeline
*/

`include "stage3_fetch_execute_if.vh"
`include "stage3_hart_selector_if.vh"
`include "stage3_program_counter_if.vh"
`include "generic_bus_if.vh"
`include "component_selection_defines.vh"
`include "rv32c_if.vh"

module stage3_program_counter (
    input logic CLK,
    nRST,
    stage3_fetch_execute_if.fetch fetch_ex_if,
    stage3_mem_pipe_if.fetch mem_fetch_if,
    stage3_hazard_unit_if.fetch hazard_if,
    stage3_hart_selector_if.fetch hart_selector_if,
    predictor_pipeline_if.access predict_if,
    generic_bus_if.cpu igen_bus_if,
    sparce_pipeline_if.pipe_fetch sparce_if,
    rv32c_if.fetch rv32cif,
    stage3_program_counter_if.pc_unit pc_if,
    prv_pipeline_if.fetch prv_pipe_if
);
    import rv32i_types_pkg::*;
    import pma_types_1_12_pkg::*;

    parameter logic [31:0] NUM_HARTS = 2;
    parameter logic [31:0] RESET_PC = 32'h80000000;

    genvar i;

    generate
        for (i = 0; i < NUM_HARTS; i = i + 1) begin : pc
          always_ff @(posedge CLK, negedge nRST) begin
            if (~nRST) begin
                pc_if.pc[i] <= RESET_PC + (i * 8);
            end else if((hazard_if.pc_en && hart_selector_if.hart_id == i) || (hazard_if.npc_sel && mem_fetch_if.ex_mem_reg.hart_id == i)) begin // if (hazard_if.pc_en /*| rv32cif.done_earlier*/)
                if(hazard_if.npc_sel && mem_fetch_if.ex_mem_reg.hart_id == i) pc_if.pc[mem_fetch_if.ex_mem_reg.hart_id] <= pc_if.npc[mem_fetch_if.ex_mem_reg.hart_id];
                else pc_if.pc[hart_selector_if.hart_id] <= pc_if.npc[hart_selector_if.hart_id];
            end
          end
        end
      endgenerate
endmodule
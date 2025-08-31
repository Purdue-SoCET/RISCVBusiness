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
*   Filename:     priv_mode.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 09/26/2024
*   Description:  Processor privilege mode switcher
*/

`include "prv_pipeline_if.vh"
`include "priv_internal_if.vh"
`include "core_interrupt_if.vh"
`include "priv_ext_if.vh"

module priv_mode (
    input logic CLK, nRST,
    priv_internal_if.mode prv_intern_if
);

    import priv_isa_types_pkg::*;
    import rv32i_types_pkg::*;

    priv_level_t curr_priv_level, next_priv_level;

    always_ff @ (posedge CLK, negedge nRST) begin
        if (~nRST) begin
            curr_priv_level <= M_MODE;
        end else begin
            curr_priv_level <= next_priv_level;
        end
    end

    always_comb begin
        next_priv_level = curr_priv_level;
        if (prv_intern_if.intr) begin
            // if interrupt into s mode else m mode
            next_priv_level = prv_intern_if.intr_to_s && SUPERVISOR_ENABLED == "enabled" ? S_MODE : M_MODE;
        end else if (prv_intern_if.mret) begin
            next_priv_level = prv_intern_if.curr_mstatus.mpp;
        end else if (prv_intern_if.sret) begin
            next_priv_level = prv_intern_if.curr_mstatus.spp && SUPERVISOR_ENABLED == "enabled" ? S_MODE : U_MODE; 
        end
    end

    assign prv_intern_if.curr_privilege_level = curr_priv_level;
    assign prv_intern_if.isUMode = curr_priv_level == U_MODE;
    assign prv_intern_if.isSMode = (curr_priv_level == S_MODE) & (SUPERVISOR_ENABLED == "enabled");  // supervisor enabled sanity check
    assign prv_intern_if.isMMode = curr_priv_level == M_MODE;

endmodule
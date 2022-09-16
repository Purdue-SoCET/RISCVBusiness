
/*
*   Copyright 2019 Purdue University
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
*   Filename:     sparce_psru.sv
*
*   Created by:   Vadim V. Nikiforov
*   Email:        vnikifor@purdue.edu
*   Date Created: 04/14/2019
*   Description:  The file containing pre-identify and skip redundancy unit
*/

`include "sparce_internal_if.vh"

//  modport psru (
//    output skipping, sparce_target,
//    input valid, insts_to_skip, preceding_pc, condition, rs1_sparsity, rs2_sparsity, ctrl_flow_enable
//  );

module sparce_psru (
    sparce_internal_if.psru psru_if
);

    always_comb begin
        if (psru_if.valid) begin
            // choose the correct condition to evaluate
            if (psru_if.condition == SASA_COND_OR) begin
                psru_if.skipping = (psru_if.rs1_sparsity || psru_if.rs2_sparsity) && psru_if.ctrl_flow_enable;
            end else begin
                psru_if.skipping = (psru_if.rs1_sparsity && psru_if.rs2_sparsity) && psru_if.ctrl_flow_enable;
            end
            // calculate the new program counter
            psru_if.sparce_target = psru_if.preceding_pc + (psru_if.insts_to_skip << 2) + 4;
        end else begin
            // don't skip if the SASA table entry is invalid
            psru_if.skipping = 1'b0;
            psru_if.sparce_target = '1;
        end
    end

endmodule

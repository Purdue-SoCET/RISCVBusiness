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
*   Filename:     sparce_sprf.sv
*
*   Created by:   Vadim V. Nikiforov
*   Email:        vnikifor@purdue.edu
*   Date Created: 04/4/2019
*   Description:  The file containing the sparsity register file (SpRF)
*                 module
*/

`include "sparce_internal_if.vh"

module sparce_sprf (
    input logic CLK,
    nRST,
    sparce_internal_if.sprf sprf_if
);

    logic [31:1] sparsity_reg;
    logic [31:0] sparsity_out;

    // all register outputs are tied to the registers, except for
    // register[0] which is always 1
    assign sparsity_out[0] = 1'b1;
    assign sparsity_out[31:1] = sparsity_reg[31:1];

    // register update logic
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            // even through regs are initialized to 0, don't treat
            // uninitialized registers as sparse registers
            sparsity_reg[31:1] <= '0;
        end else begin
            // keep registers as old values when not modified
            sparsity_reg[31:1] <= sparsity_reg[31:1];
            // modify the chosen register if the pipeline is writing back
            if (sprf_if.wb_en) begin
                sparsity_reg[sprf_if.rd] <= sprf_if.is_sparse;
            end
        end
    end

    // register output logic
    always_comb begin
        if (sprf_if.sasa_rs1 == '0) begin
            sprf_if.rs1_sparsity = 1'b1;
        end else if (sprf_if.sasa_rs1 == sprf_if.rd && sprf_if.wb_en) begin
            sprf_if.rs1_sparsity = sprf_if.is_sparse;
        end else begin
            sprf_if.rs1_sparsity = sparsity_out[sprf_if.sasa_rs1];
        end
        if (sprf_if.sasa_rs2 == '0) begin
            sprf_if.rs2_sparsity = 1'b1;
        end else if (sprf_if.sasa_rs2 == sprf_if.rd && sprf_if.wb_en) begin
            sprf_if.rs2_sparsity = sprf_if.is_sparse;
        end else begin
            sprf_if.rs2_sparsity = sparsity_out[sprf_if.sasa_rs2];
        end
    end

endmodule


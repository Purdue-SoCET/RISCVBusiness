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
*   Filename:     src/branch_res.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/14/2016
*   Description:  Determines if a branch should be taken and outputs
*                 the target address.  Optimized to use only one adder
*/

`include "branch_res_if.vh"

module branch_res (
    branch_res_if.bres br_if
);

    import rv32i_types_pkg::*;

    word_t offset;
    logic lt, eq, ltu;
    logic sign_1, sign_2, sign_r, carry_out;
    logic [WORD_SIZE : 0]
        adder_out, op_1_ext  /* verilator split_var */, op_2_ext  /* verilator split_var */;

    // target addr generation
    assign offset = $signed(br_if.imm_sb);
    assign br_if.branch_addr = br_if.pc + offset;

    //sign bits
    assign sign_1 = br_if.rs1_data[WORD_SIZE-1];
    assign sign_2 = br_if.rs2_data[WORD_SIZE-1];
    assign sign_r = adder_out[WORD_SIZE-1];

    //build operands
    assign op_1_ext[WORD_SIZE-1:0] = br_if.rs1_data;
    assign op_2_ext[WORD_SIZE-1:0] = (~br_if.rs2_data) + 1;

    always_comb begin
        if (br_if.branch_type == BLTU || br_if.branch_type == BGEU) begin
            op_1_ext[WORD_SIZE] = 1'b0;
            op_2_ext[WORD_SIZE] = 1'b0;
        end else begin
            op_1_ext[WORD_SIZE] = op_1_ext[WORD_SIZE-1];
            op_2_ext[WORD_SIZE] = op_2_ext[WORD_SIZE-1];
        end
    end

    //adder
    assign adder_out = op_1_ext + op_2_ext;
    assign carry_out = adder_out[WORD_SIZE];

    // condition calculations
    assign eq = br_if.rs1_data == br_if.rs2_data;
    assign lt = (sign_1 & ~sign_2) ? 1 : ((~sign_1 & sign_2) ? 0 : sign_r);

    assign ltu = ~carry_out & |(op_2_ext);

    always_comb begin
        casez (br_if.branch_type)
            BEQ   : br_if.branch_taken = eq;
            BNE   : br_if.branch_taken = ~eq;
            BLT   : br_if.branch_taken = lt;
            BGE   : br_if.branch_taken = ~lt;
            BLTU  : br_if.branch_taken = ltu;
            BGEU  : br_if.branch_taken = ~ltu;
            default : br_if.branch_taken = 1'b0;
        endcase
    end

endmodule

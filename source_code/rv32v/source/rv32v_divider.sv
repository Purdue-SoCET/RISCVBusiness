/*
*   Copyright 2024 Purdue University
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
*   Filename:     rv32v_divider.sv
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 03/04/2024
*   Description:  Pipelined divider for RV32V vector lanes
*                 (Uses rv32m/radix4_divider.sv)
*                 TODO: Fully pipeline, allowing for independent divs to fill stages
*/

import rv32i_types_pkg::*;
import rv32v_types_pkg::*;

module rv32v_divider (
    input logic CLK,
    input logic nRST,
    input vdiv_input_t vdiv_in,
    output vdiv_output_t vdiv_out
);

    word_t quotient, remainder;
    logic start, finished, busy;

    radix4_divider VLANE_DIV (
        .CLK,
        .nRST,
        .divisor(vdiv_in.vs2_data),
        .dividend(vdiv_in.vs1_data),
        .is_signed(~vdiv_in.vopunsigned),
        .start,
        .remainder,
        .quotient,
        .finished
    );

    assign vdiv_out.vd_res = (vdiv_in.vdivremainder) ? remainder : quotient;
    assign start = vdiv_in.vdiv_en & ~busy;
    assign vdiv_out.vdiv_busy = start | (busy & ~finished);

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            busy <= 0;
        end else if (vdiv_in.vdiv_en & ~busy) begin
            busy <= 1;
        end else if (finished) begin
            busy <= 0;
        end
    end

endmodule // rv32v_divider

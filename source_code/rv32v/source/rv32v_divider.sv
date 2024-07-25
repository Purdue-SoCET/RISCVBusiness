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

    word_t divisor, dividend, quotient, remainder;
    logic start, finished, busy, prev_finished, is_signed;
    logic overflow, div_zero;

    assign divisor = vdiv_in.vs2_data;
    assign dividend = vdiv_in.vs1_data;
    assign is_signed = ~vdiv_in.vopunsigned;

    radix4_divider VLANE_DIV (
        .CLK,
        .nRST,
        .divisor,
        .dividend,
        .is_signed,
        .start,
        .remainder,
        .quotient,
        .finished
    );

    assign start = (vdiv_in.vdiv_en & ~vdiv_in.vmem_use_stall & ~prev_finished) & ~(div_zero | overflow);
    assign vdiv_out.vdiv_busy = start | (busy & ~finished);
    assign overflow = (dividend == 32'h8000_0000) & (divisor == 32'hffff_ffff) & is_signed;
    assign div_zero = (divisor == 32'h0);

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            busy <= 0;
        end else if (start & ~busy) begin
            busy <= 1;
        end else if (finished) begin
            busy <= 0;
        end
    end

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            prev_finished <= 0;
        end else if (vdiv_in.vmem_use_stall | vdiv_in.flush) begin
            prev_finished <= 0;
        end else begin
            prev_finished <= finished;
        end
    end

    // Result
    always_comb begin
        if (vdiv_in.vdivremainder)
            vdiv_out.vd_res = div_zero ? dividend : (overflow ? 32'h0000_0000 : remainder);
        else
            if (is_signed)
                vdiv_out.vd_res = div_zero ? 32'hffff_ffff : (overflow ? 32'h8000_0000 : quotient);
            else
                vdiv_out.vd_res = div_zero ? 32'h7fff_ffff : (overflow ? 32'h8000_0000 : quotient);
    end

endmodule // rv32v_divider

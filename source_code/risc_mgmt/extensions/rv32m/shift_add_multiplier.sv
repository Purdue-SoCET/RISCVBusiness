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
*   Filename:     shift_add_multiplier.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/15/2017
*   Description:  N bit parameterized shift and add multiplier
*                 Takes up to N+1 cycles to compute the product.
*/

module shift_add_multiplier #(
    parameter N = 32
) (
    input logic CLK,
    nRST,
    input logic [N-1:0] multiplicand,
    input logic [N-1:0] multiplier,
    input logic [1:0] is_signed,
    input logic start,
    output logic [(N*2)-1:0] product,
    output logic finished
);

    logic [(N*2)-1:0] multiplier_reg, multiplicand_reg;
    logic [(N*2)-1:0] multiplier_ext, multiplicand_ext;
    logic [(N*2)-1:0] partial_product;
    logic mult_complete, adjust_product;

    assign mult_complete    = !(|multiplier_reg);
    assign adjust_product   = (is_signed[0] & multiplier[N-1]) ^ (is_signed[1] & multiplicand[N-1]);
    assign partial_product  = multiplier_reg[0] ? multiplicand_reg : '0;
    assign multiplier_ext   = (~{{N{multiplier[N-1]}},multiplier}) + 1;
    assign multiplicand_ext = (~{{N{multiplicand[N-1]}},multiplicand}) + 1;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) finished <= 1'b0;
        else if (start) finished <= 1'b0;
        else if (mult_complete) finished <= 1'b1;
    end

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            multiplicand_reg <= '0;
            multiplier_reg   <= '0;
            product          <= '0;
        end else if (start) begin
            multiplicand_reg  <= (is_signed[1] && multiplicand[N-1]) ? multiplicand_ext : {{N{1'b0}}, multiplicand};
            multiplier_reg    <= (is_signed[0] && multiplier[N-1]) ? multiplier_ext : {{N{1'b0}}, multiplier};
            product <= '0;
        end else if (mult_complete & ~finished) begin  // adjust sign on product
            multiplicand_reg <= multiplicand_reg;
            multiplier_reg   <= multiplier_reg;
            product          <= adjust_product ? (~product) + 1 : product;
        end else if (~finished) begin
            multiplicand_reg <= multiplicand_reg << 1;
            multiplier_reg   <= multiplier_reg >> 1;
            product          <= product + partial_product;
        end
    end

endmodule

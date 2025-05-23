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
*   Filename:     decompressor.sv
*
*   Created by:   Cole Nelson
*   Email:        nelso345@purdue.edu
*   Date Created: 5/4/2025
*   Description:  Decompress RV32C instructions into full-size instruction
*/
module decompressor #(
    // Note: C = Zca + (Zcf if F) + (Zcd if D)
    parameter bit ZCA = 1,
    parameter bit ZCF = 1,
    parameter bit ZCD = 1,
    parameter bit ZCB = 0,
    parameter bit ZCMP = 0,
    parameter bit ZCMT = 0
)(
    input [15:0] compressed,
    output logic [31:0] decompressed
);

    assign decompressed = decompress(compressed);
   
    // TODO: Create separate localparam for RESERVED,
    // allow configuration of how to treat them (NOP or UNIMP),
    // spec allows either. May have area advantage.
    function automatic logic [31:0] decompress(logic [15:0] compressed);
        casez({compressed[15:13], compressed[1:0]})
            5'b000_00: begin
                if (compressed == 16'h0000) begin
                    return rv32c_pkg::UNIMP;
                end else begin
                    return rv32c_pkg::decompress_ciw(compressed);
                end
            end

            5'b001_00, 5'b010_00, 5'b011_00: return rv32c_pkg::decompress_cl(compressed);
            5'b100_00: return rv32c_pkg::UNIMP; // reserved
            5'b101_00, 5'b110_00, 5'b111_00: return rv32c_pkg::decompress_cs(compressed);
            5'b000_01, 5'b010_01, 5'b011_01: return rv32c_pkg::decompress_ci_arith(compressed);
            5'b100_01: begin
                // ANDI exception case
                if(compressed[11:10] == 2'b11)
                    return rv32c_pkg::decompress_ca(compressed);
                else if(compressed[15:13] == 3'b100 && compressed[11:10] == 2'b10)
                    return rv32c_pkg::decompress_cb(compressed);
                else
                    return rv32c_pkg::decompress_ci_arith(compressed);
            end
            5'b001_01, 5'b101_01: return rv32c_pkg::decompress_cj(compressed);
            5'b110_01, 5'b111_01: return rv32c_pkg::decompress_cb(compressed);
            5'b000_10: return rv32c_pkg::decompress_ci_arith(compressed);
            5'b001_10, 5'b010_10, 5'b011_10: return rv32c_pkg::decompress_ci_load(compressed);
            5'b100_10: return rv32c_pkg::decompress_cr(compressed);
            5'b101_10, 5'b110_10, 5'b111_10: return rv32c_pkg::decompress_css(compressed);
            default: return rv32c_pkg::UNIMP; // inst. is full-size
        endcase
    endfunction

endmodule

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
*   Filename:     endian_swapper.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/14/2016
*   Description:  Swaps the endianess of the input word
*/

module endian_swapper #(
    parameter int N_BYTES = rv32i_types_pkg::WORD_SIZE / 8,
    parameter int N_BITS  = N_BYTES * 8
) (
    input  [N_BITS-1:0] word_in,
    output [N_BITS-1:0] word_out
);

    import rv32i_types_pkg::*;

    generate
        genvar i;
        for (i = 0; i < N_BYTES; i++) begin : g_word_assign
            assign word_out[N_BITS-(8*i)-1 : N_BITS-(8*(i+1))] = word_in[((i+1)*8)-1:(i*8)];
        end
    endgenerate

endmodule

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
*   Filename:     crc32.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 04/06/2017
*   Description:  CRC32 calculator.  Takes one byte and keeps the running
*                 crc32 calculation.
*/

module crc32 (
    input logic CLK,
    nRST,
    input logic [7:0] in_byte,
    input logic reset,
    new_byte,
    output logic done,
    output rv32i_types_pkg::word_t result
);

    import rv32i_types_pkg::*;

    parameter POLY = 32'h04c1_1db7;
    parameter POLY_REV = 32'hedb8_8320;
    parameter POLY_REV_REC = 32'h8260_8edb;

    word_t next_crc, curr_crc, mask;
    logic update;
    logic [3:0] count;

    assign result = ~curr_crc;
    assign done = (count[3] & ~new_byte) | reset;
    assign update = ~count[3];
    assign mask = {32{curr_crc[0]}};
    assign next_crc = (curr_crc >> 1) ^ (POLY_REV & mask);

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) curr_crc <= '1;
        else if (reset) curr_crc <= '1;
        else if (new_byte) curr_crc <= curr_crc ^ {24'h0, in_byte};
        else if (update) curr_crc <= next_crc;
    end

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) count <= 4'b1000;
        else if (new_byte) count <= 4'b0000;
        else if (update) count <= count + 1;
    end

endmodule

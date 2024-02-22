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
*   Filename:     rv32v_write_xbar.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 2/3/2024
*   Description:  Mappings from vector lane computation to vector bank
*/

import rv32i_types_pkg::*;
import rv32v_types_pkg::*;

module rv32v_write_xbar
#(
    // parameter of which bank is receiving Writeback signals generated in this module 
    BANK_NUM = 0 
)
(
    input word_t [3:0] lane_dat, 
    input logic[3:0] lane_wen, 
    input vsew_t eew,
    input logic[1:0] bank_offset, 

    output word_t vwdat,
    output logic[3:0] byte_wen
);

// typedef enum logic[1:0] {BYTE_4 = 2'd0, BYTE_2 = 2'd1, BYTE_1 = 2'd2} EEW_TYPE; // put this in a package

always_comb begin
    //default
    vwdat = '0; 
    byte_wen = '0; 

    if(eew == SEW32) begin
        vwdat = lane_dat[BANK_NUM];
        byte_wen = lane_wen[BANK_NUM] ? 4'b1111 : 4'b0000;  
    end
    else if(eew == SEW16) begin
        if(BANK_NUM == bank_offset) begin
            vwdat = {lane_dat[1][15:0], lane_dat[0][15:0]}; 
            byte_wen = { { 2{lane_wen[1]} }, { 2{lane_wen[0]} } }; 
        end 
        else if(BANK_NUM == (bank_offset + 1)) begin
            vwdat = {lane_dat[3][15:0], lane_dat[2][15:0]}; 
            byte_wen = { { 2{lane_wen[3]} }, { 2{lane_wen[2]} } }; 
        end
    end 
    else begin  // eew == SEW8
        if(BANK_NUM == bank_offset) begin
            vwdat = {lane_dat[3][7:0], lane_dat[2][7:0], lane_dat[1][7:0], lane_dat[0][7:0]}; 
            byte_wen = lane_wen; 
        end 
    end
end



endmodule
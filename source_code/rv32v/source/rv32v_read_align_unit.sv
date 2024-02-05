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
*   Filename:     rv32v_read_align_unit.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 2/3/2024
*   Description:  aligning the 32 bit from vector banks to appropriate positions along w/ sign or zero extension  
*/

import rv32i_types_pkg::*;

module rv32v_read_align_unit
#(
    // parameter of which lane is receiving the output data
    LANE_NUM = 0
)
(
    input word_t [3:0] bank_dat, 
    input logic[1:0] eew,
    input logic[1:0] bank_offset, 

    output word_t out_dat
);

typdef enum logic[1:0] {BYTE_4 = 2'd0, BYTE_2 = 2'd1, BYTE_1 = 2'd2} EEW_TYPE; 



always_comb begin
    if(EEW_TYPE'(eew) == BYTE_4) begin
        out_dat = bank_dat[LANE_NUM]; 
    end
    else if(EEW_TYPE'(eew) == BYTE_2) begin
        case(LANE_NUM)
            0,1: out_dat = bank_dat[bank_offset];  
            default: out_dat = bank_dat[bank_offset + 1]; 
        endcase 
        out_dat = bank
    end 
    else begin
        out_dat = bank_dat[bank_offset]; 
    end
end



endmodule
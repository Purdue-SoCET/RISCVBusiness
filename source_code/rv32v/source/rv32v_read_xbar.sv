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
*   Filename:     rv32v_read_xbar.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 2/3/2024
*   Description:  Mappings from vector bank data to appropriate lane  
*/

import rv32v_types_pkg::*;
import rv32i_types_pkg::*;

module rv32v_read_xbar
(
    input word_t [3:0] bank_dat, 
    input vsew_t veew,
    input logic[1:0] bank_offset, 
    input logic sign_ext, 

    output word_t [3:0] out_dat
);

// typedef enum logic[1:0] {BYTE_4 = 2'd0, BYTE_2 = 2'd1, BYTE_1 = 2'd2} EEW_TYPE; 

always_comb begin
    if(veew == SEW32) begin
        out_dat[0] = bank_dat[0];
        out_dat[1] = bank_dat[1]; 
        out_dat[2] = bank_dat[2]; 
        out_dat[3] = bank_dat[3];  
    end
    else if(veew == SEW16) begin
        out_dat[0] = sign_ext ? { {16{bank_dat[bank_offset][15]}}, bank_dat[bank_offset][15:0] } 
                              : {16'b0, bank_dat[bank_offset][15:0]};
        out_dat[1] = sign_ext ? { {16{bank_dat[bank_offset][31]}}, bank_dat[bank_offset][31:16] } 
                              : {16'b0, bank_dat[bank_offset][31:16]};

        out_dat[2] = sign_ext ? { {16{bank_dat[bank_offset + 1][15]}}, bank_dat[bank_offset + 1][15:0] } 
                              : {16'b0, bank_dat[bank_offset + 1][15:0]};
        out_dat[3] = sign_ext ? { {16{bank_dat[bank_offset + 1][31]}}, bank_dat[bank_offset + 1][31:16] } 
                              : {16'b0, bank_dat[bank_offset + 1][31:16]};
    end 
    else begin
        out_dat[0] = sign_ext ? { {24{bank_dat[bank_offset][7]}}, bank_dat[bank_offset][7:0] }
                              : { 24'b0, bank_dat[bank_offset][7:0] };
        out_dat[1] = sign_ext ? { {24{bank_dat[bank_offset][15]}}, bank_dat[bank_offset][15:8] }
                              : { 24'b0, bank_dat[bank_offset][15:8] };
        out_dat[2] = sign_ext ? { {24{bank_dat[bank_offset][23]}}, bank_dat[bank_offset][23:16] }
                              : { 24'b0, bank_dat[bank_offset][23:16] };
        out_dat[3] = sign_ext ? { {24{bank_dat[bank_offset][31]}}, bank_dat[bank_offset][31:16] }
                              : { 24'b0, bank_dat[bank_offset][31:16] };
    end
end

endmodule
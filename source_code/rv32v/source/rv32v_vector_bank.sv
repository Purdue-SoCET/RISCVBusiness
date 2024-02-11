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
*   Filename:     rv32v_vector_bank
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 2/3/2024
*   Description:  vector reg file bank
*/

import rv32i_types_pkg::*;

module rv32v_vector_bank
(
    input logic CLK, nRST, 

    input logic[4:0] vs1, vs2, vw,   
    input word_t vwdata, 
    input logic[3:0] byte_wen, 

    output word_t vdat1, vdat2, v0
);

word_t[31:0]  bank_reg_file; 

assign vdat1 = bank_reg_file[vs1];
assign vdat2 = bank_reg_file[vs2];
assign v0 = bank_reg_file[0]; 

always_ff @(posedge CLK, negedge nRST) begin
    if(~nRST) begin
        bank_reg_file = '{{32{32'b0}}}; 
    end
    else begin
        if(byte_wen[3])
            bank_reg_file[vw][31:24] = vwdat[31:24];

        if(byte_wen[2])
            bank_reg_file[vw][23:16] = vwdat[23:16];

        if(byte_wen[1])
            bank_reg_file[vw][15:8] = vwdat[15:8];

        if(byte_wen[0])
            bank_reg_file[vw][7:0] = vwdat[7:0]; 
    end
end

endmodule
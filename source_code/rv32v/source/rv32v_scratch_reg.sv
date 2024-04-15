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
*   Filename:     rv32v_scratch_reg
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 3/16/2024
*   Description:  vector scratch register
*/

import rv32i_types_pkg::*;
import rv32v_types_pkg::*;

module rv32v_scratch_reg
(
    input logic CLK, nRST,

    input logic vpad_inactive,
    input word_t vpad_word,

    input logic[3:0] vbyte_wen,
    input word_t[3:0] vwdata, 
    output word_t[3:0] vrdata
);

always_ff @(posedge CLK, negedge nRST) begin
    if(~nRST) begin
        vrdata <= '0;
    end else begin
        if (vbyte_wen[0]) begin
            vrdata[0] <= vwdata[0];
        end else if (vpad_inactive) begin
            vrdata[0] <= vpad_word;
        end
        if (vbyte_wen[1]) begin
            vrdata[1] <= vwdata[1];
        end else if (vpad_inactive) begin
            vrdata[1] <= vpad_word;
        end
        if (vbyte_wen[2]) begin
            vrdata[2] <= vwdata[2];
        end else if (vpad_inactive) begin
            vrdata[2] <= vpad_word;
        end
        if (vbyte_wen[3]) begin
            vrdata[3] <= vwdata[3];
        end else if (vpad_inactive) begin
            vrdata[3] <= vpad_word;
        end
    end
end

endmodule

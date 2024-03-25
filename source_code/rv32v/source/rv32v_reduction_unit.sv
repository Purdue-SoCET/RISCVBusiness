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
*   Filename:     rv32v_reduction_unit.sv
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 3/17/2024
*   Description:  performs cross-lane operations required for reduction
*/

import rv32i_types_pkg::*;

module rv32v_reduction_unit
(
    input valuop_t valuop,
    input logic vopunsigned,
    input word_t[3:0] vdat_in,
    input logic[3:0] vmask_in,
    output word_t vdat_out
);

word_t masked_value;
word_t[3:0] vdat_masked;
word_t[1:0] interm;

// Block to figure out which values to use as mask
always_comb begin
    masked_value = '0;

    case (valuop)
        VALU_ADD: begin
            masked_value = '0;
        end

        VALU_MAX: begin
            // Masked off lanes use minimum possible value
            if (vopunsigned) begin
                masked_value = '0;
            end else begin
                masked_value = '1;
            end
        end

        VALU_MIN: begin
            // Masked off lanes use maximum possible value
            if (vopunsigned) begin
                masked_value = '1;
            end else begin
                masked_value = '0;
            end
        end

        VALU_AND: begin
            masked_value = '1;
        end

        VALU_OR: begin
            masked_value = '0;
        end

        VALU_XOR: begin
            masked_value = '0;
        end
    endcase
end

// Block to mask off input lanes as required
always_comb begin
    vdat_masked = vdat_in;

    if (!vmask_in[0]) begin
       vdat_masked[0] = masked_value;
    end
    if (!vmask_in[1]) begin
       vdat_masked[1] = masked_value;
    end
    if (!vmask_in[2]) begin
       vdat_masked[2] = masked_value;
    end
    if (!vmask_in[3]) begin
       vdat_masked[3] = masked_value;
    end
end

always_comb begin
    interm = '0;
    vdat_out = 32'hbad1bad1;

    case (valuop)
        VALU_ADD: begin
            vdat_out = (vdat_masked[0] + vdat_masked[1]) + (vdat_masked[2] + vdat_masked[3]);
        end

        VALU_MAX: begin
            if (vopunsigned) begin
                interm[0] = (vdat_masked[0] > vdat_masked[1]) ? vdat_masked[0] : vdat_masked[1];
                interm[1] = (vdat_masked[2] > vdat_masked[3]) ? vdat_masked[2] : vdat_masked[3];
                vdat_out = (interm[0] > interm[1]) ? interm[0] : interm[1];
            end else begin
                interm[0] = ($signed(vdat_masked[0]) > $signed(vdat_masked[1])) ? $signed(vdat_masked[0]) : $signed(vdat_masked[1]);
                interm[1] = ($signed(vdat_masked[2]) > $signed(vdat_masked[3])) ? $signed(vdat_masked[2]) : $signed(vdat_masked[3]);
                vdat_out = ($signed(interm[0]) > $signed(interm[1])) ? $signed(interm[0]) : $signed(interm[1]);
            end
        end

        VALU_MIN: begin
            if (vopunsigned) begin
                interm[0] = (vdat_masked[0] < vdat_masked[1]) ? vdat_masked[0] : vdat_masked[1];
                interm[1] = (vdat_masked[2] < vdat_masked[3]) ? vdat_masked[2] : vdat_masked[3];
                vdat_out = (interm[0] < interm[1]) ? interm[0] : interm[1];
            end else begin
                interm[0] = ($signed(vdat_masked[0]) < $signed(vdat_masked[1])) ? $signed(vdat_masked[0]) : $signed(vdat_masked[1]);
                interm[1] = ($signed(vdat_masked[2]) < $signed(vdat_masked[3])) ? $signed(vdat_masked[2]) : $signed(vdat_masked[3]);
                vdat_out = ($signed(interm[0]) < $signed(interm[1])) ? $signed(interm[0]) : $signed(interm[1]);
            end
        end

        VALU_AND: begin
            vdat_out = (vdat_masked[0] & vdat_masked[1]) & (vdat_masked[2] & vdat_masked[3]);
        end

        VALU_OR: begin
            vdat_out = (vdat_masked[0] | vdat_masked[1]) | (vdat_masked[2] | vdat_masked[3]);
        end

        VALU_XOR: begin
            vdat_out = (vdat_masked[0] ^ vdat_masked[1]) ^ (vdat_masked[2] ^ vdat_masked[3]);
        end
    endcase
end

endmodule
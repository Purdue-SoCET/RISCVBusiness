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
*   Filename:     rv32v_multiplier.sv
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 02/27/2024
*   Description:  Pipelined multiplier for RV32V vector lanes
*                 (Uses rv32m/pp_mul32.sv)
*                 TODO: Fully pipeline, allowing for independent muls to fill stages
*/

import rv32i_types_pkg::*;
import rv32v_types_pkg::*;

module rv32v_multiplier (
    input logic CLK,
    input logic nRST,
    input vmul_input_t vmul_in,
    output vmul_output_t vmul_out
);

    word_t multiplicand;
    logic [63:0] full_product;
    word_t product;
    logic start, busy, finished;

    pp_mul32 VLANE_MULT (
        .CLK,
        .nRST,
        .multiplicand,
        .multiplier(vmul_in.vs1_data),
        .is_signed(vmul_in.sign),
        .start,
        .finished,
        .product(full_product)
    );

    assign multiplicand = ((vmul_in.vmulop == VMADD) | (vmul_in.vmulop == VNMSUB)) ? vmul_in.vd_data : vmul_in.vs2_data;
    assign start = vmul_in.vmul_en & ~busy;
    assign vmul_out.vmul_busy = start | (busy & ~finished);

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            busy <= 0;
        end else if (vmul_in.vmul_en & ~busy) begin
            busy <= 1;
        end else if (finished) begin
            busy <= 0;
        end
    end

    always_comb begin
        casez (vmul_in.vsew)
            SEW32:
                product = (vmul_in.vmul_ret_high) ? full_product[63:32]
                                                  : full_product[31:0];
                // cannot widen to SEW64
            SEW16:
                product = (vmul_in.vmul_ret_high) ? {16'b0, full_product[32:16]} :
                          (vmul_in.vmul_widen)    ? full_product[31:0]
                                                  : {16'b0, full_product[15:0]};
            SEW8:
                product = (vmul_in.vmul_ret_high) ? {24'b0, full_product[15:8]} :
                          (vmul_in.vmul_widen)    ? {16'b0, full_product[15:0]}
                                                  : {24'b0, full_product[7:0]};
            default: product = full_product[31:0];
        endcase
    end

    always_comb begin
        casez (vmul_in.vmulop)
            VMUL_MACC:  vmul_out.vd_res = vmul_in.vd_data + product;
            VMUL_NMSAC: vmul_out.vd_res = vmul_in.vd_data - product;
            VMUL_MADD:  vmul_out.vd_res = vmul_in.vs2_data + product;
            VMUL_NMSUB: vmul_out.vd_res = vmul_in.vs2_data - product;
            default:    vmul_out.vd_res = product;
        endcase
    end

endmodule // rv32v_multiplier

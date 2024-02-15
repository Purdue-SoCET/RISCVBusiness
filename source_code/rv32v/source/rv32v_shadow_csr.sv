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
*   Filename:     rv32v_shadow_csr.sv
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 02/13/2024
*   Description:  Shadow copy of vector CSR data in decode
*/

// `include "rv32v_types_pkg.vh"
`include "rv32v_shadow_csr_if.vh"

module rv32v_shadow_csr (
    input logic CLK,
    input logic nRST,
    rv32v_shadow_csr_if.shadow shadow_if
);

    import rv32v_types_pkg::*;

    vlmul_t vlmul, vlmul_next;
    vsew_t vsew, vsew_next;
    logic vill, vill_next;
    word_t vl, vl_next;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            vlmul <= '0;
            vsew <= '0;
            vill <= 0;
            vl <= '0;
        end else begin
            vlmul <= vlmul_next;
            vsew <= vsew_next;
            vill <= vill_next;
            vl <= vl_next;
        end
    end

    assign shadow_if.vlmul_shadow = vlmul;
    assign shadow_if.vsew_shadow = vsew;
    // assign shadow_if.vill_shadow = vill;  // don't speculatively raise illegal isn, do so in mem with known vill value
    assign shadow_if.vl_shadow = vl;

    always_comb begin
        vlmul_next = vlmul;
        vsew_next = vsew;
        vill_next = vill;
        vl_next = vl;

        if (shadow_if.flush_decode) begin
            vlmul_next = shadow_if.vtype_arch.vlmul;
            vsew_next = shadow_if.vtype_arch.vsew;
            vill_next = shadow_if.vtype_arch.vill;
            vl_next = shadow_if.vl_arch;
        end else if (shadow_if.vsetvl) begin
            // Update vl if applicable
            if (~shadow_if.vkeepvl) begin
                if (shadow_if.avl_spec <= VLMAX) begin
                    vl_next = shadow_if.avl_spec;
                end else begin
                    vl_next = VLMAX;
                end
            end
            // Update vtype, first check for supported values
            // If illegal, set vill, all else 0
            if (shadow_if.vtype_spec.vsew > SEW32) begin
                vill_next = 1;
                vlmul_next = '0;
                vsew_next = '0;
            end else if (shadow_if.vtype_spec.vta | shadow_if.vtype_spec.vma) begin  // only vma=0, vta=0 supported right now
                vill_next = 1;
                vlmul_next = '0;
                vsew_next = '0;
            end else begin
                vlmul_next = shadow_if.vtype_spec.vlmul;
                vsew_next = shadow_if.vtype_spec.vsew;
            end
        end
    end

endmodule // rv32v_shadow_csr

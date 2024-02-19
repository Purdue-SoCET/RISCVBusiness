/*
*   Copyright 2023 Purdue University
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
*   Filename:     priv_1_12_vector.sv
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 01/30/2024
*   Description:  Vector CSR file, version 1.12
*/

`include "priv_1_12_internal_if.vh"
`include "priv_ext_if.vh"

module priv_1_12_vector (
    input logic CLK,
    input logic nRST,
    priv_1_12_internal_if.vect prv_intern_if,  // has vsetvl, vkeepvl, and new_vtype signals
    priv_ext_if.ext priv_ext_if
);

    import machine_mode_types_1_12_pkg::*;
    import rv32i_types_pkg::*;
    import rv32v_types_pkg::*;

    csr_reg_t         vstart, vstart_next;
    // vxsat
    // vxrm
    // vcsr
    csr_reg_t         vl, vl_next;
    vtype_t           vtype, vtype_next;
    // csr_reg_t         vlenb;  // VLENB = VLEN/8
    logic [$clog2(VLMAX)-1:0] vlmax;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            vstart <= '0;
            vl <= '0;
            vtype <= vtype_t'(0);
        end else begin
            vstart <= vstart_next;
            vl <= vl_next;
            vtype <= vtype_next;
        end
    end

    // vl and vtype exposed for updating shadow copy on flush
    assign prv_intern_if.vl = vl;
    assign prv_intern_if.vtype = vtype;
    // vstart exposed for masking off elements on instruction restart
    assign prv_intern_if.vstart = vstart;

    always_comb begin
        // Compute new vlmax
        casez (prv_intern_if.new_vtype.vlmul)
            LMUL1:      vlmax = (VLEN << prv_intern_if.new_vtype.vsew);
            LMUL2:      vlmax = (VLEN << prv_intern_if.new_vtype.vsew) << 1;
            LMUL4:      vlmax = (VLEN << prv_intern_if.new_vtype.vsew) << 2;
            LMUL8:      vlmax = (VLEN << prv_intern_if.new_vtype.vsew) << 3;
            LMULHALF:   vlmax = (VLEN << prv_intern_if.new_vtype.vsew) >> 1;
            LMULFOURTH: vlmax = (VLEN << prv_intern_if.new_vtype.vsew) >> 2;
            LMULEIGHTH: vlmax = (VLEN << prv_intern_if.new_vtype.vsew) >> 3;
        endcase
    end

    always_comb begin
        vstart_next = vstart;
        vl_next = vl;
        vtype_next = vtype;
        priv_ext_if.value_out = '0;
        priv_ext_if.ack = 1'b0;

        casez (priv_ext_if.csr_addr)
            VSTART_ADDR: begin
                if (priv_ext_if.csr_active) begin
                    vstart_next[$clog2(VLMAX)-1:0] = priv_ext_if.value_in[$clog2(VLMAX)-1:0];
                end
                priv_ext_if.value_out = vstart;
                priv_ext_if.ack = 1'b1;
            end
            /*
            VXSAT_ADDR: begin

            end
            VXRM_ADDR: begin

            end
            VCSR_ADDR: begin

            end
            */
            VL_ADDR: begin
                if (priv_ext_if.csr_active & prv_intern_if.vsetvl) begin
                    // Update vl if applicable (avl on priv_ext_if.value_in)
                    if (~prv_intern_if.vkeepvl) begin
                        vl_next = priv_ext_if.value_in; 
                        // if (priv_ext_if.value_in <= VLMAX) begin
                        //     vl_next = priv_ext_if.value_in;
                        // end else begin
                        //     vl_next = VLMAX;
                        // end
                    end
                    // Update vtype, first check for supported values
                    // If illegal, set vill, all else 0
                    // if (prv_intern_if.new_vtype.vsew > SEW32) begin
                    //     vtype_next.vill = 1;
                    //     vtype_next[30:0] = '0;
                    // end else if (prv_intern_if.new_vtype.vta | prv_intern_if.new_vtype.vma) begin  // only vma=0, vta=0 supported right now
                    //     vtype_next.vill = 1;
                    //     vtype_next[30:0] = '0;
                    // end else begin
                    //     vtype_next.vlmul = prv_intern_if.new_vtype.vlmul;
                    //     vtype_next.vsew = prv_intern_if.new_vtype.vsew;
                    // end
                    vtype_next = prv_intern_if.new_vtype; 
                end
                // if vl was updated, return new vl value
                priv_ext_if.value_out = vl;
                priv_ext_if.ack = 1'b1;
            end
            VTYPE_ADDR: begin
                priv_ext_if.value_out = vtype;
                priv_ext_if.ack = 1'b1;
            end
            VLENB_ADDR: begin
                priv_ext_if.value_out = VLENB;
                priv_ext_if.ack = 1'b1;
            end
        endcase
    end

    assign priv_ext_if.invalid_csr = 1'b0;

endmodule // priv_1_12_vector

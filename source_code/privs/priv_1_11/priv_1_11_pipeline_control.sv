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
*   Filename:     priv_1_11_pipeline_control.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 08/13/2019
*   Description:  Control signals for the pipeline from the exception/IRQ
*                 block
*/
// Code will mainly be used as pipeline control
`include "priv_1_11_internal_if.vh"

module priv_1_11_pipeline_control (
    priv_1_11_internal_if.pipe_ctrl prv_intern_if  // interface for pipeline control
);
    import machine_mode_types_1_11_pkg::*;
    import rv32i_types_pkg::*;

    assign prv_intern_if.insert_pc = prv_intern_if.mret | (prv_intern_if.pipe_clear & prv_intern_if.intr); // insert the PC


    always_comb begin
        prv_intern_if.priv_pc = '0;

        if (prv_intern_if.intr) begin
            if (prv_intern_if.mtvec.mode == VECTORED & prv_intern_if.mcause.interrupt) begin // vectored mode based on the interrupt source
                prv_intern_if.priv_pc = (prv_intern_if.mtvec.base << 2) + (prv_intern_if.mcause.cause << 2);
            end else prv_intern_if.priv_pc = prv_intern_if.mtvec.base << 2;

        end else if (prv_intern_if.mret)
            prv_intern_if.priv_pc = prv_intern_if.mepc; // when leaving the ISR, restore to the original PC

    end


endmodule

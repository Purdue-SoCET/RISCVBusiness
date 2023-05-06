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
*   Filename:     priv_1_12_mode.sv
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 11/16/2022
*   Description:  Processor privilege mode switcher
*/

`include "prv_pipeline_if.vh"
`include "priv_1_12_internal_if.vh"
`include "core_interrupt_if.vh"
`include "priv_ext_if.vh"

module priv_1_12_mode (
    input logic CLK, nRST,
    priv_1_12_internal_if.mode prv_intern_if
);

    import machine_mode_types_1_12_pkg::*;
    import rv32i_types_pkg::*;

    priv_level_t curr_priv_level, next_priv_level;
    logic curr_priv_dmode, next_priv_dmode;
    
    //EXT_DEBUG_SUP
    logic ebreakm_debug_mode, ebreaku_debug_mode;   // ebreak in M/U will cause hart to enter Debug-Mode instead of M-Mode
    logic debug_intr;                               // interrupt caused by debug intr
    assign ebreakm_debug_mode = (prv_intern_if.next_mcause.cause == BREAKPOINT && 
                                curr_priv_level == M_MODE && 
                                prv_intern_if.ebreakm_debug);

    assign ebreaku_debug_mode = (prv_intern_if.next_mcause.cause == BREAKPOINT &&
                                curr_priv_level == U_MODE && 
                                prv_intern_if.ebreaku_debug);
    
    assign debug_intr = (prv_intern_if.next_mcause.cause == DEBUG_INT_M);

    assign prv_intern_if.curr_priv_dmode = curr_priv_dmode;

    always_ff @ (posedge CLK, negedge nRST) begin
        if (~nRST) begin
            curr_priv_level <= M_MODE;
            curr_priv_dmode <= 1'b0;
        end else begin
            curr_priv_level <= next_priv_level;
            curr_priv_dmode <= next_priv_dmode;
        end
    end

    always_comb begin
        next_priv_level = curr_priv_level;
        next_priv_dmode = curr_priv_dmode;
        
        if (prv_intern_if.intr) begin
            next_priv_level = M_MODE;
            
            // implement the real D_MODE
            if(debug_intr) begin
                next_priv_dmode = 1'b1;
            end
            else if(ebreakm_debug_mode) begin
                // set the D_mode flag
                next_priv_dmode = 1'b1;
            end
            else if(ebreaku_debug_mode) begin
                // set the D_mode flag
                next_priv_dmode = 1'b1;
            end

        end else if (prv_intern_if.dret) begin
            // when resume, clear the debug mode flag and return to the priv mode user specified
            next_priv_level = prv_intern_if.curr_dcsr.prv;
            next_priv_dmode = 1'b0;
        end
        else if (prv_intern_if.mret) begin
            next_priv_level = prv_intern_if.curr_mstatus.mpp;
        end 
    end

    assign prv_intern_if.curr_privilege_level = curr_priv_level;

endmodule
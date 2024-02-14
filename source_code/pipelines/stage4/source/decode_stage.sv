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
*   Filename:     stage4_decode_stage.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 11/19/2023
*   Description:  Arbitrate between scalar and vector decode and feed uops into the queue 
*/

// `include "stage4_types_pkg.sv"
//`include "stage4_fet_dec_ex_if.vh"
`include "stage4_hazard_unit_if.vh" 

import stage4_types_pkg::*;
import rv32i_types_pkg::*;
import rv32v_types_pkg::*; 

module decode_stage
(
    input logic CLK,
    input logic nRST,
    // input logic stall_decode,

    input fetch_ex_t fetch_in,
    
    output uop_t uop_out, 
    output logic queue_wen,

    stage4_hazard_unit_if.decode hazard_if 


    // output word_t pc_decode,
    // output logic valid_decode,

    rv32c_if rv32cif
);


word_t scalar_instr;
control_t control;
logic svalid;
word_t scalar_instr; 

// RV32C inputs
assign rv32cif.inst16 = fetch_in.instr[15:0];
assign rv32cif.halt = 1'b0; // TODO: Is this signal necessary? Can't get it right on decode of a halt instruction
assign rv32cif.ex_busy = stall_decode;
assign scalar_instr = rv32cif.c_ena ? rv32cif.inst32 : fetch_in.instr;  //if_stage_in.instr;

// Instantiate scalar decode

scalar_decode U_SCALAR_DECODE(
    .instr(scalar_instr),
    .control_out(control)
);

assign svalid = !control.fault_insn && !control.illegal_insn;


// Instantiate vector decode
vcontrol_t vcontrol;
logic vvalid;
logic vbusy;

//rv32v_control_unit_if vcu_if();
//rv32v_control_unit U_VECTOR_DECODE(vcu_if)

//assign vcu_if.instr = fetch_in.instr;
//assign vcu_if.stall = stall_decode;

// assign vcu_if.vsew = vsew;
// assign vcu_if.vlmul = vlmul;
// assign vcu_if.vl = vl;

// Vector CSR shadow copy
// vsew_t vsew;
// vlmul_t vlmul;
// vl_t vl;

// TODO

// EPC signals for interrupts 
assign hazard_if.valid_decode = fetch_in.valid; 
assign hazard_if.pc_decode = fetch_in.pc; 


// Decode resolution
//assign num_uops = fetch_in.valid ? DISPATCH_SIZE : 0; 
assign queue_wen = ~hazard_if.stall_decode & fetch_in.valid;

always_comb begin
    uop_out.if_out = fetch_in;
    uop_out.ctrl_out = control;
    uop_out.vctrl_out = '{'0};

    // Mux in the register write enable from the vector decode
    // if required
    // if (vvalid) begin
    //     uop_out.ctrl_out.wen = vcontrol.sregwen;
    // end
end

endmodule 
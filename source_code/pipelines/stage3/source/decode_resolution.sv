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
*   Filename:     decode_resolution.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 11/19/2023
*   Description:  Arbitrate between scalar and vector decode and feed uops into the queue 
*/

//`include "stage3_types_pkg.sv"
import stage3_types_pkg::*;
import rv32i_types_pkg::*;

module decode_resolution
#(
    parameter type D_TYPE = fetch_ex_t, 
    parameter QUEUE_LEN = 8,
    parameter DISPATCH_SIZE = 1
)
(
    input D_TYPE[DISPATCH_SIZE-1:0] s_ctrls,
    input logic[$clog2(QUEUE_LEN)+1:0] num_free_slots, 
    input logic[$clog2(DISPATCH_SIZE):0] s_num_uops, 

    
    output D_TYPE[DISPATCH_SIZE-1:0] ctrls, 
    output logic[$clog2(DISPATCH_SIZE):0] num_uops, 
    output logic store,
    output word_t pc_decode,
    output logic valid_decode
);

assign ctrls = s_ctrls; 

assign num_uops = s_ctrls[0].if_out.valid ? DISPATCH_SIZE : 0; 


// EPC signals for interrupts 
assign valid_decode = s_ctrls[0].if_out.valid; 
assign pc_decode = s_ctrls[0].if_out.pc; 

always_comb begin
    if((num_uops > 0) && (num_free_slots >= num_uops))
        store = 1; 
    else 
        store = 0; 
end

endmodule 


// fetch_ex_reg connections
// assign ctrls0.valid = s_ctrls.valid;
// assign ctrls0.token = s_ctrls.token;
// assign ctrls0.mal_insn = s_ctrls.mal_insn;
// assign ctrls0.ault_insn = s_ctrls.ault_insn;
// assign ctrls0.pc = s_ctrls.pc;
// assign ctrls0.pc4 = s_ctrls.pc4;
// assign ctrls0.instr = s_ctrls.instr;
// assign ctrls0.prediction = s_ctrls.prediction;
// assign ctrls0.badaddr = s_ctrls.badaddr;
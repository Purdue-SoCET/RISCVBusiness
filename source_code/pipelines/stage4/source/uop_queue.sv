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
*   Filename:     uop_queue.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 11/19/2023
*   Description:  uop stage in pipeline that recieves input from the IF stage and generates output to the EX stage. 
*/
//'include "stage3_types_pkg.sv"
`include "stage4_fetch_execute_if.vh"

import stage4_types_pkg::*;
import rv32i_types_pkg::*;

module uop_queue 
#(
    parameter type D_TYPE = uop_t, 
    parameter QUEUE_LEN = 8,
    parameter DISPATCH_SIZE = 1
)
(
    input logic CLK,
    input logic nRST,

    input fetch_ex_t fetch_in, 
    output uop_t uop_out

    // stage3_fetch_execute_if.queue fetch_ex_if, 
    // stage3_hazard_unit_if.queue hazard_if

);



D_TYPE[DISPATCH_SIZE-1:0] ctrls;
logic[$clog2(QUEUE_LEN)+1:0] num_free_slots;

logic[$clog2(DISPATCH_SIZE):0] num_uops; 
logic store;

stage4_decode_stage decode(
    .instr(fetch_ex_)
)

// decode_resolution #(.D_TYPE(D_TYPE), .QUEUE_LEN(QUEUE_LEN), .DISPATCH_SIZE(DISPATCH_SIZE)) 
//                   DEC_RES(.num_free_slots(num_free_slots),
//                            .num_uops(num_uops),
//                            .ctrls(ctrls), 
//                            .store(store), 
//                            .valid_decode(hazard_if.valid_decode), 
//                            .pc_decode(hazard_if.pc_decode), 
//                            .s_ctrls(fetch_ex_if.s_ctrls),
//                            .s_num_uops(fetch_ex_if.s_num_uops)
//                            ); 


decode_queue #(.D_TYPE(D_TYPE), .QUEUE_LEN(QUEUE_LEN), .DISPATCH_SIZE(DISPATCH_SIZE))
             DEC_QUEUE(.CLK(CLK),
                       .nRST(nRST),
                       .ctrls(ctrls),
                       .num_uops(num_uops),
                       .stall_queue(hazard_if.stall_queue),
                       .flush_queue(hazard_if.flush_queue),
                       .num_free_slots(num_free_slots),
                       .uop0(fetch_ex_if.uop),
                       .store(store));


assign hazard_if.is_queue_full = (num_free_slots < num_uops) & ~hazard_if.flush_queue; 


endmodule 

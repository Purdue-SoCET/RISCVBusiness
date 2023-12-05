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
*   Filename:     stage3_uop_stage.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 11/19/2023
*   Description:  uop stage in pipeline that recieves input from the IF stage and generates output to the EX stage. 
*/
//'include "stage3_types_pkg.sv"

import stage3_types_pkg::*;
import rv32i_types_pkg::*;

module stage3_uop_stage 
#(
    parameter type D_TYPE = uop_t, 
    parameter QUEUE_LEN = 8,
    parameter DISPATCH_SIZE = 1
)
(
    input logic CLK,
    input logic nRST,
    input fetch_ex_t if_stage_in,
    input logic stall_queue, flush_queue, 

    output D_TYPE ex_stage_in,
    output logic is_queue_full,
    output word_t pc_decode,
    output logic valid_decode, 

    rv32c_if rv32cif
);

D_TYPE[DISPATCH_SIZE-1:0] ctrls; 
logic[$clog2(QUEUE_LEN)+1:0] num_free_slots;
logic[$clog2(DISPATCH_SIZE):0] s_num_uops; 

logic[$clog2(DISPATCH_SIZE):0] num_uops; 
logic store;

// uop_t [DISPATCH_SIZE-1:0] sctrls2; 

D_TYPE[DISPATCH_SIZE-1:0] s_ctrls; 


scalar_decode #(.D_TYPE(uop_t), .DISPATCH_SIZE(DISPATCH_SIZE))
              S_DECODE(.*); 



decode_resolution #(.D_TYPE(D_TYPE), .QUEUE_LEN(QUEUE_LEN), .DISPATCH_SIZE(DISPATCH_SIZE)) 
                  DEC_RES(.num_free_slots(num_free_slots),
                           .num_uops(num_uops),
                           .ctrls(ctrls), .store(store), .valid_decode(valid_decode), .pc_decode(pc_decode), .*); 


decode_queue #(.D_TYPE(D_TYPE), .QUEUE_LEN(QUEUE_LEN), .DISPATCH_SIZE(DISPATCH_SIZE))
             DEC_QUEUE(.CLK(CLK),
                       .nRST(nRST),
                       .ctrls(ctrls),
                       .num_uops(num_uops),
                       .stall_queue(stall_queue),
                       .flush_queue(flush_queue),
                       .num_free_slots(num_free_slots),
                       .uop0(ex_stage_in),
                       .store(store));


assign is_queue_full = (num_free_slots < num_uops) & ~flush_queue; 


endmodule 

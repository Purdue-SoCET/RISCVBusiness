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
*   Filename:     decode_queue.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 11/19/2023
*   Description:  Decode queue for uops 
*/

//`include "stage3_types_pkg.sv"

// import stage3_types_pkg::*;
// import alu_types_pkg::*;
// import rv32i_types_pkg::*;
// import machine_mode_types_1_12_pkg::*;
// import rv32m_pkg::*;

module decode_queue
#(
    parameter type D_TYPE = fetch_ex_t, 
    parameter QUEUE_LEN = 8,
    parameter DISPATCH_SIZE = 1
)
(
    input logic CLK, nRST,
    input D_TYPE [DISPATCH_SIZE-1:0] ctrls, 
    input logic stall_queue, flush_queue, store,
    input logic[$clog2(DISPATCH_SIZE):0] num_uops,  

    output logic[$clog2(QUEUE_LEN)+1:0] num_free_slots,
    output D_TYPE uop0
);

logic[$clog2(QUEUE_LEN)+1:0] tail_idx, nxt_tail_idx; 

D_TYPE[QUEUE_LEN:1] queue_data, nxt_queue_data; // start counting from 1 instead of 0 so I don't have to deal with negative numbers (if tail_idx == 0, then tail_idx - 1= -1) 


assign uop0 = queue_data[1]; // assign up0 to the head to of the queue 

always_ff @(posedge CLK, negedge nRST) begin:TAIL_IDX_REG
    if(~nRST)
        tail_idx = 0; 
    else 
        tail_idx = nxt_tail_idx; 
end

always_ff @(posedge CLK, negedge nRST) begin:QUEUE_DATA_REG
    if(~nRST) begin
        for(int i = 1; i <= QUEUE_LEN; i+=1)
            queue_data[i] <= '0; 
    end
    else begin
        for(int i = 1; i <= QUEUE_LEN; i+=1)
            queue_data[i] <= nxt_queue_data[i]; 
    end
end

always_comb begin: NXT_QUEUE_DATA_LOGIC
    for(int i = 1; i <= QUEUE_LEN; i+=1) // default case, elements retain their values 
        nxt_queue_data[i] = queue_data[i]; 
    
    if(flush_queue) begin
        for(int i = 1; i <= QUEUE_LEN; i+=1)
            nxt_queue_data[i] = '0; 
    end
    else if(~store && ~stall_queue) begin // behaves like a shift register
        for(int i = 1; i <= QUEUE_LEN-1; i+=1 ) begin
            nxt_queue_data[i] = queue_data[i+1];
        end
        nxt_queue_data[QUEUE_LEN] = '0; // shift in a NOP
    end
    else if(store) begin
        if(stall_queue) begin
            for(int i = 1; i <= tail_idx; i+=1)
                nxt_queue_data[i] = queue_data[i]; // retain elements already in the queue
            
            for(int i = tail_idx + 1; i <= tail_idx + num_uops; i+=1)
                nxt_queue_data[i] = ctrls[i - 1 - tail_idx]; // add the uops to the queue

        end
        else begin
            if(tail_idx == 0) begin
                for(int i = 1; i <= num_uops; i+=1) begin
                    nxt_queue_data[i] = ctrls[i-1]; // add all uops 
                end
            end
            else begin
                for(int i = 1; i <= tail_idx - 1; i+=1) // shift in uops already inside queue
                    nxt_queue_data[i] = queue_data[i+1];
                
                for(int i = tail_idx; i <= tail_idx + num_uops - 1 ; i+=1) // store additional uops 
                    nxt_queue_data[i] = ctrls[i - tail_idx];
            end
        end 

    end


end 
always_comb begin:NXT_TAIL_IDX_LOGIC
    if(flush_queue)
        nxt_tail_idx = 0; 
    else if(~store) begin
        if(stall_queue)
            nxt_tail_idx = tail_idx;
        else 
            nxt_tail_idx = tail_idx == 0 ? 0 : tail_idx - 1;
    end
    else begin
        if(stall_queue)
            nxt_tail_idx = tail_idx + num_uops; 
        else 
            nxt_tail_idx = tail_idx == 0 ? num_uops : tail_idx + num_uops - 1;
    end
end

always_comb begin:NUM_FREE_SLOTS
    if(stall_queue)
        num_free_slots = QUEUE_LEN - tail_idx;
    else 
        num_free_slots = tail_idx == 0 ? QUEUE_LEN : ((QUEUE_LEN + 1) - tail_idx); 
end


endmodule 
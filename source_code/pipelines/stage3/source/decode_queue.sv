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
    QUEUE_LEN=8,
    DISPATCH_SIZE=1
)
(
    input logic CLK, nRST,
    input fetch_ex_t [DISPATCH_SIZE-1:0] ctrls, 
    input logic stall_queue, flush_queue, store,
    input logic[$clog2(DISPATCH_SIZE):0] num_uops,  

    output logic[$clog2(QUEUE_LEN)+1:0] num_free_slots,
    output fetch_ex_t uop0
);

logic[$clog2(QUEUE_LEN)+1:0] tail_idx, nxt_tail_idx; 

fetch_ex_t[QUEUE_LEN:1] queue_data, nxt_queue_data; // start counting from 1 instead of 0 so I don't have to deal with negative numbers (if tail_idx == 0, then tail_idx - 1= -1) 


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



// typedef struct packed {
//         // ** fetch_ex_if **  
//         logic valid;
//         logic token;
//         logic mal_insn;
//         logic fault_insn;
//         word_t pc;
//         word_t pc4;
//         word_t instr;
//         word_t prediction;
//         word_t badaddr;

//         // ** cu_if ** 
//         logic dwen, dren;
//         logic j_sel;
//         logic branch; 
//         logic jump; 
//         logic ex_pc_sel;
//         logic imm_shamt_sel; 
//         logic halt; 
//         logic wen; 
//         logic ifence;
//         logic wfi;
//         aluop_t alu_op;
//         logic [1:0] alu_a_sel;
//         logic[1:0] alu_b_sel;
//         logic [2:0] w_sel;
//         logic [4:0] shamt;
//         logic [4:0] rd;
//         logic [11:0] imm_I;
//         logic[11:0] imm_S;
//         logic [20:0] imm_UJ;
//         logic [12:0] imm_SB;
//         word_t imm_U;
//         load_t load_type;
//         branch_t branch_type;
//         opcode_t opcode;

//         logic fault_insn; 
//         logic illegal_insn;
//         logic ret_insn;
//         logic breakpoint;
//         logic ecall_insn;
//         logic csr_swap;
//         logic csr_set;
//         logic csr_clr;
//         logic csr_imm;
//         logic csr_rw_valid;
//         csr_addr_t csr_addr;
//         logic [4:0] zimm;

//         rv32m_decode_t rv32m_control;

//         // ** rf_if ** 
//         logic [4:0] rs1;
//         logic [4:0] rs2; 

// } uop_type;
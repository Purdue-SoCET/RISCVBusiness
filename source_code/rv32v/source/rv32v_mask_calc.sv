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
*   Filename:     rv32v_mask_calc.sv 
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 3/23/2024
*   Description:  Computes mask results from special mask instructions (vpopc, vfirst, etc.) 
*/

import rv32i_types_pkg::*;

module rv32v_mask_calc
(   
    input logic CLK, nRST, 
    input logic[127:0] mask_src, mask_dest, v0_mask, 
    input logic[31:0] vl, // needed for masking 
    input logic flush, mask_en, 
    input logic final_instr,
    input logic stall, 

    input vexec_t vexec, 
    input logic[4:0] uop_num,

    output logic busy, 
    output logic[127:0] mask_calc_out 
);

typedef enum {IDLE, VPOPC_1, VPOPC_2, VPOPC_DONE,
         VFIRST_1, VFIRST_2, VFIRST_DONE,  
         VMSBF, VMSIF, VMSOF} state_t; 


// VPOPC SIGNALS
logic[31:0] vpopc_out; 
logic[31:0] nxt_vpopc_out; 

// VFIRST SIGNALS 
logic[31:0] vfirst_out; 
logic[31:0] nxt_vfirst_out; 
logic[31:0] priority_enc_res;  

// VMS* SIGNALS 
logic[127:0] vms_out; 

// VIOTA AND VID SIGNALS
logic[31:0] prev_sum; 
logic[31:0] nxt_sum; 
logic[127:0] viota_out; // vid instruction uses the same datapath
logic[3:0] viota_mask_src; 
logic[7:0] viota_start_idx; 


state_t curr_state, nxt_state; 
logic[31:0] internal_reg, nxt_internal_reg; 

always_ff @(negedge nRST, posedge CLK) begin
    if(~nRST) begin
        internal_reg <= '0; 
        curr_state <= IDLE; 
    end 
    else begin
        if(flush) begin
            internal_reg <= '0; 
            curr_state <= IDLE; 
        end 
        else begin
            internal_reg <= nxt_internal_reg; 
            curr_state <= nxt_state; 
        end 

    end 
end 

always_comb begin: NXT_STATE_AND_INTERNAL_REG_LOGIC
    nxt_state = curr_state;
    nxt_internal_reg = internal_reg;
    busy = 1'b0;  
    case(curr_state)
        IDLE: begin
            case(vexec.vmaskop)
                VMSK_CNT: begin 
                    if(~stall) begin
                        nxt_state = VPOPC_1; 
                        nxt_internal_reg[31:0] = nxt_vpopc_out; 
                        busy = 1'b1; 
                    end 
                    
                end 
                VMSK_SBF, VMSK_SIF, VMSK_SOF, VMSK_FST: begin 
                    if(~stall) begin
                        nxt_state = VFIRST_1; 
                        nxt_internal_reg[31:0] = nxt_vfirst_out; 
                        busy = 1'b1; 
                    end 
                end 
                VMSK_ITA, VMSK_IDX: begin
                    if(~stall) begin
                        if(!final_instr)
                            nxt_internal_reg[31:0] = nxt_sum; 
                        else 
                            nxt_internal_reg = '0; 
                    end 
                end 
            endcase 
        end 
        VPOPC_1: begin 
            nxt_state = VPOPC_2; 
            nxt_internal_reg[31:0] = nxt_vpopc_out;
            busy = 1'b1;  
        end 
        VPOPC_2: begin 
            nxt_state= VPOPC_DONE; 
            nxt_internal_reg[31:0] = nxt_vpopc_out; 
            busy = 1'b1; 
        end 
        VPOPC_DONE: begin
             nxt_state = IDLE; 
             nxt_internal_reg = '0; 
             busy = 1'b0; 
        end 
        VFIRST_1: begin 
            nxt_state = VFIRST_2;
            nxt_internal_reg[31:0] = nxt_vfirst_out; 
            busy = 1'b1; 
        end 
        VFIRST_2: begin 
            nxt_state = VFIRST_DONE;
            nxt_internal_reg[31:0] = nxt_vfirst_out;
            busy = 1'b1;  
        end 
        VFIRST_DONE: begin
            case(vexec.vmaskop)
                VMSK_SBF: begin 
                    nxt_state = VMSBF; 
                    nxt_internal_reg[31:0] = nxt_vfirst_out; 
                    busy = 1'b1; 
                end 
                VMSK_SIF: begin 
                    nxt_state = VMSIF; 
                    nxt_internal_reg[31:0] = nxt_vfirst_out; 
                    busy = 1'b1; 
                end 
                VMSK_SOF: begin 
                    nxt_state = VMSOF; 
                    nxt_internal_reg[31:0] = nxt_vfirst_out;
                    busy = 1'b1;  
                end 
                default: begin 
                    nxt_state = IDLE; 
                    nxt_internal_reg[31:0] = '0; 
                    busy = 1'b0; 
                end 
            endcase 
        end 
        VMSBF, VMSIF, VMSOF: begin
            nxt_state = IDLE; 
            nxt_internal_reg = '0; 
            busy = 1'b0; 
        end 


    endcase 
end 


always_comb begin: MASK_CALC_OUT_LOGIC
    mask_calc_out = '0; 
    case(vexec.vmaskop)
        VMSK_CNT: mask_calc_out[31:0] = nxt_vpopc_out; 
        VMSK_FST: mask_calc_out[31:0] =  nxt_vfirst_out; 
        VMSK_SBF, VMSK_SIF, VMSK_SOF: mask_calc_out = vms_out; 
        VMSK_ITA, VMSK_IDX: mask_calc_out = viota_out; 
    endcase 
end 



//*** Masking mask_src bits due to vl, v0_mask, mask_en values ****//
logic[127:0] mask_src_masked; 
always_comb begin: CALC_MASK_SRC_MASKED

    for(int i = 0; i < 128; i++) begin
        if(i < vl && ~mask_en)
            mask_src_masked[i] = mask_src[i];
        else if(i < vl && mask_en && v0_mask[i])
            mask_src_masked[i] = mask_src[i]; 
        else 
            mask_src_masked[i] = 1'b0; 
    end 
end 



//**** VPOPC OUTPUT LOGIC  ****//
assign vpopc_out = internal_reg[31:0]; 

logic[31:0] active_bits;
always_comb begin
    nxt_vpopc_out = 0; 
    active_bits = '0; 
    case(curr_state)
        IDLE: begin 
            active_bits = mask_src_masked[31:0]; 
        end
        VPOPC_1, VFIRST_1: begin 
            active_bits = mask_src_masked[63:32]; 
        end 
        VPOPC_2, VFIRST_2: begin 
            active_bits = mask_src_masked[95:64]; 
        end
        VPOPC_DONE, VFIRST_DONE: begin
            active_bits = mask_src_masked[127:96];
        end
    endcase 


    nxt_vpopc_out = vpopc_out; 
    for(int i = 0; i < 32; i++) begin
       nxt_vpopc_out += active_bits[i];
    end
end


//**** VFIRST OUTPUT LOGIC ****//
assign vfirst_out = internal_reg[31:0]; 

always_comb begin
    nxt_vfirst_out = 'b0; 
    priority_enc_res = '1; 
    for(int i = 0; i < 32; i++) begin
        if(active_bits[i] == 1'b1) begin
            priority_enc_res = i; 
            break; 
        end 
    end 

    case(curr_state)
        IDLE: begin 
            nxt_vfirst_out = priority_enc_res; 
        end
            VFIRST_1: begin 
            nxt_vfirst_out = vfirst_out == '1 ? (priority_enc_res == '1 ? '1 : priority_enc_res + 32) : vfirst_out; 
                                                    
        end 
            VFIRST_2: begin 
            nxt_vfirst_out = vfirst_out == '1 ? (priority_enc_res == '1 ? '1 : priority_enc_res + 64) : vfirst_out; 
        end
            VFIRST_DONE: begin
             nxt_vfirst_out = vfirst_out == '1 ? (priority_enc_res == '1 ? '1 : priority_enc_res + 96) : vfirst_out; 
        end
    endcase 

   
end


//**** VMSBF, VMSIF, VMSOF LOGIC ****//
always_comb begin
    vms_out = 0; 
    // these instructions use the value from vfirst to produce an output
    case(curr_state)
        VMSBF: begin
            vms_out = 1; 
            if(vfirst_out != 32'hffffffff)
                vms_out = (vms_out << vfirst_out) - 1; 
            else 
                vms_out = '1; 
        end 
        VMSIF: begin
            vms_out = 1; 
            if(vfirst_out != '1) begin
                vms_out = (vms_out << (vfirst_out)) - 1; 
                vms_out[vfirst_out] = 1'b1;
            end 
            else 
                vms_out = '1; 
        end
        VMSOF: begin
            vms_out = 1; 
            if(vfirst_out != '1)
                vms_out = vms_out << vfirst_out; 
            else 
                vms_out = '0; 
        end
    endcase 

    // mask the output dependeding on vl, mask_en, and v0
    for(int i = 0; i < 128; i++) begin
        if(i > vl || (mask_en && ~v0_mask[i]))
            vms_out[i] = mask_dest[i]; // retains original value and does not overwrite it
    end 
end 

//**** VIOTA, VID LOGIC ****//
assign prev_sum = internal_reg[31:0]; 

always_comb begin
    viota_start_idx = {uop_num, 2'b0};   

    viota_mask_src[0] = mask_src_masked[viota_start_idx]; 
    viota_mask_src[1] = mask_src_masked[viota_start_idx + 1]; 
    viota_mask_src[2] = mask_src_masked[viota_start_idx + 2];
    viota_mask_src[3] = mask_src_masked[viota_start_idx + 3];  


    // if instruction is vid instruction, set all the mask bits to 1s; 
    if(vexec.vmaskop == VMSK_IDX)
        viota_mask_src = '1; 

    // calculate parallel prefix sum 
    viota_out[31:0]   = prev_sum; 
    viota_out[63:32]  = viota_out[31:0] + viota_mask_src[0]; 
    viota_out[95:64]  = viota_out[63:32] + viota_mask_src[1];
    viota_out[127:96] = viota_out[95:64] + viota_mask_src[2];
    
    nxt_sum = viota_out[127:96] + viota_mask_src[3];  

end  

endmodule
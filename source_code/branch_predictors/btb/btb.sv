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
*   Filename:     btb.sv
*
*   Created by:   Yueting Zhao
*   Email:        zhao979@purdue.edu
*   Date Created: 07/07/2023
*   Description:  Branch target buffer that caches target address and predicted branch direction. 
*/

`include "predictor_pipeline_if.vh"

module btb (
    input logic CLK, nRST,
    predictor_pipeline_if.predictor predict_if
);
	import rv32i_types_pkg::*;

	localparam N_FRAMES = 32;
	localparam ASSOC = 2;
	localparam N_SETS = N_FRAMES / ASSOC;
	localparam N_PRED_BITS = 1;
	localparam N_TAG_BITS = 8 - N_PRED_BITS;
	localparam N_SET_BITS = $clog2(N_SETS) + (N_SETS == 1);
	localparam N_IGNORE_BITS = WORD_SIZE - N_TAG_BITS - N_SET_BITS - 2;

	typedef struct packed {
		logic [N_TAG_BITS-1:0] tag;
		word_t target;
		logic [N_PRED_BITS-1:0]taken;
	} btb_frame_t;		// BTB frame

	typedef struct packed {
		btb_frame_t [ASSOC-1:0] frames;
	} btb_set_t;		// BTB set
	
	typedef struct packed {
		logic [N_IGNORE_BITS-1:0] ignore_bits;
		logic [N_TAG_BITS-1:0] tag_bits;
		logic [N_SET_BITS-1:0] idx_bits;
		logic [1:0] byte_bits;
	} btb_addr_t;		// decoded curr PC type

	btb_set_t [N_SETS-1:0] buffer;
	btb_addr_t curr_pc, update_pc;
	btb_set_t selected_set, update_set;
	btb_frame_t selected_frame, update_frame;
	
	assign curr_pc = predict_if.current_pc; // convert PC to decoded type
	assign update_pc = predict_if.pc_to_update;
	assign selected_set = buffer[curr_pc.idx_bits];
	assign selected_frame = selected_set.frames[1];	// new entry default to frame 1
	assign update_set = buffer[update_pc.idx_bits];

	// FIXME: can't have update_frame in FF
	assign update_frame = (update_set.frames[1].tag == update_pc.tag_bits) ? update_set.frames[1] : update_set.frames[0];
							// update entry default to frame 0

	always_ff @(posedge CLK, negedge nRST) begin
		if(!nRST) begin
			buffer <= '0;
		end else begin
			if(predict_if.update_predictor) begin
				// update entry		
				update_frame.tag <= update_pc.tag_bits;
				update_frame.taken <= predict_if.branch_result;
				update_frame.target <= predict_if.update_addr;	
			end
		end
	end

	// get prediction
	always_comb begin
		if(selected_set.frames[0].tag != curr_pc.tag_bits && selected_set.frames[1].tag != curr_pc.tag_bits) begin
			// current PC not in buffer: predict not taken, 
			// FIXME: DO NOT enter PC in an invalid frame or frame 1
			selected_frame = (selected_set.frames[0].target == '0) ? selected_set.frames[0] : selected_set.frames[1];
			predict_if.predict_taken = 0;
			predict_if.target_addr = predict_if.is_rv32c ? predict_if.current_pc + 2 : predict_if.current_pc + 4;
			selected_frame.target = predict_if.target_addr;
			selected_frame.taken = predict_if.predict_taken;
			selected_frame.tag = curr_pc.tag_bits;
		end
		else begin
			selected_frame = (selected_set.frames[0].tag == curr_pc.tag_bits)? selected_set.frames[0] : selected_set.frames[1];
			predict_if.predict_taken = selected_frame.taken;
			predict_if.target_addr = selected_frame.taken ? selected_frame.target
									 : predict_if.is_rv32c ? predict_if.current_pc + 2
									 : predict_if.current_pc + 4;
		end 
	end

	
endmodule

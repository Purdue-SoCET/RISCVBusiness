`include "predictor_pipeline_if.vh"

module btb_ghr_pht #(
	parameter PRED_BITS = 2,
    parameter SIZE = 4
)
(
    input logic CLK, nRST,
    predictor_pipeline_if.predictor predict_if
);  

	import rv32i_types_pkg::*;

	localparam N_FRAMES		= 32;
	localparam ASSOC		= 2;
	localparam N_SETS		= N_FRAMES / ASSOC;
	//localparam N_PRED_BITS = 1;
	localparam N_TAG_BITS	= 8 - PRED_BITS;
	localparam N_SET_BITS	= $clog2(N_SETS) + (N_SETS == 1);
	localparam N_IGNORE_BITS = WORD_SIZE - N_TAG_BITS - N_SET_BITS - 2;

	typedef struct packed {
		logic [N_TAG_BITS-1:0] tag;
		word_t target;
		logic [PRED_BITS-1:0]taken;
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
	btb_set_t selected_set, next_set, update_set;
	btb_frame_t selected_frame; 
	logic GHR_taken;
	//logic BTB_hit;

	assign curr_pc = predict_if.current_pc; // convert PC to decoded type
	assign update_pc = predict_if.pc_to_update;
	assign selected_set = buffer[curr_pc.idx_bits];
	assign selected_frame = (selected_set.frames[0].tag == curr_pc.tag_bits)? selected_set.frames[0] : selected_set.frames[1];
	assign update_set = buffer[update_pc.idx_bits];

     // Instantiate ghr_pht
    ghr_pht # (.SIZE(SIZE), .PRED_BITS(PRED_BITS)) ghr_pht (
        .CLK(CLK), 
        .nRST(nRST), 
        .predict_if(predict_if), 
        .GHR_taken(GHR_taken)
    );

	always_ff @(posedge CLK, negedge nRST) begin
		if(!nRST) begin
			buffer <= '0;
		end else begin
			buffer[update_pc.idx_bits] <= next_set;	
		end
	end

	// update BTB
	always_comb begin	:	update_logic
		next_set = buffer[update_pc.idx_bits];
		if(predict_if.update_predictor) begin
			if(update_set.frames[1].tag == update_pc.tag_bits || update_set.frames[1].target == '0) begin
				// frame 1 matches with the update_pc, or frame 1 is empty, replace frame 1
				next_set.frames[1].tag = update_pc.tag_bits;
				//next_set.frames[1].taken = {next_set.frames[1].taken[PRED_BITS-1:0], predict_if.branch_result} [PRED_BITS-1:0];
				next_set.frames[1].target = predict_if.update_addr;
			end else begin
					// otherwise, replace frame 0
				next_set.frames[0].tag = update_pc.tag_bits;
				//next_set.frames[0].taken = {next_set.frames[0].taken[PRED_BITS-1:0], predict_if.branch_result} [PRED_BITS-1:0];
				//next_set.frames[0].taken <<= predict_if.branch_result;
				next_set.frames[0].target = predict_if.update_addr;
			end
		end
	end

    // get prediction
	always_comb begin	:	predict_logic
		if(selected_set.frames[0].tag != curr_pc.tag_bits && selected_set.frames[1].tag != curr_pc.tag_bits) begin
			// current PC not in buffer: predict not taken, 
			predict_if.predict_taken = 0;
			predict_if.target_addr = predict_if.is_rv32c ? predict_if.current_pc + 2 : predict_if.current_pc + 4;
		end
		else begin
			// if using 2 bit predictor:
			// 00 - strongly NT, 01 - NT, 11 - strongly T, 10 - T
			predict_if.predict_taken = (predict_if.is_branch)? GHR_taken : 0;
			predict_if.target_addr = predict_if.predict_taken ? selected_frame.target
									 : predict_if.is_rv32c ? predict_if.current_pc + 2
									 : predict_if.current_pc + 4;
		end 
	end

endmodule

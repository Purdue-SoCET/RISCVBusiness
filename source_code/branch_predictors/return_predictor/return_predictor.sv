`include "predictor_pipeline_if.vh"

module return_predictor #(parameter entries=4)(input logic CLK, nRST, predictor_pipeline_if.predictor predict_if);

	import rv32i_types_pkg::*;
	logic [1:0] nxt_pointer, pointer;
	logic [31:0] inst, nxt_inst;
	logic [5:0] ras[3:0];
    logic [5:0] nxt_ras[3:0];
	logic link1, link2;
    integer i;
    //integer num;

	//question. If it is push, do I need to add the address as target_address and predict_taken?? I would assume no.
    //does that mean you only push with JAL, and pop needs to be JALR???
	//How should I get value of x1 and x5.
    
	always_ff@(posedge CLK, negedge nRST) begin
		if (!nRST) begin
			pointer <= 0;
            inst <= 0;
            for (i=0; i<entries; i++) ras[i] <= 6'b0;
        end
		else begin
			pointer <= nxt_pointer;
            inst <= nxt_inst;
            ras <= nxt_ras;
        end
	end

	always_comb begin
	    nxt_inst = predict_if.instr;
        predict_if.predict_taken = 0;
		nxt_pointer = pointer;
        nxt_ras = ras;
        //num = 0;

		link1 = 0;
		link2 = 0;
		if (inst[11:7] == 5'h1 || inst[11:7] == 5'h5) //defined constant
			link1 = 1;
		if (inst[19:15] == 5'h1 || inst[19:15] == 5'h5)
			link2 = 1;

		if(inst[6:0] == JAL && link1) begin
            //predict_if.predict_taken = 1;
			nxt_ras[pointer] = inst[11:7];// + 4;
			if(pointer == entries-1) nxt_pointer = 0;
			else nxt_pointer = pointer+1;
        end
		else if(inst[6:0] == JALR) begin
            //num = 1;
			case({link1, link2, inst[19:15]==inst[11:7]})
				3'b010, 3'b011: begin //pop
                    if(pointer == 0) nxt_pointer = 0;
                    else begin
                        nxt_pointer -= 1;
                        predict_if.predict_taken = 1;
                        predict_if.target_addr = nxt_ras[pointer-1];
                    end
                    //num = 2;
                end
                3'b100, 3'b101, 3'b111: begin //push
                    nxt_ras[pointer] = inst[11:7];// + 4;
			        if(pointer == entries-1) nxt_pointer = 0;
			        else nxt_pointer = pointer+1;
                    //num = 3;
                end
                3'b110: begin //push and pop
                    if(pointer != 0) begin
                        predict_if.predict_taken = 1;
                        predict_if.target_addr = nxt_ras[pointer-1];
                        nxt_ras[pointer-1] = inst[11:7];
                    end
                    //num = 4;
                end
			endcase	
		end
	end
endmodule



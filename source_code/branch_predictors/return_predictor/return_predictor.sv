`include "predictor_pipeline_if.vh"
`include "rv32e_reg_file.sv"

module return_predictor #(parameter entries=4)(input logic CLK, nRST, predictor_pipeline_if.predictor predict_if);

	import rv32i_types_pkg::*;
	//rtype_t rtype;???
	//input current_pc
	//output predict_taken, target_addr
	//this logic, but how exactly to implement it???
	//predict_if.predict_taken = (rs1==x1)||(rs1==x5);
	//predict_if.target_addr = rs1;
	logic [1:0] nxt_pointer, pointer;
	logic [31:0] pc, nxt_pc; //this shouldn't be pc. It should be instruction. Where can we get this info???
	logic [5:0] ras[3:0];
    logic [5:0] nxt_ras[3:0];
	logic link1, link2;

	//question. If it is push, do I need to add the address as target_address and predict_taken?? I would assume no.
    //does that mean you only push with JAL, and pop needs to be JALR???
	//How should I get value of x1 and x5.

	always_ff@(posedge CLK, negedge nRST) begin
		if (nRST) begin
			pointer <= 0;
            pc <= 0;
            ras <= 0;
        end
		else begin
			pointer <= nxt_pointer;
            pc <= nxt_pc;
            ras <= nxt_ras;
        end
	end

	always_comb begin
		nxt_pc = predict_if.current_pc;
        predict_if.predict_taken = 0;
		nxt_pointer = pointer;
        nxt_ras = ras;
		if(pc[6:0] == JAL && link1) begin
            //predict_if.predict_taken = 1;
			nxt_ras[pointer] = pc[11:7];// + 4;
			if(pointer == entries-1) nxt_pointer = 0;
			else nxt_pointer = pointer+1;
        end
		else if(pc[6:0] == JALR) begin
			case({link1, link2, pc[19:15]==pc[11:7]})
				({!link1, link2, 0}), ({!link1, link2, 1}): begin //pop
                    predict_if.predict_taken = 1;
                    predict_if.target_addr = nxt_ras[pointer-1];
                    nxt_pointer -= 1;
                end
                ({link1, !link2, 0}), ({link1, !link2, 1}), ({link1, link2, 1}): begin //push
                    nxt_ras[pointer] = pc[11:7];// + 4;
			        if(pointer == entries-1) nxt_pointer = 0;
			        else nxt_pointer = pointer+1;
                end
                {link1, link2, 0}: begin //push and pop
                    predict_if.predict_taken = 1;
                    predict_if.target_addr = nxt_ras[pointer-1];
                    nxt_ras[pointer-1] = pc[11:7];
                end
			endcase	
		end
	end

	always_comb begin
		link1 = 0;
		link2 = 0;
		if (pc[11:7] == 1 || pc[11:7] == 5) //defined constant
			link1 = 1;
		if (pc[19:15] == 1 || pc[19:15] == 5)
			link2 = 1;
	end
endmodule


`include "predictor_pipeline_if.vh"

module return_predictor #(
    parameter ENTRIES=4
)(
    input logic CLK, nRST,
    predictor_pipeline_if.predictor predict_if
);

    import rv32i_types_pkg::*;
    logic [$clog2(ENTRIES)-1:0] nxt_pointer, pointer;
    logic [31:0] inst, nxt_inst;
    logic [5:0] ras[ENTRIES-1:0];
    logic [5:0] nxt_ras[ENTRIES-1:0];
    logic link1, link2;
    integer i;

    always_ff@(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            pointer <= 0;
            inst <= 0;
            for (i=0; i<ENTRIES; i++) ras[i] <= 6'b0;
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

        link1 = 0;
        link2 = 0;
        if (inst[11:7] == 5'h1 || inst[11:7] == 5'h5) //defined constant
            link1 = 1;
        if (inst[19:15] == 5'h1 || inst[19:15] == 5'h5)
            link2 = 1;

        if(inst[6:0] == JAL && link1) begin
            nxt_ras[pointer] = inst[11:7];// + 4;
            if(pointer == ENTRIES-1) nxt_pointer = 0;
            else nxt_pointer = pointer+1;
        end
        else if(inst[6:0] == JALR) begin
            case({link1, link2, inst[19:15]==inst[11:7]})
                3'b010, 3'b011: begin //pop
                    predict_if.predict_taken = 1;
                    if(pointer == 0) begin
                        nxt_pointer = 0;
                        predict_if.target_addr = nxt_ras[pointer];
                    end
                    else begin
                        nxt_pointer -= 1;
                        predict_if.target_addr = nxt_ras[pointer-1];
                    end
                end
                3'b100, 3'b101, 3'b111: begin //push
                    nxt_ras[pointer] = inst[11:7];// + 4;
                    if(pointer == ENTRIES-1) nxt_pointer = 0;
                    else nxt_pointer = pointer+1;
                end
                3'b110: begin //push and pop
                    predict_if.predict_taken = 1;
                    if(pointer != 0) begin
                        predict_if.target_addr = nxt_ras[pointer-1];
                        nxt_ras[pointer-1] = inst[11:7];
                    end
                    else begin
                        predict_if.target_addr = nxt_ras[pointer];
                        nxt_ras[pointer] = inst[11:7];
                    end
                end
            endcase
        end
    end
endmodule



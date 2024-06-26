module rv32aes_alu(
    input [31:0] a,
    input [31:0] b,
    input rv32aes_pkg::rv32aes_op_t aluop,
    output logic [31:0] y
);
   
    import rv32aes_pkg::*;
    logic [5:0] acc;

    function [7:0] xperm8_lookup;
        input [7:0] idx;
        input [31:0] lut;
        begin
            logic [31:0] lut_shift;
            lut_shift = lut >> {idx,3'b000};
            xperm8_lookup = lut_shift[7:0];
        end  
    endfunction

    function [3:0] xperm4_lookup;
        input [3:0] idx;
        input [31:0] lut;
        begin
            logic [31:0] lut_shift;
            lut_shift = lut >> {idx,2'b00};
            xperm4_lookup = lut_shift[3:0];
        end  
    endfunction

    always_comb begin
        acc = 0;
        casez(aluop)
            XPERM8: begin
                for (int i = 0; i < 32; i = i + 8) begin
                        y[i + 7:i] = xperm8_lookup(b[i + 7:i], a);
                end
            end   
            XPERM4: begin
                for (int i = 0; i < 32; i = i + 4) begin
                        y[i + 3:i] = xperm4_lookup(b[i + 3:i], a);
                end
            end
            default: y = 0;
        endcase
    end

endmodule

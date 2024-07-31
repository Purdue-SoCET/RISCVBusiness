module rv32zc_handler(
    input [31:0] a,
    input [31:0] b,
    input rv32zc_pkg::rv32zc_op_t aluop,
    output logic [31:0] y
);
   
    import rv32zc_pkg::*;
    logic [31:0] rd_temp;

    always_comb begin
        rd_temp = 0;
        casez(aluop)
            NEZ: begin 
                if (b != 0) begin 
                    rd_temp = 0; 
                end else begin 
                    rd_temp = a;    
                end
            end 
            EQZ: begin 
                if (b == 0) begin 
                    rd_temp = 0; 
                end else begin 
                    rd_temp = a; 
                end
            end 
        endcase
        y = rd_temp; 
    end

endmodule

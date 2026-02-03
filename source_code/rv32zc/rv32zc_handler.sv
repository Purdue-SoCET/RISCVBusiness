module rv32zc_handler(
    input [31:0] a,
    input [31:0] b,
    input rv32zc_pkg::rv32zc_op_t aluop,
    output logic [31:0] y
);

    import rv32zc_pkg::*;
    logic [31:0] rd_temp;

    always_comb begin
        casez(aluop)
            NEZ: begin
                y = (b != 0) ? 0 : a;
            end
            EQZ: begin
                y = (b == 0) ? 0 : a;
            end
        endcase
    end


endmodule

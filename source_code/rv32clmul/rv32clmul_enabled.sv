module rv32clmul_enabled (
    input  logic CLK,
    input  logic nRST,
    input  logic rv32clmul_start,
    input  rv32clmul_pkg::rv32clmul_op_t operation,
    input  logic [31:0] rv32clmul_a,
    input  logic [31:0] rv32clmul_b,
    output logic rv32clmul_done,
    output logic [31:0] rv32clmul_out
);
    import rv32clmul_pkg::*;

    logic [63:0] clmul_full_out;

    // Your existing carryless multiplier math block
    carryless #(.N(32)) CLMUL_U (
        .a(rv32clmul_a),
        .b(rv32clmul_b),
        .c(clmul_full_out)
    );

    // Single-cycle / combinational unit: always ready
    assign rv32clmul_done = 1'b1;

    // Pick result based on operation
    always_comb begin
        case (operation)
            CLMUL:   rv32clmul_out = clmul_full_out[31:0];
            default: rv32clmul_out = 32'b0;
        endcase
    end

endmodule
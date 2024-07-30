// Modified Booth Multiplier - 8 bits
// Modified from pp_mul32.sv in source_code/rv32m
module mul8 (
    input logic CLK,
    input logic nRST,
    input logic [7:0] multiplicand,
    input logic [7:0] multiplier,
    input logic [1:0] is_signed,
    input logic start,
    output logic finished,
    output logic [15:0] product
);
    //logic start_reg;
    logic [15:0] result, result2,
                 temp_product, temp_product2;
    logic [7:0] multiplicand_reg, multiplier_reg,
                multiplicand_mod, multiplier_mod,
                mul_plus2, mul_minus2, mul_minus1;
    logic [1:0] is_signed_reg;
    logic adjust_product;
    logic [15:0] partial_product[4], pp[4], pp0, pp1, pp2, pp3;
    logic [8:0] modified_in;
    logic [15:0] sum0, sum1,
                 cout0, cout1;
    integer i, j;

    // Register inputs
    always_ff @(posedge CLK, negedge nRST) begin
        if (nRST == 0) begin
            multiplicand_reg <= '0;
            multiplier_reg   <= '0;
            is_signed_reg    <= '0;
        end else if (start) begin
            multiplicand_reg <= multiplicand;
            multiplier_reg   <= multiplier;
            is_signed_reg    <= is_signed;
        end
    end

    // Modify multiplicand and multiplier if they are signed
    assign multiplier_mod   = is_signed_reg[0] && multiplier_reg[7] ?
                                (~(multiplier_reg)+1) : multiplier_reg;
    assign multiplicand_mod = is_signed_reg[1] && multiplicand_reg[7] ?
                                (~(multiplicand_reg)+1) : multiplicand_reg;

    // Control signal to modify final product
    assign adjust_product   = (is_signed_reg[0] & multiplier_reg[7])
                            ^ (is_signed_reg[1] & multiplicand_reg[7]);

    // For bit pair recoding part
    assign mul_plus2 = multiplicand_mod << 1;
    assign mul_minus2 = ~mul_plus2 + 1;
    assign mul_minus1 = ~multiplicand_mod + 1;
    assign modified_in = {multiplier_mod, 1'b0};

    // STAGE 1: BOOTH ENCODER
    // Bit pair recoding to generate partial product
    always_comb begin
        for (i = 0; i < 8; i = i + 2) begin
            case ({
                modified_in[i+2], modified_in[i+1], modified_in[i]
            })
                3'b000: pp[i/2] = '0;  //0
                3'b001: pp[i/2] = {8'd0, multiplicand_mod};  // +1M
                3'b010: pp[i/2] = {8'd0, multiplicand_mod};  // +1M
                3'b011: pp[i/2] = {8'd0, mul_plus2};  // +2M
                3'b100: pp[i/2] = {{8{1'b1}}, mul_minus2};  // -2M
                3'b101: pp[i/2] = {{8{1'b1}}, mul_minus1};  // -1M
                3'b110: pp[i/2] = {{8{1'b1}}, mul_minus1};  // -1M
                3'b111: pp[i/2] = '0;
            endcase
        end
    end

    // Shift partial product
    always_comb begin
        for (j = 0; j < 4; j = j + 1) begin
            partial_product[j] = pp[j] << (2 * j);  // Shift with multiple of 2 (Radix 4)
        end
    end

    // Register before wallace tree
    always_ff @(posedge CLK, negedge nRST) begin
        if (nRST == 0) begin
            pp0  <= '0;
            pp1  <= '0;
            pp2  <= '0;
            pp3  <= '0;
        end else begin
            pp0  <= partial_product[0];
            pp1  <= partial_product[1];
            pp2  <= partial_product[2];
            pp3  <= partial_product[3];
        end
    end

    // STAGE 2: WALLACE TREE
    // Layer 1
    carry_save_adder #(16) CSA0 (
        .x(pp0),
        .y(pp1),
        .z(pp2),
        .cout(cout0),
        .sum(sum0)
    );
    carry_save_adder #(16) CSA1 (
        .x(pp3),
        .y(cout0),
        .z(sum0),
        .cout(cout1),
        .sum(sum1)
    );
    
    // STAGE 3: Result
    assign temp_product = cout1 + sum1;
    assign temp_product2 = is_signed_reg[0] == 0 && multiplier_reg[7] ?
                                temp_product + ({8'd0,multiplicand_mod})
                                : temp_product; // plus extra 1M
    assign result = adjust_product ? (~temp_product2) + 1 : temp_product2;
    assign result2 = state == FINISH ? result : '0;
    assign product = result2;

    //FSM to track calculation progress
    typedef enum logic [1:0] {
        IDLE,
        CALCPP,
        RESULT,
        FINISH
    } state_t;
    state_t state, next_state;
    always_ff @(posedge CLK, negedge nRST) begin
        if (nRST == 0) state <= IDLE;
        else state <= next_state;
    end

    always_comb begin
        next_state = IDLE;
        finished = 1'b0;
        casez(state)
            IDLE:   if (start) next_state = CALCPP; 
            CALCPP: next_state = RESULT;
            RESULT: next_state = FINISH;
            FINISH: begin
                if (start) next_state = CALCPP;
                finished = 1'b1;
            end
            default: ;
        endcase
    end

endmodule

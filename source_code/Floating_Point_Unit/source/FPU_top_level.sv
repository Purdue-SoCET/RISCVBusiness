//By            : Joe Nasti
//Last Updated  : 8/25/18
//
//Module Summary:
//    Three-stage floating point unit supporting operations:
//    addition
//    subtraction
//    multiplication (in progress)
//
//Inputs:
//    clk                - system clock
//    nrst               - active low reset
//    floating_point1/2  - floating points to be operated on
//    frm                - rounding mode
//    funct7             - 7 bit operation code
//Outputs:
//    floating_point_out - result of operation
//    flags              - 5 error flags (overflow,  underflow, divide by zero, inexact result, invalid operation)

module FPU_top_level (
    input         clk,
    input         nrst,
    input  [31:0] floating_point1,
    input  [31:0] floating_point2,
    input  [ 2:0] frm,
    input  [ 6:0] funct7,
    output [31:0] floating_point_out,
    output [ 4:0] flags
);



    reg [2:0] frm2;
    reg [2:0] frm3;
    reg [6:0] funct7_2;
    reg [6:0] funct7_3;

    //funct7 definitions
    localparam ADD = 7'b0100000;
    localparam MUL = 7'b0000010;

    // ADD step1 outputs -> step2 inputs
    //reg 	       nxt_sign_shifted;
    reg        sign_shifted;
    //reg [25:0]  nxt_frac_shifted;
    reg [25:0] frac_shifted;
    //reg 	       nxt_sign_not_shifted;
    reg        sign_not_shifted;
    //reg [25:0]  nxt_frac_not_shifted;
    reg [25:0] frac_not_shifted;
    //reg [7:0]   nxt_exp_max;
    reg [ 7:0] exp_max;

    // MUL step1 outputs -> step2 inputs
    reg        mul_sign1;
    reg        mul_sign2;
    reg [ 7:0] mul_exp1;
    reg [ 7:0] mul_exp2;
    reg [25:0] product;
    reg        mul_carry_out;

    reg [61:0] step1_to_step2;
    reg [61:0] nxt_step1_to_step2;


    // ADD step2 outputs -> step3 inputs
    reg        add_sign_out;
    //reg        nxt_sign_out;
    reg [25:0] add_sum;
    //reg [25:0] nxt_sum;
    reg        add_carry_out;
    //reg 	      nxt_carry_out;
    reg [ 7:0] add_exp_max;
    //reg [7:0]  nxt_exp_max_out;

    // MUL step2 outputs -> step3 inputs
    reg        mul_sign_out;
    reg [ 7:0] sum_exp;
    reg        mul_ovf;
    reg        mul_unf;

    // invalid operation flag
    reg        inv;
    reg        inv2;
    reg        inv3;


    reg [37:0] step2_to_step3;
    reg [37:0] nxt_step2_to_step3;

    // right shift smaller fraction by difference in exponents

    ADD_step1 addStep1 (
        .floating_point1_in(floating_point1),
        .floating_point2_in(floating_point2),
        .sign_shifted(sign_shifted),
        .frac_shifted(frac_shifted),
        .sign_not_shifted(sign_not_shifted),
        .frac_not_shifted(frac_not_shifted),
        .exp_max(exp_max)
    );

    // multiply fractions

    MUL_step1 mulStep1 (
        .fp1_in(floating_point1),
        .fp2_in(floating_point2),
        .sign1(mul_sign1),
        .sign2(mul_sign2),
        .exp1(mul_exp1),
        .exp2(mul_exp2),
        .product(product),
        .carry_out(mul_carry_out)
    );

    always_comb begin : check_for_invalid_op
        inv = 0;
        if (funct7 == ADD) begin
            if((floating_point1[30:0] == 31'h7F800000) &&
	    (floating_point2[30:0] == 31'h7F800000) &&
	    (floating_point1[31] ^ floating_point2[31])) begin
                inv = 1;
            end
        end

        if (funct7 == MUL) begin
            if(((floating_point1[30:0] == 31'h00000000)  &&
	     (floating_point2[30:0] == 31'h7F800000)) ||
	    ((floating_point1[30:0] == 31'h7F800000)  &&
	     (floating_point2[30:0] == 31'h00000000))) begin
                inv = 1;
            end
        end
    end  // block: check_for_invalid_op


    always_comb begin : select_op_step1to2
        case (funct7)
            ADD: begin
                nxt_step1_to_step2[61]    = sign_shifted;
                nxt_step1_to_step2[60:35] = frac_shifted;
                nxt_step1_to_step2[34]    = sign_not_shifted;
                nxt_step1_to_step2[33:8]  = frac_not_shifted;
                nxt_step1_to_step2[7:0]   = exp_max;
            end
            MUL: begin
                nxt_step1_to_step2[61]    = mul_sign1;
                nxt_step1_to_step2[60]    = mul_sign2;
                nxt_step1_to_step2[59:52] = mul_exp1;
                nxt_step1_to_step2[51:44] = mul_exp2;
                nxt_step1_to_step2[43:18] = product;
                nxt_step1_to_step2[17]    = mul_carry_out;

            end

        endcase  // case (funct7)
    end  // block: select_op

    always_ff @(posedge clk, negedge nrst) begin : STEP1_to_STEP2
        if (nrst == 0) begin
            frm2 <= 0;
            step1_to_step2 <= 0;
            funct7_2 <= 0;
            inv2 <= 0;  /*
         sign_shifted     <= 0;
         frac_shifted     <= 0;
         sign_not_shifted <= 0;
         frac_not_shifted <= 0;
         exp_max          <= 0;*/
        end else begin
            frm2 <= frm;
            step1_to_step2 <= nxt_step1_to_step2;
            funct7_2 <= funct7;
            inv2 <= inv;  /*
         sign_shifted     <= nxt_sign_shifted;
         frac_shifted     <= nxt_frac_shifted;
         sign_not_shifted <= nxt_sign_not_shifted;
         frac_not_shifted <= nxt_frac_not_shifted;
         exp_max          <= nxt_exp_max;*/
        end
    end

    // add signed fractions

    ADD_step2 add_step2 (
        .frac1      (step1_to_step2[60:35]),  // frac_shifted
        .sign1      (step1_to_step2[61]),     // sign_shifted
        .frac2      (step1_to_step2[33:8]),   // frac_not_shhifted
        .sign2      (step1_to_step2[34]),     // sign_not_shifted
        .exp_max_in (step1_to_step2[7:0]),    // exp_max
        .sign_out   (add_sign_out),
        .sum        (add_sum),
        .carry_out  (add_carry_out),
        .exp_max_out(add_exp_max)
    );

    // add exponents and xor sign bits

    MUL_step2 mul_step2 (
        .sign1(step1_to_step2[61]),  // mul_sign1
        .sign2(step1_to_step2[60]),  // mul_sign2
        .exp1(step1_to_step2[59:52]),  // mul_exp1
        .exp2(step1_to_step2[51:44]),  // mul_exp2
        .sign_out(mul_sign_out),
        .sum_exp(sum_exp),
        .ovf(mul_ovf),
        .unf(mul_unf),
        .carry(step1_to_step2[17])
    );

    always_comb begin : select_op_step2to3
        case (funct7_2)
            ADD: begin
                nxt_step2_to_step3[37:36]= 2'b00;
                nxt_step2_to_step3[35]   = add_sign_out;
                nxt_step2_to_step3[34:9] = add_sum;
                nxt_step2_to_step3[8]    = add_carry_out;
                nxt_step2_to_step3[7:0]  = add_exp_max;
            end
            MUL: begin
                nxt_step2_to_step3[37]   = mul_ovf;
                nxt_step2_to_step3[36]   = mul_unf;
                nxt_step2_to_step3[35]   = mul_sign_out;
                nxt_step2_to_step3[34:9] = step1_to_step2[43:18]; // product from MUL_step1
                nxt_step2_to_step3[8]    = step1_to_step2[17];    // mul_carry_out;
                nxt_step2_to_step3[7:0]  = sum_exp;

            end
        endcase  // case (funct7_2)
    end  // block: select_op_step2to3


    always_ff @(posedge clk, negedge nrst) begin : STEP2_to_STEP3
        if (nrst == 0) begin
            funct7_3       <= 0;
            step2_to_step3 <= 0;
            frm3           <= 0;
            inv3           <= 0;
        end else begin
            funct7_3       <= funct7_2;
            step2_to_step3 <= nxt_step2_to_step3;
            frm3           <= frm2;
            inv3           <= inv2;
        end
    end

    //shift fraction until 1 is the first digit
    //round based on rounding mode
    reg o;

    always_comb begin
        if((step2_to_step3[7:0] == 8'b11111111) && (step2_to_step3[36] == 1'b0) && (step2_to_step3[8] == 0))
            o = 1;
        else o = step2_to_step3[37];
    end

    ADD_step3 step3 (
        .ovf_in(o),
        .unf_in(step2_to_step3[36]),
        .dz(1'b0),
        .inv(inv3),
        .frm(frm3),
        .exponent_max_in(step2_to_step3[7:0]),
        .sign_in(step2_to_step3[35]),
        .frac_in(step2_to_step3[34:9]),
        .carry_out(step2_to_step3[8]),
        .floating_point_out(floating_point_out),
        .flags(flags)
    );

endmodule

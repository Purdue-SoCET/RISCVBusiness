`timescale 1ns / 10ps
`include "priv_ext_if.vh"

module hpm #(
   parameter NUM_PEFORMANCE_COUNTERS = 32 // Number of performance counters we have 
) (
    input logic clk,
    input logic n_rst,

    input logic enable_array [NUM_PEFORMANCE_COUNTERS-1 : 0],

    priv_ext_if.ext priv
);

localparam UPPERSEL = 2'd2;
localparam LOWERSEL = 2'd1;
localparam NOSEL = 2'd0;

localparam ADDRLOWERCOUNTER1 = 12'hC00;
localparam ADDRLOWERCOUNTER2 = 12'hC01;
localparam ADDRLOWERCOUNTER3 = 12'hC02;
localparam ADDRLOWERCOUNTER4 = 12'hC03;
localparam ADDRLOWERCOUNTER5 = 12'hC04;
localparam ADDRLOWERCOUNTER6 = 12'hC05;
localparam ADDRLOWERCOUNTER7 = 12'hC06;
localparam ADDRLOWERCOUNTER8 = 12'hC07;
localparam ADDRLOWERCOUNTER9 = 12'hC08;
localparam ADDRLOWERCOUNTER10 = 12'hC09;
localparam ADDRLOWERCOUNTER11 = 12'hC0A;
localparam ADDRLOWERCOUNTER12 = 12'hC0B;
localparam ADDRLOWERCOUNTER13 = 12'hC0C;
localparam ADDRLOWERCOUNTER14 = 12'hC0D;
localparam ADDRLOWERCOUNTER15 = 12'hC0E;
localparam ADDRLOWERCOUNTER16 = 12'hC0F;
localparam ADDRLOWERCOUNTER17 = 12'hC10;
localparam ADDRLOWERCOUNTER18 = 12'hC11;
localparam ADDRLOWERCOUNTER19 = 12'hC12;
localparam ADDRLOWERCOUNTER20 = 12'hC13;
localparam ADDRLOWERCOUNTER21 = 12'hC14;
localparam ADDRLOWERCOUNTER22 = 12'hC15;
localparam ADDRLOWERCOUNTER23 = 12'hC16;
localparam ADDRLOWERCOUNTER24 = 12'hC17;
localparam ADDRLOWERCOUNTER25 = 12'hC18;
localparam ADDRLOWERCOUNTER26 = 12'hC19;
localparam ADDRLOWERCOUNTER27 = 12'hC1A;
localparam ADDRLOWERCOUNTER28 = 12'hC1B;
localparam ADDRLOWERCOUNTER29 = 12'hC1C;
localparam ADDRLOWERCOUNTER30 = 12'hC1D;
localparam ADDRLOWERCOUNTER31 = 12'hC1E;
localparam ADDRLOWERCOUNTER32 = 12'hC1F;

logic [31:0][11:0] counter_address;
logic [31:0][11:0] next_counter_address;

always_comb begin : ADDRESS_BLOCK
    next_counter_address = counter_address;
end

always_ff @(posedge clk, negedge n_rst) begin : ADDRESS_BLOCK_MEMORY
    if(!n_rst) begin
        counter_address[0] <= ADDRLOWERCOUNTER1;
        counter_address[1] <= ADDRLOWERCOUNTER2;
        counter_address[2] <= ADDRLOWERCOUNTER3;
        counter_address[3] <= ADDRLOWERCOUNTER4;
        counter_address[4] <= ADDRLOWERCOUNTER5;
        counter_address[5] <= ADDRLOWERCOUNTER6;
        counter_address[6] <= ADDRLOWERCOUNTER7;
        counter_address[7] <= ADDRLOWERCOUNTER8;
        counter_address[8] <= ADDRLOWERCOUNTER9;
        counter_address[9] <= ADDRLOWERCOUNTER10;
        counter_address[10] <= ADDRLOWERCOUNTER11;
        counter_address[11] <= ADDRLOWERCOUNTER12;
        counter_address[12] <= ADDRLOWERCOUNTER13;
        counter_address[13] <= ADDRLOWERCOUNTER14;
        counter_address[14] <= ADDRLOWERCOUNTER15;
        counter_address[15] <= ADDRLOWERCOUNTER16;
        counter_address[16] <= ADDRLOWERCOUNTER17;
        counter_address[17] <= ADDRLOWERCOUNTER18;
        counter_address[18] <= ADDRLOWERCOUNTER19;
        counter_address[19] <= ADDRLOWERCOUNTER20;
        counter_address[20] <= ADDRLOWERCOUNTER21;
        counter_address[21] <= ADDRLOWERCOUNTER22;
        counter_address[22] <= ADDRLOWERCOUNTER23;
        counter_address[23] <= ADDRLOWERCOUNTER24;
        counter_address[24] <= ADDRLOWERCOUNTER25;
        counter_address[25] <= ADDRLOWERCOUNTER26;
        counter_address[26] <= ADDRLOWERCOUNTER27;
        counter_address[27] <= ADDRLOWERCOUNTER28;
        counter_address[28] <= ADDRLOWERCOUNTER29;
        counter_address[29] <= ADDRLOWERCOUNTER30;
        counter_address[30] <= ADDRLOWERCOUNTER31;
        counter_address[31] <= ADDRLOWERCOUNTER32;
    end
    else begin
        counter_address <= next_counter_address;
    end
end

logic [NUM_PEFORMANCE_COUNTERS-1:0] [1:0] counter_sel;
logic [11:0] masked_address;

always_comb begin : MASK_COMB
    //check to see if the inputted address is asking for the upper 32 bits
    masked_address = {priv.csr_addr[11:8], ~priv.csr_addr[7], priv.csr_addr[6:0]};
end


always_comb begin: WRITE_SEL
    integer i;
    counter_sel = '0;
    priv.invalid_csr = 1;
    priv.ack = 0;
    for(i = 0; i < NUM_PEFORMANCE_COUNTERS; i++) begin
        if(((priv.csr_addr == counter_address[i]) || (masked_address == counter_address[i])) && priv.csr_active) begin
            if(priv.csr_addr > ADDRLOWERCOUNTER32) begin
                counter_sel[i] = UPPERSEL;
                priv.invalid_csr = 0;
                priv.ack = 1;
            end 
            else begin
                counter_sel[i] = LOWERSEL;
                priv.invalid_csr = 0;
                priv.ack = 1;
            end
        end
    end
end

genvar ind;
logic [NUM_PEFORMANCE_COUNTERS-1:0][63:0] count_out;

generate
    for(ind = 0; ind < NUM_PEFORMANCE_COUNTERS; ind++) begin
        counter64bit counter(.clk(clk), .n_rst(n_rst), .enable(enable_array[ind]),
        .overwrite_val(priv.value_in), .csr_active_sel(counter_sel[ind]), .clear(),
        .count_out(count_out[ind]), .rollover_flag());
    end
endgenerate

always_comb begin : READ_SEL_COMB
    integer i;
    priv.value_out = '0;
    for(i = 0; i < NUM_PEFORMANCE_COUNTERS; i++) begin
        if(((priv.csr_addr == counter_address[i]) || (masked_address == counter_address[i]))) begin
            if(priv.csr_addr > ADDRLOWERCOUNTER32) begin
                priv.value_out = count_out[i][63:32];
            end
            else begin
                priv.value_out = count_out[i][31:0];
            end
        end
    end
end


/*
modport ext (
    output invalid_csr, ack, value_out,
    input csr_addr, value_in, csr_active
);
*/

endmodule

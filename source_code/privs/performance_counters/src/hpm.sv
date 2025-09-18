`timescale 1ns / 10ps
`include "priv_ext_if.vh"

module hpm #(
   parameter NUM_PEFORMANCE_COUNTERS = 2 // ASSUME DEFAULT OF 2 FOR NOW 
) (
    input logic clk,
    input logic n_rst,

    input logic enable_array [NUM_PEFORMANCE_COUNTERS - 1 : 0],

    priv_ext_if.ext priv
);

localparam UPPERSEL = 2'd2;
localparam LOWERSEL = 2'd1;
localparam NOSEL = 2'd0;

localparam ADDRLOWERCOUNTER1 = 12'hC00; // ADDRESS TO ACCESS LOWER 32 BITS OF FIRST COUNTER
localparam ADDRUPPERCOUNTER1 = 12'hC80; // ADDRESS TO ACCESS UPPER 32 BITS OF FIRST COUNTER
localparam ADDRLOWERCOUNTER2 = 12'hC01; // ADDRESS TO ACCESS LOWER 32 BITS OF SECOND COUNTER
localparam ADDRUPPERCOUNTER2 = 12'hC81; // ADDRESS TO ACCESS UPPER 32 BITS OF SECOND COUNTER

typedef struct packed {
    logic [1:0] sel;
    logic [11:0] address;
    logic [31:0] data;
} counter_sel_map_t;

counter_sel_map_t counter_map [NUM_PEFORMANCE_COUNTERS];
counter_sel_map_t next_counter_map [NUM_PEFORMANCE_COUNTERS];

always_ff @(posedge clk, negedge n_rst) begin: COUNTER_MAP_REG
    if(~n_rst) begin
        counter_map[0].sel <= NOSEL;
        counter_map[0].address <= ADDRLOWERCOUNTER1;
        counter_map[0].data <= 32'd0;

        counter_map[1].sel <= NOSEL;
        counter_map[1].address <= ADDRLOWERCOUNTER2;
        counter_map[1].data <= 32'd0;
    end
    else begin
        counter_map <= next_counter_map;
    end
end

always_comb begin : WRITE_SEL_COMB
    foreach(counter_map[i]) begin
    
        next_counter_map[i].address = counter_map[i].address;

        if((counter_map[i].address == priv.csr_addr) || ((counter_map[i].address + 128) == priv.csr_addr)  && priv.csr_active) begin // Address is one of ours and we want to overwrite
            if(priv.csr_addr >= ADDRUPPERCOUNTER1) begin  //Interested in upper bits
                priv.ack = 1;
                priv.invalid_csr = 0;
                next_counter_map[i].sel = UPPERSEL;
                next_counter_map[i].data = priv.value_in;
            end
            else begin
                priv.ack = 1;
                priv.invalid_csr = 0;
                next_counter_map[i].sel = LOWERSEL;
                next_counter_map[i].data = priv.value_in;
            end
        end
        else begin
            priv.ack = 0;
            priv.invalid_csr = 1;
            next_counter_map[i].sel = NOSEL;
            next_counter_map[i].data = priv.value_in;
        end
    end
end

genvar ind;
logic [63:0] count_out [NUM_PEFORMANCE_COUNTERS-1:0];

generate
    for(ind = 0; ind < NUM_PEFORMANCE_COUNTERS; ind++) begin
        counter64bit counter(.clk(clk), .n_rst(n_rst), .enable(enable_array[ind]),
        .overwrite_val(counter_map[ind].data), .csr_active_sel(counter_map[ind].sel), .clear(),
        .count_out(count_out[ind]), .rollover_flag());
    end
endgenerate

always_comb begin : READ_SEL_COMB
    priv.value_out = 32'd0;

    foreach(counter_map[i]) begin : READ_SEL_COMB
        if((counter_map[i].address == priv.csr_addr) || ((counter_map[i].address + 128) == priv.csr_addr)) begin
            if(priv.csr_addr >= ADDRUPPERCOUNTER1) begin
                priv.value_out = count_out[i][63:32];
            end
            else begin
                priv.value_out = count_out[i][31:0];
            end
        end
    end
end

endmodule

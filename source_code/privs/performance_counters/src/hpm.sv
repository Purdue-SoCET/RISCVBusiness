`include "priv_ext_if.vh"

/*modport ext (
    output invalid_csr, ack, value_out,
    input csr_addr, value_in, csr_active
);*/

/*module counter64bit (
input logic clk,
input logic n_rst,
input logic enable, //counter enable
input logic [31:0] overwrite_val, //overwrite value, can only overwrite 32 bits of the counter at a time
input logic [1:0] csr_active_sel, // 0 --> not overwriting; 1 --> write to lower 32 bits ; 2 --> write to upper 32 bits
input logic clear, //clear all 64 bits of counter

output logic [63:0] count_out,
output logic rollover_flag
);*/

module hpm #(
   parameter NUM_PEFORMANCE_COUNTERS = 2 // ASSUME DEFAULT OF 2 FOR NOW 
) (
    input logic clk,
    input logic n_rst,

    logic enable1, // Temporary enable signals ==> these will be pulled from CPU core
    logic enable2,

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
    logic [31:0] data;
    logic [11:0] address;
} counters_t;

counters_t counter_overwrite_map [NUM_PEFORMANCE_COUNTERS] = '{
    '{32'd0, ADDRLOWERCOUNTER1},
    '{32'd0, ADDRUPPERCOUNTER1},
    '{32'd0, ADDRLOWERCOUNTER2},
    '{32'd0, ADDRUPPERCOUNTER2}
};

logic [1:0] csr_active_sel;

foreach(counter_overwrite_map[i]) begin : WRITE_SEL_COMB
    if((counter_overwrite_map[i].address == priv.csr_addr) && priv.csr_active) begin // Address is one of ours and we want to overwrite
        if(priv.csr_addr >= ADDRUPPERCOUNTER1) begin  //Interested in upper bits
            priv.ack = 1;
            priv.invalid_csr = 0;
            csr_active_sel = UPPERSEL;
            counter_overwrite_map[i].data = value_in;
        end
        else begin
            priv.ack = 1;
            priv.invalid_csr = 0;
            csr_active_sel = LOWERSEL;
            counter_overwrite_map[i].data = value_in;
        end
    end
    else begin
        priv.ack = 0;
        priv.invalid_csr = 1;
        csr_active_sel = NOSEL;
        counter_overwrite_map[i].data = 0;
    end
end

foreach(counter_overwrite_map[i]) begin : READ_SEL_COMB
    
end

genvar i;

generate
    for(i = 0; i < NUM_PEFORMANCE_COUNTERS; i++) begin
        counter64bit counter()
    end
endgenerate

endmodule

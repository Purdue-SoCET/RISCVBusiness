module sram #(
    parameter SRAM_WR_SIZE = 128,
    parameter SRAM_HEIGHT = 128
)
(
    input logic                     CLK, nRST,
    input logic [SRAM_WR_SIZE-1:0]  wVal,
    output logic [SRAM_WR_SIZE-1:0] rVal,
    input logic                     REN, WEN,
    input logic [$clog2(SRAM_HEIGHT)-1:0] SEL,
    input logic [SRAM_WR_SIZE-1:0] wMask
);
    typedef logic [SRAM_WR_SIZE-1:0] sram_entry_size_t;
    sram_entry_size_t [SRAM_HEIGHT-1:0] sramMemory; 
    sram_entry_size_t [SRAM_HEIGHT-1:0] n_sramMemory;

    always_ff @(posedge CLK) begin
        sramMemory <= n_sramMemory;
    end

    always_comb begin
        n_sramMemory = sramMemory;
        rVal = 32'hBAD0BAD0;
        if (WEN)
            n_sramMemory[SEL] = (wVal & ~wMask) | (wMask & sramMemory[SEL]);
        if (REN)
            rVal = sramMemory[SEL];
    end
endmodule
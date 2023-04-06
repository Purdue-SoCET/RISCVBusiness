interface apb_if #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input logic PCLK,
    input logic PRESETn
);
    
    logic [ADDR_WIDTH-1:0] PADDR;
    logic [DATA_WIDTH-1:0] PRDATA, PWDATA;
    logic [2:0] PPROT; // Optional
    logic PSEL;
    logic PENABLE;
    logic PWRITE;
    logic [(ADDR_WIDTH/8)-1:0] PSTRB; // Optional
    logic PREADY;
    logic PSLVERR;

    modport requester(
        input PCLK, PRESETn,
        input PREADY, PRDATA, PSLVERR,
        output PADDR, PPROT, PSEL, 
        PENABLE, PWRITE, PWDATA, PSTRB
    );

    modport completer(
        input PCLK, PRESETn,
        input PADDR, PPROT, PSEL,
        PENABLE, PWRITE, PWDATA, PSTRB,
        output PREADY, PRDATA, PSLVERR
    );

endinterface

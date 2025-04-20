`ifndef BUS_IF_VH
`define BUS_IF_VH

// FIXME: THIS INTERFACE IS COPIED INTO BUS_CTRL_IF AS A 'FIX'
//        CHANGES MADE HERE WONT WORK
// TODO: fix this

`include "addr_space.sv"

interface bus_if #(
    parameter ADDR_WIDTH = 32, 
    parameter DATA_WIDTH = 32
)(input CLK);
    import addr_space::*;

    // Vital signals
    logic wen; // request is a data write
    logic ren; // request is a data read
    logic request_stall; // High when protocol should insert wait states in transaction
    logic [ADDR_WIDTH-1 : 0] addr; // *offset* address of request
    logic error; // Indicate error condition to bus
    logic [(DATA_WIDTH/8)-1 : 0] strobe; // byte enable for writes
    logic [DATA_WIDTH-1 : 0] wdata, rdata; // data lines -- from perspective of bus master

    // Hint signals
    logic is_burst;
    logic [1:0] burst_type; // WRAP, INCR
    logic [7:0] burst_length; // up to 256
    logic secure_transfer;

    // UVM signals
    logic iREN;
    logic [ADDR_WIDTH-1 : 0] iaddr;
    logic ierror, i_req_stall;
    logic [DATA_WIDTH-1 : 0] instruction;

    logic dREN, dWEN;
    logic [ADDR_WIDTH-1 : 0] daddr;
    logic [DATA_WIDTH-1 : 0] dstore; 
    logic [DATA_WIDTH-1 : 0] dload;
    logic derror, d_req_stall;

    // Modports
    modport uvm (
        input iREN, iaddr, 
        output instruction, ierror, i_req_stall,
        input dREN, dWEN, daddr, dstore, 
        output dload, derror, d_req_stall
    );

    modport cpu (
        input wen, ren, addr, wdata, strobe,
        output rdata, error, request_stall
    );

    modport protocol (
        input rdata, error, request_stall,
        output wen, ren, addr, wdata, strobe, 
        output is_burst, burst_type, burst_length, secure_transfer
    );

    // Behavior
    always_comb begin
        iREN = '0;
        iaddr = '0;
        ierror = '0;
        i_req_stall = '0;
        dREN = '0;
        dWEN = '0;
        daddr = '0;
        dload = '0;
        dstore = '0;
        derror = '0;
        d_req_stall = '0;

        if (addr >= INSTR_START_ADDR_SPACE && addr <= INSTR_END_ADDR_SPACE) begin
            iREN = ren;
            iaddr = addr;
            error = ierror;
            request_stall = i_req_stall;
            rdata = instruction;
        end else if (addr >= DATA_START_ADDR_SPACE && addr <= DATA_END_ADDR_SPACE) begin 
            dREN = ren;
            dWEN = wen;
            daddr = addr;
            dstore = wdata;
            rdata = dload;
            error = derror;
            request_stall = d_req_stall;
        end    
    end

endinterface
`endif

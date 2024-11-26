`ifndef BUS_IF_VH
`define BUS_IF_VH

`include "addr_space.sv"
    
    interface bus_if #(
        parameter ADDR_WIDTH = 32, 
        parameter DATA_WIDTH = 32
    )(/* No I/O */);

        // Vital signals
        logic wen; // request is a data write
        logic ren; // request is a data read
        logic request_stall; // High when protocol should insert wait states in transaction
        logic [ADDR_WIDTH-1 : 0] addr; // *offset* address of request TODO: Is this good for general use?
        logic error; // Indicate error condition to bus
        logic [(DATA_WIDTH/8)-1 : 0] strobe; // byte enable for writes
        logic [DATA_WIDTH-1 : 0] wdata, rdata; // data lines -- from perspective of bus master. rdata should be data read from peripheral.

        // Hint signals
        logic is_burst;
        logic [1:0] burst_type; // WRAP, INCR
        logic [7:0] burst_length; // up to 256, would support AHB and AXI
        logic secure_transfer; // TODO: How many bits?

        // UVM driven and monitored signals
        // ****************************************************
        // CPU Inputs to Instruction Agents 
        logic iREN;
        logic [ADDR_WIDTH-1 : 0] iaddr; 
        
        // Instruction Agent Outputs to CPU
        logic ierror, i_req_stall;   
        logic [DATA_WIDTH-1 : 0] instruction; 

        // CPU Inputs to Data Agents 
        logic dREN, dWEN;
        logic [ADDR_WIDTH-1 : 0] daddr;
        logic [DATA_WIDTH-1 : 0] data_store;  

        // Data Agent Outputs to CPU
        logic derror, d_req_stall;   
        logic [DATA_WIDTH-1 : 0] data_load;  
        // ****************************************************

        modport uvm (
            input iREN, iaddr, 
            output instruction, ierror, i_req_stall,
            input dREN, dWEN, daddr, data_store, 
            output data_load, derror, d_req_stall
        );

        always_comb begin
            iREN = '0;
            iaddr = '0;
            ierror = '0;
            i_req_stall = '0;
            dREN = '0;
            dWEN = '0;
            daddr = '0;
            data_load = '0;
            data_store = '0;
            derror = '0;
            d_req_stall = '0;

            if(addr >= INSTR_START_ADDR_SPACE && addr <= INSTR_END_ADDR_SPACE) begin
                iREN = ren;
                iaddr = addr;
                error =  ierror;
                request_stall = i_req_stall;
                rdata = instruction;
            end
            else if(addr >= DATA_START_ADDR_SPACE && addr <= DATA_END_ADDR_SPACE) begin 
                dREN = ren;
                dWEN = wen;
                daddr = addr;
                data_store = wdata;
                rdata = data_load;
                error = derror;
                request_stall = d_req_stall;
            end    
        end

        modport cpu (
            input wen, ren, addr, wdata, strobe,
            output rdata, error, request_stall
        );

        modport protocol (
            input rdata, error, request_stall,
            output wen, ren, addr, wdata, strobe, // vital signals
            output is_burst, burst_type, burst_length, secure_transfer // hint signals
        );

    endinterface
`endif

`include "generic_bus_if.vh"

module memory_arbiter (
    input CLK, nRST,
    generic_bus_if.generic_bus icache_if, dcache_if,
    generic_bus_if.cpu mem_arb_if
);
    typedef enum logic[1:0] {IDLE, IREQUEST, DREQUEST} state_t;
    state_t state, next_state;
    
    always_comb begin : OUTPUT_LOGIC
		mem_arb_if.ren 	  	= '0;
		mem_arb_if.wen 	  	= '0;
		mem_arb_if.addr   	= '0;
		mem_arb_if.wdata  	= '0;
		mem_arb_if.byte_en	= '0;

		icache_if.busy 	  	= '1;
		icache_if.rdata   	= '0;

		dcache_if.busy 	  	= '1;
		dcache_if.rdata   	= '0;

		case(state)
			IDLE: begin
				if(dcache_if.wen || dcache_if.ren) begin
					mem_arb_if.ren 	  	= dcache_if.ren;
					mem_arb_if.wen 	  	= dcache_if.wen;
					mem_arb_if.addr   	= dcache_if.addr;
					mem_arb_if.wdata  	= dcache_if.wdata;
					mem_arb_if.byte_en	= dcache_if.byte_en;
					dcache_if.busy 	  	= mem_arb_if.busy;
					dcache_if.rdata 	= mem_arb_if.rdata;
				end
				else if(icache_if.wen || icache_if.ren) begin
					mem_arb_if.ren 	  	= icache_if.ren;
					mem_arb_if.wen 	  	= icache_if.wen;
					mem_arb_if.addr   	= icache_if.addr;
					mem_arb_if.wdata  	= icache_if.wdata;
					mem_arb_if.byte_en	= icache_if.byte_en;
					icache_if.busy 	  	= mem_arb_if.busy;
					icache_if.rdata 	= mem_arb_if.rdata;
				end 
			end
			IREQUEST: begin
				mem_arb_if.ren 	  	= icache_if.ren;
				mem_arb_if.wen 	  	= icache_if.wen;
				mem_arb_if.addr   	= icache_if.addr;
				mem_arb_if.wdata  	= icache_if.wdata;
				mem_arb_if.byte_en	= icache_if.byte_en;
				icache_if.busy 	  	= mem_arb_if.busy;
				icache_if.rdata 	= mem_arb_if.rdata;
			end
			DREQUEST: begin
				mem_arb_if.ren 	  	= dcache_if.ren;
				mem_arb_if.wen 	  	= dcache_if.wen;
				mem_arb_if.addr   	= dcache_if.addr;
				mem_arb_if.wdata  	= dcache_if.wdata;
				mem_arb_if.byte_en	= dcache_if.byte_en;
				dcache_if.busy 	  	= mem_arb_if.busy;
				dcache_if.rdata 	= mem_arb_if.rdata;
			end 
		endcase
	end

   	always_comb begin : NEXT_STATE_LOGIC
       	next_state  = state;

       	case(state)
			IDLE: begin
				if((dcache_if.wen || dcache_if.ren) && mem_arb_if.busy) begin
					next_state  = DREQUEST;
				end
				else if((icache_if.wen || icache_if.ren) && mem_arb_if.busy) begin
					next_state  = IREQUEST;
				end
			end
			DREQUEST: begin
				if(~mem_arb_if.busy) begin // hopefully, busy will always be high until fetch, so no problem
					next_state  = IDLE;
				end
			end
			IREQUEST: begin
				if(~mem_arb_if.busy) begin
					next_state  = IDLE;
				end
			end
      	endcase
   	end
    
   	always_ff @ (posedge CLK, negedge nRST) begin
       	if(~nRST) begin
	   		state <= IDLE;
       	end 
		else begin
	   		state <= next_state;
       	end
   	end
    
endmodule

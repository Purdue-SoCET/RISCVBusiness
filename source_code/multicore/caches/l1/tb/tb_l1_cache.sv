`timescale 1ns/1ns
`include "generic_bus_if.vh"

parameter CLK_PERIOD = 10;
			    
module tb_l1_cache;
    logic CLK, nRST;
    initial CLK  = 1'b0;
    always #(CLK_PERIOD/2) begin
	CLK = ~CLK;    
    end
    
/* -----\/----- EXCLUDED -----\/-----
module l1_cache #(
    parameter CACHE_SIZE          = 1024, // must be power of 2, in bytes, max 2^32
    parameter BLOCK_SIZE          = 2, // must be power of 2, max 32
    parameter ASSOC               = 1, // 1 or 2 so far
    parameter NONCACHE_START_ADDR = 32'h8000_0000
)
(
    input logic CLK, nRST,
    input logic clear, flush,
    output logic clear_done, flush_done,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus proc_gen_bus_if

);
 -----/\----- EXCLUDED -----/\----- */
    // TODO:
    // 1. Test L1 with ASSOC = 0, it should be already working, but worth calling
    // test program again on it and making sure no error from assertions.
    
    logic clear, flush, clear_done, flush_done;
    generic_bus_if mem_gen_bus_if(), proc_gen_bus_if();
    
    l1_cache #(.CACHE_SIZE(1024), .BLOCK_SIZE(2), .ASSOC(2), .NONCACHE_START_ADDR(32'h8000_0000)) DUT (.*);
    test TB_DUT(clear_done, flush_done, CLK, clear, flush, nRST, mem_gen_bus_if, proc_gen_bus_if);
    // test TB_DUT(.*);
 
endmodule // tb_l1_cache

program test(
    input logic  clear_done, flush_done, CLK, 
    output logic clear, flush, nRST, 
    generic_bus_if.generic_bus mem_gen_bus_if,
    generic_bus_if.cpu proc_gen_bus_if
);

    integer 	 test_num, test_value, test_value2;
    string 	 test_case;
    
    initial begin
	// Test case:0, initialization
	test_num 		 = 0;
	test_case 		 = "Initialization";
	nRST 			 = 1'b1;
	clear 			 = 1'b0;
	flush 			 = 1'b0;
	mem_gen_bus_if.busy 	 = 1'b1;
	mem_gen_bus_if.rdata 	 = '0;
	proc_gen_bus_if.addr 	 = '0;
	proc_gen_bus_if.ren 	 = 1'b0;
	proc_gen_bus_if.wen 	 = 1'b0;
	proc_gen_bus_if.wdata 	 = '0;
	proc_gen_bus_if.byte_en  = '0;
	
	#1;
	
	// Test case: 1, Reset
	test_num++;
	test_case  = "Reset";
	@(negedge CLK);
	nRST  = 1'b0;

	// Test case: 2, Write miss
	@(negedge CLK);
	test_num++;
	test_case 	       = "Write miss";
	nRST 		       = 1'b1;
	proc_gen_bus_if.ren    = 1'b0;
	proc_gen_bus_if.wen    = 1'b1;
	proc_gen_bus_if.addr   = '0; // miss
	proc_gen_bus_if.wdata  = 32'hDEAD_DEAF;
	wait(mem_gen_bus_if.ren);
	assert(mem_gen_bus_if.addr == proc_gen_bus_if.addr) else $error("Test case: %s, test num: %0d, address from CPU does not match with incoming to main memory", test_case, test_num);
	mem_gen_bus_if.rdata  = 32'hBEEF_BEEF;
	mem_gen_bus_if.busy   = 1'b0;
	@(posedge CLK);
	assert(mem_gen_bus_if.addr == proc_gen_bus_if.addr + 4) else $error("Test case: %s, test num: %0d, second word address is wrong", test_case, test_num);
	mem_gen_bus_if.rdata  = 32'hFFFF_AAAA;
	wait(~proc_gen_bus_if.busy);
	mem_gen_bus_if.busy  = 1'b1;
	@(posedge CLK);
	proc_gen_bus_if.wen  = 1'b0;
	
	// Test case: 3, Read back from 32'd0
	#CLK_PERIOD;
	test_num++;
	test_case  = "Read back";
	@(posedge CLK);
	proc_gen_bus_if.ren  = 1'b1;
	wait(~proc_gen_bus_if.busy);
	assert(proc_gen_bus_if.rdata == 32'hDEAD_DEAF) else $error("Test case: %s, test num: %0d, read %h, expected %h,  value from cache after miss", test_case, test_num, proc_gen_bus_if.rdata, 32'hDEAD_DEAF);
	proc_gen_bus_if.ren = 1'b0;

	// Test case 4, cache replace
	#CLK_PERIOD;
	test_num++;
	test_case  = "Cache Replace";
	@(posedge CLK);
	proc_gen_bus_if.addr   = 32'h0FFF_0000;
	proc_gen_bus_if.wdata  = 32'hAAAA_AAAA;
	proc_gen_bus_if.wen    = 1'b1;
	mem_gen_bus_if.busy    = 1'b0;
	mem_gen_bus_if.rdata   = 32'hCCCC_CCCC;
	wait(~proc_gen_bus_if.busy);
	@(posedge CLK);
	proc_gen_bus_if.wdata  = 32'hBBBB_BBBB;
	proc_gen_bus_if.addr   = 32'h0AAA_0000; #1;
	wait(~proc_gen_bus_if.busy);
	@(posedge CLK);
	proc_gen_bus_if.wen  = 1'b0;
	@(posedge CLK);
	proc_gen_bus_if.ren  = 1'b1; #1;
	wait(~proc_gen_bus_if.busy);
	assert(proc_gen_bus_if.rdata == 32'hBBBB_BBBB) else $error("Test case: %s, test num: %0d, read %h, expected 32'hBBBB_BBBB",test_case,test_num,proc_gen_bus_if.rdata);
	@(posedge CLK);
	
      	// Test case: 5, contrinuous write and then read
	#CLK_PERIOD;
	test_num++;
	test_case  = "Continous write/read";
	@(posedge CLK);
	nRST 		     = 1'b0;
	proc_gen_bus_if.wen  = 1'b0;
	proc_gen_bus_if.ren  = 1'b0;
	@(posedge CLK);
	@(posedge CLK);
	nRST  = 1'b1;
	@(posedge CLK);
	proc_gen_bus_if.wen    = 1'b1;
	proc_gen_bus_if.wdata  = 32'h1;
	mem_gen_bus_if.busy    = 1'b0;
	mem_gen_bus_if.rdata   = 32'hda7ada7a;
	// Write twice to each word
	for(integer i = 0; i < 32'h0000_0040; i = i + 4) begin
	    proc_gen_bus_if.addr  = i; #1;
	    wait(~proc_gen_bus_if.busy);
	    @(posedge CLK);
	    proc_gen_bus_if.wdata++;
	end // for (integer i = 0; i < 32'h0000_0400; i = i + 4)
	proc_gen_bus_if.wen 	  = 1'b0;
	proc_gen_bus_if.ren 	  = 1'b0;
	#CLK_PERIOD;
        @(posedge CLK);
	test_value 	     = 32'h0000_0001;
	proc_gen_bus_if.ren  = 1'b1;
	// Read back lastest values
	for(integer i = 32'h0000_0000; i < 32'h0000_0040; i = i + 4) begin
	    proc_gen_bus_if.addr = i; #1;
	    wait(~proc_gen_bus_if.busy);
	    assert(proc_gen_bus_if.rdata == test_value) else $error("Test case: %s, test num: %0d, read: 0x%h, expected: 0x%h for address: 0x%h\n", test_case, test_num, proc_gen_bus_if.rdata, test_value, proc_gen_bus_if.addr);
	    test_value++;
	    @(posedge CLK);
	end // for (integer i = 32'h0000_0200; i < 32'h0000_0400; i = i + 4)

	// Test case 6, flush functionality
	#CLK_PERIOD;
	@(negedge CLK);
	test_num++;
	test_case  = "Flush";
	// First write to cache, and then set flush
	nRST 	   = 1'b0;
	#(2*CLK_PERIOD);
	@(posedge CLK);
	nRST 		       = 1'b1;
	proc_gen_bus_if.wen    = 1'b1;
	proc_gen_bus_if.ren    = 1'b0;
	proc_gen_bus_if.addr   = '0;
	proc_gen_bus_if.wdata  = '0;
	mem_gen_bus_if.busy    = 1'b0;
	mem_gen_bus_if.rdata   = '0;

	for(integer i = 0; i < 32'h0000_0040; i = i + 4) begin
	    proc_gen_bus_if.addr  = i;
	    #1; wait(~proc_gen_bus_if.busy);
	    @(posedge CLK);
	    proc_gen_bus_if.wdata++;
	end // for (integer i = 0; i < 32'h0000_0400; i = i + 4)	
	proc_gen_bus_if.wen = 1'b0;
	#CLK_PERIOD;
	@(negedge CLK);
	flush 		     = 1'b1;
	mem_gen_bus_if.busy  = 1'b1;
	test_value 	     = 32'h0000_0080;
	test_value2 	     = '0;
	// Check for memory writes
	while(1) begin
	    wait(mem_gen_bus_if.wen || flush_done);
	    if(flush_done) begin
		break;
	    end
	    if(mem_gen_bus_if.addr >= 32'h0000_0200) begin
		assert(mem_gen_bus_if.wdata == test_value) else $error("Test case: %s, test num: %0d, \n \t Second Round first write at 0x%h, expected: 0x%h, read: 0x%h", test_case, test_num, mem_gen_bus_if.addr, test_value, mem_gen_bus_if.wdata);
		mem_gen_bus_if.busy  = 1'b0;
	        @(posedge CLK);
		test_value++;
		// now second word in the frame
		assert(mem_gen_bus_if.wdata == test_value) else $error("Test case: %s, test num: %0d, \n \t Second Round second write at 0x%h, expected: 0x%h, read: 0x%h", test_case, test_num, mem_gen_bus_if.addr, test_value, mem_gen_bus_if.wdata);
	        @(posedge CLK);
		mem_gen_bus_if.busy  = 1'b1;
		test_value++;
	    end // if (mem_gen_bus_if.addr > 32'h0000_0200)
	    else begin
		assert(mem_gen_bus_if.wdata == test_value2) else $error("Test case: %s, test num: %0d, \n \t First Round write at 0x%h, expected: 0x%h, read: 0x%h", test_case, test_num, mem_gen_bus_if.addr, test_value2, mem_gen_bus_if.wdata);
		mem_gen_bus_if.busy  = 1'b0;
	        @(posedge CLK);
		test_value2++;
		// now second word in the frame
		assert(mem_gen_bus_if.wdata == test_value2) else $error("Test case: %s, test num: %0d, \n \t First Round second write at 0x%h, expected: 0x%h, read: 0x%h", test_case, test_num, mem_gen_bus_if.addr, test_value, mem_gen_bus_if.wdata);
		@(posedge CLK);
		mem_gen_bus_if.busy  = 1'b1;
		test_value2++;
	    end // else: !if(mem_gen_bus_if.addr >= 32'h0000_0200)
	end // while (1)
	flush  = 1'b0;

	// Test case 7, write 4 times to a set, check cache replacement
	#CLK_PERIOD;
	@(negedge CLK);
	test_num++;
	test_case 	      = "Cache Replace";
	nRST 		      = 1'b0;
	#CLK_PERIOD;
	nRST 		       = 1'b1;
	proc_gen_bus_if.wen    = 1'b1;
	proc_gen_bus_if.addr   = '0;
	proc_gen_bus_if.wdata  = 32'hBADD_BADD;
	mem_gen_bus_if.busy    = 1'b0;
	mem_gen_bus_if.rdata   = '0; #1;
	wait(~proc_gen_bus_if.busy);
	@(posedge CLK);
	proc_gen_bus_if.wdata  = 32'hBADD_BADD;
	proc_gen_bus_if.addr   = 32'h0000_0200; #1;
	wait(~proc_gen_bus_if.busy);
	@(posedge CLK);
	proc_gen_bus_if.wdata  = 32'hBADD_BADD;
	proc_gen_bus_if.addr   = 32'h2000_0000; #1;
	wait(~proc_gen_bus_if.busy);
	@(posedge CLK);
	proc_gen_bus_if.wdata  = 32'hFEED_FEED;
	proc_gen_bus_if.addr = 32'h4000_0000; #1;
	wait(~proc_gen_bus_if.busy);
	@(posedge CLK);
	proc_gen_bus_if.wen   = 1'b0;
	// read to replace, read-allocate
	proc_gen_bus_if.ren   = 1'b1;
	proc_gen_bus_if.addr  = 32'h3000_0000;
        mem_gen_bus_if.rdata  = 32'hFEED_FEED;
	#1; wait(~proc_gen_bus_if.busy);
	@(posedge CLK);

	// read back to test
	proc_gen_bus_if.ren   = 1'b1;
	mem_gen_bus_if.rdata  = 32'hAAAA_AAAA;
	proc_gen_bus_if.addr  = 32'h4000_0000; #1;
	wait(~proc_gen_bus_if.busy);
	assert(proc_gen_bus_if.rdata == 32'hFEED_FEED) else $error("Test case: %s, test num: %0d, \n \t read: 0x%h, expected: 0x%h at 0x%h", test_case, test_num, proc_gen_bus_if.rdata, 32'hFEED_FEED, proc_gen_bus_if.addr);
	@(posedge CLK);
	
	proc_gen_bus_if.addr  = 32'h3000_0000; #1;
	wait(~proc_gen_bus_if.busy);
	assert(proc_gen_bus_if.rdata == 32'hFEED_FEED) else $error("Test case: %s, test num: %0d, \n \t read: 0x%h, expected: 0x%h at 0x%h", test_case, test_num, proc_gen_bus_if.rdata, 32'hFEED_FEED, proc_gen_bus_if.addr);
	@(posedge CLK);
	proc_gen_bus_if.ren = 1'b0;
	
	
	// // Test case 8, flush after random write
	// @(negedge CLK);
	// nRST  = 1'b0;
	// #CLK_PERIOD;
	// nRST 		      = 1'b1;
	// test_case 	      = "Random Flush";
	// test_num 	     += 1;
	// proc_gen_bus_if.wen   = 1'b1;
	// mem_gen_bus_if.busy   = 1'b0;
	// mem_gen_bus_if.rdata  = 32'hFEED_FEED;
	// proc_gen_bus_if.ren   = 1'b0;
	// proc_gen_bus_if.addr  = 32'h0000_0100;
	// proc_gen_bus_if.wdata = 32'hDEAF_DEAF;
	// #1; wait(~proc_gen_bus_if.busy); @(posedge CLK);

	// proc_gen_bus_if.addr  = 32'h0000_0020;
	// #1; wait(~proc_gen_bus_if.busy); @(posedge CLK);

	// proc_gen_bus_if.wen  = 1'b0;
	// flush 		     = 1'b1;

    //     while(1) begin
	//     wait(flush_done || mem_gen_bus_if.wen);
	//     if(flush_done) begin
	// 		flush  = 1'b0;
	// 		#CLK_PERIOD;
	// 		break;
	//     end
	//     if(mem_gen_bus_if.addr === 32'h0000_0100 || mem_gen_bus_if.addr == 32'h0000_0020) begin
	// 		assert(mem_gen_bus_if.wdata == 32'hDEAF_DEAF) else $error("Test case: %s, test num: %0d, \n \t read: 0x%h, expected: 0x%h, at 0x%h", test_case, test_num, mem_gen_bus_if.wdata, 32'hDEAF_DEAF, mem_gen_bus_if.addr);
	//     end
	//     else begin
	// 		assert(mem_gen_bus_if.wdata == 32'hFEED_FEED) else $error("Test case: %s, test num: %0d, \n \t read: 0x%h, expected: 0x%h, at 0x%h", test_case, test_num, mem_gen_bus_if.wdata, 32'hFEED_FEED, mem_gen_bus_if.addr);
	//     end // else: !if(mem_gen_bus_if.addr === 32'h0000_0100 || mem_gen_bus_if.addr == 32'h0000_0020)
	// end // while (1)
	$finish;	
    end // initial begin
 
endprogram // test

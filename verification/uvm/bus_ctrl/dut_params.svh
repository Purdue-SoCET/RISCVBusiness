`ifndef DUT_PARAMS_SVH
`define DUT_PARAMS_SVH

`define zero_unpckd_array(ARRAY) \
  foreach(``ARRAY``[i]) ``ARRAY``[i] = 0
package dut_params;

  localparam NUM_CPUS_USED = 8;
  localparam BLOCK_SIZE_WORDS = 2;
  localparam WORD_W = 32;
  localparam DRVR_TIMEOUT = 10000;
  localparam MONITOR_TIMEOUT = 20;
  localparam BUS_CHECKER_TIMEOUT = 25;
  localparam DRVR_SNOOP_ARRAY_SIZE = 4096;
  localparam l2_RAND_RANGE = 10;

  // Signals to control test type
  localparam NUM_TESTS = 10; // Reset is pulled low between each test
  localparam NUM_TRANS_PER_TEST = 10; // number of cache -> bus requests (per cache) in each test
  localparam ALLOW_IDLE_TRANS = 0;// Allows idle transactions to be part of the possible trans in a test

endpackage
`endif

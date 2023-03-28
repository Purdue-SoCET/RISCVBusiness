`ifndef DUT_PARAMS_SVH
`define DUT_PARAMS_SVH

`define zero_unpckd_array(ARRAY) \
  foreach(``ARRAY``[i]) ``ARRAY``[i] = 0
package dut_params;

  localparam NUM_CPUS_USED = 2;
  localparam BLOCK_SIZE_WORDS = 2;
  localparam WORD_W = 32;
  localparam DRVR_TIMEOUT = 100;
  localparam MONITOR_TIMEOUT = 10;
  localparam BUS_CHECKER_TIMEOUT = 25;
  localparam DRVR_SNOOP_ARRAY_SIZE = 4096;
  localparam l2_RAND_RANGE = 10;

endpackage
`endif

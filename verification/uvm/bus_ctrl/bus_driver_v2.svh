`ifndef BUS_DRIVER_V2_SVH
`define BUS_DRIVER_V2_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "bus_ctrl_if.vh"
`include "dut_params.svh"
`include "env_config.svh"

class bus_driver_v2 extends uvm_driver #(bus_transaction);
  `uvm_component_utils(bus_driver_v2)

  virtual bus_ctrl_if vif;
  env_config envCfg;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // get interface from database
    if (!uvm_config_db#(virtual bus_ctrl_if)::get(this, "", "bus_ctrl_vif", vif)) begin
      // if the interface was not correctly set, raise a fatal message
      `uvm_fatal("Driver", "No virtual interface specified for this test instance");
    end
    /*if (!uvm_config_db#(env_config)::get(this, "", "envCfg", envCfg)) begin
      // if the envCfg was not correctly set, raise a fatal message
      `uvm_fatal("Driver", "No env_config passed down through database");
    end*/
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    bus_transaction currTrans;
    int cpuIndexCounts[dut_params::NUM_CPUS_USED-1:0];
    int snoopCpuIndexs [dut_params::NUM_CPUS_USED-1:0] ; // array of all the cpus that have a snoop request that need to be handled
    int transCpuIndex;
    int timeoutCount [dut_params::NUM_CPUS_USED-1:0];

    DUT_reset();  // Power on Reset
    repeat (20) @(posedge vif.clk)

    forever begin
      zero_all_sigs();
      seq_item_port.get_next_item(currTrans);
      `uvm_info(this.get_name(), $sformatf("Received new sequence item:\n%s", currTrans.sprint()),
                UVM_DEBUG);
      `zero_unpckd_array(cpuIndexCounts);

      for(int j = 0; j < dut_params::NUM_CPUS_USED; j++) begin
      fork
          automatic int i = j;
          runCpu(i, currTrans, cpuIndexCounts, timeoutCount);
      join_none
      end
      wait fork;

      zero_all_sigs();
      send_finished_stim();
      seq_item_port.item_done();

    end
  endtask

  task runCpu;
    input int i;
    input bus_transaction currTrans;
    input int cpuIndexCounts[dut_params::NUM_CPUS_USED-1:0];
    input int timeoutCount [dut_params::NUM_CPUS_USED-1:0];

    begin
    bit [2:0] waitAmount;
          while (allStimNotSent(
              cpuIndexCounts[i], currTrans.numTransactions
          )) begin

          waitAmount = $urandom %5;
          repeat (waitAmount) @(posedge vif.clk);

            timeoutCount[i] = 0;
            `uvm_info(this.get_name(), "Stim not fully sent...", UVM_DEBUG);
            // Loop through all of the CPUS that we are driving and send out any stim that needs to be sent
                `uvm_info(this.get_name(), $sformatf("Sending stim %0d from CPU: %d", cpuIndexCounts[i], i), UVM_DEBUG);
                driveCpuStim(i, cpuIndexCounts[i], currTrans);

            @(posedge vif.clk);  // clock in the stimulus

              while (vif.dwait[i] && currTrans.idle[i][cpuIndexCounts[i]] != 1) begin
                if (timeoutCount[i] > dut_params::DRVR_TIMEOUT) begin
                  `uvm_fatal("Driver",
                             "Timeout while waiting for a low dwait");
                end
                @(posedge vif.clk);
                timeoutCount[i] = timeoutCount[i] + 1;
              end

            `uvm_info(this.get_name(), $sformatf("Transaction %0d/%0d complete for CPU: %0d",
                                                 cpuIndexCounts[i] + 1,
                                                 currTrans.numTransactions, i), UVM_DEBUG);
            cpuIndexCounts[i] = cpuIndexCounts[i] + 1;

            driveCpuIdle(i);
        end
    end
  endtask

  function automatic bit allStimNotSent(int cpuIndexCount,
                                        int numTrans);
      if (cpuIndexCount < numTrans) return 1'b1;
    return 1'b0;
  endfunction

  function automatic bit [dut_params::WORD_W-1:0] addrMatch(bit [dut_params::WORD_W-1:0] addr, bit [dut_params::NUM_CPUS_USED-1:0][dut_params::WORD_W-1:0] addrArray, int index);
    for(int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
      if(index != i && addr == addrArray[i]) begin
        return 1;
      end
    end
    return 0;
  endfunction

  // Task that drives the stim to the correct CPU based off of the data given in the transaction
  // Also makes sure that only 1 L1 is writing to a given address at a given time!
  task driveCpuStim;
    input int cpuIndex;
    input int arrayIndex;
    input bus_transaction currTrans;
    begin
      if (currTrans.idle[cpuIndex][arrayIndex]) begin
        driveCpuIdle(cpuIndex);
      end else begin
        vif.cctrans[cpuIndex] = 1'b1;
        vif.daddr[cpuIndex]   = currTrans.daddr[cpuIndex][arrayIndex];
        vif.dWEN[cpuIndex]    = currTrans.dWEN[cpuIndex][arrayIndex] && ~(&(~(1'b1 << cpuIndex) & vif.dWEN) && addrMatch(vif.daddr, currTrans.daddr[cpuIndex][arrayIndex], cpuIndex)); // only do a write if we are the only one writing to this address
        vif.dREN[cpuIndex]    = ~currTrans.dWEN[cpuIndex][arrayIndex] || (&(~(1'b1 << cpuIndex) & vif.dWEN) && addrMatch(vif.daddr, currTrans.daddr[cpuIndex][arrayIndex], cpuIndex)); // we read if someone else is already writing to this address or if we were supposed to read
        vif.dstore[cpuIndex]  = currTrans.dstore[cpuIndex][arrayIndex];
        vif.ccwrite[cpuIndex] = currTrans.readX[cpuIndex][arrayIndex];
      end
    end
  endtask

  task driveCpuIdle;
    input int cpuIndex;
    begin
      vif.daddr[cpuIndex]   = '0;
      vif.dWEN[cpuIndex]    = '0;
      vif.dREN[cpuIndex]    = '0;
      vif.dstore[cpuIndex]  = '0;
      vif.ccwrite[cpuIndex] = '0;
      vif.cctrans[cpuIndex] = '0;

    end
  endtask

  task DUT_reset();
    begin
      `uvm_info(this.get_name(), "Resetting DUT", UVM_LOW);

      zero_all_sigs();

      @(posedge vif.clk);
      vif.nRST = '0;
      @(posedge vif.clk);
      vif.nRST = '1;
      @(posedge vif.clk);
      @(posedge vif.clk);

      `uvm_info(this.get_name(), "DUT Reset", UVM_LOW);
    end
  endtask

  task send_finished_stim();
    begin
      for(int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
        vif.daddr[i] = 32'hdeadbeef;
      end
      repeat (5) @(posedge vif.clk);
    end
  endtask

  task zero_all_sigs();
    begin
      vif.dREN        = '0;
      vif.dWEN        = '0;
      vif.daddr       = '0;
      vif.dstore      = '0;
      vif.cctrans     = '0;
      vif.ccwrite     = '0;
      vif.ccsnoophit  = '0;
      vif.ccIsPresent = '0;
      vif.ccdirty     = '0;
      vif.ccsnoopdone = '0;
    end
  endtask

  task zero_snoop_sigs();
    begin
      vif.ccsnoophit  = '0;
      vif.ccIsPresent = '0;
      vif.ccdirty     = '0;
      vif.ccsnoopdone = '0;
    end
  endtask

endclass : bus_driver_v2

`endif

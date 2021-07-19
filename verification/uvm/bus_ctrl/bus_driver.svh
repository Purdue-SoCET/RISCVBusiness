`ifndef BUS_DRIVER_SVH
`define BUS_DRIVER_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "bus_ctrl_if.vh"
`include "dut_params.svh"
`include "env_config.svh"

class bus_driver extends uvm_driver #(bus_transaction);
  `uvm_component_utils(bus_driver)

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
    if (!uvm_config_db#(env_config)::get(this, "", "envCfg", envCfg)) begin
      // if the envCfg was not correctly set, raise a fatal message
      `uvm_fatal("Driver", "No env_config passed down through database");
    end
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    bus_transaction currTrans;
    int cpuIndexCounts[dut_params::NUM_CPUS_USED-1:0];
    int snoopCpuIndexs [dut_params::NUM_CPUS_USED-1:0] ; // array of all the cpus that have a snoop request that need to be handled
    int transCpuIndex;
    int timeoutCount;

    DUT_reset();  // Power on Reset

    forever begin
      zero_all_sigs();
      seq_item_port.get_next_item(currTrans);
      `uvm_info(this.get_name(), $sformatf("Received new sequence item:\n%s", currTrans.sprint()),
                UVM_DEBUG);
      `zero_unpckd_array(cpuIndexCounts);


      // While there are still some transactions by the CPUs that need to be sent
      while (allStimNotSent(
          cpuIndexCounts, currTrans.numTransactions
      )) begin
        timeoutCount = 0;
        `uvm_info(this.get_name(), "Stim not fully sent...", UVM_DEBUG);
        // Loop through all of the CPUS that we are driving and send out any stim that needs to be sent
        for (int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
          if (cpuIndexCounts[i] < currTrans.numTransactions) begin // if we haven't sent all stim from this particular CPU
            `uvm_info(this.get_name(), $sformatf("Sending stim from CPU: %d", i), UVM_DEBUG);
            driveCpuStim(i, currTrans);
          end else begin
            `uvm_info(this.get_name(), $sformatf("Sending idle from CPU: %d", i), UVM_DEBUG);
            driveCpuIdle(i);
          end
        end

        @(posedge vif.clk);  // clock in the stimulus
        `zero_unpckd_array(snoopCpuIndexs);
        transCpuIndex = 0;

        // The snoop hit and transaction complete ints are passed by reference
        // TransComplete function checks to see if dwait is low for any of the cpus
        while (!snoopHit(
            snoopCpuIndexs
        ) && !transComplete(
            transCpuIndex
        )) begin
          if (timeoutCount > dut_params::DRVR_TIMEOUT) begin
            `uvm_fatal("Driver",
                       "Timeout while waiting for bus to snoop or give low dwait to any cpu");
          end
          @(posedge vif.clk);
          timeoutCount = timeoutCount + 1;
        end

        timeoutCount = 0;
        if (snoopHit(snoopCpuIndexs)) begin
          `uvm_info(this.get_name(), $sformatf("Snoop hits on: %p", snoopCpuIndexs), UVM_DEBUG);
          driveSnoopResponses(snoopCpuIndexs, currTrans);
          while (!transComplete(
              transCpuIndex
          )) begin
            if (timeoutCount > dut_params::DRVR_TIMEOUT) begin
              `uvm_fatal("Driver",
                         "Timeout while waiting for a low dwait to any cpu after snooping");
            end
            @(posedge vif.clk);
            timeoutCount = timeoutCount + 1;
          end
        end

        `uvm_info(this.get_name(), $sformatf("Transaction %0d/%0d complete for CPU: %0d",
                                             cpuIndexCounts[transCpuIndex] + 1,
                                             currTrans.numTransactions, transCpuIndex), UVM_DEBUG);
        cpuIndexCounts[transCpuIndex] = cpuIndexCounts[transCpuIndex] + 1;

        @(posedge vif.clk);
        if (!allDwaitHigh()) begin
          `uvm_fatal("Driver", "Not all dwaits high cycle after bus gives response");
        end

        zero_all_sigs();

      end
      zero_all_sigs();
      send_finished_stim();
      seq_item_port.item_done();

    end
  endtask

  function automatic bit allDwaitHigh();
    foreach (vif.dwait[i]) begin
      if (vif.dwait[i] != 1'b1) return 1'b0;
    end
    return 1'b1;

  endfunction

  function automatic bit isInside(
      bit [dut_params::DRVR_SNOOP_ARRAY_SIZE-1:0][dut_params::WORD_W - 1:0] checkArray,
      bit [dut_params::WORD_W - 1:0] checkVal);
    foreach (checkArray[i]) begin
      if (checkVal == checkArray[i]) return 1'b1;
    end
    return 1'b0;

  endfunction
  ;

  task driveSnoopResponses;
    input int snoopCpuIndexs[dut_params::NUM_CPUS_USED-1:0];
    input bus_transaction currTrans;
    begin
      zero_snoop_sigs();

      foreach (snoopCpuIndexs[i]) begin
        if(snoopCpuIndexs[i] == 1'b1) begin // if we have a snoop hit to the i'th CPU then we need to respond
          if (isInside(
                  currTrans.snoopHitAddr[i], vif.ccsnoopaddr[i]
              )) begin  // if the snoop is a hit
            vif.ccsnoopdone[i] = 1'b1;
            vif.ccsnoophit[i] = 1'b1;
            vif.ccIsPresent[i] = 1'b1;
            vif.ccdirty[i] = isInside(currTrans.snoopDirty[i], vif.ccsnoopaddr[i]);
          end else begin
            vif.ccsnoopdone[i] = 1'b1;
          end
        end
      end

      @(posedge vif.clk);

      zero_snoop_sigs();
    end
  endtask

  function automatic bit snoopHit(ref int snoopCpuIndexs[dut_params::NUM_CPUS_USED-1:0]);
    bit returnVal;

    `zero_unpckd_array(snoopCpuIndexs);

    for (int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
      if (vif.ccwait[i]) begin
        returnVal = 1'b1;
        snoopCpuIndexs[i] = 1;
      end
    end

    return returnVal;
  endfunction

  function automatic bit transComplete(ref int transCpuIndex);
    bit returnVal;

    returnVal = 1'b0;
    transCpuIndex = 0;  // no real need to zero out, just nice to do

    for (int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
      if (~vif.dwait[i]) begin
        // Check to make sure that this is the only cpu recieviing information
        if (returnVal == 1'b1)
          `uvm_fatal("Driver", "Multiple CPUS see !dwait, cannot continue");
        returnVal = 1'b1;
        transCpuIndex = i;
      end
    end
    return returnVal;
  endfunction


  function automatic bit allStimNotSent(int cpuIndexCounts[dut_params::NUM_CPUS_USED-1:0],
                                        int numTrans);
    for (int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
      if (cpuIndexCounts[i] < numTrans) return 1'b1;
    end

    return 1'b0;
  endfunction

  // Task that drives the stim to the correct CPU based off of the data given in the transaction
  task driveCpuStim;
    input int cpuIndex;
    input bus_transaction currTrans;
    begin
      if (currTrans.idle[cpuIndex]) begin
        driveCpuIdle(cpuIndex);
      end else begin
        vif.cctrans[cpuIndex] = 1'b1;
        vif.daddr[cpuIndex]   = currTrans.daddr[cpuIndex];
        vif.dWEN[cpuIndex]    = currTrans.dWEN[cpuIndex];
        vif.dREN[cpuIndex]    = ~currTrans.dWEN[cpuIndex];
        vif.dstore[cpuIndex]  = currTrans.dstore[cpuIndex];
        vif.ccwrite[cpuIndex] = currTrans.readX[cpuIndex];
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

endclass : bus_driver

`endif

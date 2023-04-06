`ifndef L1_SNOOPRESP_BFM
`define L1_SNOOPRESP_BFM

import uvm_pkg::*;

`include "bus_ctrl_if.vh"
`include "dut_params.svh"
`include "uvm_macros.svh"


class l1_snoopresp_bfm extends uvm_component;
 `uvm_component_utils(l1_snoopresp_bfm)

 virtual bus_ctrl_if vif;

 function new(string name = "l1_snoopresp_bfm", uvm_component parent);
   super.new(name, parent);
 endfunction : new

 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   if (!uvm_config_db#(virtual bus_ctrl_if)::get(this, "", "bus_ctrl_vif", vif)) begin
     `uvm_fatal("snoop_bfm", "No virtual interface specified for this mbgm instance")
   end
 endfunction

 virtual task run_phase(uvm_phase phase);
   forever begin
    @(posedge vif.clk);
    #2; // propogation delay
    zero_all_sigs();
    snoop_bus(); 
   end
 endtask : run_phase 

 virtual task snoop_bus();
  bit hit;
  int loc;
  logic [CPUS-1:0] dirtyVals;
  logic [CPUS-1:0] hitVals;
  logic [CPUS-1:0][DATA_WIDTH-1:0]l1_dstore;
  dirtyVals = '0;
  hitVals  = '0;


  if(|vif.ccwait == 1) begin
    // First generate all of our randomized hit/dirty values
    // Need to do this before fork since the dirty depends on all of the hits being generated first
    hitVals = generate_hit(vif.ccwait);
    dirtyVals = generate_ccdirty(hitVals);

    `uvm_info(this.get_name(), $sformatf("Dirty vals are 0x%x\n", dirtyVals), UVM_DEBUG);
    for(int j = 0; j < dut_params::NUM_CPUS_USED; j++) begin
      fork
          automatic int i = j;
          runResp(i, hitVals, dirtyVals);
      join_none
      end
    wait fork;

       while(|vif.ccwait) begin
         @(posedge vif.clk);
       end

       zero_all_sigs();
   end
 endtask

 virtual task runResp;
    input int i;
    input logic [CPUS-1:0] hitVals;
    input logic [CPUS-1:0] dirtyVals;
 begin
    if((vif.ccwait[i] == 1) && (vif.ccinv[i] == 0)) begin
     // Wait a random amount of time
     wait_new_time();

     // Set the hit/dirty values 
     vif.ccsnoophit[i] = hitVals[i];
     vif.ccIsPresent[i] = hitVals[i];
     vif.ccdirty[i] = dirtyVals[i];

     // If we get a hit set our dstore
     if(hitVals[i]) vif.snoop_dstore[i] = {32'hbbbbbbbb, vif.ccsnoopaddr[i]};
     else vif.snoop_dstore[i] = {32'hbbbbbbbb, 32'hdeadbeef};
     vif.ccsnoopdone[i] = 1; //check this part again
   end 
   else if(vif.ccwait[i] == 1) begin
     vif.ccsnoopdone[i] = 1; //check this part again
   end 
   else begin
     zeroSigsForIndex(i);
   end

 end
 endtask

 virtual function logic [CPUS-1:0] generate_hit(logic [CPUS-1:0] waitVals);
    logic [CPUS-1:0] tempHitArray = '0;
    for(int i = 0; i < CPUS; i++) begin
        tempHitArray[i] = (logic'($urandom() % 2)) & waitVals[i]; // generae a random val between 0 and 1 and only set hit if this cache is being snooped into
    end

    return tempHitArray;
 endfunction 


 virtual function logic [CPUS-1:0] generate_ccdirty(logic [CPUS-1:0] snoophit);
    logic [CPUS-1:0] tempDirtyArray = '0;
    int numHit; // number of hits in the hit array
    int hitPosArray[CPUS-1];
    int hitPos;


    // Figure out how many hits we have
    // Also fit up the position array with all of the hit indexes
    // We will pick a random number and choose from the hitPosArray for which person gets a dirty if any
    for(int i = 0; i < CPUS; i++) begin
        if(snoophit[i] == 1'b1) begin 
            hitPosArray[numHit] = i;
            numHit = numHit + 1; 
        end
    end

    // If only 1 hit then we can toss a coin to see if it is dity
    // Can't do this if multiple hits because only 1 cache can be in M while the others must be in I
    if(numHit == 1) begin tempDirtyArray[hitPosArray[0]] = $urandom() %2; end

    return tempDirtyArray;
 endfunction

 virtual task wait_new_time();
  int wait_cycle;
  wait_cycle = $urandom_range(3, 8); //waiting random cycles for each L1
  for(int i = 0; i < wait_cycle; i++) begin
   @(posedge vif.clk);
  end
 endtask

 virtual task zero_all_sigs();
     begin
       vif.cctrans     = '0;
       vif.snoop_dstore = '0;
       //vif.ccwrite     = '0;
       vif.ccsnoophit  = '0;
       vif.ccIsPresent = '0;
       vif.ccdirty     = '0;
       vif.ccsnoopdone = '0;
     end
 endtask

 virtual task zeroSigsForIndex(input int i);
     begin
       vif.cctrans[i]     = '0;
       //vif.ccwrite     = '0;
       vif.ccsnoophit[i]  = '0;
       vif.ccIsPresent[i] = '0;
       vif.ccdirty[i]     = '0;
       vif.ccsnoopdone[i] = '0;
       vif.snoop_dstore[i] = '0;
     end
 endtask

endclass : l1_snoopresp_bfm
`endif

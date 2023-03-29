`ifndef L1_SNOOPRESP_BFM
`define L1_SNOOPRESP_BFM

import uvm_pkg::*;

`include "bus_ctrl_if.vh"
`include "dut_params.svh"
`include "uvm_macros.svh"


class l1_snoopresp_bfm extends uvm_component;
 `uvm_component_utils(l1_snoopresp_bfm)

 virtual bus_ctrl_if vif;
 //rand bit [CPUS-1:0] l1_ccdirty, l1_ccsnoophit, l1_ccIsPresent;
 //constraint l1_ccdirty_c {$onehot(l1_ccdirty) == 1;};
 //constraint l1_ccsnoophit_ccIsPresent_c {l1_ccsnoophit == l1_ccIsPresent;};

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
  logic [CPUS-1:0] l1_ccdirty;
  logic [CPUS-1:0][DATA_WIDTH-1:0]l1_dstore;
  l1_ccdirty = '0;
  l1_dstore = '0;
  //std::randomize(loc);

  if(|vif.ccwait == 1) begin

       fork 
        begin
         for(int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin 
           if((vif.ccwait[i] == 1) && (vif.ccinv[i] == 0)) begin
             wait_new_time();
             void'(std::randomize(hit));
             vif.ccsnoophit[i] = hit;
             vif.ccIsPresent[i] = hit;
             if(hit) l1_dstore[i] = {32'hbbbbbbbb, vif.ccsnoopaddr[i]};
             else l1_dstore[i] = {32'hbbbbbbbb, 32'hdeadbeef};
           end 
           else if((vif.ccwait[i] == 1) && (vif.ccinv[i] == 1)) begin
            //Add logic here to search L1, if found, then invalidate depending on exclusive or not
            //`uvm_info("L1_SNOOP", $sformatf("Cache block invalidated in %d th L1", i), UVM_DEBUG);
           end 
           else begin
             //`uvm_info("L1_SNOOP", $sformatf("Nothing to Snoop/Respond to in %d th L1", i), UVM_LOW);
             zero_all_sigs();
           end
          end 
        end
       join

       if(|vif.ccsnoophit) begin 
        //`uvm_info("L1_SNOOP", $sformatf("Cache Block Found with L1 = %b", vif.ccsnoophit), UVM_LOW);
       end 
       else begin 
        //`uvm_info("L1_SNOOP", $sformatf("Requested Cache block is not found with L1's. Go to L2!!"), UVM_LOW);
        //vif.l2_req = 1; //this signal should connect to L2/Busctrl to get the new block.
       end
       //still randomizing the L1 which provides the block to bus when block = shared along with dirty
       loc = generate_ccdirty(vif.ccsnoophit);
       //l1_ccdirty[loc] = 1;
       void'(std::randomize(hit));
       l1_ccdirty[loc] = hit; //randomizing selected random bit
       vif.snoop_dstore = l1_dstore;
       vif.ccdirty = l1_ccdirty;
       foreach(vif.ccsnoopdone[i]) begin 
         vif.ccsnoopdone[i] = vif.ccwait[i] ? 1 : 0; //check this part again
       end

       // Hold the signals until we get ccwait low
       // This is the bus protocol the bus controller expects
       while(|vif.ccwait) begin
         @(posedge vif.clk);
       end

       zero_all_sigs();
   end
 endtask

 //virtual task generate_ccdirty(logic [CPUS-1:0] snoophit);
 virtual function generate_ccdirty(logic [CPUS-1:0] snoophit);
  logic [CPUS-1:0] l1_ccdirty;
  int temp_arr[$bits(snoophit)];
  int position;
  l1_ccdirty = '0;
  void'(std::randomize(temp_arr));
  for(int i = 0; i < $bits(snoophit); i++) begin
   if(snoophit[i] == 1) temp_arr[i] = i;
  end
  position = $urandom_range(0, $size(temp_arr));
  return temp_arr[position];
  //l1_ccdirty[temp_arr[position]] = 1;
  //return l1_ccdirty;
 endfunction : generate_ccdirty
 
 virtual task wait_new_time();
  int wait_cycle;
  wait_cycle = $urandom_range(3, 8); //waiting random cycles for each L1
  for(int i = 0; i < wait_cycle; i++) begin
   @(posedge vif.clk);
  end
 endtask

// virtual task snoop_bus(word_t ccsnoopaddr); //check cc_trans/ccwait directions again
//   for(int i = 0, i < dut_params::NUM_CPUS_USED, i++) begin 
//     if(vif.cc_trans[i] == 1) begin  //if requester is undergoing a miss
//       vif.ccwait[i] = 1;
//       if(searchl1(ccsnoopaddr, 0)) begin 
//         `uvm_info("L1_SNOOP", $sformatf("Cache Block Found!! Sending to the requester thru the BUS"), UVM_LOW);
//       end 
//       else begin 
//         `uvm_info("L1_SNOOP", $sformatf("Requested Cache block is not found with L1's. Go to L2!!"), UVM_LOW);
//         vif.l2_req = 1; //this signal should connect to L2/Busctrl to get the new block.
//       end 
//     else if(vif.ccinv[i] == 1) begin
//       vif.ccwrite[i] = 1;
//       vif.ccdirty[i] = 1;
//       if(vif.ccexclusive[i] == 0) //No need to invalidate if the block is in exclusive state
//         searchl1(ccsnoopaddr, 1);
//       `uvm_info("L1_SNOOP", $sformatf("invalidation completed"), UVM_LOW)
//       vif.ccwrite[i] = 0;
//       vif.ccdirty[i] = 0; //use this later to flush into L2
//     end 
//     else begin
//       `uvm_info("L1_SNOOP", $sformatf("Nothing to Snoop/Respond to"), UVM_LOW);
//       zero_all_sigs();
//     end
//     vif.ccwait[i] = 0;
//   end
// endtask
// 
// virtual task searchl1(logic [31:0] addr, bit invalidate);
//   rand bit cacheblkfound;
//   rand bit [31:0] l1_data; 
//   //returning random value for now as we don't care the exact value
//   //PS: Ideally, L1 cache should be developed, instantiated for each CPU and get the data from it if the addr/tag matches.
//   for(int i = 0, i < dut_params::NUM_CPUS_USED, i++) begin
//     if((cacheblkfound == 1) && (vif.ccIsPresent[i] == 1)) begin
//      vif.ccsnoophit[i] == 1;
//      if(invalidate == 0) begin
//        vif.ccsnoopdone[i] = 1;
//        break;
//      end
//      else begin
//        //add invalidation logic wrt coherence - TODO: Discuss how to develop the coherence states.
//        `uvm_info("L1_SNOOP", $sformatf("invalidating the block in Processor %d", i), UVM_LOW)
//      end
//     end
//   end
//   if(invalidate == 0)
//     return l1_data;
//   else
//     `uvm_info("L1_SNOOP", $sformatf("invalidating the block in Processor %d", i), UVM_LOW) //TODO
// endtask
 
 virtual task zero_all_sigs();
     begin
       vif.cctrans     = '0;
       //vif.ccwrite     = '0;
       vif.ccsnoophit  = '0;
       vif.ccIsPresent = '0;
       vif.ccdirty     = '0;
       vif.ccsnoopdone = '0;
     end
 endtask

endclass : l1_snoopresp_bfm
`endif

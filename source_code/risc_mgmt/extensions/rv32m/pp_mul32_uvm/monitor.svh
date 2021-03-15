import uvm_pkg::*;
`include "uvm_macros.svh"
`include "mult_if.svh"

class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    virtual mult_if vif;
    uvm_analysis_port #(transaction) mult_ap;
    uvm_analysis_port #(transaction) result_ap;
    transaction prev_tx;


    virtual function void build_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual mult_if)::get(this, "", "mult_vif", vif)) begin
          `uvm_fatal("monitor", "No virtual interface specified for this monitor instance")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        prev_tx = transaction::type_id::create("prev_tx");
        forever begin
          transaction tx;
          @(posedge vif.clk);
          tx = transaction::type_id::create("tx");
          tx.multiplicand = vif.multiplicand;
          tx.multiplier = vif.multiplier;
          if(!tx.input_equal(prev_tx) && tx.multiplicand != 'z && tx.multiplier != 'z) begin
            mult_ap.write(tx);
            while(!vif.finished) begin
                @(posedge vif.clk)
            end
            tx.product = vif.product;
            result_ap.write(tx);
            prev_tx.copy(tx);
          end
        end
    endtask: run_phase

endclass
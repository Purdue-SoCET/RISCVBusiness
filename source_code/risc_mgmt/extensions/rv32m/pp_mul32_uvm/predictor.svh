import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.svh"

class predictor extends uvm_subscriber #(transaction);
    `uvm_component_utils(predictor) 

    uvm_analysis_port #(transaction) pred_ap; 
    transaction output_tx;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        pred_ap = new("pred_ap", this);
    endfunction

    function void write(transaction tx);
        output_tx = transaction::type_id::create("output_tx", this);
        output_tx.copy(tx);
        output_tx.product = 64'b0;

        for(int i = 0; i < tx.multiplier; i++) {
            output_tx.product += tx.multiplicand;
        }
        
        pred_ap.write(output_tx);

    endfunction: write
endclass
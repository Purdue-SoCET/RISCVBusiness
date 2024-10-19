`ifndef INSTR_TRANSACTION_SVH
`define INSTR_TRANSACTION_SVH

    class instr_transaction extends uvm_sequence_item;
        `uvm_object_utils(instr_transaction)

        // *********** DUT Inputs ***********

        // *********** DUT Outputs ***********

        function new(string name = "instr_transaction");
            super.new(name);
        endfunction

    endclass
`endif


class component extends uvm_component;
    `uvm_component_utils(component)
   
    virtual dut_if pp_mult32_if;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);  
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
    endtask: run_phase

    function report_phase(uvm_phase phase);
    endfunction: report phase
endclass
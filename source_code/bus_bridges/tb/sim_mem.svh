`ifndef MEM
`define MEM
`include "uvm_macros.svh"
import uvm_pkg::*;


//simulated memory that is used in the simulated slave
class sim_mem extends uvm_object;
  parameter SIZE = 4; //the number of bits in the addr
  rand bit [7:0] registers[2 ** SIZE  - 1:0];
  
  `uvm_object_utils_begin(sim_mem)
    `uvm_field_sarray_int(registers, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name = "sim_mem");
    super.new(name);
  endfunction: new

  //print the value in all registers for debugging purpose
  function void print_all();
    for (int lcv = 0; lcv < 2**SIZE; lcv++) begin
      $display("%h: %h",lcv, registers[lcv]);
    end
    
  endfunction

  //write the least significant byte in HWDATA to addr
  function void write_byte(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr] = HWDATA[7:0];
  endfunction

  //write two least significant bytes in HWDATA to addr
  function void write_half(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr++] = HWDATA[7:0];
    registers[addr] = HWDATA[15:8];
  endfunction

  //write four least significant bytes in HWDATA to addr
  function void write_word(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr++] = HWDATA[7:0];
    registers[addr++] = HWDATA[15:8];
    registers[addr++] = HWDATA[23:16];
    registers[addr] = HWDATA[31:24];
  endfunction

  //read a byte stored in addr to the least significant byte to HRDATA
  function logic[31:0] read_byte(logic[SIZE - 1:0] addr);
    logic[31:0] result;
    result = '0;
    result[7:0] = registers[addr];
    return result;
  endfunction

  //read two bytes stored in addr to the least significant byte to HRDATA
  function logic[31:0] read_half(logic[SIZE - 1:0] addr);
    logic[31:0] result;
    result = '0;
    result[7:0] = registers[addr++];
    result[15:8] = registers[addr];
    return result;
  endfunction

  //read four bytes stored in addr to the least significant byte to HRDATA
  function logic[31:0] read_word(logic[SIZE - 1:0] addr);
    logic[31:0] result;
    result = '0;
    result[7:0] = registers[addr++];
    result[15:8] = registers[addr++];
    result[23:16] = registers[addr++];
    result[31:24] = registers[addr];
    return result;
  endfunction
endclass //sim_mem

`endif

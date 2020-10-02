//By            : Zhengsen Fu
//Description   : all the UVM components needed in tb_ahb.sv
//Last Updated  : 8/21/20

`include "uvm_macros.svh"
import uvm_pkg::*;



//a queue that record all the transactions.
//search function still needs debugging
class transactionSeq; //transaction sequence
  localparam MAX_SIZE = 4000;
  transaction arr[MAX_SIZE - 1:0];
  integer time_arr[MAX_SIZE - 1:0]; //arr which recording the time that the transaction has happened
  int index; //points to most recent transactoin
  function new();
    index = -1;
  endfunction //new()

  //push one transaction into the arr
  function void push(transaction item);
    if(index == MAX_SIZE) begin //can be implemented as a queue is needed in the future
      $fatal("transactionSeq: sequence cannot hold more items"); 
    end
    index++;
    arr[index] = item;
    time_arr[index] = $time();
  endfunction

  //search for the most recent transaction that write to an addr
  function transaction search(logic[31:0] addr);
    transaction item;
    for(int lcv = index; lcv > 0; lcv--) begin
      item = arr[lcv];
      //if not WRITE, pass
      if (item.trans != item.WRITE) begin
        continue;
      end
      if(item.byte_en == 4'b1111) begin
        if (addr == item.addr || addr == (item.addr - 1) || addr == (item.addr - 2)  || addr == (item.addr - 3)) begin
          return item;
        end
      end else if(item.byte_en == 4'b1100 || item.byte_en == 4'b0011) begin
        if (addr == item.addr || addr == (item.addr - 1)) begin
          return item;
        end
      end else begin
        if (addr == item.addr) begin
          return item;
        end
      end
    end
    $fatal("transaction not found!\n");
  endfunction

  //search for the index of the most recent transaction that write to an addr 
  function int search_index(logic[31:0] addr);
    transaction item;
    for(int lcv = index; lcv > 0; lcv--) begin
      item = arr[lcv];
      //if not WRITE, pass
      if (item.trans != item.WRITE) begin
        continue;
      end
      if(item.byte_en == 4'b1111) begin
        if (addr == item.addr || addr == (item.addr - 1) || addr == (item.addr - 2)  || addr == (item.addr - 3)) begin
          return lcv;
        end
      end else if(item.byte_en == 4'b1100 || item.byte_en == 4'b0011) begin
        if (addr == item.addr || addr == (item.addr - 1)) begin
          return lcv;
        end
      end else begin
        if (addr == item.addr) begin
          return lcv;
        end
      end
    end
    $fatal("transaction not found!\n");
  endfunction

  //search for the time of the most recent transaction that write to an addr 
  function int search_time(logic[31:0] addr);
    transaction item;
    for(int lcv = index; lcv > 0; lcv--) begin
      item = arr[lcv];
      //if not WRITE, pass
      if (item.trans != item.WRITE) begin
        continue;
      end
      if(item.byte_en == 4'b1111) begin
        if (addr == item.addr || addr == (item.addr - 1) || addr == (item.addr - 2)  || addr == (item.addr - 3)) begin
          return time_arr[lcv];
        end
      end else if(item.byte_en == 4'b1100 || item.byte_en == 4'b0011) begin
        if (addr == item.addr || addr == (item.addr - 1)) begin
          return time_arr[lcv];
        end
      end else begin
        if (addr == item.addr) begin
          return time_arr[lcv];
        end
      end
    end
    // $fatal("transaction not found!\n");
  endfunction
endclass //transactionSeq





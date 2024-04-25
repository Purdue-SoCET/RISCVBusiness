/*
*   Copyright 2016 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     stage3_thread_selector.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/19/2016
*   Description:  Fetch stage for the two stage pipeline
*/

`include "stage3_fetch_execute_if.vh"
`include "stage3_hart_selector_if.vh"
`include "generic_bus_if.vh"
`include "component_selection_defines.vh"
`include "rv32c_if.vh"

module stage3_hart_selector (
    input logic CLK,
    nRST,
    stage3_hazard_unit_if.fetch hazard_if,
    stage3_mem_pipe_if.execute ex_mem_if,
    stage3_hart_selector_if.hart_selector_unit hart_selector_if,
    global_events_if.hart_selector global_events_if
);
    import rv32i_types_pkg::*;
    import pma_types_1_12_pkg::*;

    parameter logic [31:0] NUM_HARTS = 1;

    word_t next_count;
    word_t count;
    logic [NUM_HARTS-1:0] stalled_threads, next_stalled_threads;
    logic [NUM_HARTS-1:0] active_threads, next_active_threads;
    word_t next_hart_id;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            count <= '0;
            hart_selector_if.hart_id <= '0;
            active_threads <= '1;
            stalled_threads <= '0;
        end else begin
            count <= next_count;
            hart_selector_if.hart_id <= next_hart_id;
            active_threads <= next_active_threads;
            stalled_threads <= next_stalled_threads;
        end
    end

    assign global_events_if.halt_proc = ~|active_threads;

    // always_comb begin
    //   for(int i = 0; i < NUM_HARTS; i++) begin
    //     global_events_if.halt_proc &= (~active_threads[i]);
    //   end
    // end

    always_comb begin
      next_active_threads = active_threads;
      if(global_events_if.thread_terminated) begin
        next_active_threads[ex_mem_if.ex_mem_reg.hart_id] = 1'b0;
      end
    end

    always_comb begin
      if(hazard_if.pc_en && !hazard_if.if_ex_flush) begin
        if (count == 10 || global_events_if.cache_miss) next_count = 0;
        else next_count = count + 1;
      end else begin
        if(global_events_if.cache_miss) next_count = 0;
        else next_count = count;
      end
    end

    always @ (global_events_if.cache_miss, next_count, global_events_if.thread_terminated) begin
      next_hart_id = hart_selector_if.hart_id;
      next_stalled_threads = stalled_threads;
      if (global_events_if.cache_miss || global_events_if.thread_terminated) begin
        word_t current_hart_id = hart_selector_if.hart_id;
        for(word_t i = 32'd0; i < NUM_HARTS; i = i + 32'd1) begin
          current_hart_id = (current_hart_id + 32'd1) % NUM_HARTS;
          if (active_threads[current_hart_id]) begin
            next_hart_id = current_hart_id;
            break;
          end  
        end
      end 
    end
endmodule
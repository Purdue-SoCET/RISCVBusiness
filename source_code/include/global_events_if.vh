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
*   Filename:     cache_control_if.vh
*   
*   Created by:   John Skubic	
*   Email:        jjs.skubic@gmail.com
*   Date Created: 06/29/2017
*   Description:  Interface between the Pipeline, caches, and memory system
*                 Any actions that control the cache are relayed through this if.
*                 Events that may cause activity on this interface:
*                   - Memory Fences
*                   - Coherence Operations 
*/

`ifndef GLOBAL_EVENTS_IF_VH
`define GLOBAL_EVENTS_IF_VH

interface global_events_if;

  import rv32i_types_pkg::*;
  logic cache_miss, thread_terminated, cache_updated, halt_proc;
  word_t hart_id;

  modport hart_selector(
    input cache_miss, thread_terminated, cache_updated,
    output halt_proc
  );

  modport pipeline (
    input cache_miss, hart_id, halt_proc,
    output thread_terminated
  );

  modport caches (
    output cache_miss, hart_id, cache_updated
  );

endinterface
`endif //GLOBAL_EVENTS_IF

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
*   Filename:     include/cpu_tracker_if.vh
*
*   Created by:   Rohan Gangaraju
*   Email:        rgangar@purdue.edu
*   Date Created: 02/20/2024
*   Description:  Interface to collect cpu statistics
*/

`ifndef CPU_TRACKER_IF_VH 
`define CPU_TRACKER_IF_VH

interface cpu_tracker_if();

  import rv32i_types_pkg::word_t;

  integer icache_misses, icache_conflicts;
  integer dcache_misses, dcache_conflicts;

  modport caches (
    output icache_misses, icache_conflicts, dcache_misses, dcache_conflicts
  );

  modport cpu_tracker(
    input icache_misses, icache_conflicts, dcache_misses, dcache_conflicts
  );

endinterface

`endif //CPU_TRACKER_IF_VH
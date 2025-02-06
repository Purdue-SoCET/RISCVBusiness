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
*   Filename:     tb_supervisor.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 1/14/2025
*   Description:  Testbench for all supervisor tests
*/


parameter PAGE_OFFSET_BITS = 12;  // For 4KB pages
parameter TLB_SIZE      = 64;     // Number of entries in the TLB
parameter TLB_ASSOC     = 1;      // dont set this to 0, TLB_SIZE / ASSOC must be power of 2
parameter TLB_SIZE_LOG2 = $clog2(TLB_SIZE);
parameter TLB_TAG_BITS  = PPNLEN - TLB_SIZE_LOG2;
parameter TLB_TAG_MAX   = 1 << TLB_TAG_BITS;
parameter ASID_MAX      = 1 << ASID_LENGTH;
parameter PPN_MAX       = 1 << PPNLEN;

parameter NUM_TESTS = 1000;
parameter NUM_ADDRS = 20;
parameter PERIOD = 20;
parameter DELAY = 5;

parameter SEED = 11;
parameter VERBOSE = 0;
parameter STDOUT = 32'h0000_0000;

// permissions
parameter RWXV_PERMS = PAGE_PERM_READ |
                       PAGE_PERM_WRITE |
                       PAGE_PERM_EXECUTE |
                       PAGE_PERM_VALID;

module tb_supervisor ();

  tb_tlb_directmapped TLB_DIRECT_MAPPED ();

  tb_page_perm_check PAGE_PERM_CHECK ();

endmodule
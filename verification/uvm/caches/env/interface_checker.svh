/*
*   Copyright 2022 Purdue University
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
*   Filename:     interface_checker.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Checks for invalid combinations of input/output signals for the DUT
*/

`ifndef INTERFACE_CHECKER_SVH
`define INTERFACE_CHECKER_SVH

module interface_checker (
    cache_if.cache d_cif,
    cache_if.cache i_cif,
    cache_if.cache l2_cif,
    generic_bus_if.generic_bus d_cpu_if,
    generic_bus_if.generic_bus i_cpu_if,
    generic_bus_if.generic_bus d_l1_arb_bus_if,
    generic_bus_if.generic_bus i_l1_arb_bus_if,
    generic_bus_if.generic_bus arb_l2_bus_if,
    generic_bus_if.generic_bus mem_if
);

  // Flush done without a flush request
  d_cif_flush_done :
  assert property (@(posedge d_cif.CLK) d_cif.flush_done |-> (d_cif.flush))
  else $fatal(1, "'d_cif.flush_done' should never be asserted without a cpu flush request");
  i_cif_flush_done :
  assert property (@(posedge i_cif.CLK) i_cif.flush_done |-> (i_cif.flush))
  else $fatal(1, "'i_cif.flush_done' should never be asserted without a cpu flush request");
  l2_cif_flush_done :
  assert property (@(posedge l2_cif.CLK) l2_cif.flush_done |-> (l2_cif.flush))
  else $fatal(1, "'l2_cif.flush_done' should never be asserted without a cpu flush request");

  // L2 Response without a read/write request
  arb_l2_bus_if_busy :
  assert property (@(posedge l2_cif.CLK) !arb_l2_bus_if.busy |-> (arb_l2_bus_if.ren | arb_l2_bus_if.wen))
  else $fatal(1, "'arb_l2_bus_if.busy' should never be low without a cpu read/write request");

  // Ensure all bus transactions only occur when there is a read/write request
  d_l1_arb_bus_if_ren :
  assert property (@(posedge d_cif.CLK) d_l1_arb_bus_if.ren |-> (!d_cpu_if.ren))
  else $fatal(1, "'d_l1_arb_bus_if.ren' should never be asserted without a cpu read request");
  d_l1_arb_bus_if_wen :
  assert property (@(posedge d_cif.CLK) d_l1_arb_bus_if.wen |-> (!d_cpu_if.wen))
  else $fatal(1, "'d_l1_arb_bus_if.wen' should never be asserted without a cpu write request");

  i_l1_arb_bus_if_ren :
  assert property (@(posedge d_cif.CLK) i_l1_arb_bus_if.ren |-> (i_cpu_if.ren))
  else $fatal(1, "'i_l1_arb_bus_if.ren' should never be asserted without a cpu read request");
  i_l1_arb_bus_if_wen :
  assert property (@(posedge d_cif.CLK) i_l1_arb_bus_if.wen |-> (i_cpu_if.wen))
  else $fatal(1, "'i_l1_arb_bus_if.wen' should never be asserted without a cpu write request");

  //TODO: IMPLEMENT CHECK FOR INVALID BYTE_EN 
endmodule : interface_checker

`endif

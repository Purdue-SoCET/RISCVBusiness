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
*   Filename:     include/address_translation_if.vh
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 11/21/2024
*   Description:  Bundles address translation signals into one interface
*                 to pass into L1, TLB, and Page Walker
*/

`ifndef ADDRESS_TRANSLATION_IF_VH
`define ADDRESS_TRANSLATION_IF_VH

interface address_translation_if();

  // valid address translation checking
  logic sv32, sv39, sv48, sv57, sv64; // need to add logic for sv39-64 if RV64 is implemented
  logic addr_trans_on;

  modport walker
  (
    output sv32, sv39, sv48, sv57, sv64, addr_trans_on
  );

  modport cache
  (
    input sv32, sv39, sv48, sv57, sv64, addr_trans_on
  );

endinterface

`endif
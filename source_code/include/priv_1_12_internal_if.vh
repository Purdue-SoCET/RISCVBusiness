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
*   Filename:     priv_1_12_internal_if.vh
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Interface for components within the privilege block v1.12
*/

`ifndef PRIV_1_12_INTERNAL_IF_VH
`define PRIV_1_12_INTERNAL_IF_VH

`include "component_selection_defines.vh"

interface priv_1_12_internal_if;
    import machine_mode_types_1_12_pkg::*;
    import rv32i_types_pkg::*;

    mcsr_addr_t csr_addr; // CSR address to read
    priv_level_t curr_priv; // Current process privilege
    logic csr_mod; // Is the CSR currently being modified?
    logic invalid_csr; // Bad CSR address
    logic inst_ret; // signal when an instruction is retired
    word_t new_csr_val, old_csr_val; // new and old CSR values (atomically swapped)

    modport csr (
        input csr_addr, curr_priv, csr_mod, new_csr_val, inst_ret,
        output old_csr_val, invalid_csr
    );

endinterface

`endif  // PRIV_1_12_INTERNAL_IF_VH

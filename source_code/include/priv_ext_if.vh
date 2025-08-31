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
*   Filename:     prv_ext_if.vh
*
*   Created by:   Hadi AHmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 10/36/2022
*   Description:  Interface connecting the main CSR file to other extension
                    CSR files so they can handle their state independently.
*/

`ifndef PRIV_EXT_IF_VH
`define PRIV_EXT_IF_VH

interface priv_ext_if();
import priv_isa_types_pkg::*;
import rv32i_types_pkg::*;

// from Priv-CSR to Ext-CSR
csr_addr_t csr_addr; // CSR address
word_t value_in; // New CSR value
logic csr_active; // active CSR operation

// from Ext-CSR to Priv-CSR
logic invalid_csr, ack; // invalid_csr: error signal when processing CSR, ack: csr_addr belongs to extension
word_t value_out; // Old CSR value

// Extensions must ALWAYS make sure they drive 'ack' high if 'csr_addr' belongs to them and that
//   'value_out' is the value of the CSR at 'csr_addr'. Only perform a write on 'csr_active', but
//   the privileged unit will need the other values to calculate 'value_in'.

modport priv (
    input invalid_csr, ack, value_out,
    output csr_addr, value_in, csr_active
);

modport ext (
    output invalid_csr, ack, value_out,
    input csr_addr, value_in, csr_active
);

endinterface

`endif // PRIV_EXT_IF_VH
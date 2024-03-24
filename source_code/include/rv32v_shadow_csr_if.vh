/*
*   Copyright 2024 Purdue University
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
*   Filename:     rv32v_shadow_csr_if.vh
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 02/13/2024
*   Description:  Interface for shadow copy of vector CSR data in decode
*/

`ifndef RV32V_SHADOW_CSR_IF_VH
`define RV32V_SHADOW_CSR_IF_VH

interface rv32v_shadow_csr_if;

    import rv32i_types_pkg::*;
    import rv32v_types_pkg::*;

    logic flush_decode;

    // From CSR block
    vtype_t vtype_arch;
    word_t vl_arch;
    // word_t vstart_arch;  // TODO: optimization to start decoding from vstart on flush

    // From shadow copy to decode
    vlmul_t vlmul_shadow;
    vsew_t vsew_shadow;
    logic vill_shadow;
    word_t vl_shadow;

    // From execute to shadow copy
    logic vsetvl, vkeepvl;
    vtype_t vtype_spec;
    word_t avl_spec;

    modport shadow (
        input flush_decode, vtype_arch, vl_arch, vsetvl, vkeepvl, vtype_spec, avl_spec,
        output vlmul_shadow, vsew_shadow, vill_shadow, vl_shadow
    );

    modport hazard (
        output flush_decode
    );

    // For speculatively updating values
    modport execute (
        input vl_shadow, 
        output vsetvl, vkeepvl, vtype_spec, avl_spec
    );

    // Get architectural CSR values from mem stage
    modport mem (
        output vtype_arch, vl_arch
    );

endinterface

`endif //RV32V_SHADOW_CSR_IF_VH

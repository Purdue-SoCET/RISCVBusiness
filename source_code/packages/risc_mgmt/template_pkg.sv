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
*   Filename:     template_pkg.sv
*
*   Created by:   <author>
*   Email:        <author email>
*   Date Created: <date>
*   Description:  Template for a package containg the needed types for
*                 a RISC-MGMT extension
*/

`ifndef TEMPLATE_PKG_SV
`define TEMPLATE_PKG_SV

package template_pkg;

    // Interface between the decode and execute stage
    // This must be named "decode_execute_t"
    typedef struct packed {logic signal;} decode_execute_t;

    // Interface between the execute and memory stage
    // This must be named "execute_memory_t"
    typedef struct packed {logic signal;} execute_memory_t;


endpackage

`endif  //TEMPLATE_PKG_SV

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
*   Filename:     crc32_pkg.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 04/06/2017
*   Description:  Package for crc32 extension
*/

`ifndef CRC32_PKG_SV
`define CRC32_PKG_SV

package crc32_pkg;

    // Interface between the decode and execute stage
    // This must be named "decode_execute_t"
    typedef struct packed {
        logic reset;
        logic new_byte;
    } decode_execute_t;

    // Interface between the execute and memory stage
    // This must be named "execute_memory_t"
    typedef struct packed {logic signal;} execute_memory_t;


endpackage

`endif  //CRC32_PKG_SV

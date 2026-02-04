
/*
*   Copyright 2025 Purdue University
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
*   Filename:     decompressor.sv
*
*   Created by:   Cole Nelson
*   Email:        nelso345@purdue.edu
*   Date Created: 5/21/2025
*   Description:  Temporary wrapper to test new decompressor with old plumbing.
*/
module decompressor_wrapper(
    decompressor_if.dcpr dcpr_if
);

    decompressor DECOMPRESSOR(
        .compressed(dcpr_if.inst16),
        .decompressed(dcpr_if.inst32)
    );

    assign dcpr_if.c_ena = dcpr_if.inst16[1:0] != 2'b11;

endmodule

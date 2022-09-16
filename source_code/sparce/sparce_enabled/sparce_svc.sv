/*
*   Copyright 2019 Purdue University
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
*   Filename:     sparce_svc.sv
*
*   Created by:   Vadim V. Nikiforov
*   Email:        vnikifor@purdue.edu
*   Date Created: 04/4/2019
*   Description:  The file containing the sparsity value chekcer (SVC)
*                 module
*/

`include "sparce_internal_if.vh"

module sparce_svc (
    sparce_internal_if.svc svc_if
);

    // sparsity only when the writeback data is zero
    assign svc_if.is_sparse = (svc_if.wb_data == 0);

endmodule


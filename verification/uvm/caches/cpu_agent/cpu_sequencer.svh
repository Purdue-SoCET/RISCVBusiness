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
*   Filename:     cpu_sequencer.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 04/04/2022
*   Description:  UVM Sequencer class for initiating processor side requests to caches
*/

`ifndef CPU_SEQUENCER_SVH
`define CPU_SEQUENCER_SVH

`include "cpu_transaction.svh"

typedef uvm_sequencer#(cpu_transaction) cpu_sequencer;

`endif

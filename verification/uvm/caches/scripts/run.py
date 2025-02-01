#!/usr/bin/python

#
#   Copyright 2016 Purdue University
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
#
#   Filename:     run.py
#
#   Created by:   Mitch Arndt
#   Email:        arndt20@purdue.edu
#   Date Created: 04/16/2022
#   Description:  Script for running UVM TB for the caches

import os

from cprint import cprint
from cprint import tags

def run(params):
    RUN_COMMON = '''
        tb_caches_top -L
	    {QUESTA_HOME}/uvm-1.2
	    -voptargs=+acc
        -iterationlimit=100k
	    -sv_seed {SEED}
	    +UVM_TESTNAME={TESTCASE}_test
	    +UVM_VERBOSITY=UVM_{VERBOSITY}
	    +uvm_set_config_int=*,iterations,{ITERATIONS}
	    +uvm_set_config_int=*,mem_timeout,{MEM_TIMEOUT}
	    +uvm_set_config_int=*,mem_latency,{MEM_LATENCY}
	    +uvm_set_config_int=*,mmio_latency,{MMIO_LATENCY}
	    -do "coverage save -onexit -p coverage/{TESTCASE}.ucdb"
    '''.format(
        QUESTA_HOME=os.getenv('QUESTA_HOME'),
        SEED=params.seed,
        TESTCASE=params.testcase,
        VERBOSITY=params.verbosity.upper(),
        ITERATIONS=params.iterations,
        MEM_TIMEOUT=params.mem_timeout,
        MEM_LATENCY=params.mem_latency,
        MMIO_LATENCY=params.mmio_latency,
    )

    if (params.gui):
        cprint("Running with GUI...", tags.LOG)
        res = os.system('''
            vsim -i
            {RUN_COMMON}
            -do "waves/{WAVE}.do"
	        -do "scripts/run.do"
        '''.format(
            RUN_COMMON=RUN_COMMON,
            WAVE=params.config
        ).replace("\n", " "))
    else: 
        cprint("Running with Terminal...", tags.LOG)
        res = os.system('''
            vsim -c
            {RUN_COMMON}
	        -do "scripts/run.do"
        '''.format(
            RUN_COMMON=RUN_COMMON,
        ).replace("\n", " "))

    if (res == 0):
        cprint("Run Finished", tags.SUCCESS)
    else:
        cprint("Run Failed", tags.FAIL)

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
#   Filename:     build.py
#
#   Created by:   Mitch Arndt
#   Email:        arndt20@purdue.edu
#   Date Created: 04/16/2022
#   Description:  Script for building UVM TB for the caches

import os

from cprint import cprint
from cprint import tags

def build(params):
    cprint("Building Sources...", tags.LOG)
    SRC = "../../../source_code/"

    TB_GLOBAL_CONFIG = "TB_{}_CONFIG".format(params.config)

    res = os.system('''\
        vlog\
        +incdir+{CACHES} \
	    +incdir+{L1} \
	    +incdir+{L2} \
	    +incdir+{INCLUDE} \
	    +incdir+{PACKAGES} \
	    +incdir+models \
	    +incdir+cpu_agent \
	    +incdir+bus_agents \
	    +incdir+end2end \
	    +incdir+generic_bus_agent_comps \
	    +incdir+bfm \
	    +incdir+env \
	    +incdir+sequences \
	    +incdir+tests \
	    +define+TB_{TB_GLOBAL_CONFIG}_CONFIG \
        +define+INTERFACE_CHECKER={IF_CHECKER} \
	    +acc \
	    +cover \
	    -L {QUESTA_HOME}/uvm-1.2 tb_caches_top.sv 
    '''.format(
        CACHES=SRC + "caches",
        L1=SRC + "caches/l1",
        L2=SRC + "caches/l2",
        INCLUDE=SRC + "include",
        PACKAGES=SRC + "packages",
        QUESTA_HOME=os.getenv('QUESTA_HOME'),
        TB_GLOBAL_CONFIG=params.config.upper(),
        IF_CHECKER="0" if params.no_if_check else "1"
    ))

    if (res == 0):
        cprint("Build Finished", tags.SUCCESS)
    else:
        cprint("Build Failed", tags.FAIL)
        exit()
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
#   Date Created: 04/04/2022
#   Description:  Script for configuring and running UVM TB for the caches

import argparse
import os
from scripts.cprint import cprint
from scripts.cprint import csprint
from scripts.cprint import tags, styles
from scripts.build import build
from scripts.run import run
from scripts.post_run import post_run
from scripts.repeat import repeat

def seed_type(arg):
    try:
        return int(arg)  # try convert to int
    except ValueError:
        pass
    if arg == "random":
        return arg
    raise argparse.ArgumentTypeError("Seed must be an integer type or 'random'")

def parse_arguments():
    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
                        description=csprint("Build and Run the UVM Testbench for the cache hierarchy\n"
                            "  Note that all runtime parameters are saved in ",
                            styles.PURPLE, styles.BOLD) +
                            csprint("run_summary.log", styles.PURPLE, styles.BOLD, styles.UNDERLINE)
                        )
    parser.add_argument('--clean', action="store_true",
                        help=csprint("Remove build artifacts", styles.BLUE))
    parser.add_argument('--build', action="store_true",
                        help=csprint("Build project without run", styles.BLUE))
    parser.add_argument('--repeat', action="store_true",
                        help=csprint("Run with the last (most recent) parameters stored in run_summary.log", styles.BLUE))
    parser.add_argument('--testcase', '-t', type=str, default="random",
                        choices=["nominal", "evict", "index", "mmio", "flush", "random"],
                        help=csprint("Specify name of the uvm test:\n", styles.YELLOW) +
                            "  nominal:   read back values previously written to caches\n"
                            "  evict:     write to same index with different tag bits to force cache eviction\n"
                            "  index:     read/write to same block of data to ensure proper block indexing\n"
                            "  mmio:      read/write to memory mapped address space\n"
                            "  flush:     perform cache flush after nominal read/writes\n"
                            "  random:    random interleaving of previous test cases"
                        )
    parser.add_argument('--gui', '-g', action='store_true',
                        help=csprint("Specify whether to run with gui or terminal only", styles.YELLOW))
    parser.add_argument('--verbosity', '-v', type=str, default="low",
                        choices=["none", "low", "medium", "high", "full", "debug"],
                        help=csprint("Specify the verbosity level to be used for UVM Logging, each stage builds on the next\n", styles.YELLOW) +
                        "  none:  - only error messages shown\n"
                        "  low:   - actual and expected values for scoreboard errors\n"
                        "         - success msg for data matches\n"
                        "         - sequence parameters\n"
                        "  medium - actual and expected values for all scoreboard checks\n"
                        "         - predictor default values for non-initialized memory\n"
                        "         - end2end transaction/propagation details\n"
                        "  high   - all uvm transactions detected in monitors, predictors, scoreboards\n"
                        "         - predictor memory before:after\n"
                        "  full   - all connections between analysis ports\n"
                        "         - all agent sub-object instantiations\n"
                        "         - all virtual interface accesses to uvm db\n"
                        "  debug  - all messages")
    parser.add_argument('--seed', '-s', type=seed_type, default="random",
                        help=csprint("Specify starter seed for uvm randomization\n", styles.YELLOW) +
                        "Identical seeds will produce identical runs")
    parser.add_argument('--iterations', '-i', type=int, default=0,
                        help=csprint("Specify the requested number of memory accesses for a test", styles.YELLOW))
    parser.add_argument('--no-if-check', action="store_true",
                        help=csprint("Remove interface checks from test", styles.YELLOW))
    parser.add_argument('--mem-timeout', type=int, default=1000,
                        help=csprint("Specify the max memory latency before a fatal timeout error", styles.YELLOW))
    parser.add_argument('--mem-latency', type=int, default=1,
                        help=csprint("Specify the number of clock cycles before main memory returns", styles.YELLOW))
    parser.add_argument('--mmio-latency', type=int, default=2,
                        help=csprint("Specify the number of clock cycles before memory mapped IO returns", styles.YELLOW))
    parser.add_argument('--config', type=str, default="full",
                        choices=["l1", "l2", "full"],
                        help=csprint("Specify the configuration of the testbench to determine which agents and modules are activated", styles.YELLOW))
    return parser.parse_args()


if __name__ == '__main__':
    params = parse_arguments()

    if params.clean:
        cprint("Cleaning Directory...", tags.LOG)
        os.system("rm -rf *.vstf work mitll90_Dec2019_all covhtmlreport *.log transcript *.wlf coverage/*.ucdb **/*.pyc")
        exit()
    elif params.repeat:
        repeat(params)

    build(params)

    if (params.build):
        exit() # stop after build

    run(params)

    cprint("Run Parameters:", tags.LOG)

    # print parameters
    keep = ["mem_timeout", "iterations", "mem_latency", "testcase", "config", "mmio_latency"]
    for arg in vars(params):
        if arg in keep:
            cprint("{key:<15}<- {val}".format(key=arg, val=getattr(params, arg)), tags.INFO)
    
    cprint("Running Post Run Script...", tags.LOG)

    post_run(params)

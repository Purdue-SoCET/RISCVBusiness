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
#   Filename:     post-run.py
#
#   Created by:   Mitch Arndt
#   Email:        arndt20@purdue.edu
#   Date Created: 04/16/2022
#   Description:  Script for parsing run results

from datetime import datetime

from cprint import cprint, csprint, tags, styles

def post_run(params):

    if (params.gui):
        resp = raw_input(csprint("Save run to run_summary.log?(Y/n)", styles.YELLOW))
        if (resp == "n"):
            exit()
    if params.config == "l1":
        keys = ["seed", "cpu_txns", "mem_txns", "uvm_error", "uvm_fatal"] # keys to log variable
    elif params.config == "l2":
        keys = ["seed", "mem_arb_txns", "mem_txns", "uvm_error", "uvm_fatal"] # keys to log variable
    elif params.config == "full":
        keys = ["seed", "d_cpu_txns", "i_cpu_txns", "mem_txns", "uvm_error", "uvm_fatal"] # keys to log variable

    log = {}
    if (params.seed != "random"):
        log["seed"] = params.seed

    with open("transcript", "r") as transcript:
        lines = transcript.readlines()
        try:
            sim_err = lines[-1].split(",")[0].split(":")[1].strip()
            sim_err = int(sim_err)
            if (sim_err > 0):
                cprint("Fatal Simulation Error Detected", tags.FAIL)
                cprint("For more details, view " + csprint("verification/uvm/caches/transcript", styles.UNDERLINE), tags.FAIL)
                # exit()
        except Exception as err:
            cprint("Unable to parse simulator errors from transcript", tags.WARNING)
            cprint(err, tags.WARNING)

        for line in lines:
            words = line.strip().split()
            for i, word in enumerate(words):
                if not log.has_key("seed") and "seed" in word.lower():
                    if words[i+1] == "=":
                        log["seed"] = words[i+2]
                    elif words[i+1] != "random":
                        log["seed"] = words[i+1]

                if not log.has_key("uvm_fatal") and "UVM_FATAL" in word:
                    if (words[i+1] == ":"):
                        log["uvm_fatal"] = words[i+2]
                
                if not log.has_key("uvm_error") and "UVM_ERROR" in word:
                    if (words[i+1] == ":"):
                        log["uvm_error"] = words[i+2]

                if "TXN_Total" in word:
                    if words[i-1] == "[MEM_SCORE]":
                        log["mem_txns"] = words[i+1]
                    elif words[i-1] == "[I_CPU_SCORE]":
                        log["i_cpu_txns"] = words[i+1]
                    elif words[i-1] == "[D_CPU_SCORE]":
                        log["d_cpu_txns"] = words[i+1]
                    elif words[i-1] == "[CPU_SCORE]":
                        log["cpu_txns"] = words[i+1]
                    elif words[i-1] == "[MEM_ARB_SCORE]":
                        log["mem_arb_txns"] = words[i+1]
                
                if len(log) == len(keys):
                    break # ignore the rest of the file

    for key in keys:
        try:
            if key == "uvm_error" or key == "uvm_fatal":
                num = int(log[key])
                if (num != 0):
                    cprint("{key:<15}-> {val}".format(key=key, val=log[key]), tags.FAIL)
                else:
                    cprint("{key:<15}-> {val}".format(key=key, val=log[key]), tags.SUCCESS)
                continue

            cprint("{key:<15}-> {val}".format(key=key, val=log[key]), tags.SUCCESS)
        
        except:
            cprint("{key:<15}-> {val}".format(key=key, val="None"), tags.FAIL)
    
    with open("run_summary.log", "a") as out:
        now = datetime.now()
        dt_string = now.strftime("%m-%d-%Y %H:%M:%S")
        
        msg = "[{date}]: ".format(date=dt_string)

        msg += "testcase: {}, ".format(params.testcase)
        msg += "seed: {}, ".format(log["seed"])
        msg += "config: {}, ".format(params.config)
        msg += "iterations: {}, ".format(params.iterations)
        msg += "mem_timeout: {}, ".format(params.mem_timeout)
        msg += "mem_latency: {}, ".format(params.mem_latency)
        msg += "mmio_latency: {}, ".format(params.mmio_latency)

        for key in keys:
            if key == "seed": 
                continue
            try:
                msg += "{key}: {val}, ".format(key=key, val=log[key])
            except:
                msg += "{key}: None, ".format(key=key)
        
        out.write(msg)
        out.write("\n")

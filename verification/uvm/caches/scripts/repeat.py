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
#   Filename:     repeat.py
#
#   Created by:   Mitch Arndt
#   Email:        arndt20@purdue.edu
#   Date Created: 04/17/2022
#   Description:  Script for re-running the cache UVM test with the last used parameters
import re

from cprint import cprint
from cprint import tags

def repeat(params):
    cprint("Repeating Previous Run...", tags.LOG)
    try:
        with open('run_summary.log', 'r') as f:
            last_line = re.sub(r"\[.*\]:", "", f.readlines()[-1])
    except: 
        cprint("Couldn't open 'run_summary.log' file", tags.FAIL)
        cprint("Make sure you have at least one run logged before repeating...", tags.FAIL)
        exit()
    for param in last_line.split(",")[0:-3]:
        pair = param.strip().replace(",", "").split(": ")
        if ("txns" not in pair[0]):
            setattr(params, pair[0], pair[1])

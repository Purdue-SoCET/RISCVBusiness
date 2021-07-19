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
#   Filename:     cprint.py
#
#   Created by:   Mitch Arndt
#   Email:        arndt20@purdue.edu
#   Date Created: 04/16/2022
#   Description:  Script for colored printing to terminal

class styles:
    PURPLE      = '\033[95m'
    BLUE        = '\033[94m'
    GREEN       = '\033[92m'
    YELLOW      = '\033[93m'
    RED         = '\033[91m'
    BOLD        = '\033[1m'
    UNDERLINE   = '\033[4m'
    ENDC        = '\033[0m'

class tags:
    LOG         = '{}[{:<7}]:'.format(styles.PURPLE, "LOG")
    INFO        = '{}[{:<7}]:'.format(styles.BLUE, "INFO")
    SUCCESS     = '{}[{:<7}]:'.format(styles.GREEN, "SUCCESS")
    WARNING     = '{}[{:<7}]:'.format(styles.YELLOW, "WARNING")
    FAIL        = '{}[{:<7}]:'.format(styles.RED, "FAIL")

def csprint(msg, *formats):
    res = ""
    for f in formats:
        res += f
    res += msg
    res += styles.ENDC
    return res

def cprint(msg, *formats):
    for f in formats:
        print(f),
    print(msg),
    print(styles.ENDC)

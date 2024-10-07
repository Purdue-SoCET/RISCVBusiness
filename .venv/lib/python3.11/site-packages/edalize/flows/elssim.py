# Copyright edalize contributors
# Licensed under the 2-Clause BSD License, see LICENSE for details.
# SPDX-License-Identifier: BSD-2-Clause

import os.path

from edalize.flows.edaflow import Edaflow

SIM = "icarus"
class Elssim(Edaflow):
    """Run a simulation"""

    argtypes = ["plusarg", "vlogdefine", "vlogparam"]

    FLOW = [
        ("ipxact2v", [SIM], {}),
        (SIM, [], {}),
    ]

    FLOW_OPTIONS = {
        "frontends": {
            "type": "str",
            "desc": "Tools to run before linter (e.g. sv2v)",
            "list": True,
        },
        "tool": {
            "type": "str",
            "desc": "Select simulator",
        },
    }

    def configure_tools(self, nodes):
        print("Nodes")
        print(nodes)
        print("Nodesnides")
        super().configure_tools(nodes)

        self.commands.default_target = nodes[SIM].default_target
        self.run_tool = nodes[SIM]

    def run(self, args):
        (cmd, args, cwd) = self.run_tool.run(args)
        self._run_tool(cmd, args=args, cwd=cwd)

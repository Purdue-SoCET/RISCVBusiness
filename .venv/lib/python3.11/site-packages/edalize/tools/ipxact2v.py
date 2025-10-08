import os

from edalize.tools.edatool import Edatool
from edalize.utils import EdaCommands


class Ipxact2v(Edatool):

    description = "IP-XACT to Verilog conversion"

    TOOL_OPTIONS = {
        "ipxact2v_options": {
            "type": "str",
            "desc": "Additional options for ipxact2v",
            "list": True,
        },
        "vlnv": {
            "type": "str",
            "desc": "VLNV for toplevel parsed by ipxact2v",
        },
    }

    def configure(self, edam):
        super().configure(edam)

        ipxact_files = []
        unused_files = []

        for f in self.files:
            if f["file_type"] == "ipxact":
                ipxact_files.append(os.path.join(self.work_root, f["name"]))
            else:
                unused_files.append(f)

        output_file = self.name + ".sv"
        self.edam = edam.copy()
        self.edam["files"] = unused_files
        self.edam["files"].append(
            {
                "name": output_file,
                "file_type": "verilogSource",
            }
        )

        vlnv = self.tool_options.get("vlnv")
        if not vlnv:
            raise RuntimeError("tool option 'vlnv' needs to be set")

        view_name = self.tool_options.get("view", "hierarchical")

        module_name = self.tool_options.get("module_name")

        args = ["ipxact2v"]
        if module_name:
            args += ["-m", module_name]
        args += ["-o", os.path.join(self.work_root, output_file),
                 vlnv,
                 view_name] + ipxact_files
        commands = EdaCommands()
        commands.add(
            args,
            [output_file],
            ipxact_files,
        )

        self.commands = commands.commands

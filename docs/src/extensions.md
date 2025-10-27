# Extensions
RISC-V defines many ISA extensions. Some add extra instructions, such as the "M" extension that adds multiply and divide instructions. Some add extra state, such as the "F" extension that adds a new floating point register file. Some assert properties about the microarchitecture, such as the "Ztso" extension that indicates the implementation follows the total store order memory consistency model.

To allow configurability, extensions must be implemented in a way that makes them easy to enable or disable as desired.

Most extensions implemented in RISCVBusiness will add an extra functional unit, and require decoding new instruction types. Extension implementation can be broken down into the following steps:
1. Implement the new functional unit
2. Implement a decoder that understands *only* the new instruction types.
3. Create a wrapper file that conditionally either instantiates the new functional unit, or assign all outputs to '0' (for disabled)
4. Add your new decoder to `source_code/standard_core/control_unit.sv`. Your new decoder must assert a 'claim' signal to indicate that an instruction belongs to that extension. Your decoder must generate all the needed control signals for your functional unit, and generate a 'start' signal to tell it to start working on the computation.
5. Instantiate your functional unit wrapper in the execute stage.

## Walkthrough: Adding a Custom Extension

This walkthrough demonstrates how to add a custom extension by implementing a simple DELAY instruction that stalls the CPU for 100 cycles. This example uses the CUSTOM-0 opcode space (0x0B) reserved by RISC-V for custom extensions.
(Note: This is a custom instruction for documentation purposes, and is not actually implemented.)

### File Structure

For an extension named "delay", you would create:

```
source_code/
├── packages/
│   └── rv32delay_pkg.sv       // Type definitions
└── rv32delay/
    ├── rv32delay_decode.sv    // Decoder
    ├── rv32delay_enabled.sv   // Functional unit
    ├── rv32delay_disabled.sv  // Disabled stub
    └── rv32delay_wrapper.sv   // Wrapper
```

### Step 1: Create the Package

**File: `source_code/packages/rv32delay_pkg.sv`**

```systemverilog
package rv32delay_pkg;

    // CUSTOM-0 opcode (0x0B)
    localparam logic [6:0] RV32DELAY_OPCODE = 7'b0001011;

    // R-type instruction format
    typedef struct packed {
        logic [6:0] funct7;
        logic [4:0] rs2;
        logic [4:0] rs1;
        logic [2:0] funct3;
        logic [4:0] rd;
        logic [6:0] opcode;
    } rv32delay_insn_t;

    // Operation type
    typedef enum logic [2:0] {
        DELAY = 3'b000
    } rv32delay_op_t;

    // Decoder output
    typedef struct packed {
        logic select;
        rv32delay_op_t op;
    } rv32delay_decode_t;

endpackage
```

### Step 2: Implement the Decoder

**File: `source_code/rv32delay/rv32delay_decode.sv`**

```systemverilog
module rv32delay_decode (
    input [31:0] insn,
    output logic claim,
    output rv32delay_pkg::rv32delay_decode_t rv32delay_control
);
    import rv32delay_pkg::*;

    rv32delay_insn_t insn_split;

    assign insn_split = rv32delay_insn_t'(insn);

    // Claim any instruction with CUSTOM-0 opcode and funct3=000
    assign claim = (insn_split.opcode == RV32DELAY_OPCODE)
                && (insn_split.funct3 == 3'b000);

    assign rv32delay_control.select = claim;
    assign rv32delay_control.op = DELAY;

endmodule
```

**Key point:** The decoder "claims" instructions to prevent them from being treated as illegal. This claim signal is ORed with other extension claim signals in the control unit (see `control_unit.sv`).

### Step 3: Implement the Functional Unit

**File: `source_code/rv32delay/rv32delay_enabled.sv`**

```systemverilog
module rv32delay_enabled (
    input CLK,
    input nRST,
    input rv32delay_start,
    input rv32delay_pkg::rv32delay_op_t operation,
    input [31:0] rv32delay_a,
    input [31:0] rv32delay_b,
    output logic rv32delay_done,
    output logic [31:0] rv32delay_out
);
    import rv32delay_pkg::*;

    localparam DELAY_CYCLES = 100;

    logic [7:0] counter;
    logic counting;

    // Start counting when start is pulsed
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            counter <= '0;
            counting <= 1'b0;
        end else begin
            if (rv32delay_start && !counting) begin
                // Start new delay
                counter <= DELAY_CYCLES;
                counting <= 1'b1;
            end else if (counting && counter > 0) begin
                // Count down
                counter <= counter - 1;
            end else if (counting && counter == 0) begin
                // Done counting
                counting <= 1'b0;
            end
        end
    end

    // Assert done when not counting (or on last cycle)
    assign rv32delay_done = !counting || (counter == 1);
    assign rv32delay_out = 32'b0;  // No result value

endmodule
```

**Key points:**
- Multi-cycle operations deassert `done` while busy
- The execute stage will stall until `done` is asserted (via `hazard_if.ex_busy` in `stage3_execute_stage.sv`)
- Single-cycle operations can keep `done` high always

### Step 4: Create the Disabled Stub

**File: `source_code/rv32delay/rv32delay_disabled.sv`**

```systemverilog
module rv32delay_disabled (
    input CLK,
    input nRST,
    input rv32delay_start,
    input rv32delay_pkg::rv32delay_op_t operation,
    input [31:0] rv32delay_a,
    input [31:0] rv32delay_b,
    output rv32delay_done,
    output logic [31:0] rv32delay_out
);
    // Always ready, return zero
    assign rv32delay_done = 1'b1;
    assign rv32delay_out = 32'b0;
endmodule
```

**Key point:** The disabled module must have identical ports but just tie outputs to safe values. This is never actually used because the decoder is also disabled, but prevents compilation errors.

### Step 5: Create the Wrapper

**File: `source_code/rv32delay/rv32delay_wrapper.sv`**

```systemverilog
`include "component_selection_defines.vh"

module rv32delay_wrapper (
    input CLK,
    input nRST,
    input rv32delay_start,
    input rv32delay_pkg::rv32delay_op_t operation,
    input [31:0] rv32delay_a,
    input [31:0] rv32delay_b,
    output rv32delay_done,
    output logic [31:0] rv32delay_out
);
    import rv32delay_pkg::*;

    `ifdef RV32DELAY_SUPPORTED
    rv32delay_enabled RV32DELAY(.*);
    `else
    rv32delay_disabled RV32DELAY(.*);
    `endif

endmodule
```

**Key point:** The wrapper uses preprocessor conditionals to select between enabled/disabled modules based on build configuration. These are found in `component_selection_defines.vh`, which is in turn generated by the configuration YAML file with the `config_core.py` script.

### Step 6: Integrate into Control Unit

**File: `source_code/standard_core/control_unit.sv`**

Add these changes:

**Import the package:**
```systemverilog
import rv32delay_pkg::*;
```

**Declare claim signal:**
```systemverilog
logic rv32delay_claim;
```

**Instantiate decoder:**
```systemverilog
`ifdef RV32DELAY_SUPPORTED
rv32delay_decode RV32DELAY_DECODE(
    .insn(cu_if.instr),
    .claim(rv32delay_claim),
    .rv32delay_control(cu_if.rv32delay_control)
);
`else
assign cu_if.rv32delay_control = {1'b0, rv32delay_op_t'(0)};
assign rv32delay_claim = 1'b0;
`endif // RV32DELAY_SUPPORTED
```

**Update claimed signal:**
```systemverilog
assign claimed = rv32m_claim || rv32a_claim || rv32b_claim || rv32zc_claim || rv32delay_claim;
```

**Key point:** Adding your claim signal to the `claimed` logic prevents instructions from being marked as illegal when your extension is enabled. The main decoder generates a `maybe_illegal` signal that is surpressed by any `claim` being asserted; `maybe_illegal && !claimed` implies the insturction is illegal.

### Step 7: Integrate into Execute Stage

**File: `source_code/pipelines/stage3/source/stage3_execute_stage.sv`**

**Declare signals:**
```systemverilog
logic rv32delay_done;
word_t rv32delay_out;
```

**Instantiate wrapper:**
```systemverilog
rv32delay_wrapper RV32DELAY_FU (
    .CLK(CLK),
    .nRST(nRST),
    .rv32delay_start(cu_if.rv32delay_control.select && !hazard_if.mem_use_stall),
    .operation(cu_if.rv32delay_control.op),
    .rv32delay_a(rs1_post_fwd),
    .rv32delay_b(rs2_post_fwd),
    .rv32delay_done(rv32delay_done),
    .rv32delay_out(rv32delay_out)
);
```

**Add to output mux:**
```systemverilog
always_comb begin
    if(cu_if.rv32m_control.select) begin
        ex_out = rv32m_out;
    end else if(cu_if.rv32b_control.select) begin
        ex_out = rv32b_out;
    end else if(cu_if.rv32delay_control.select) begin
        ex_out = rv32delay_out;
    end else begin
        ex_out = alu_if.port_out;
    end
end
```

**Add to hazard detection:**
```systemverilog
assign hazard_if.ex_busy = (!rv32m_done && cu_if.rv32m_control.select)
                        || (!rv32delay_done && cu_if.rv32delay_control.select);
```

**Key points:**
- The start signal is gated with `!hazard_if.mem_use_stall` to prevent spurious starts during pipeline stalls
- Use `rs1_post_fwd`/`rs2_post_fwd` instead of raw register file outputs to respect data forwarding (see `stage3_execute_stage.sv`)
- Multi-cycle functional units must contribute to `ex_busy` or the pipeline won't stall

### Step 8: Add Interface Signals

**File: `source_code/include/control_unit_if.vh`**

Add your control signal bundle:
```systemverilog
rv32delay_pkg::rv32delay_decode_t rv32delay_control;
```

### Step 9: Update core configuration
**File: `scripts/config_core.py`**
Finally, you need to add your extension to `config_core.py` so that it can be parsed from the YAML file and generate the correct preprocessor definitions to include in `component_selection_defines.vh`. If you are using a standard extension, it should suffice to add your extension to the list in the `RISCV_ISA` variable. Custom extensions will need to add a new key to the YAML file, check for it in `config_core.py`, and generate the appropriate preprocessor defines.

### Summary Checklist

- [ ] Create package with opcodes and type definitions
- [ ] Implement decoder that claims your instructions
- [ ] Implement enabled module with functional unit logic
- [ ] Create disabled stub with same interface
- [ ] Create wrapper with conditional instantiation
- [ ] Integrate decoder into control unit
- [ ] Add claim signal to `claimed` logic
- [ ] Integrate functional unit into execute stage (signals, instantiation, output mux)
- [ ] Add busy signal to hazard detection for multi-cycle ops
- [ ] Add control signals to `control_unit_if.vh`
- [ ] Update `config_core.py` to generate the `RV32X_SUPPORTED` define

### Reference: Existing Extensions

The codebase includes several extension implementations you can reference:
- **RV32M** (Multiply/Divide): `source_code/rv32m/` - Multi-cycle operations with variable latency
- **RV32B** (Bit Manipulation): `source_code/rv32b/` - Single-cycle combinational logic
- **RV32Zicond**: `source_code/rv32zc/` - Simple conditional operations

## History
Earlier versions of RISCVBusiness (including the original fork) used a different system to manage extensions, RISC-MGMT. RISC-MGMT treated extensions as plugins that hooked into the pipeline in the decode, execute, and memory stages and could control some chosen signals. The philosophy for RISC-MGMT was that extensions acted as their own execution pipelines, and the main pipeline just passed a "token" to track where the instruction was (as the execution was still single-issue, in-order). 

RISC-MGMT had some distinct advantages:
1. Extensions all saw the same interface to the processor, and could be written in a standardized format
2. Custom instructions were simple to implement, as they worked identically to the standard extensions

However, it also had the disadvantage of being inflexible. The model would have worked well for extensions like "M" or "B" where isolated functional units were added, but extensions like "F" that add new architectural state, "C" that changed the way instruction fetch worked and re-used "I" decoding, and "A" that is tightly coupled to the cache implementation require tighter integration with the rest of the core.

The current configuration implementation is essentially "inlining" the RISC-MGMT idea into the pipeline so that we can have more flexibility at the cost of more difficult integration.
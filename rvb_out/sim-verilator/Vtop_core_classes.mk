# Verilated -*- Makefile -*-
# DESCRIPTION: Verilator output: Make include file with class lists
#
# This file lists generated Verilated files, for including in higher level makefiles.
# See Vtop_core.mk for the caller.

### Switches...
# C11 constructs required?  0/1 (always on now)
VM_C11 = 1
# Timing enabled?  0/1
VM_TIMING = 0
# Coverage output mode?  0/1 (from --coverage)
VM_COVERAGE = 0
# Parallel builds?  0/1 (from --output-split)
VM_PARALLEL_BUILDS = 1
# Threaded output mode?  0/1/N threads (from --threads)
VM_THREADS = 0
# Tracing output mode?  0/1 (from --trace/--trace-fst)
VM_TRACE = 1
# Tracing output mode in VCD format?  0/1 (from --trace)
VM_TRACE_VCD = 0
# Tracing output mode in FST format?  0/1 (from --trace-fst)
VM_TRACE_FST = 1

### Object file lists...
# Generated module classes, fast-path, compile with highest optimization
VM_CLASSES_FAST += \
	Vtop_core \
	Vtop_core___024root__DepSet_h93b009c4__0 \
	Vtop_core___024root__DepSet_hcf116ceb__0 \
	Vtop_core_top_core__DepSet_h7cd292d3__0 \
	Vtop_core_top_core__DepSet_h7cd292d3__1 \
	Vtop_core_top_core__DepSet_h9fef01de__0 \

# Generated module classes, non-fast-path, compile with low/medium optimization
VM_CLASSES_SLOW += \
	Vtop_core__ConstPool_0 \
	Vtop_core___024root__Slow \
	Vtop_core___024root__DepSet_h93b009c4__0__Slow \
	Vtop_core___024root__DepSet_hcf116ceb__0__Slow \
	Vtop_core_top_core__Slow \
	Vtop_core_top_core__DepSet_h7cd292d3__0__Slow \
	Vtop_core_top_core__DepSet_h7cd292d3__1__Slow \
	Vtop_core_top_core__DepSet_h9fef01de__0__Slow \
	Vtop_core___024unit__Slow \
	Vtop_core___024unit__DepSet_h07c714ba__0__Slow \
	Vtop_core_risc_mgmt_if__Slow \
	Vtop_core_risc_mgmt_if__DepSet_he471ecf8__0__Slow \
	Vtop_core_tspp_fetch_execute_if__Slow \
	Vtop_core_tspp_fetch_execute_if__DepSet_hf0f29e8d__0__Slow \
	Vtop_core_tspp_hazard_unit_if__Slow \
	Vtop_core_tspp_hazard_unit_if__DepSet_h6363566a__0__Slow \
	Vtop_core_prv_pipeline_if__Slow \
	Vtop_core_prv_pipeline_if__DepSet_h9af2bda9__0__Slow \
	Vtop_core_generic_bus_if__Slow \
	Vtop_core_generic_bus_if__DepSet_hde74c0c4__0__Slow \
	Vtop_core_cache_control_if__Slow \
	Vtop_core_cache_control_if__DepSet_hc7e9190a__0__Slow \
	Vtop_core_sparce_pipeline_if__Slow \
	Vtop_core_sparce_pipeline_if__DepSet_h19a774a8__0__Slow \
	Vtop_core_rv32c_if__Slow \
	Vtop_core_rv32c_if__DepSet_h00b238eb__0__Slow \
	Vtop_core_stage3_fetch_execute_if__Slow \
	Vtop_core_stage3_fetch_execute_if__DepSet_h2f5bf92f__0__Slow \
	Vtop_core_stage3_hazard_unit_if__Slow \
	Vtop_core_stage3_hazard_unit_if__DepSet_h82971794__0__Slow \
	Vtop_core_stage3_forwarding_unit_if__Slow \
	Vtop_core_stage3_forwarding_unit_if__DepSet_hd01a79ee__0__Slow \
	Vtop_core_stage3_mem_pipe_if__Slow \
	Vtop_core_stage3_mem_pipe_if__DepSet_hb4826813__0__Slow \
	Vtop_core_priv_1_12_internal_if__Slow \
	Vtop_core_priv_1_12_internal_if__DepSet_h36fc9c0b__0__Slow \
	Vtop_core_priv_ext_if__Slow \
	Vtop_core_priv_ext_if__DepSet_h9e65bf92__0__Slow \
	Vtop_core_alu_if__Slow \
	Vtop_core_alu_if__DepSet_h10bc6385__0__Slow \
	Vtop_core_branch_res_if__Slow \
	Vtop_core_branch_res_if__DepSet_he81a53bb__0__Slow \
	Vtop_core_control_unit_if__Slow \
	Vtop_core_control_unit_if__DepSet_h00afb341__0__Slow \

# Generated support classes, fast-path, compile with highest optimization
VM_SUPPORT_FAST += \
	Vtop_core__Dpi \
	Vtop_core__Trace__0 \

# Generated support classes, non-fast-path, compile with low/medium optimization
VM_SUPPORT_SLOW += \
	Vtop_core__Syms \
	Vtop_core__Trace__0__Slow \

# Global classes, need linked once per executable, fast-path, compile with highest optimization
VM_GLOBAL_FAST += \
	verilated \
	verilated_dpi \
	verilated_fst_c \

# Global classes, need linked once per executable, non-fast-path, compile with low/medium optimization
VM_GLOBAL_SLOW += \


# Verilated -*- Makefile -*-

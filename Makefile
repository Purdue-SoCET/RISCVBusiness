# SRC VARIABLES
ROOT := $(shell pwd)

RISCV := $(ROOT)/source_code
RISCV_CORE := $(RISCV)/standard_core
RISCV_INC := $(RISCV)/include
PIPELINE := $(RISCV)/pipelines
RISCV_PKGS := $(RISCV)/packages
RISC_MGMT := $(RISCV)/risc_mgmt
SPARCE := $(RISCV)/sparce
PRIVS := $(RISCV)/privs
BRANCH_PREDICT := $(RISCV)/branch_predictors
CACHES := $(RISCV)/caches
RISCV_BUS := $(RISCV)/bus_bridges
RV32C := $(RISCV)/rv32c
RV32M_FILES := $(RISC_MGMT)/extensions/rv32m/carry_save_adder.sv $(RISC_MGMT)/extensions/rv32m/flex_counter_mul.sv $(RISC_MGMT)/extensions/rv32m/full_adder.sv $(RISC_MGMT)/extensions/rv32m/pp_mul32.sv $(RISC_MGMT)/extensions/rv32m/radix4_divider.sv $(RISC_MGMT)/extensions/rv32m/rv32m_decode.sv $(RISC_MGMT)/extensions/rv32m/rv32m_execute.sv $(RISC_MGMT)/extensions/rv32m/rv32m_memory.sv
RV32C_FILES := $(RV32C)/decompressor.sv $(RV32C)/fetch_buffer.sv $(RV32C)/rv32c_disabled.sv $(RV32C)/rv32c_enabled.sv $(RV32C)/rv32c_wrapper.sv
RISC_MGMT_FILES := $(RISC_MGMT)/risc_mgmt_wrapper.sv $(RISC_MGMT)/tspp/tspp_risc_mgmt.sv $(RV32M_FILES)
RISC_EXT_FILES := $(RISC_MGMT)/extensions/template/template_decode.sv $(RISC_MGMT)/extensions/template/template_execute.sv $(RISC_MGMT)/extensions/template/template_memory.sv
CORE_PKG_FILES := $(RISCV_PKGS)/rv32i_types_pkg.sv $(RISCV_PKGS)/alu_types_pkg.sv $(RISCV_PKGS)/risc_mgmt/template_pkg.sv $(RISCV_PKGS)/risc_mgmt/crc32_pkg.sv $(RISCV_PKGS)/risc_mgmt/rv32m_pkg.sv $(RISCV_PKGS)/risc_mgmt/test_pkg.sv $(RISCV_PKGS)/machine_mode_types_pkg.sv $(RISCV_PKGS)/machine_mode_types_1_12_pkg.sv $(RISCV_PKGS)/pma_types_1_12_pkg.sv
CORE_FILES := $(RISCV_CORE)/alu.sv  $(RISCV_CORE)/branch_res.sv  $(RISCV_CORE)/control_unit.sv  $(RISCV_CORE)/dmem_extender.sv  $(RISCV_CORE)/endian_swapper.sv  $(RISCV_CORE)/jump_calc.sv  $(RISCV_CORE)/memory_controller.sv  $(RISCV_CORE)/RISCVBusiness.sv  $(RISCV_CORE)/rv32i_reg_file.sv $(RISCV_CORE)/top_core.sv
PIPELINE_FILES :=  $(PIPELINE)/tspp/tspp_execute_stage.sv  $(PIPELINE)/tspp/tspp_fetch_stage.sv  $(PIPELINE)/tspp/tspp_hazard_unit.sv  #$(PIPELINE)/tspp/tspp.sv
PREDICTOR_FILES := $(BRANCH_PREDICT)/branch_predictor_wrapper.sv $(BRANCH_PREDICT)/nottaken_predictor/nottaken_predictor.sv
PRIV_FILES := $(PRIVS)/priv_wrapper.sv  $(PRIVS)/priv_1_12/priv_1_12_block.sv  $(PRIVS)/priv_1_12/priv_1_12_int_ex_handler.sv  $(PRIVS)/priv_1_12/priv_1_12_csr.sv  $(PRIVS)/priv_1_12/priv_1_12_pipe_control.sv $(PRIVS)/priv_1_12/priv_1_12_pma.sv
CACHE_FILES := $(CACHES)/caches_wrapper.sv $(CACHES)/pass_through/pass_through_cache.sv $(CACHES)/direct_mapped_tpf/direct_mapped_tpf_cache.sv $(CACHES)/separate_caches.sv
SPARCE_FILES := $(SPARCE)/sparce_wrapper.sv $(SPARCE)/sparce_disabled/sparce_disabled.sv $(SPARCE)/sparce_enabled/sparce_cfid.sv  $(SPARCE)/sparce_enabled/sparce_enabled.sv  $(SPARCE)/sparce_enabled/sparce_psru.sv  $(SPARCE)/sparce_enabled/sparce_sasa_table.sv  $(SPARCE)/sparce_enabled/sparce_sprf.sv  $(SPARCE)/sparce_enabled/sparce_svc.sv
RISCV_BUS_FILES := $(RISCV_BUS)/generic_nonpipeline.sv $(RISCV_BUS)/ahb.sv
TRACKER_FILES := $(RISCV)/trackers/cpu_tracker.sv $(RISCV)/trackers/branch_tracker.sv

# MULTICORE_FILES:=$(RISCV_CORE)/multicore_wrapper.sv $(RISCV_INC)/core_interrupt.vh
 
ALL_SOURCE_FILES := $(RV32M_FILES) \
					$(RV32C_FILES) \
					$(RISC_MGMT_FILES) \
					$(RISC_EXT_FILES) \
					$(CORE_PKG_FILES) \
					$(CORE_FILES) \
					$(PIPELINE_FILES) \
					$(PREDICTOR_FILES) \
					$(PRIV_FILES) \
					$(CACHE_FILES) \
					$(SPARCE_FILES) \
					$(TRACKER_FILES) \
					$(RISCV_BUS_FILES) \


# UVM Variables
TBTOP:=testbench_top
VERIFICATION:=$(ROOT)/verification
UVM:=$(VERIFICATION)/uvm/multicore
DATA_AGT:=$(UVM)/data_agent
ENV:=$(UVM)/env
INSTR_AGT:=$(UVM)/instr_agent
INTERFACE:=$(UVM)/interfaces
PROGRAMMER:=$(UVM)/programmer
PARAMS:=$(UVM)/params
SEQ:=$(UVM)/sequences
TESTS:=$(UVM)/tests

# Name of UVM test to be run
TESTNAME?=reset_test
VERBOSITY?=UVM_HIGH
SEED?=$(shell echo $$RANDOM)

QUESTA_HOME?=/package/eda/mg/questa10.6b/questasim

# Output directories
COVERAGE_DIR=verification/uvm/multicore/reports
WAVE_SCRIPT=verification/uvm/multicore/waves/multicore.do

# Makefile Targets
all: build run_gui
build:
	@echo "Building testbench and DUT..."
	@echo ""
	vlog +incdir+$(RISCV) \
		+incdir+$(RISCV_INC) \
		+incdir+$(RISCV_CORE) \
		+incdir+$(PIPELINE) \
		+incdir+$(RISC_MGMT) \
		+incdir+$(SPARCE) \
		+incdir+$(PRIVS) \
		+incdir+$(BRANCH_PREDICT) \
		+incdir+$(RISCV_PKGS) \
		+incdir+$(CACHES) \
		+incdir+$(RV32C) \
		+incdir+$(RISCV_BUS) \
		+incdir+$(INTERFACE) \
		+incdir+$(PROGRAMMER) \
		+incdir+$(PARAMS) \
		+incdir+$(ENV) \
		+incdir+$(DATA_AGT) \
		+incdir+$(INSTR_AGT) \
		+incdir+$(SEQ) \
		+incdir+$(TESTS) \
		+acc \
		+cover \
		-L $(QUESTA_HOME)/uvm-1.2 \
		$(UVM)/$(TBTOP).sv \
		-logfile tb_compile.log \
		-printinfilenames=file_search.log

run: build
	@echo "Running simulation..."
	vsim -c $(TBTOP) \
		-L $$QUESTA_HOME//uvm-1.2 \
		-novopt \
		-voptargs=+acc \
		-coverage \
		-sv_seed $(SEED) \
		+UVM_TESTNAME="$(TESTNAME)" \
		+UVM_VERBOSITY=$(VERBOSITY) \
		-do "coverage save -onexit $(COVERAGE_DIR)/coverage_$(SEED).ucdb" \
		-do "run -all"

run_gui: build
	@echo "Running simulation in GUI mode..."
	vsim -coverage -i $(TBTOP) \
		-L $(QUESTA_HOME)/uvm-1.2 \
		-novopt \
		-voptargs=+acc \
		-sv_seed $(SEED) \
		+UVM_TESTNAME="$(TESTNAME)" \
		+UVM_VERBOSITY=$(VERBOSITY) \
		-do "coverage save -onexit $(COVERAGE_DIR)/coverage_$(SEED).ucdb" \
		-do "do $(WAVE_SCRIPT)" \
		-do "run -all"

merge: 
	@echo "Merging coverage reports..."
	vcover merge -out $(COVERAGE_DIR)/merged.ucdb $(COVERAGE_DIR)/coverage_*.ucdb -suppress 6820
	@echo "Generating HTML coverage report..."
	vcover report -html -htmldir $(COVERAGE_DIR)/covhtmlreport -source -details -assert -directive -cvg -code bcefst $(COVERAGE_DIR)/merged.ucdb

report:
	@echo "Opening HTML coverage report..."
	firefox $(COVERAGE_DIR)/covhtmlreport/index.html &

clean:
	@echo "Cleaning up..."
	rm -rf work
	rm -f transcript
	rm -f *.log
	rm -f *.vstf
	rm -f *.wlf

delete_coverage:
	@echo "Deleting Coverage..."
	rm -rf $(COVERAGE_DIR)/*.ucdb
	rm -rf $(COVERAGE_DIR)/covhtmlreport

help:
	@echo "Available targets:"
	@echo "  all                - Build testbench and DUT, and run GUI simulation."
	@echo "  build              - Build the testbench and DUT."
	@echo "  run                - Run the simulation with coverage."
	@echo "  run_gui            - Run the simulation in GUI mode with coverage."
	@echo "  merge              - Merge coverage reports and generate HTML and text coverage reports."
	@echo "  report             - Open the HTML coverage report in Firefox."
	@echo "  clean              - Clean up build and log files."
	@echo "  delete_coverage    - Delete all coverage files and reports."
	@echo "  help               - Display this help message."

# Error handler for undefined targets
%:
	@echo "Error: '$@' is not a recognized target."
	@echo "Run 'make help' to see the list of available targets."

.PHONY: build run run_gui clean report all delete_coverage merge help

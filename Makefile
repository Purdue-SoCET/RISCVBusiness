# ************************************************** #
# Description: Multicore UVM Makefile                #
# Author: Adam Keith                                 #
# Date: 2/18/25                                      #
# ************************************************** #
# Shell
ROOT := $(shell pwd)

# Directories
DIR_FUSESOC_LIBS := fusesoc_libraries
DIR_SOURCE_CODE  := source_code

# Dependencies - via RISCVBusiness.core
FUSE_BUS_PRO := $(DIR_FUSESOC_LIBS)/bus-components/generic/bus_protocol_if
FUSE_BUS_AHB := $(DIR_FUSESOC_LIBS)/bus-components/generic/ahb/ahb_if
FUSE_BUS_APB := $(DIR_FUSESOC_LIBS)/bus-components/generic/apb/apb_if
SRC_PKGS     := $(DIR_SOURCE_CODE)/packages
SRC_STAGE_3  := $(DIR_SOURCE_CODE)/pipelines/stage3
SRC_PRIVS    := $(DIR_SOURCE_CODE)/privs
SRC_CACHES   := $(DIR_SOURCE_CODE)/caches
SRC_STANDARD := $(DIR_SOURCE_CODE)/standard_core
SRC_INCLUDE  := $(DIR_SOURCE_CODE)/include
SRC_RV32A    := $(DIR_SOURCE_CODE)/rv32a
SRC_RV32B    := $(DIR_SOURCE_CODE)/rv32b
SRC_RV32C    := $(DIR_SOURCE_CODE)/rv32c
SRC_RV32M    := $(DIR_SOURCE_CODE)/rv32m
SRC_RV32ZC   := $(DIR_SOURCE_CODE)/rv32zc
# NEW - Not explicitly included in .core file
SRC_BRANCH := $(DIR_SOURCE_CODE)/branch_predictors

# Files - via RISCVBusiness.core
# Branch Predictors
BRANCH_FILES     := $(DIR_SOURCE_CODE)/branch_predictors/branch_predictor_wrapper.sv \
                    $(DIR_SOURCE_CODE)/branch_predictors/nottaken_predictor/nottaken_predictor.sv
# Bus
BUS_FILES        := $(DIR_SOURCE_CODE)/bus_bridges/generic_nonpipeline.sv
# Pipelines
PIPELINE_FILES   := $(DIR_SOURCE_CODE)/pipelines/tspp/tspp_hazard_unit.sv \
                    $(DIR_SOURCE_CODE)/pipelines/tspp/tspp_fetch_stage.sv \
                    $(DIR_SOURCE_CODE)/pipelines/tspp/tspp_execute.sv
# Sparce
SPARCE_FILES     := $(DIR_SOURCE_CODE)/sparce/sparce_disabled/sparce_disabled.sv
# RV32E
RV32E_FILES      := $(DIR_SOURCE_CODE)/RV32E/rv32e_reg_file.sv \
                    $(DIR_SOURCE_CODE)/RV32E/rv32e_wrapper.sv
# Trackers
TRACKER_FILES    := $(DIR_SOURCE_CODE)/trackers/branch_tracker.sv \
                    $(DIR_SOURCE_CODE)/trackers/cpu_tracker.sv

# Bus Files
BUS_BRIDGE_FILES := $(DIR_SOURCE_CODE)/bus_bridges/ahb.sv \
                    $(DIR_SOURCE_CODE)/bus_bridges/apb.sv
# Core
TOP_LEVEL_SRC   := $(DIR_SOURCE_CODE)/standard_core/top_core.sv
# All Design Files
DESIGN_FILES := $(BRANCH_FILES) \
                $(BUS_FILES) \
                $(PIPELINE_FILES) \
                $(SPARCE_FILES) \
                $(RV32E_FILES) \
                $(TRACKER_FILES) \
                $(BUS_BRIDGE_FILES) \
                $(TOP_LEVEL_SRC)

# Verification Team Files
TBTOP 		 := testbench_top
VERIFICATION := $(ROOT)/verification
UVM 		 := $(VERIFICATION)/uvm/multicore
TOP 		 := $(UVM)/tb_tops
DATA_AGT 	 := $(UVM)/data_agent
ENV 		 := $(UVM)/env
INSTR_AGT 	 := $(UVM)/instr_agent
INTERFACE 	 := $(UVM)/interfaces
PROGRAMMER 	 := $(UVM)/programmer
PARAMS 	 	 := $(UVM)/params
SEQ 		 := $(UVM)/sequences
TESTS 		 := $(UVM)/tests

# UVM Test - Override via CL args later on
TESTNAME  ?= reset_test
VERBOSITY ?= UVM_HIGH
SEED      ?= $(shell echo $$RANDOM)
# QuestaSim Path
QUESTA_HOME:=/package/eda/mg/questa10.6b/questasim

# Artifacts - will add a lot more later
COVERAGE_DIR := $(UVM)/reports
WAVE_SCRIPT  := $(UVM)/waves/multicore.do

# Help Text
define helpText

PLACEHOLDER HELP TEXT

endef
export helpText


.PHONY: help
help:
	@echo "$$(helpText)"


.PHONY: config
config:
	@echo "----------------------"
	@echo " Running config_core"
	@echo "----------------------"
	@python3 scripts/config_core.py example.yml


.PHONY: build
build: config
	@echo "Building testbench and DUT..."
	@echo ""
	vlog -mfcu \
	+incdir+$(FUSE_BUS_PRO) \
	+incdir+$(FUSE_BUS_AHB) \
	+incdir+$(FUSE_BUS_APB) \
	+incdir+$(SRC_PKGS) \
	+incdir+$(SRC_STAGE_3) \
	+incdir+$(SRC_PRIVS) \
	+incdir+$(SRC_CACHES) \
	+incdir+$(SRC_STANDARD) \
	+incdir+$(SRC_INCLUDE) \
	+incdir+$(SRC_RV32A) \
	+incdir+$(SRC_RV32B) \
	+incdir+$(SRC_RV32C) \
	+incdir+$(SRC_RV32M) \
	+incdir+$(SRC_RV32ZC) \
	+incdir+$(TOP) \
	+incdir+$(PARAMS) \
	+incdir+$(INTERFACE) \
	+incdir+$(PROGRAMMER) \
	+incdir+$(ENV) \
	+incdir+$(DATA_AGT) \
	+incdir+$(INSTR_AGT) \
	+incdir+$(SEQ) \
	+incdir+$(TESTS) \
	+incdir+$(SRC_BRANCH) \
	+acc \
	+cover \
	-L $(QUESTA_HOME)/uvm-1.2 \
	-sv $(DESIGN_FILES) \
	$(TOP)/$(TBTOP).sv \
	-logfile tb_compile.log \
	-printinfilenames=file_search.log \
	> build.log 2>&1

.PHONY: clean
clean:
	@echo "Removing QSim Artifacts..."
	rm -rf work
	rm -f transcript
	rm -f *.log
	rm -f *.vstf
	rm -f *.wlf
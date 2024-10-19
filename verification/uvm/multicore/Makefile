# NOT TESTED WITH MULTICORE YET. MIGHT FAIL FIRST TIME. 

# Variables (NEED TO MODIFY FOR MULTICORE)
TBTOP=testbench_top
PLIC_AGT=uvm_tb/plic_agent
BUS_AGT=uvm_tb/bus_agent
TEST=uvm_tb/tests
ENV=uvm_tb/env
SEQ=uvm_tb/sequences
PKG=packages
CFG=uvm_tb/config
FUSESOC=fusesoc_libraries/digital-lib/edge_detector/src/socetlib_edge_detector.sv

# Name of UVM test to be run
TESTNAME=reset_test
VERBOSITY=UVM_MEDIUM
SEED=$(shell echo $$RANDOM)


# Ensure QUESTA_HOME is set to the QuestaSim installation directory
QUESTA_HOME?=/package/eda/mg/questa10.6b/questasim

# Makefile Targets
all: build run_gui

build: build_param_pkg run_pkg
	@echo "Building testbench and DUT..."
	vlog +incdir+src \
	+incdir+$(CFG) \
	+incdir+$(PKG) \
	+incdir+$(PLIC_AGT) \
	+incdir+$(BUS_AGT) \
	+incdir+$(TEST) \
	+incdir+$(ENV) \
	+incdir+$(SEQ) \
	+acc \
	+cover \
	-L $(QUESTA_HOME)/uvm-1.2 \
	$(FUSESOC) \
	uvm_tb/top_tbs/$(TBTOP).sv \
	-logfile tb_compile.log \
	-printinfilenames=file_search.log 

run: build_param_pkg run_pkg build
	vsim -c $(TBTOP) -L \
	$(QUESTA_HOME)/uvm-1.2 -novopt \
	-voptargs=+acc \
	-coverage \
	-sv_seed $(SEED) \
	+UVM_TESTNAME="$(TESTNAME)" \
	+UVM_VERBOSITY=$(VERBOSITY) \
	-do "coverage save -onexit uvm_tb/reports/coverage_$(SEED).ucdb" -do "run -all" &
	
run_gui: build_param_pkg run_pkg build
	@echo "Running simulation in GUI mode..."
	vsim -coverage -i $(TBTOP) -L \
	$(QUESTA_HOME)/uvm-1.2 -novopt \
	-voptargs=+acc \
	-sv_seed $(SEED) \
	+UVM_TESTNAME="$(TESTNAME)" \
	+UVM_VERBOSITY=$(VERBOSITY) \
	-do "coverage save -onexit uvm_tb/reports/coverage_$(SEED).ucdb" -do "do wave.do" -do "run -all" &

merge:
	@echo "Merging coverage reports..."
	vcover merge -out uvm_tb/reports/merged.ucdb uvm_tb/reports/coverage_*.ucdb -suppress 6820
	@echo "Generating HTML coverage report..."
	vcover report -html -htmldir uvm_tb/reports/covhtmlreport -source -details -assert -directive -cvg -code bcefst uvm_tb/reports/merged.ucdb
	
report:
	firefox uvm_tb/reports/covhtmlreport/index.html &

clean:
	@echo "Cleaning up..."
	rm -rf work
	rm -f uvm_tb/config/param_pkg.sv
	rm -f wlf*
	rm -f transcript	
	rm -f *.log
	rm -f *.vstf
	rm -f *.wlf

make delete_coverage:
	@echo "Deleting Coverage..."
	rm -rf uvm_tb/reports/*.ucdb
	rm -rf uvm_tb/reports/covhtmlreport

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

%:
	@echo "Error: '$@' is not a recognized target."
	@echo "Run 'make help' to see the list of available targets."
	
.PHONY: build run run_gui clean report all delete_coverage merge help
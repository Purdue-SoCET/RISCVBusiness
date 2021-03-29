##############################################################################
# ECE 337 General Makefile
# 
# Set tab spacing to 2 spaces per tab for best viewing results
##############################################################################

# Include the common/shared variables for the course to minimize potentially stale values
# Note: the release_make_vars already includes the common/public ones
include /home/ecegrid/a/ece337/Course_Prod/course_make_vars

##############################################################################
# File Related Variables
##############################################################################
# List internal component/block files here (separate the filenames with spaces)
# (do not include the source folder in the name)
# NOTE: YOU WILL NEED TO SET THIS VARIABLE'S VALUE WHEN WORKING WITH HEIRARCHICAL DESIGNS
# AND THE AUTOMATED GRADING SYSTEM
COMPONENT_FILES	:= pht.sv BTB.sv
# Specify the name of the top level file (do not include the source folder in the name)
# NOTE: YOU WILL NEED TO SET THIS VARIABLE'S VALUE WHEN WORKING WITH HEIRARCHICAL DESIGNS
# AND THE AUTOMATED GRADING SYSTEM
TOP_LEVEL_FILE	:= gshare_bp.sv

# Specify the filepath of the test bench you want to use (ie. tb_top_level.sv)
# (do not include the source folder in the name)
TEST_BENCH	:= tb_$(TOP_LEVEL_FILE)

# Fill in the names of any test bench helper code files (code files referenced by your testbenches
# other than the actual design files)( do not include the 'source/')
TB_HELPER_FILES	:= 

# Get the top level design and test_bench module names
TB_MODULE		:= $(notdir $(basename $(TEST_BENCH)))
TOP_MODULE	:= $(notdir $(basename $(TOP_LEVEL_FILE)))

# Select the Cell Library to use with simulations
GATE_LIB		:= $(AMI_05_LIB)

S_WORK_LIB := source_work
M_WORK_LIB := mapped_work

LIB_CREATE	:= vlib
COMPILE 		:= vlog -sv
SIMULATE		:= vsim -Lf $(LABS_IP_LIB) -L $(GATE_LIB) -L $(GOLD_LIB) +no_glitch_msg -coverage -voptargs="+acc"
DC_SHELL		:= dc_shell-t

##############################################################################
# Designate that all "intermediate" files created during chaing make rules
# should not be deleted (otherwise automatically compiled or synthesized files
# will be automatically deleted by make after it's done with them).
##############################################################################
.SECONDARY:

##############################################################################
# Designate targets that do not correspond directly to files so that they are
# run every time they are called
##############################################################################
.PHONY: help clean veryclean
.PHONY: print_vars
.PHONY: sim_full_source sim_full_mapped
.PHONY: syn_mapped

##############################################################################
# Make the default target (the one called when no specific one is invoked) to
# output the proper usage of this makefile
##############################################################################
help:
	@echo "----------------------------------------------------------------"
	@echo "Administrative targets:"
	@echo "  clean         - removes the temporary files"
	@echo	"  veryclean     - removes the mapped files as well"
	@echo	"  print_vars    - prints the contents of the variables"
	@echo
	@echo "Compilation targets:"
	@echo "  source_%     - compiles the source version of an indivudal file"
	@echo "                 with the basename of % and outputs the feedback"
	@echo "                 to the terminal instead of to a log file"
	@echo "  mapped_%     - compiles the mapped version of an indivudal file"
	@echo "                 with the basename of % and outputs the feedback"
	@echo "                 to the terminal instead of to a log file"
	@echo "  mapped_tb_%  - compiles the testbench for an indivudal mapped file"
	@echo "                 with the basename of % and outputs the feedback"
	@echo "                 to the terminal instead of to a log file"
	@echo
	@echo "Simulation targets:"
	@echo "  sim_full_source   - compiles and simulates the source version"
	@echo "                      of a full design including its top level"
	@echo "                      test bench"
	@echo "  sim_full_mapped   - compiles and simulates the mapped version"
	@echo "                      of a full design including its top level"
	@echo "                      test bench"
	@echo "  sim_%_source      - compiles and simulates the source version"
	@echo "                      of an individual file with basename %"
	@echo "                      without a testbench"
	@echo "  sim_%_mapped      - compiles and simulates the mapped version"
	@echo "                      of an individual file with basename %"
	@echo "                      without a testbench"
	@echo "  tbsim_%_source    - compiles and simulates the source version"
	@echo "                      of an individual file with basename %"
	@echo "                      with its testbench"
	@echo "  tbsim_%_mapped    - compiles and simulates the mapped version"
	@echo "                      of an individual file with basename %"
	@echo "                      with its testbench"
	@echo 
	@echo "Synthesis targets:"
	@echo "  mapped/%.v - synthesizes the mapped version of an individual file"
	@echo "               additionally the DEP_SUB_FILES variabl can be used "
	@echo "               to define dependant submodule files needed for "
	@echo "               synthesis and the CLOCK_NAME variable can be used"
	@echo "               to define the clock signal name to use for synthesis"
	@echo "               of sequential/clocked designs"
	@echo "----------------------------------------------------------------"

##############################################################################
# Administrative Targets
##############################################################################

clean:
	@echo -e "Removing temporary files"
	@rm -rf *_work
	@rm -rf analyzed/ARCH analyzed/ENTI
	@rm -f analyzed/*
	@rm -f schematic/*
	@rm -f *.wlf *.svf transcript
	@rm -f *.*tran
	@rm -f *.*comp
	@rm -f do_mapping.tcl
	@echo -e "Done\n\n"

veryclean:
	@$(MAKE) --no-print-directory clean
	@echo -e "Removing synthesized files, synthesis logs, and synthesis reports"
	@rm -f mapped/*
	@rm -f reports/*
	@rm -f *.log
	@rm -f rc.*
	@echo -e "Done\n\n"

print_vars:
	@echo -e "Component Files: \n $(foreach file, $(COMPONENT_FILES), $(file)\n)"
	@echo -e "Top level File: $(TOP_LEVEL_FILE)"
	@echo -e "Testbench: $(TEST_BENCH)"
	@echo -e "Top level module: $(TOP_MODULE)"
	@echo -e "Testbench module: $(TB_MODULE)"
	@echo -e "Gate Library: '$(GATE_LIB)'"
	@echo -e "Gold Library: '$(GOLD_LIB)'"
	@echo -e "Course Library: '$(LABS_IP_LIB)'"
	@echo -e "Source work library: '$(S_WORK_LIB)'"
	@echo -e "Mapped work library: '$(M_WORK_LIB)'"

##############################################################################
# General Compilation Targets
##############################################################################

# Define a pattern rule to automatically create the work library for a design source compile
$(S_WORK_LIB):
	@echo -e "Creating work library: $@"
	@rm -rf $@
	@$(LIB_CREATE) $@

# Define a pattern rule to automatically compile updated source files for a design
$(S_WORK_LIB)/%: source/%.sv | $(S_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(S_WORK_LIB)'"
	@$(COMPILE) -work $(S_WORK_LIB) $< | tee $*.scomp ; exit "$${PIPESTATUS[0]}"
	@touch $@
	@echo -e "Done compiling '$<' into work library '$(S_WORK_LIB)'"

# Define a pattern rule to for use at commandline to compile source versions
source_%: $(S_WORK_LIB)/%
	@exit 0 # We cannot have an empty pattern rule in a makefile

# Define a pattern rule to automatically create the work library for a full design mapped compile
$(M_WORK_LIB):
	@echo -e "Creating work library: $@"
	@rm -rf $@
	@$(LIB_CREATE) $@

# Define a pattern rule to automatically compile updated mapped design files for a full mapped design
$(M_WORK_LIB)/%: mapped/%.v | $(M_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(M_WORK_LIB)'"
	@$(COMPILE) -work $(M_WORK_LIB) $< | tee $*.mcomp ; exit "$${PIPESTATUS[0]}"
	@touch $@
	@echo -e "Done compiling '$<' into work library '$(M_WORK_LIB)'"

# Define a pattern rule to automatically compile updated test bench files for a full mapped design
$(M_WORK_LIB)/tb_%: source/tb_%.sv | $(M_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(M_WORK_LIB)'"
	@$(COMPILE) -work $(M_WORK_LIB) $< | tee $*.mcomp; exit "$${PIPESTATUS[0]}"
	@touch $@
	@echo -e "Done compiling '$<' into work library '$(M_WORK_LIB)'"

# Define a pattern rule to for use at commandline to compile mapped versions
mapped_%: $(M_WORK_LIB)/%
	@exit 0 # We cannot have an empty pattern rule in a makefile

# Define a pattern rule to for use at commandline to compile testbenches
mapped_tb_%: $(M_WORK_LIB)/tb_%
	@exit 0 # We cannot have an empty pattern rule in a makefile

##############################################################################
# General Simulation Targets
##############################################################################
define CONSOLE_SIM_CMDS
"run 15 us;	\
 quit -f"
endef

# This rule defines how to simulate the source form of the full design
sim_full_source: $(addprefix $(S_WORK_LIB)/, $(notdir $(basename $(TOP_LEVEL_FILE) $(TEST_BENCH) $(TB_HELPER_FILES) $(COMPONENT_FILES))))
	@echo -e "Simulating Source Design"
# Uncomment below if you want to just run the simulation as a console command
# using the commands listed in the CONSOLE_SIM_CMDS definition above instead of 
# .do file and have the transcript contents to be saved to a file
#	@$(SIMULATE) -c -t ps -do $(CONSOLE_SIM_CMDS) $(S_WORK_LIB).$(TB_MODULE) > source.tran

# Uncomment below if you want run the simulation the normal way and have it
# run the specified .do file
#	@$(SIMULATE) -t ps -do s_waves.do $(S_WORK_LIB).$(TB_MODULE)

# This way just runs it like normal and only sets up the simulation but doesn't
# run it or add any waveforms
	@$(SIMULATE) -i -t ps $(S_WORK_LIB).$(TB_MODULE)
	@cp -f transcript $(basename $(TOP_LEVEL_FILE)).stran
	@echo -e "Done simulating the source design\n\n"

# This rule defines how to simulate the mapped form of the full design
sim_full_mapped: $(addprefix $(M_WORK_LIB)/, $(notdir $(basename $(TOP_LEVEL_FILE) $(TEST_BENCH) $(TB_HELPER_FILES))))
	@echo -e "Simulating Mapped Design"
# Uncomment below if you want to just run the simulation as a console command
# using the commands listed in the CONSOLE_SIM_CMDS definition above instead of 
# .do file and have the transcript contents to be saved to a file
#	@$(SIMULATE) -c -t ps -do $(CONSOLE_SIM_CMDS) $(M_WORK_LIB).$(TB_MODULE) > mapped.tran

# Uncomment below if you want run the simulation the normal way and have it
# run the specified .do file
#	@$(SIMULATE) -t ps -do s_waves.do $(M_WORK_LIB).$(TB_MODULE)

# This way just runs it like normal and only sets up the simulation but doesn't
# run it or add any waveforms
	@$(SIMULATE) -i -t ps $(M_WORK_LIB).$(TB_MODULE)
	@cp -f transcript $(basename $(TOP_LEVEL_FILE)).mtran
	@echo -e "Done simulating the mapped design\n\n"

# Define a pattern rule for simulating the source version of individual files	without a testbench
sim_%_source: $(S_WORK_LIB)/%
	@$(SIMULATE) -i -t ps $(dir $<).$*
	@cp -f transcript $*.stran

# Define a pattern rule for simulating the mapped version of individual files	without a testbench
sim_%_mapped: $(M_WORK_LIB)/%
	@$(SIMULATE) -i -t ps $(dir $<).$*
	@cp -f transcript $*.mtran

# Define a pattern rule for simulating the source version of individual files	with a testbench
tbsim_%_source: $(S_WORK_LIB)/% $(S_WORK_LIB)/tb_%
	@$(SIMULATE) -i -t ps $(dir $<).tb_$*
	@cp -f transcript $*.stran

# Define a pattern rule for simulating the mapped version of individual files	with a testbench
tbsim_%_mapped: $(M_WORK_LIB)/% $(M_WORK_LIB)/tb_%
	@$(SIMULATE) -i -t ps $(dir $<).tb_$*
	@cp -f transcript $*.mtran

##############################################################################
# Define the synthesis target specific variables to use
##############################################################################

# Set the default value of the clock name and clock period to an empty string so that clock timing will
# only be activated in the SYN_CMDS definition if they were overwritten at invocation
CLOCK_NAME 		:= clk
CLOCK_PERIOD	:= 10

# Set the default value of the source files for sub modules to be an empty string so that
# it will only be used if overwritten at invocation
DEP_SUB_FILES :=

# Set the default value of the main source file to an empty string since it will be
# overwritten by each rule where it is used anyways
MAIN_FILE :=

# Set the module's name to always be the same as the basename of the file
# (a.k.a. the file name without the file extension)
MOD_NAME := $(basename $(MAIN_FILE))

##############################################################################
# Synthesis Targets
##############################################################################

# A customized make target for the top level file for complex designs
# Note: The CLOCK_NAME variable override below will need to be set to the actual
# clock signal name for sequential/clocked designs.
# Also have to specify to run with the c shell to force it to use the course config (.cshrc) and call course scripts 
mapped/$(TOP_MODULE).v: SHELL := /usr/local/bin/tcsh
$(addsuffix .v, $(addprefix mapped/, $(TOP_MODULE))): mapped/%.v : source/%.sv $(addprefix source/,$(COMPONENT_FILES))
	@echo "Synthesizing design: $@\n"
	@$(MAKE) --no-print-directory syn_mapped MAIN_FILE='$(notdir $<)' DEP_SUB_FILES='$(COMPONENT_FILES)' CLOCK_NAME='$(CLOCK_NAME)' CLOCK_PERIOD='$(CLOCK_PERIOD)' > $(notdir $(basename $@)).log
	@echo "Synthesis run attempt for $@ complete"
	@echo "Checking synthesis attempt for errors"
	@syschk -w $(notdir $(basename $@))
	@echo "\nCheck for synthesis attempt errors complete, open $(notdir $(basename $@)).log for details if errors were found"
	@echo "\nRemember to check $(TOP_MODULE).log for latches and timing arcs"
	@echo "Synthesis run complete for design: $@\n\n"

# A pattern rule target to synthesize any design that does not already have one defined earlier,
# as long as the desired mapped file has a corresponding source file with the same basename,
# (which is grabbed by the '%' and accessed via the $* automatic variable).
# Additionally it will include any specified dependant submodule source files in the target's
# dependencies and thus will resynthesize if any of them are newer as well.
# It will pass on any of the related variables values if they were overwritten at runtime.
# Also have to specify to run with the c shell to force it to use the course config (.cshrc) and call course scripts 
mapped/%.v: SHELL := /usr/local/bin/tcsh
mapped/%.v: source/%.sv $(addprefix source/,$(DEP_SUB_FILES))
	@echo "Synthesizing and Compiling design: $@\n"
	@$(MAKE) --no-print-directory syn_mapped MAIN_FILE='$*.sv' DEP_SUB_FILES='$(DEP_SUB_FILES)' CLOCK_NAME='$(CLOCK_NAME)' CLOCK_PERIOD='$(CLOCK_PERIOD)' > $*.log
	@echo "Synthesis run attempt for $@ complete"
	@echo "Checking synthesis attempt for errors (errors will be printed if found)"
	@syschk -w $*
	@echo "\nCheck for synthesis attempt errors complete, open $*.log for details if errors were found"
	@echo "\nRemember to check $*.log for latches and timing arcs"
	@echo "Synthesis run complete for design: $@\n\n"

##############################################################################
# Define the synthesis commands to use
##############################################################################
define newline


endef

define SYN_CMDS
# Step 1:  Read in the source file
analyze -format sverilog -lib WORK {$(DEP_SUB_FILES) $(MAIN_FILE)}
elaborate $(MOD_NAME) -lib WORK
uniquify
# Step 2: Set design constraints
# Uncomment below to set timing, area, power, etc. constraints
# set_max_delay <delay> -from "<input>" -to "<output>"
# set_max_area <area>
# set_max_total_power <power> mW
$(if $(and $(CLOCK_NAME), $(CLOCK_PERIOD)), create_clock "$(CLOCK_NAME)" -name "$(CLOCK_NAME)" -period $(CLOCK_PERIOD))

# Step 3: Compile the design
compile -map_effort medium

# Step 4: Output reports
report_timing -path full -delay max -max_paths 1 -nworst 1 > reports/$(MOD_NAME).rep
report_area >> reports/$(MOD_NAME).rep
report_power -hier >> reports/$(MOD_NAME).rep

# Step 5: Output final VHDL and Verilog files
write_file -format verilog -hierarchy -output "mapped/$(MOD_NAME).v"
echo "\nScript Done\n"
echo "\nChecking Design\n"
check_design
quit
endef

# Define the target that will actually invoke the synthesis commands through design compiler
syn_mapped do_mapping.tcl:
	@echo -e "Synthesizing design: $(MAIN_FILE)"
	@echo -e '$(subst $(newline),\n,$(subst \n,\\n,${SYN_CMDS}))' > do_mapping.tcl
	$(DC_SHELL) -x "source -echo do_mapping.tcl"
	@echo -e "Done\n\n"


MITROOT := /package/asicfab/MITLL_90_Dec2019/MITLL90_STDLIB_8T/2019.12.20/

syn_test: 
	@irun -gui -access +rwc +nctimescale+1ns/1ns -coverage all -covoverwrite -define MAPPED $(MITROOT)/MITLL90_STDLIB_8T.v gshare_bp.v source/tb_gshare_bp.sv 


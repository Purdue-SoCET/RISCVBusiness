RUN_COMMON=tb_bus_ctrl -L $(QUESTA_HOME)/uvm-1.2 -novopt -iterationlimit=100k -sv_seed 1138575530 "+UVM_VERBOSITY=UVM_DEBUG" 
#add in the random seed!, look into the iterationLimit variable 
targets:
	@echo "Available Targets:"
	@echo "build : compile tb with vlog"
	@echo "run   : run tb with vsim"
	@echo "gui   : run tb with vsim in gui mode"
	
all: build run

build:
	@echo "Building Project"
	vlog -L $(QUESTA_HOME)/uvm-1.2 tb_bus_ctrl.sv

run:
	@echo "Running Tests"
	vsim -c $(RUN_COMMON) -do ./run.do

gui:
	@echo "Running Tests with Gui"
	vsim -i $(RUN_COMMON) -do wave.do -do ./run.do

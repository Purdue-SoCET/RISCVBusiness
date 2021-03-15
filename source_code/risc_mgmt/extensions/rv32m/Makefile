TOP = tb_mult.sv
AGENT = tb/agent
TEST = tb/test
ENV = tb/env
SEQ = tb/sequencer
COMP = tb/comparator
DRIVER = tb/driver
MONITOR = tb/monitor
MULT_if = tb/mult_if
PRED = tb/predictor
TRANS = tb/transaction
REG_MODEL = $(REG)/vreguvm_pkg_uvm.sv


all: build run

build: 
	vlog +incdir+src \
	+incdir+$(TOP) \
	+incdir+$(AGENT) \
	+incdir+$(TEST) \
	+incdir+$(ENV) \
	+incdir+$(SEQ) \
	+incdir+$(COMP) \
	+incdir+$(DRIVER) \
	+incdir+$(MONITOR) \
	+incdir+$(MULT_if) \
	+incdir+$(PRED) \
	+incdir+$(TRANS) \
	+acc \
	+cover \
	-L $$QUESTA_HOME/uvm-1.2 $(REG_MODEL) tb/$(TOP) 

run:
	vsim -i tb_mult -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="mult_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "do wave.do" -do "run -all"

clean:
	rm -rf work
	rm -rf mitll90_Dec2019_all
	rm -rf covhtmlreport
	rm *.log
	rm transcript
	rm *.wlf

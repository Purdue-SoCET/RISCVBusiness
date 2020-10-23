irun(64): 15.20-s030: (c) Copyright 1995-2017 Cadence Design Systems, Inc.
TOOL:	irun(64)	15.20-s030: Started on Oct 22, 2020 at 21:50:50 EDT
irun
	-gui
	-access +rwc
	-l div.sv
	tb_div.sv
file: tb_div.sv
	module worklib.tb_div:sv
		errors: 0, warnings: 0
		Caching library 'worklib' ....... Done
	Elaborating the design hierarchy:
		Caching library 'worklib' ....... Done
  div #(32) DUT (.*);
              |
ncelab: *E,CUVMUR (./tb_div.sv,15|14): instance 'tb_div.DUT' of design unit 'div' is unresolved in 'worklib.tb_div:sv'.
irun: *E,ELBERR: Error during elaboration (status 1), exiting.
TOOL:	irun(64)	15.20-s030: Exiting on Oct 22, 2020 at 21:50:50 EDT  (total: 00:00:00)

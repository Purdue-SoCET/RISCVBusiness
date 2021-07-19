#!/bin/bash
irun $1 -access +rwc +nctimescale+1ns/1ns -coverage all -covoverwrite -incdir  ~/AFTx06/RISCVBusiness/source_code/include/ ~/AFTx06/RISCVBusiness/source_code/packages/rv32i_types_pkg.sv  l2_cache.sv ../memory_arbiter.sv  tb/tb_full_cache.sv ../l1/l1_cache.sv


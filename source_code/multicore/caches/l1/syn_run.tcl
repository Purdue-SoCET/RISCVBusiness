#!/bin/bash
irun -v200x -gui -delay_trigger +acc -access +rwc -linedebug tb/tb_l1_cache.sv -incdir ~/AFTx06/RISCVBusiness/source_code/include/ /package/asicfab/MITLL_90_Dec2019/MITLL90_STDLIB_8T/2019.12.20/MITLL90_STDLIB_8T.v synthesis_scripts/mapped/l1_cache.v

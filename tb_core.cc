#include <iostream>
#include <fstream>
#include <map>

#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop_core.h"
#include "Vtop_core_top_core.h"

vluint64_t sim_time = 0;

std::map<uint32_t, uint32_t>* make_memory() {

    std::map<uint32_t, uint32_t>* mmap = new std::map<uint32_t, uint32_t>;

    uint32_t address = 0x80000000;
    std::ifstream myFile("meminit.bin", std::ios::in | std::ios::binary);
    if(!myFile) {
        std::cout << "Couldn't open meminit.bin!" << std::endl;
        return NULL;
    }

    while(!myFile.eof()) {
        uint32_t data;
        myFile.read((char *)&data, sizeof(data));

        mmap->insert(std::make_pair(address, data));

        address += 4;
    }

    return mmap;
}

void tick(Vtop_core& dut, VerilatedVcdC& trace) {
    dut.CLK = 0;
    dut.eval();
    trace.dump(sim_time);
    sim_time++;
    dut.CLK = 1;
    dut.eval();
    trace.dump(sim_time);
    sim_time++;
}

void reset(Vtop_core& dut, VerilatedVcdC& trace) {
    // Initialize signals 
    dut.CLK = 0;
    dut.nRST = 0;
    dut.ext_int = 0;
    dut.ext_int_clear = 0;
    dut.soft_int = 0;
    dut.soft_int_clear = 0;
    dut.timer_int = 0;
    dut.timer_int_clear = 0;
    dut.busy = 1;
    dut.rdata = 0;

    tick(dut, trace);
    dut.nRST = 0;
    tick(dut, trace);
    dut.nRST = 1;
    tick(dut, trace);
}


int main(int argc, char **argv) {

    std::map<uint32_t, uint32_t> *memory = make_memory();
    if(!memory) {
        std::cout << "Could not open meminit.bin" << std::endl;
        return 0;
    }

    Vtop_core dut;

    Verilated::traceEverOn(true);
    VerilatedVcdC m_trace;
    dut.trace(&m_trace, 5);
    m_trace.open("waveform.vcd");


    reset(dut, m_trace);
    while(!dut.halt) {
        if((dut.ren || dut.wen) && dut.busy) {
            dut.busy = 0;
            if(dut.ren) {
                uint32_t addr = dut.addr;
                auto it = memory->find(addr);
                if(it != memory->end()) {
                    uint32_t data = it->second;
                    dut.rdata = data;
                } else {
                    dut.rdata = 0;
                }
            }
        } else if(!dut.busy) {
            dut.busy = 1;
        }

        tick(dut, m_trace);
    }

    if(dut.top_core->get_x28()) {
        std::cout << "Test PASSED" << std::endl;
    } else {
        std::cout << "Test FAILED" << std::endl;
    }

    m_trace.close();
    return 0;
}

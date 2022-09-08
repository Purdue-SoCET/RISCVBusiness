#include <iostream>
#include <iomanip>
#include <cstdio>
#include <fstream>
#include <sstream>
#include <map>

#include "verilated.h"
#include "verilated_fst_c.h"
#include "Vtop_core.h"
#include "Vtop_core_top_core.h"

vluint64_t sim_time = 0;



class MemoryMap {
private:

    // NOTE: Assuming 0 for uninitialized memory
    // This is because bare-metal tests may not set up bss,
    // but the program will nonetheless have a bss section.
    const uint32_t c_default_value = 0x00000000;
    const char *dumpfile = "memsim.dump";
    std::map<uint32_t, uint32_t> mmap;

protected:
    inline uint32_t expand_mask(uint8_t mask) {
        uint32_t acc = 0;
        for(int i = 0; i < 4; i++) {
            auto bit = ((mask & (1 << i)) != 0);
            if(bit) {
                acc |= (0xFF << (i * 8));
            }
        }

        return acc;
    }

public:

    MemoryMap(const char *fname) {
        uint32_t address = 0x80000000;
        std::ifstream myFile(fname, std::ios::in | std::ios::binary);
        if(!myFile) {
            std::ostringstream ss;
            ss << "Couldn't open " << fname << std::endl;
            throw ss.str();
        }

        while(!myFile.eof()) {
            uint32_t data;
            myFile.read((char *)&data, sizeof(data));

            mmap.insert(std::make_pair(address, data));

            address += 4;
        }
    }

    // TODO: Add simulation for SWI/mtime?
    uint32_t read(uint32_t addr) {
        auto it = mmap.find(addr);
        if(it != mmap.end()) {
            return it->second;
        } else {
            return c_default_value;
        }
    }

    void write(uint32_t addr, uint32_t value, uint8_t mask) {
        // NOTE: For now, assuming that all memory is legally acessible.
        auto it = mmap.find(addr);
        if(it != mmap.end()) {
            auto mask_exp = expand_mask(mask);
            it->second = (value & mask_exp) | (it->second & ~mask_exp);
        } else {
            mmap.insert(std::make_pair(addr, value));
        }
    }

    void dump() {
        std::ofstream outfile;
        outfile.open(dumpfile);
        if(!outfile) {
            std::ostringstream ss;
            ss << "Couldn't open " << dumpfile << std::endl;
            throw ss.str();
        }

        // Account for endianness
        for(auto p : mmap) {
            if(p.second != 0) {
                char buf[80];
                snprintf(buf, 80, "%08x : %02x%02x%02x%02x", p.first, 
                        (p.second & 0xFF000000) >> 24, 
                        (p.second & 0x00FF0000) >> 16, 
                        (p.second & 0x0000FF00) >> 8, 
                        p.second & 0x000000FF);
                outfile << buf << std::endl;
            }
        }
    }
};

void tick(Vtop_core& dut, VerilatedFstC& trace) {
    dut.CLK = 0;
    dut.eval();
    trace.dump(sim_time);
    sim_time++;
    dut.CLK = 1;
    dut.eval();
    trace.dump(sim_time);
    sim_time++;
}

void reset(Vtop_core& dut, VerilatedFstC& trace) {
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

    const char *fname;

    if(argc < 2) {
        std::cout << "Warning: No bin file name provided, assuming './meminit.bin' as file location!" << std::endl;
        fname = "meminit.bin";
    } else {
        fname = argv[1];
    }

    MemoryMap memory(fname);

    Vtop_core dut;

    Verilated::traceEverOn(true);
    VerilatedFstC m_trace;
    dut.trace(&m_trace, 5);
    m_trace.open("waveform.fst");


    reset(dut, m_trace);
    while(!dut.halt && sim_time < 1000000) {
        // TODO: Variable latency
        if((dut.ren || dut.wen) && dut.busy) {
            dut.busy = 0;
            if(dut.ren) {
                uint32_t addr = dut.addr & 0xFFFFFFFC;
                dut.rdata = memory.read(addr);
            } else if(dut.wen) {
                uint32_t addr = dut.addr & 0xFFFFFFFC;
                uint32_t value = dut.wdata;
                uint8_t mask = dut.byte_en;
                memory.write(addr, value, mask);
            }
        } else if(!dut.busy) {
            dut.busy = 1;
        }

        tick(dut, m_trace);
    }

    if(sim_time == 1000000) {
        std::cout << "Test TIMED OUT" << std::endl;
    } else if(dut.top_core->get_x28() == 1) {
        std::cout << "Test PASSED" << std::endl;
    } else {
        std::cout << "Test FAILED: Test " << dut.top_core->get_x28() << std::endl;
    }
    m_trace.close();
    memory.dump();

    return 0;
}

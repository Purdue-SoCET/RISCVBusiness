#include "Vcache_stress_wrapper.h"
#include "verilated.h"
#include "verilated_fst_c.h"
#include <atomic>
#include <cstdint>
#include <ctime>
#include <fstream>
#include <iostream>
#include <queue>
#include <random>
#include <sstream>

uint64_t sim_time = 0;

bool posedge = false;
bool negedge = false;
Vcache_stress_wrapper *dut;
VerilatedFstC *trace;

enum class TransactionAction {
    Read,
    Write,
    Noop,
};

struct Transaction {
    TransactionAction action;
    uint32_t addr;
    uint32_t data;

    Transaction(TransactionAction action, uint32_t addr, uint32_t data)
        : action(action), addr(addr), data(data) {}
};

Transaction rand_transaction(Transaction prev) {
    TransactionAction action;
    uint32_t addr;
    uint32_t data;
    {
        uint8_t rand_action = rand() % 10;
        if (rand_action <= 2)
            action = TransactionAction::Read;
        else if (rand_action <= 5)
            action = TransactionAction::Write;
        else
            return prev;
    }
    {
        // Cache sizes are 1kB, get 4kB range just to increase possibility we force evictions
        addr = rand() % 128 + 0x80000000;
        addr &= ~0x3;
    }
    data = rand();
    return Transaction(action, addr, data);
}

struct Ram {
  private:
    const uint32_t c_default_value = 0x00000000;
    const char *dump_file = "memsim.dump";
    const char *transaction_dump_file = "transaction.dump";
    std::map<uint32_t, uint32_t> mmap;

  protected:
    inline uint32_t expand_mask(uint8_t mask) {
        uint32_t acc = 0;
        for (int i = 0; i < 4; i++) {
            auto bit = ((mask & (1 << i)) != 0);
            if (bit) {
                acc |= (0xFF << (i * 8));
            }
        }

        return acc;
    }

  public:
    Ram() {}

    Ram(const char *dump_file, const char *transaction_dump_file)
        : dump_file(dump_file), transaction_dump_file(transaction_dump_file) {}

    uint32_t read(uint32_t addr) {
        std::cout << "did read" << std::endl;
        auto it = mmap.find(addr);
        if (it != mmap.end()) {
            return __builtin_bswap32(it->second);
        } else {
            return c_default_value;
        }
    }

    void write(uint32_t addr, uint32_t value, uint8_t mask) {
        // NOTE: For now, assuming that all memory is legally acessible.
        std::cout << "did write" << std::endl;
        auto it = mmap.find(addr);
        if (it != mmap.end()) {
            auto mask_exp = expand_mask(mask);
            it->second = __builtin_bswap32(value & mask_exp) |
                         __builtin_bswap32(__builtin_bswap32(it->second) & ~mask_exp);
        } else {
            mmap.insert(std::make_pair(addr, __builtin_bswap32(value)));
        }
    }

    uint32_t handle_transaction(Transaction transaction) {
        if (transaction.action == TransactionAction::Read) {
            return read(transaction.addr);
        } else if (transaction.action == TransactionAction::Write) {
            write(transaction.addr, transaction.data, 0xF);
        }
    }

    void dump() {
        std::ofstream outfile;
        outfile.open(dump_file);
        if (!outfile) {
            std::ostringstream ss;
            ss << "Couldn't open " << dump_file << std::endl;
            exit(1);
        }

        for (auto p : mmap) {
            char buf[80];
            snprintf(buf, 80, "%08x : %02x%02x%02x%02x", p.first, (p.second & 0xFF000000) >> 24,
                     (p.second & 0x00FF0000) >> 16, (p.second & 0x0000FF00) >> 8,
                     p.second & 0x000000FF);
            outfile << buf << std::endl;
        }
    }
};

std::atomic_bool kill_caches = false;

struct GenericBusIf {
    volatile uint32_t *addr;
    volatile uint32_t *wdata;
    volatile unsigned char *ren;
    volatile unsigned char *wen;
    volatile uint32_t *rdata;
    volatile unsigned char *busy;

    GenericBusIf(uint32_t *addr, uint32_t *wdata, unsigned char *ren, unsigned char *wen,
                 uint32_t *rdata, unsigned char *busy)
        : addr(addr), wdata(wdata), ren(ren), wen(wen), rdata(rdata), busy(busy) {}
};

struct RamWithBus {
    Ram ram;
    GenericBusIf bus;

    RamWithBus(GenericBusIf bus) : ram(), bus(bus) {}

    void run() {
        while (!kill_caches) {}
    }
};

struct Cache {
    std::queue<Transaction> transactions;
    Ram *golden_model;
    uint32_t addr;
    GenericBusIf bus;

    Cache(Ram *golden_model, GenericBusIf bus) : golden_model(golden_model), bus(bus) {}

    void run() {
        while (!kill_caches) {
            populateTransactions();

            Transaction transaction = transactions.front();
            transactions.pop();
            executeTransaction(transaction);
        }
    }

    __attribute__((noinline)) void executeTransaction(Transaction transaction) {
        *bus.addr = transaction.addr;
        *bus.wdata = transaction.data;
        *bus.ren = 0;
        *bus.wen = 0;
        switch (transaction.action) {
        case TransactionAction::Noop:
            return;
        case TransactionAction::Read:
            *bus.ren = 1;
            break;
        case TransactionAction::Write:
            *bus.wen = 1;
            break;
        }
        while (*bus.busy) {
            if (kill_caches)
                return;
        }
        uint64_t curr_time = sim_time;
        while (sim_time < curr_time + 2) {
            if (kill_caches) return;
        }
        *bus.ren = 0;
        *bus.wen = 0;
        golden_model->handle_transaction(transaction);
    }

    void populateTransactions() {
        Transaction prev = {TransactionAction::Read, 0x80000000, 0x0};
        while (transactions.size() < 16) {
            transactions.push(rand_transaction(prev));
            prev = transactions.back();
        }
    }
};

void tick() {
    dut->CLK = 0;
    dut->eval();
    trace->dump(sim_time++);
    dut->CLK = 1;
    dut->eval();
    trace->dump(sim_time++);
}

void reset() {
    dut->CLK = 0;
    dut->nRST = 1;
    dut->cache0_addr = 0x0;
    dut->cache0_wdata = 0x0;
    dut->cache0_ren = 0x0;
    dut->cache0_wen = 0x0;
    dut->cache1_addr = 0x0;
    dut->cache1_wdata = 0x0;
    dut->cache1_ren = 0x0;
    dut->cache1_wen = 0x0;
    dut->memory_rdata = 0x0;
    dut->memory_busy = 0x1;

    tick();
    dut->nRST = 0;
    tick();
    dut->nRST = 1;
    tick();
}

int main(int argc, char **argv) {
    srand(0);

    dut = new Vcache_stress_wrapper;
    trace = new VerilatedFstC;
    Ram golden_model("goldensim.dump", "golden_transaction.dump");
    Ram simulated_ram;
    // RamWithBus simulated_ram(GenericBusIf(&dut->memory_addr, &dut->memory_wdata,
    // &dut->memory_ren,
    //                                      &dut->memory_wen, &dut->memory_rdata,
    //                                      &dut->memory_busy));
    Verilated::traceEverOn(true);
    dut->trace(trace, 5);
    trace->open("cache_stress_wrapper.fst");

    reset();

    std::thread cache0_thread = std::thread([&] {
        Cache cache(&golden_model,
                    GenericBusIf(&dut->cache0_addr, &dut->cache0_wdata, &dut->cache0_ren,
                                 &dut->cache0_wen, &dut->cache0_rdata, &dut->cache0_busy));
        cache.run();
    });

    std::thread cache1_thread = std::thread([&] {
        Cache cache(&golden_model,
                    GenericBusIf(&dut->cache1_addr, &dut->cache1_wdata, &dut->cache1_ren,
                                 &dut->cache1_wen, &dut->cache1_rdata, &dut->cache1_busy));
        cache.run();
    });

    // std::thread simulated_ram_thread = std::thread([&] { simulated_ram.run(); });

    while (sim_time < 1000) {
        tick();
        if (dut->memory_busy) {
            if (dut->memory_ren) {
                dut->memory_rdata = simulated_ram.read(dut->memory_addr);
                dut->memory_busy = 0;
            } else if (dut->memory_wen) {
                simulated_ram.write(dut->memory_addr, dut->memory_wdata, 0xF);
                dut->memory_busy = 0;
            }
        } else {
            dut->memory_busy = 1;
        }
    }

    // dut->cache0_flush = 1;
    // dut->cache1_flush = 1;
    // do {
    //     tick();
    //     if (dut->cache0_flush_done)
    //         dut->cache0_flush = 0;
    //     if (dut->cache1_flush_done)
    //         dut->cache1_flush = 0;
    // } while (dut->cache0_flush || dut->cache1_flush);

    dut->final();
    trace->close();
    simulated_ram.dump();
    golden_model.dump();

    kill_caches = true;
    cache0_thread.join();
    cache1_thread.join();
    // simulated_ram_thread.join();

    return 0;
}

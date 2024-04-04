#include "Vcache_stress_wrapper.h"
#include "verilated.h"
#include "verilated_fst_c.h"
#include <cstdint>
#include <ctime>
#include <fstream>
#include <iostream>
#include <queue>
#include <random>
#include <span>
#include <sstream>

uint64_t sim_time = 0;

bool posedge = false;
bool negedge = false;
Vcache_stress_wrapper *dut;
VerilatedFstC *trace;

void print_help_exit() {
    std::cerr << "Usage: ./build.sh <num_transactions> <flags...>" << std::endl;
    std::cerr << "\t--help: Print this" << std::endl;
    exit(1);
}

void tick_dut() {
    dut->CLK = 0;
    dut->eval();
    trace->dump(sim_time++);
    dut->CLK = 1;
    dut->eval();
    trace->dump(sim_time++);
}

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

Transaction rand_transaction() {
    TransactionAction action;
    uint32_t addr;
    uint32_t data;
    {
        uint8_t rand_action = rand() % 10;
        // Roughly 25% chance to read, 25% chance to write, 50% change to do nothing
        if (rand_action <= 2)
            action = TransactionAction::Read;
        else if (rand_action <= 5)
            action = TransactionAction::Write;
        else
            action = TransactionAction::Noop;
    }
    {
        // TODO: Once caches reliably work, bump this up to test evictions and conflicts
        // Cache sizes are 1kB, get 4kB range just to increase possibility we force evictions
        // TODO: Currently 512B range
        addr = rand() % 512 + 0x80000000;
        addr &= ~0x3;
    }
    data = rand();
    // Only waste max of 30 cycles on a noop
    if (action == TransactionAction::Noop)
        data %= 30;
    return Transaction(action, addr, data);
}

struct Ram {
  private:
    const uint32_t c_default_value = 0x00000000;
    const char *dump_file = "memsim.dump";
    std::map<uint32_t, uint32_t> mmap;

    uint32_t read(uint32_t addr) {
        auto it = mmap.find(addr);
        if (it != mmap.end()) {
            return __builtin_bswap32(it->second);
        } else {
            uint32_t other_addr = (addr % 8 == 0) ? addr + 4 : addr - 4;
            mmap.insert(std::make_pair(addr, c_default_value));
            mmap.insert(std::make_pair(other_addr, c_default_value));
            return c_default_value;
        }
    }

    void write(uint32_t addr, uint32_t value, uint8_t mask) {
        // NOTE: For now, assuming that all memory is legally acessible.
        auto it = mmap.find(addr);
        if (it != mmap.end()) {
            auto mask_exp = expand_mask(mask);
            it->second = __builtin_bswap32(value & mask_exp) |
                         __builtin_bswap32(__builtin_bswap32(it->second) & ~mask_exp);
        } else {
            uint32_t other_addr = (addr % 8 == 0) ? addr + 4 : addr - 4;
            mmap.insert(std::make_pair(addr, __builtin_bswap32(value)));
            mmap.insert(std::make_pair(other_addr, c_default_value));
        }
    }

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
    Ram(const char *dump_file) : dump_file(dump_file) {}

    uint32_t handle_transaction(Transaction transaction) {
        if (transaction.action == TransactionAction::Read) {
            return read(transaction.addr);
        } else if (transaction.action == TransactionAction::Write) {
            write(transaction.addr, transaction.data, 0xF);
        }
        return 0;
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

bool cache0_done = false;
bool cache1_done = false;

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

struct CacheState {
    enum class CacheStateEnum { Start, Wait, Read, Write, Done };

  private:
    uint64_t transaction_start_cycle;
    CacheStateEnum e;
    // Address used for reads and writes
    uint32_t addr;
    // Either the data to be written or the number of clock cycles to stay idle.
    uint32_t data;

    CacheState(CacheStateEnum e, uint32_t addr, uint32_t data)
        : transaction_start_cycle(sim_time), e(e), addr(addr), data(data) {}

  public:
    static CacheState Start() {
        return CacheState(CacheStateEnum::Start, 0x0, 0);
    }

    static CacheState Read(uint32_t addr) {
        return CacheState(CacheStateEnum::Read, addr, 0x0);
    }

    static CacheState Write(uint32_t addr, uint32_t data) {
        return CacheState(CacheStateEnum::Write, addr, data);
    }

    static CacheState Wait(uint32_t num_cycles) {
        return CacheState(CacheStateEnum::Wait, 0x0, num_cycles);
    }

    static CacheState Done() {
        return CacheState(CacheStateEnum::Done, 0x0, 0);
    }

    static CacheState fromTransaction(Transaction t) {
        switch (t.action) {
        case TransactionAction::Read:
            return Read(t.addr);
        case TransactionAction::Write:
            return Write(t.addr, t.data);
        case TransactionAction::Noop:
            return Wait(t.data);
        }
    }

    Transaction intoTransaction() {
        switch (e) {
        case CacheStateEnum::Wait:
        case CacheStateEnum::Start:
        case CacheStateEnum::Done:
            return {TransactionAction::Noop, 0, 0};
        case CacheStateEnum::Read:
            return {TransactionAction::Read, addr, data};
        case CacheStateEnum::Write:
            return {TransactionAction::Write, addr, data};
        }
    }

    void setBusStim(GenericBusIf &gbif) {
        *gbif.addr = 0;
        *gbif.wdata = 0;
        *gbif.ren = 0;
        *gbif.wen = 0;
        switch (e) {
        case CacheStateEnum::Wait:
        case CacheStateEnum::Start:
        case CacheStateEnum::Done:
            break;
        case CacheStateEnum::Read:
            *gbif.addr = addr;
            *gbif.ren = 1;
            break;
        case CacheStateEnum::Write:
            *gbif.addr = addr;
            *gbif.wdata = data;
            *gbif.wen = 1;
            break;
        }
    }

    bool isDone(GenericBusIf &gbif) {
        switch (e) {
        case CacheStateEnum::Wait:
            return sim_time > (transaction_start_cycle + data);
        case CacheStateEnum::Read:
        case CacheStateEnum::Write:
            return !(*gbif.busy);
        case CacheStateEnum::Start:
        case CacheStateEnum::Done:
            return true;
        }
    }

    uint64_t startCycle() {
        return transaction_start_cycle;
    }
};

struct Cache {
  private:
    const char *transaction_dump_file = "transaction.dump";

  public:
    std::vector<std::tuple<Transaction, uint64_t, uint64_t>> all_transactions;
    std::span<Transaction, std::dynamic_extent> transactions;
    CacheState state;
    Ram &golden_model;
    uint32_t addr;
    GenericBusIf bus;
    bool &done;

    Cache(Ram &golden_model, GenericBusIf bus, const char *transaction_dump_file, bool &done)
        : golden_model(golden_model), bus(bus), transaction_dump_file(transaction_dump_file),
          done(done), state(CacheState::Start()) {}

    void tick() {
        if (state.isDone(bus)) {
            if (transactions.size() > 0) {
                Transaction curr_transaction = state.intoTransaction();
                all_transactions.push_back(
                    std::make_tuple(curr_transaction, state.startCycle(), sim_time));
                golden_model.handle_transaction(curr_transaction);
                Transaction transaction = transactions.front();
                transactions = transactions.subspan(1);
                state = CacheState::fromTransaction(transaction);
                state.setBusStim(bus);
            } else if (!done) {
                printf("finished\n");
                Transaction curr_transaction = state.intoTransaction();
                all_transactions.push_back(
                    std::make_tuple(curr_transaction, state.startCycle(), sim_time));
                golden_model.handle_transaction(curr_transaction);
                state = CacheState::Done();
                state.setBusStim(bus);
                done = true;
            }
        }
    }

    void dump() {
        std::ofstream outfile;
        outfile.open(transaction_dump_file);
        if (!outfile) {
            std::ostringstream ss;
            ss << "Couldn't open " << transaction_dump_file << std::endl;
            exit(1);
        }

        for (auto t : all_transactions) {
            const auto [transaction, start, end] = t;
            char buf[80];
            switch (transaction.action) {
            case TransactionAction::Noop:
                snprintf(buf, 80, "noop at %d", start);
                break;
            case TransactionAction::Read:
                snprintf(buf, 80, "read %x, start %d, end %d", transaction.addr, start, end);
                break;
            case TransactionAction::Write:
                snprintf(buf, 80, "write %x %x, start %d, end %d", transaction.addr,
                         endian_flip(transaction.data), start, end);
                break;
            }
            outfile << buf << std::endl;
        }
    }

    uint32_t endian_flip(uint32_t num) {
        uint32_t flipped_data = 0;
        // Note, this line comes from StackOverflow
        flipped_data = ((num >> 24) & 0xff) |      // move byte 3 to byte 0
                       ((num << 8) & 0xff0000) |   // move byte 1 to byte 2
                       ((num >> 8) & 0xff00) |     // move byte 2 to byte 1
                       ((num << 24) & 0xff000000); // byte 0 to byte 3
        return flipped_data;
    }
};

// An epoch creates and assigns transactions to caches to provide determinism
// to transaction generation. It manages the lifetimes of both caches and both
// simulated rams.
struct Epoch {
    std::vector<Transaction> transactions;
    uint32_t num_transactions;
    Cache cache0;
    Cache cache1;
    Ram golden_model;
    Ram sim_model;

    Epoch(uint32_t num_transactions, GenericBusIf cache0_gbif, GenericBusIf cache1_gbif)
        : num_transactions(num_transactions), golden_model(Ram("goldensim.dump")),
          sim_model(Ram("memsim.dump")),
          cache0(golden_model, cache0_gbif, "cache0_transactions.dump", cache0_done),
          cache1(golden_model, cache1_gbif, "cache1_transactions.dump", cache1_done) {
        transactions.reserve(num_transactions);
        for (int i = 0; i < num_transactions; i++) {
            transactions.push_back(rand_transaction());
        }
        cache0.transactions = std::span(transactions.begin(), num_transactions / 2);
        cache1.transactions =
            std::span(transactions.begin() + num_transactions / 2, num_transactions / 2);
    }

    void tick() {
        tick_dut();
        if (dut->memory_busy) {
            if (dut->memory_ren) {
                dut->memory_rdata =
                    sim_model.handle_transaction({TransactionAction::Read, dut->memory_addr, 0x0});
                dut->memory_busy = 0;
            } else if (dut->memory_wen) {
                sim_model.handle_transaction(
                    {TransactionAction::Write, dut->memory_addr, dut->memory_wdata});
                dut->memory_busy = 0;
            }
        } else {
            dut->memory_busy = 1;
        }
        cache0.tick();
        cache1.tick();
    }

    void flush() {
        dut->cache0_flush = 1;
        dut->cache1_flush = 1;
        do {
            tick();
            if (dut->cache0_flush_done)
                dut->cache0_flush = 0;
            if (dut->cache1_flush_done)
                dut->cache1_flush = 0;
        } while (dut->cache0_flush || dut->cache1_flush);
    }
};

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

    tick_dut();
    dut->nRST = 0;
    tick_dut();
    dut->nRST = 1;
    tick_dut();
}

int main(int argc, char **argv) {
    srand(time(NULL));

    uint32_t num_transactions = 1000000;
    if (argc == 2) {
        if (!strncmp("--help", argv[1], strlen("--help"))) {
            print_help_exit();
        }
        num_transactions = std::stoul(argv[1]);
    }

    printf("Running with %d transactions\n", num_transactions);

    dut = new Vcache_stress_wrapper;
    trace = new VerilatedFstC;
    GenericBusIf cache0_gbif(&dut->cache0_addr, &dut->cache0_wdata, &dut->cache0_ren,
                             &dut->cache0_wen, &dut->cache0_rdata, &dut->cache0_busy);
    GenericBusIf cache1_gbif(&dut->cache1_addr, &dut->cache1_wdata, &dut->cache1_ren,
                             &dut->cache1_wen, &dut->cache1_rdata, &dut->cache1_busy);
    Epoch epoch(num_transactions, cache0_gbif, cache1_gbif);
    Verilated::traceEverOn(true);
    dut->trace(trace, 5);
    trace->open("cache_stress_wrapper.fst");

    reset();

    while (!(cache0_done && cache1_done)) {
        epoch.tick();
    }

    epoch.cache0.dump();
    epoch.cache1.dump();
    epoch.flush();

    dut->final();
    trace->close();
    epoch.sim_model.dump();
    epoch.golden_model.dump();

    printf(
        "cache0: invalidations: %d, send shared block: %d, got shared block: %d, exclusives: %d\n",
        dut->cache0_invalidated_blocks, dut->cache0_shared_blocks, dut->cache0_to_s_transitions,
        dut->cache0_to_e_transitions);
    printf(
        "cache1: invalidations: %d, send shared block: %d, got shared block: %d, exclusives: %d\n",
        dut->cache1_invalidated_blocks, dut->cache1_shared_blocks, dut->cache1_to_s_transitions,
        dut->cache1_to_e_transitions);

    return 0;
}

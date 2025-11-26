# List of test directories
TEST_DIRS := interrupts-exceptions u-mode pma-tests pmp-tests s-mode

# Compiler and tools
CROSS := riscv64-unknown-elf-
CC := $(CROSS)gcc
OBJCOPY := $(CROSS)objcopy
OBJDUMP := $(CROSS)objdump

# Flags
CFLAGS := -O2 -I./common -T./common/link.ld \
		  -Wall -Wextra -Werror \
		  -march=rv32imc_zicsr -mabi=ilp32 -mcmodel=medany \
		  -static -nostartfiles -nostdlib -ffreestanding \
		  -ffunction-sections -fdata-sections# -Wl,--gc-sections

# Common directory
COMMON_DIR := common
BUILD_DIR := build

# Find all .c and .S files in common directory
COMMON_SRCS := $(wildcard $(COMMON_DIR)/*.c $(COMMON_DIR)/*.S)
COMMON_OBJS := $(patsubst $(COMMON_DIR)/%,$(BUILD_DIR)/$(COMMON_DIR)/%,$(COMMON_SRCS:.c=.o))
COMMON_OBJS := $(COMMON_OBJS:.S=.o)

# Generate test targets for each directory
define make-test-targets
TEST_SRCS_$(1) := $$(wildcard $(1)/*.c $(1)/*.S)
TEST_OBJS_$(1) := $$(patsubst $(1)/%,$$(BUILD_DIR)/$(1)/%,$$(TEST_SRCS_$(1):.c=.o))
TEST_OBJS_$(1) := $$(TEST_OBJS_$(1):.S=.o)
TEST_ELFS_$(1) := $$(patsubst $(1)/%,$$(BUILD_DIR)/$(1)/%,$$(patsubst %.c,%,$$(filter %.c,$$(TEST_SRCS_$(1)))))
TEST_ELFS_$(1) += $$(patsubst $(1)/%,$$(BUILD_DIR)/$(1)/%,$$(patsubst %.S,%,$$(filter %.S,$$(TEST_SRCS_$(1)))))
TEST_BINS_$(1) := $$(TEST_ELFS_$(1):=.bin)
TEST_ASMS_$(1) := $$(TEST_ELFS_$(1):=.asm)

ALL_ELFS += $$(TEST_ELFS_$(1))
ALL_BINS += $$(TEST_BINS_$(1))
ALL_ASMS += $$(TEST_ASMS_$(1))
ALL_OBJS += $$(TEST_OBJS_$(1))
endef

$(foreach dir,$(TEST_DIRS),$(eval $(call make-test-targets,$(dir))))

# Main targets
.PHONY: all clean

all: $(ALL_ELFS) $(ALL_BINS) $(ALL_ASMS)

# Rule to compile .c files
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to assemble .S files
$(BUILD_DIR)/%.o: %.S
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to link ELF files (one per test source file)
define make-link-rule
$$(BUILD_DIR)/$(1)/%: $$(BUILD_DIR)/$(1)/%.o $$(COMMON_OBJS)
	@mkdir -p $$(dir $$@)
	$$(CC) $$(CFLAGS) $$< $$(COMMON_OBJS) -o $$@
endef

$(foreach dir,$(TEST_DIRS),$(eval $(call make-link-rule,$(dir))))

# Rule to create flat binary with objcopy
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%
	$(OBJCOPY) -O binary $< $@

# Rule to create disassembly with objdump
$(BUILD_DIR)/%.asm: $(BUILD_DIR)/%
	$(OBJDUMP) -d $< > $@

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

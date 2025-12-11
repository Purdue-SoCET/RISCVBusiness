
define USAGE
@echo "----------------------------------------------------------------------"
@echo " Build Targets:"
@echo "     config: config core with example.yml"
@echo "     verilate: Invoke 'FuseSoC run --build' to build Verilator target"
@echo "     xcelium: Invoke 'FuseSoC run --build' to build Xcelium target"
@echo "     lint: Invoke 'FuseSoC run --build' to run the Verilator lint target"
@echo "     clean: Remove build directories"
@echo "     veryclean: Remove fusesoc libraries & build directories"
@echo "----------------------------------------------------------------------"
endef

.phony: default clean config verilate xcelium


default:
	$(USAGE)

config:
	@echo "----------------------"
	@echo " Running config_core"
	@echo "----------------------"
	@python3 scripts/hetero_config_core.py core_configuration.yml

verilate: config
	@fusesoc --cores-root . run --setup --build --build-root rvb_out --target sim --tool verilator socet:riscv:RISCVBusiness --make_options='-j'
	@echo "------------------------------------------------------------------"
	@echo "Build finished, you can run with 'fusesoc run', or by navigating"
	@echo "to the build directory created by FuseSoC and using the Makefile there."
	@echo "------------------------------------------------------------------"

no_mem: config
	@fusesoc --cores-root . run --setup --build --build-root rvb_out --target no_mc --tool verilator socet:riscv:RISCVBusiness --make_options='-j'
	@echo "------------------------------------------------------------------"
	@echo "Build finished, you can run with 'fusesoc run', or by navigating"
	@echo "to the build directory created by FuseSoC and using the Makefile there."
	@echo "------------------------------------------------------------------"

xcelium: config
	@fusesoc --cores-root . run --setup --build --build-root rvb_out --target sim --tool xcelium socet:riscv:RISCVBusiness
	@echo "Build finished, you can run with 'fusesoc run', or by navigating"
	@echo "to the build directory created by FuseSoC and using the Makefile there."

lint: config
	@fusesoc --cores-root . run --setup --build --build-root rvb_out --target lint --tool verilator socet:riscv:RISCVBusiness
	@echo "Lint finished, no errors found"

clean:
	rm -rf build
	rm -rf rvb_out

veryclean:
	rm -rf fusesoc_libraries
	rm fusesoc.conf

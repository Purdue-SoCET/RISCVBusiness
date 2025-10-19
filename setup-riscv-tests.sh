#! /bin/sh

git submodule update --init --recursive
pushd riscv-tests
git apply ../riscv-tests-isa.patch
pushd env
git apply ../../riscv-tests-env.patch
popd
pushd benchmarks
git apply ../../riscv-tests-benchmarks.patch
popd
autoconf
./configure
make $1
pushd isa
find . -maxdepth 1 -type f ! -name "Makefile" ! -name "*.*" -exec riscv64-unknown-elf-objcopy -O binary "{}" "{}.bin" \;
popd
popd

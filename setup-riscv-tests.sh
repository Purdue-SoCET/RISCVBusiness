#! /bin/sh

git submodule update --init --recursive
pushd riscv-tests
pushd env
git apply ../../riscv-tests-patch.patch
popd
autoconf
./configure
make $1
pushd isa
find . -maxdepth 1 -type f ! -name "Makefile" ! -name "*.*" -exec riscv64-unknown-elf-objcopy -O binary "{}" "{}.bin" \;
popd
popd

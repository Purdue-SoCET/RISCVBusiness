# RISC-V "V" extension compiler support

## Introduction
Despite the relative user-friendliness of the RISC-V "V" extension, for most practical purposes it's still critical to have good compiler support so that programs can be generally accelerated without needing specific optimization for the vector core. Fortunately, both GCC and Clang have support for auto-vectorization with the "V" extension and can generate quite performant vector code if given well-written data-parallel programs.

A good tool to test out and verify auto-vectorization is [Compiler Explorer](https://godbolt.org/). It has toolchains for RISC-V including the trunk versions, which may be critical depending on how much further integration of the RISC-V "V" extension has progressed when you are reading this. You can simply paste C code, set the appropriate compiler and flags, and easily inspect the generated assembly.

## General notes
### Writing code
The compilers will generally do a pretty good job of vectorizing data-parallel code, but you may occasionally have to nudge them to do what you want. Take the following code as an example:

[Matrix Multiplication](https://gcc.godbolt.org/#z:OYLghAFBqd5QCxAYwPYBMCmBRdBLAF1QCcAaPECAMzwBtMA7AQwFtMQByARg9KtQYEAysib0QXACx8BBAKoBnTAAUAHpwAMvAFYTStJg1AB9U8lJL6yAngGVG6AMKpaAVxYM9DgDJ4GmADl3ACNMYhAAVgjSAAdUBUJbBmc3Dz04hJsBX38gllDwqItMKyyGIQImYgIU908uYtKkiqqCHMCQsMjohUrq2rSG3tb2vILugEoLVFdiZHYOAHpFgGoAUgAmAGYsGn8VxwAJbEcAaTWNAEFl9e3dv0wVgBUASQBZbAvLr82tvCpds93p8rr8/Mg3Fh1ltHL18KgAHQINZbEHfbbgyGPFGOGxsJEotG/Bz/FYrG6vD4/UF3TB7R4AJQA8gB1IRcFZcABsP1p9IOTO87M5PJpOzpDxWzLZGxFvPF/McgqEsu51MufgIKxYTAIxDwqi4awiACFpeyAFRKoVGiIAEWhDrWAHYTRsuFtSCttlyvRsABzOr3OrjRFZcjZhrhcDZeiJcjRxhorZ0ATljnNTXv9Gn92a2Ya5kl9K1TEWk4a5Qe9gez/uTkn9GedXLzpeTW2dbbLGakJcjJa4GizKwiOezqf7GZ7Xsk7q9Hs9K2LGa2yaLba4/qXjb9qYrqcnC4Lda9a%2BnXa9XNT1bLXsPzY0Hed1fdya4zozrZH153S7XS5RNW/pcmGkgaBW3KJimGwVgGFb1rORThmmC7cnGyE5kuqbjuGqZLu6UYen6GjTlsJaptGV7EeGGxftswYaCWXLJk22FbCOEQ0c6Y6zhszFHt6PFxqm0H%2BoJaYUTR/rbnGtbesWwb%2BlGlFocx84rDJYYbBo0GiSO/Fts6WwVpIVHhjRnYVly5Fxi%2BZ5bkhS5btBNkjqJBGdveGw/jGs5bDuzrQdG3YRAZFYttB/FLgm/7IaJm7IVwh5nvhV4hn6LZXqBSklhEqGjv6B5%2BSsWzKfeGg7iBSEdmG6YqRmGZhSO24lkVBm8d6JY8Rm4HBZI7klcZwHGZlFYRBot4BguglbFFk3ZjZ96hn6E2zgVCa9cJpVcoOS48WG%2BXJjeX4RmeYVnkWwazuBwamVs06OeGXF%2BoOBkfutUVrUJnHoaOw4idBB3BmuV5zXGPnnXlkb3mdpUPdm30hoOGWcgRTEORR14LjDmmibOMlnrJy5BX6dFE22ja3iWZkjpIo3hrZKYnozI7OpIYZYQu4n3tZBVlpzqnPdhGNddWkgI8u8beYWkMpjeqWcajAbJtsvY5ZpGsRCZcZM7tf43e58mdthgkTYBV2ch9IptiZr6o5OYak5p5mdhmMkaC6dooiaXyatqur6qoGzGmarIqlayoh/ajrrK6AbOWZV6rrt3N1cdqNSLbTbBgVOYVgF0FeZyc4LqXy4QdmyZptpBEMZpqNduuUizqL9P9hzZesRs4ukXGZ4aaGhYJtmkiQU%2BwYaZOzmVWhutIUTIObgNZ596Whaz6WZWzhrHOQfzGtVquiHMyOnbV5LCHb8u1VCU133KcxTPbIB2s3bXRc66Vq5Pfl1bs%2BtYq3VFIoX7CtUqSdSxjwJg2BswFO6lTqgzfiFYopf0DO7QSOZqxrgPJ1IK2ke5g1MoTUsWVlz8SvBoJ2LEFwAJ2olP041JYBWfMBP6HpXzQKgWfFhuZUpRhXqVNu5Mt5th0jdSClDwwTjZgzIK1NewaWvLbfGtE4reVVqLD8qsQGWwmlFBm%2B4vyX22lEHc5kgqq2vkWMMJljr1x7t2BB24OypwbtBMc1ZozuxHl1CiulZx3hdquFKy4aL9m7MTEyX5xb015nBDWJki4AzxmJBWeEvr3nIQmNma9yLjUCRXOxu5mYRQZslDsAUmHATfuGHOmkhHsyLjhDCeV9p%2BIGv2dM60rzBJDARdxZYpEHgordWi3jN5zntpEuR7ttpzWCuAuibUqx0OrvXUSUZ5KhmhsxOpzUHIGQWszXqHEgl1SEa0ihvVaGcnITmKM9CJJyM5lc/csMWrxPhuw4C4M0l%2Bj%2Bq2Ge3jznqJmiHZ03sti%2ByuP7TAqgYiYGsKHc0XBI5Cmjk6LYTpXRlQgkOAuoltiV1Ki%2BScBUOL4V0nBSidFYKziHIGUG4Sohj20k2G81TvSdiKvZLqRUxycTHiuVW252ZrNKspci19yLbmHLbIsZVJXTPpSWcik1DymRpZ%2Bd624yy9xwl2V82t8KytEnOIRyr3T0JQe6O57oIJcQLi%2BYyxdtYTRjDg/iOl8qr0DJ%2BW2uZozljPA9CIdFTIRqrN8h6rZSIp3rDeVWOl6aUrHEPYKZZjGmQ3FIIuPkArcJ7oS0RdEuI2RwZNVNW19zJQLnRQMwS1yPxZuRKQLbMo5kmnYtMLYEEPT5c268Ply78RfDGOKCVXYxnEshOc2s5yNRzIGUWPlYI2Wcjhal4iExPgZRQhN1yfJcW1gRfcpFxnJPwt9Huc1V3nRbDGnexlSJ03wgGHm4TWES3WrswSS6Ixw1NY7QKgrglzk7DZVctMdL/g4rpMF8YtyRsuluMyoSCESJvvlBM4ttg4S/o2AKylKZmQDaZIKc53FmRlXc8s8Yog01Ivla%2B5ZwIRpaW%2B5KjKF0NKLfhIRZlA31z/qBTq4Fr3/kPN2uBnH%2BHLlAhBSWEa43NuMuWIc/l9yTltslR14tdpnrschtySYqPS3CRa0p7bjJPQDJJZ2AUcKNgbDeclz4hxMTppVFtmGTJFVSo2GSNNYIhks2uahUhxYxi80G1qV66IBS/j69M5V4bsqWoguaUhGqTkqo46MlFb6wTKhqwB4lLaFvEwXD09VvWhjlXuYsOZeohTKsfLC3yBrxgDUTfLEGwrDm65VaLvVF1VkM0xHuZ8J1xtXoR42kWux5RYiBXepEWIlXItefTjKArIz4tRy2HN3QytbmPD8%2BGbLiRwSKoKNMeJMrPh%2BAK0ix66XZndjmN4z4ZrKrSj0TiB6dmob1eqc1vUAQQeunNN0Y27x7j3KZg65qrifOG22rrGxwS0vTF1dXUmRbHGCjrbqooYPIujgaRUCIflzGCnShEWUYZ%2B3BeMw5sNrjTOViBuZhwdjVp%2BdVD5pVnnZUxAu9MCwvWEbpbYiqyofg7r13e96mwxci%2BMny9assDnZkLAs7MxzQUbCxZNq9htc7oiGW%2ByWtzROocM7OtG5Zve1llsqyljJwXZoXBsLHVPnQHKk2juZcJlXLHW8X8ZPz/h1wOPc%2B4HqFOJWEgs97Y1O8gw5YyRV1UfejA2T1HMab08mqZAaWyi7fg5mBCMLYGb3ojBkoV%2B5xngWGWCvqVYnpvY4ttgs24NLlgDGFHBjyzKm%2BV3NcaQ4gf/jMlBP84Etxn0PFSmm3OTIFwjeJJmHMeJFiLluU/lHyz51bnVpbRYLf%2BK1Tgqx544yTbYmeKjTcBEKOYz46hYb3PfTFgsRlZoY6T8aUQZqrgvg05kYxg%2Bp8Q5jch0whpAEDzKSNYDxdhvavQeina54G7VjawQTsri6PxpSlShiSa2wS7fQcTjqkoLppjKRew%2Bx%2ByCArDECYAKCuC0AECorhzorWgqjGjYq4q%2BxQqsGghXCmC6h6h4DBCuAECYCmBQAMCoB%2BC0APATATBfAABu6h6AAcBALAPBEAmoFoHBXBch1gRhyY5hlhvQ%2BoNhOoBAGY9hnBjheANhHhXo/sxAdh7ByAARWoxAbhgRGwEwccsKlwZIZI/AxAKwZh7BeAscnsMKKwKROIHBRo6ReAmwvsGwJokRLo0RsRZRKw8RiR/sAA1qkT7CsLUVkUEfUdUfkfkcUa6F8OUd0RUSQFUewdoHUekYMU0SHMMW0YUR0aUT0TMR4aHHgBaMgLKPkSsNoCIbcL7DirYfMYsRyCsa0THBYS4dHCaNUYscsYUasSIZITETMbESwVcDMQ8bcWSM8W8XCuwTqH4BAFMfKP8ICJSGiGURCKgMgNUcYFqMMNULHCCWCT8TccSAwPgFQOqGUS4SYbQBAC4UHMmNiQaBmB4TwQQF6Gil6EIcmOaBmEIREQiWKP8XSECFSI8bEbCeCVqA4DCbQKCdUfCTCl0bEegDMMEPQCsCUEwDEEoIYSiA6BAIKa4MKZgBMBAByQALQrBQkECRGrCODeBMhnBCDGDKDYAMjGBCAnA3FlExD6iCBUAQCbAbB2gCCPB%2BC3ARAokRCOAMD2lehikSmYDoA6F8ligkgolSEvEZHsFhDEAkAKBDHRF/EAgMlHAnDnDMlxF9FJFaiZFbFpEmgZHQiOBSgCEYrCG5ETFFFRH8ndGkgQCEm8HzHrFgBgDSmimIrIp8Gmh5H2i/Fpl3FRkxkbEtk5HTHdHPFlFvHbAhlkg3DJlnComxGcEECzAMCinEDRnEAKAIkSFXAcBTC0CcARC8CeAcBaCkCoCcCFkKAzBzDYjbA8CkAECaC7lTDVGRCJj7kcCSBHlPlnmcC8AKAgCJiPknm7mkBwCwAwCIAgAIrIqKEkDkCUBVDAAKDKCGAlBCAICoAADux595aALAMQdAuoSQqF/gtAGF2Fx5p5%2BFhF9A4QyAwAQOpANFdAYQAQrACwvALFdFTIihFFOFP5MFyAlwxAyFf5pAQlFQ%2BAx5vA/AggIgYg7ALccl8gSgagP5ugDQBgRgIApgxg5gmhwQAFkAUwqAMQZQAFHAvAqAuhUZeAWAxlPxpAxArgggeAbATwqALgjlUwV5sw8wegcIfgpF6FmFAl3AvAWFxA4pnAPAe5B535IFv5HA2AqgsFRACRqgIEKpRYKwwAyAyAaMCIsoEAjgXouAhAfRvwXAEwvAwFWg2hpAr5a0H5X5pALAIAa4CIRUT4%2BEVGe6OOpAVF1l4lAFQFT5Uw4FUF3FYQCFEAM14QxAuhD0KpDFBVeorl1RfAdAShG5lAwQP5wQfgVQAAnrFbwEdcwMQCdUyMENoO2edcxagCwGwIIEyAwLQGdUlVgAocAI4GILQJZfeVgDqEYOIN9XgJwdYHgLZZZaeUJYoQsPeZqCUD%2BYZdFddc4FgD%2BXIR1RFaQLZcQMEPEJgHaJgKDcAJoTpSBVMFQAYMhQAGp4CYBYVMhIq4WyWyAKXiDKWyCKAqDqBJWaX6CGAmBmD6DyE%2BVnnmVJCWUqlMiygqk6hzDIg4pLUPTuXGAABetlD0qgKwStTAR10pdAMQD0BtLAS1uhhtqgKptAGJ0p6AJ1zALAXhKw1lhN%2BoDl8AvlJQ7ZSQ9gSJAw9QElSJownQ4QDQGQiQAgwd6Q8QMdDA4d%2BQXQQwft0NAgLQ/QLgdQgV6dZQWdbQDwYwqdFgfQNQOdgwZdIwxdEdEgvl15AVNV%2BgCVQ1P555HAUoLwQgjgKpDNiRK1R1BACgkR%2BVhVEAG1DA1RkREAFVGVtwa4tVD5E1UwCAmATAWA4QTlrVvAHVrYCIoYOE02ZYVKb8w1yV/5gFy9NNL5b5LdHAWwiVp5HddVK999GwT9I1Vl19DVUwhNCQdgkgQAA%3D%3D)

There's two things worth noting here:
* This is a pretty simple implementation of matrix multiplication. Other than the basic loop interchange optimization, there are no other weird intrinsics or anything like that required for it to vectorize. As long as you write clean, independent loops, there's a good chance the compilers will be able to vectorize it.
* The input pointers are marked `restrict` for a reason. Pointer aliasing is the bane of auto-vectorization, and if you're not careful, you can end up with fully-scalar inner loops. For instance, the Embench matrix multiplication implementation suffers from this problem and generates fully scalar code, which is why we see no uplift.

### Compiler flags
To enable auto-vectorization, you will need to specify a vector extension as part of your `march=` flag, e.g. `march=rv32im_zve32x`. It's a good idea to also specify `-mabi=ilp32` to make sure that hardware floating point instructions are not generated.

Additionally, you will want to use `-O2` to generate good quality vector code. Generally it seems that `-O3` results in both compilers generating a bunch of unrolled loops and extra code, which will probably not work so well with the limited instruction cache our CPU has to work with. `-Os` may also work, but makes GCC more reluctant to generate vector instructions. Clang seems happy to vectorize away with `-Os` though, so that's probably the best option if you're using it.

Finally, a useful flag to add is `-mrvv-max-lmul=dynamic` for GCC. This makes GCC actually use an LMUL greater than `m1`, which is good because higher LMUL generally means lower overhead and higher performance. Clang also has some similar flags you can use to tune the vector code generation, but I haven't been able to find good documentation on those.

### Code quality
As mentioned before, generally the vector code generated by the compilers is of decent quality. However, there are a couple of quirks to be aware of:

* While GCC does a good job of using RISC-V "V" extension-specific features, Clang generates code that looks more like traditional vector ISAs. This leads to it often having worse code size and performance compared to GCC.
* If you write code with a lot of weird memory access patterns or conditionals, the compilers may end up outputting code that actually runs slower than scalar. This is mostly because some instructions (like `vrgather` and the segmented load/store instructions) have low-performance implementations, and using them in a hot loop may not work well.

It's a good idea to always inspect the generated assembly and make sure there's nothing too strange going on in there.

## Setting up
### GCC
GCC is set to integrate auto-vectorization into the mainline builds in the [GCC 14 release](https://gcc.gnu.org/gcc-14/changes.html). As of May 2024, auto-vectorization already seems to be working pretty well on the trunk builds, and as long as you're careful when setting up the toolchain you should be able to build the trunk version locally and compile stuff that way.

To build trunk GCC, you will need a system with the appropriate dependencies. As of this writing, `asicfab` does not appear to have recent enough tool versions to be able to do this, so you may have to try `asicfabu` or ideally a Linux (or Windows with WSL) machine where you have the ability to install additional packages.

First, go ahead and clone the [RISC-V GNU toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) and install the relevant dependencies mentioned there:

    git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git

Next, you will need to configure the toolchain with the appropriate options. For some reason, the instructions in the repository tell you to run the configure script from the toolchain directory, but I've had better luck creating an adjacent directory and running the script from there:

    mkdir riscv32-gcc
    cd riscv32-gcc
    ../riscv-gnu-toolchain/configure --prefix=`pwd` --with-arch=rv32im_zve32x_zicsr_zifencei --with-abi=ilp32

Here, the `--with-arch` flag needs to have the extensions supported by the core and ONLY the extensions supported by the core. If you are not specific enough (i.e. you use `g` or `v`), the standard libraries may get built with incompatible instructions (like floating point) that will cause you to fault even if you later provide the correct flags during compilation.

Now, you're ready to run the build (expect this to take some time):

    make -j `nproc`

Once the build is done, you'll want to add the `bin` directory to your PATH so that you can easily access the compiler. Don't worry about it conflicting with your native GCC installation since all the binaries are prefixed with `riscv32-unknown-elf-` so there should be no conflicts.

### Clang
Clang already has auto-vectorization support for the RISC-V "V" extension integrated into the latest release. In theory, the process of setting up Clang for the vector core should be as simple as getting the appropriate release and adding it to your PATH. However, this has not been tested so be warned that you may run into snags.

## Contributors
- Om Gupta (guptao@purdue.edu)



# Microarchitecture

In this document we delve into more detail about the decode, execute, and memory pipeline stages in the following top-level diagram of our processor: 

![Vector_Extension_Pipeline](images/rvv_pipeline.jpg)


## Decode Stage 




## Execute Stage 

Below is a more detailed diagram of what is hapenning in the execute stage. We omit details about the datapath for scalar instructions, since those were not affected by the vector extension. 

![Execute_Stage](images/execute_stage.jpg)

The execute datapath is able to handle 4 parallel operations every clock cycle. In order to sustain this throughput, we have partitioned our datapath for vector instructions in 4 lanes. However those lanes have a lot of intercommunication with one another, particularly when reading operands. The source file deadling with constructing this datapath is in *source_code/rv32v/rv32v_ex_datapath.sv*. 

The vector register file contains 32 vector registers where the size of each vector register is 128-bits. This register file is banked across 4 banks, where the each 32-bit segment of a vector register resides in a different bank. Since vector operations can work on 8-bit, 16-bit, or 32-bit elements, some vector operations can have three operands, and the different operands can have a different data-width, we add three read crossbars. Those read crossbars read data from the all the banks, take into account the data-width of the operand and the bank where one should get the data from, and then generate the appropriate data to send to each of the 4 vector functional units when it comes to that particular operand. 

Instructions that require reading a third operand have that third operand being the vector destination register. That is why in the diagram, it shows reading vd from the register banks. 


To support masking element operations, we generate 4 mask bits in the excute stage with 1 bit corresponding to each mask. Those bits are used in the memory stage to mask element writeback or memory accesses. 

Certain vector instructions have an a value coming from the scalar register file or an immediate field in the instruction serving as one the operands. To handle this, muxes are added at the inputs of the vector functional units. 

This datapath handles most of the vector instructions, however certain instructions require different handling. For instance some masking instructions like *vcpop, vfirst, vmsbf, etc.* have their own dedicate mask_calc_unit in *source_code/rv32v/source/rv32v_mask_calc.sv*. The same goes for reductions and permutations. 



## Mem Stage



## Tricky Instructions 

### Reductions


### Permutations


### Mask Setting Instructions 
Some vector instructions write on the granularity of individual bits. Examples of these instructions include the vector comparison instructions like *vmslt.vv* where each comparison either writes a 0 bit or a 1 bit in the destination vector register. In these instructions, we generate 4 bits in the execute stage (since where are doing 4 parallel comparisons) that we send to the memory stage for writeback. However, the lowest granularity that we can write to a vector register is 1 byte or 8-bits. To deal with this we have the following logic in the execute stage: 

![mask_set_layer_img](images/mask_set_layer.jpg). 

Before we pass inputs to the mem stage latch, we have a mask set layer that adjusts those input values for mask setting instructions as shown by the *is_mskset_instr* signal in the above diagram. For mask setting instructions, only the least signficant bit from the VFU (vector functional unit) is relevant. We pack those 4 bits (the LSB from each VFU) in the mask set layer to be sent in the *vres{x}* signals. In the case where the uop in the execute stage is writing to bits 4-7 of a vector register, we do not want to overwrite the previous 4 bits we generated in the previous cycle. This is why we forward 4 bits from the mem stage to the execute stage to use as needed. In the mask set layer, we also end up needing to overwrite the lane_mask signals, the bank_offset signals, along with other signals before sending them to the mem stage. The source file deadling with the mask set layer is in *source_code/rv32v/source/mask_set_layer.sv*. 

### Segmented Memory Instructions  
Segmented memory operations are dealt differently with when compared to other types of vector memory operations. For instance with unit-strided, strided, and indexed vector memory operations, 4 memory accesess are sent in 1 uop where they are serialized in the mem stage. For segmented memory operations, each uop only deals with 1 memory access. 

Segmented load/store instructions are used for loading/storing arrays of structs. Below is an example of a unit-strided segmented load where each struct in the struct array is composed of two fields: 

![unit_segment_load](images/unit_seg_load.jpg)

These memory instructions are primarly dealt with in the decode stage when we are generating uops. A different set of counters are used in the uop generation unit in *source_code/rv32v/source/rv32v_uop_gen.sv* to handling decoding these instructions. Each uop only deals with 1 memory access, and we performs memory accesses in order. We access the segments in order as well as the fields within each segment. 




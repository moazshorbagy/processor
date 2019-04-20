vsim -gui work.processor
# vsim -gui work.processor 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.processor(structural)
# Loading ieee.numeric_std(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.address_module(address)
# Loading work.mux2(when_else_mux)
# Loading work.reg(behavioral)
# Loading work.memory(memory_architecture)
add wave -position insertpoint  \
sim:/processor/in_port \
sim:/processor/interrupt \
sim:/processor/reset \
sim:/processor/clk \
sim:/processor/out_port \
sim:/processor/address \
sim:/processor/write_data \
sim:/processor/mem_out \
sim:/processor/W32 \
sim:/processor/M_write_enable \
sim:/processor/stall_fetch \
sim:/processor/FAT \
sim:/processor/D_pc_plus_one \
sim:/processor/D_port \
sim:/processor/D_instr
add wave -position insertpoint  \
sim:/processor/D_read_data_1 \
sim:/processor/D_read_data_2
add wave -position insertpoint  \
sim:/processor/D_read_addr_1 \
sim:/processor/D_read_addr_2
add wave -position insertpoint  \
sim:/processor/D_write_data_1 \
sim:/processor/D_write_data_2
add wave -position insertpoint  \
sim:/processor/D_write_addr_1 \
sim:/processor/D_write_addr_2

mem load -filltype value -filldata 65535 -fillradix decimal /processor/memory_unit/ram(0)
mem load -filltype value -filldata 1 -fillradix decimal /processor/memory_unit/ram(1)
mem load -filltype value -filldata 2 -fillradix decimal /processor/memory_unit/ram(2)
mem load -filltype value -filldata 3 -fillradix decimal /processor/memory_unit/ram(3)
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
run

force -freeze sim:/processor/reset 0 0
run
run
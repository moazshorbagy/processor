vsim -gui work.processor
# vsim 
# Start time: 01:09:17 on May 06,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.processor(structural)
# Loading work.mux2(when_else_mux)
# Loading ieee.numeric_std(body)
# Loading work.address_module(address)
# Loading work.mux4(with_select_mux)
# Loading work.fallingreg(behavioral)
# Loading work.spreg(behavioral)
# Loading work.memory(memory_architecture)
# Loading work.fetchdecodebuffer(arch)
# Loading work.call_counter(count)
# Loading work.resolveinstr(dataflow)
# Loading work.regfile(structural)
# Loading work.decoder(dataflow)
# Loading work.reg(behavioral)
# Loading work.tristatebuffer(dataflow)
# Loading work.controlunit(cu)
# Loading work.decodeexbuffer(arch)
# Loading work.fallingreg1bit(behavioral)
# Loading work.forwardunit(arch)
# Loading work.alu(operations)
# Loading work.flags(flags_arch)
# Loading work.mux41bit(with_select_mux)
# Loading work.executemembuffer(arch)
# Loading work.memwbbuffer(arch)
# ** Warning: Design size of 13501 statements or 132 leaf instances exceeds ModelSim PE Student Edition recommended capacity.
# Expect performance to be quite adversely affected.
add wave -position insertpoint  \
sim:/processor/reset
add wave -position insertpoint  \
sim:/processor/in_port \
sim:/processor/interrupt
add wave -position insertpoint  \
sim:/processor/address
add wave -position insertpoint  \
sim:/processor/clk
add wave -position insertpoint  \
sim:/processor/out_port
add wave -position insertpoint  \
sim:/processor/register_file_unit/loop1(0)/rx/q
add wave -position insertpoint  \
sim:/processor/register_file_unit/loop1(1)/rx/q
add wave -position insertpoint  \
sim:/processor/register_file_unit/loop1(2)/rx/q
add wave -position insertpoint  \
sim:/processor/register_file_unit/loop1(3)/rx/q
add wave -position insertpoint  \
sim:/processor/register_file_unit/loop1(4)/rx/q
add wave -position insertpoint  \
sim:/processor/register_file_unit/loop1(5)/rx/q
add wave -position insertpoint  \
sim:/processor/register_file_unit/loop1(6)/rx/q
add wave -position insertpoint  \
sim:/processor/register_file_unit/loop1(7)/rx/q
mem load -i {E:/CUFE CHS Materials/Senior 1/Semester 8/Architecture/computer-architecture/test-cases/Branch.mem} /processor/memory_unit/ram

force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/clk 1 0, 0 {50 ns} -r 100
run
# ** Error: (vsim-86) Argument value -2147483648 is not in bounds of subtype NATURAL.
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Error: (vsim-86) Argument value -2147483648 is not in bounds of subtype NATURAL.
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Error: (vsim-86) Argument value -2147483648 is not in bounds of subtype NATURAL.
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/memory_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/memory_unit
# ** Error: (vsim-86) Argument value -2147483648 is not in bounds of subtype NATURAL.
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Error: (vsim-86) Argument value -2147483648 is not in bounds of subtype NATURAL.
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Error: (vsim-86) Argument value -2147483648 is not in bounds of subtype NATURAL.
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Error: (vsim-86) Argument value -2147483648 is not in bounds of subtype NATURAL.
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Error: (vsim-86) Argument value -2147483648 is not in bounds of subtype NATURAL.
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /processor/address_control_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 1  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 1  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 1  Instance: /processor/D_ALU_component
# ** Error: (vsim-86) Argument value -1 is not in bounds of subtype NATURAL.
#    Time: 0 ns  Iteration: 2  Instance: /processor/D_ALU_component
force -freeze sim:/processor/reset 0 0


add wave -position insertpoint  \
sim:/processor/E_C \
sim:/processor/E_N \
sim:/processor/E_Z

force -freeze sim:/processor/in_port 16'h0030 0
run
force -freeze sim:/processor/in_port 16'h0050 0
run
force -freeze sim:/processor/in_port 16'h0100 0
run
force -freeze sim:/processor/in_port 16'h0300 0
run
add wave -position insertpoint  \
sim:/processor/D_flags_component/z_rst
run
run
run
run
run
run
# ** Warning: NUMERIC_STD.TO_UNSIGNED: vector truncated
#    Time: 2650 ns  Iteration: 2  Instance: /processor/D_ALU_component
run
run
# ** Error: (vsim-86) Argument value -1 is not in bounds of subtype NATURAL.
#    Time: 2850 ns  Iteration: 2  Instance: /processor/D_ALU_component
run
run
force -freeze sim:/processor/in_port 16'h0200 0
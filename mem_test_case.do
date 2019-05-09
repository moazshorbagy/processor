vsim -gui work.processor
# vsim 
# Start time: 00:50:35 on May 01,2019
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
# ** Warning: Design size of 13315 statements or 128 leaf instances exceeds ModelSim PE Student Edition recommended capacity.
# Expect performance to be quite adversely affected.
add wave -position insertpoint  \
sim:/processor/reset \
sim:/processor/out_port \
sim:/processor/in_port \
sim:/processor/clk
force -freeze sim:/processor/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 1 0
mem load -filltype value -filldata 0011101000000000 -fillradix binary /processor/memory_unit/ram(0)
mem load -filltype value -filldata 0011101100000000 -fillradix binary /processor/memory_unit/ram(1)
mem load -filltype value -filldata 0011110000000000 -fillradix binary /processor/memory_unit/ram(2)
mem load -filltype value -filldata 1110000100000000 -fillradix binary /processor/memory_unit/ram(3)
mem load -filltype value -filldata 0000000000000101 -fillradix binary /processor/memory_unit/ram(4)
mem load -filltype value -filldata 1000000100000000 -fillradix binary /processor/memory_unit/ram(5)
mem load -filltype value -filldata 1000001000000000 -fillradix binary /processor/memory_unit/ram(6)
mem load -filltype value -filldata 1000100100000000 -fillradix binary /processor/memory_unit/ram(7)
mem load -filltype value -filldata 1000101000000000 -fillradix binary /processor/memory_unit/ram(8)
mem load -filltype value -filldata 1111001000000000 -fillradix binary /processor/memory_unit/ram(9)
mem load -filltype value -filldata 0000001000000000 -fillradix binary /processor/memory_unit/ram(10)
mem load -filltype value -filldata 1111000100000000 -fillradix binary /processor/memory_unit/ram(11)
mem load -filltype value -filldata 0000001000000001 -fillradix binary /processor/memory_unit/ram(12)
mem load -filltype value -filldata 1110101100000000 -fillradix binary /processor/memory_unit/ram(13)
mem load -filltype value -filldata 0000001000000001 -fillradix binary /processor/memory_unit/ram(14)
mem load -filltype value -filldata 1110110000000000 -fillradix binary /processor/memory_unit/ram(15)
mem load -filltype value -filldata 0000001000000000 -fillradix binary /processor/memory_unit/ram(16)
run
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
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/in_port 16'h19 0
run
# ** Error: (vsim-86) Argument value -1 is not in bounds of subtype NATURAL.
#    Time: 150 ns  Iteration: 3  Instance: /processor/D_ALU_component
force -freeze sim:/processor/in_port 16'hffff 0
run
force -freeze sim:/processor/in_port 16'hF320 0
run
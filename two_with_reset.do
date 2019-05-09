vsim -gui work.processor
# vsim 
# Start time: 00:52:56 on May 09,2019
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
# Loading work.nbitfulladder(theadder)
# Loading work.my_adder(a_my_adder)
# Loading work.flags(flags_arch)
# Loading work.mux41bit(with_select_mux)
# Loading work.executemembuffer(arch)
# Loading work.memwbbuffer(arch)
# ** Warning: Design size of 13989 statements or 151 leaf instances exceeds ModelSim PE Student Edition recommended capacity.
# Expect performance to be quite adversely affected.
add wave -position insertpoint  \
sim:/processor/address
add wave -position insertpoint  \
sim:/processor/E_C
add wave -position insertpoint  \
sim:/processor/E_N
add wave -position insertpoint  \
sim:/processor/E_Z
add wave -position insertpoint  \
sim:/processor/in_port
add wave -position insertpoint  \
sim:/processor/interrupt
add wave -position insertpoint  \
sim:/processor/clk
add wave -position insertpoint  \
sim:/processor/out_port
add wave -position insertpoint  \
sim:/processor/reset
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
force -freeze sim:/processor/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 1 0
mem load -i {E:/CUFE CHS Materials/Senior 1/Semester 8/Architecture/computer-architecture/test-cases/TwoOperand.mem} /processor/memory_unit/ram
run
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/in_port 16'h5 0
run
force -freeze sim:/processor/in_port 16'h0019 0
run
force -freeze sim:/processor/in_port 16'hffff 0
run
force -freeze sim:/processor/in_port 16'hF320 0
run
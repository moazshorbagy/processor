vsim -gui work.processor
# //  ModelSim PE Student Edition 10.4a Apr  7 2015 
# //
# //  Copyright 1991-2015 Mentor Graphics Corporation
# //  All Rights Reserved.
# //
# //  THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION
# //  WHICH IS THE PROPERTY OF MENTOR GRAPHICS CORPORATION OR ITS
# //  LICENSORS AND IS SUBJECT TO LICENSE TERMS.
# //  THIS DOCUMENT CONTAINS TRADE SECRETS AND COMMERCIAL OR FINANCIAL
# //  INFORMATION THAT ARE PRIVILEGED, CONFIDENTIAL, AND EXEMPT FROM
# //  DISCLOSURE UNDER THE FREEDOM OF INFORMATION ACT, 5 U.S.C. SECTION 552.
# //  FURTHERMORE, THIS INFORMATION IS PROHIBITED FROM DISCLOSURE UNDER
# //  THE TRADE SECRETS ACT, 18 U.S.C. SECTION 1905.
# //
# // NOT FOR CORPORATE OR PRODUCTION USE.
# // THE ModelSim PE Student Edition IS NOT A SUPPORTED PRODUCT.
# // FOR HIGHER EDUCATION PURPOSES ONLY
# //
# vsim -gui 
# Start time: 20:26:43 on May 08,2019
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
# ** Warning: Design size of 13940 statements or 151 leaf instances exceeds ModelSim PE Student Edition recommended capacity.
# Expect performance to be quite adversely affected.
mem load -i {E:/CUFE CHS Materials/Senior 1/Semester 8/Architecture/computer-architecture/test-cases/OneOperand.mem} /processor/memory_unit/ram
add wave -position insertpoint  \
sim:/processor/reset
add wave -position insertpoint  \
sim:/processor/out_port
add wave -position insertpoint  \
sim:/processor/interrupt
add wave -position insertpoint  \
sim:/processor/in_port
add wave -position insertpoint  \
sim:/processor/address
add wave -position insertpoint  \
sim:/processor/clk
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
run
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
#    Time: 0 ns  Iteration: 1  Instance: /processor/address_control_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 3  Instance: /processor/memory_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 3  Instance: /processor/memory_unit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 4  Instance: /processor/address_control_unit
force -freeze sim:/processor/reset 0 0
add wave -position insertpoint  \
sim:/processor/E_C
add wave -position insertpoint  \
sim:/processor/E_N
add wave -position insertpoint  \
sim:/processor/E_Z
run
run
run
run
run
force -freeze sim:/processor/in_port 16'h5 0
run
force -freeze sim:/processor/in_port 16'h0010 0
run
run
run
run
run
run
run
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 1450 ns  Iteration: 1  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 1450 ns  Iteration: 1  Instance: /processor/D_ALU_component
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 1550 ns  Iteration: 1  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 1550 ns  Iteration: 1  Instance: /processor/D_ALU_component
run
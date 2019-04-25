vsim -gui work.processor
# vsim 
# Start time: 12:32:34 on Apr 25,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.processor(structural)
# Loading ieee.numeric_std(body)
# Loading work.address_module(address)
# Loading work.mux2(when_else_mux)
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
# Loading work.decodeexbuffer(arch)
# Loading work.reg1bit(behavioral)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.alu(operations)
# Loading work.flags(flags_arch)
# Loading work.mux41bit(with_select_mux)
# ** Warning: Design size of 12917 statements or 82 leaf instances exceeds ModelSim PE Student Edition recommended capacity.
# Expect performance to be quite adversely affected.
add wave  \
sim:/processor/in_port \
sim:/processor/interrupt \
sim:/processor/reset \
sim:/processor/clk \
sim:/processor/out_port \
sim:/processor/address \
sim:/processor/F_pc_plus_one \
sim:/processor/write_data \
sim:/processor/mem_out \
sim:/processor/W32 \
sim:/processor/M_write_enable \
sim:/processor/stall_fetch \
sim:/processor/FAT \
sim:/processor/spen \
sim:/processor/D_pc_plus_one \
sim:/processor/D_eff_addr \
sim:/processor/D_port \
sim:/processor/D_mem_data \
sim:/processor/D_read_data_1 \
sim:/processor/D_read_data_2 \
sim:/processor/D_instr \
sim:/processor/D_op_code \
sim:/processor/D_shift_val \
sim:/processor/D_read_addr_1 \
sim:/processor/D_read_addr_2 \
sim:/processor/D_write_addr_1 \
sim:/processor/D_write_addr_2 \
sim:/processor/D_reg_addr \
sim:/processor/D_we_1 \
sim:/processor/D_we_2 \
sim:/processor/D_pc_plus_one_flags \
sim:/processor/E_port \
sim:/processor/E_read_data_1 \
sim:/processor/E_read_data_2 \
sim:/processor/E_read_addr_2 \
sim:/processor/E_reg_addr \
sim:/processor/E_eff_addr \
sim:/processor/E_pc_plus_one_flags \
sim:/processor/fetch_decode_buffer_enable \
sim:/processor/decode_execute_buffer_enable \
sim:/processor/id_ex_enable \
sim:/processor/ex_mem_enable \
sim:/processor/mem_wb_enable \
sim:/processor/flags_regs_enable \
sim:/processor/D_wb \
sim:/processor/D_mem_wr \
sim:/processor/D_setc \
sim:/processor/D_clc \
sim:/processor/D_zn \
sim:/processor/D_alu_op \
sim:/processor/D_reg_src \
sim:/processor/D_alu_src_2 \
sim:/processor/D_output_enable \
sim:/processor/D_reg_addr_src \
sim:/processor/D_res_sel \
sim:/processor/D_data_2_sel \
sim:/processor/D_stall_fetch \
sim:/processor/D_sp_en \
sim:/processor/D_sp_add \
sim:/processor/D_mem_addr_src \
sim:/processor/D_pc_src \
sim:/processor/D_call \
sim:/processor/D_ret \
sim:/processor/E_wb \
sim:/processor/E_mem_wr \
sim:/processor/E_setc \
sim:/processor/E_clc \
sim:/processor/E_zn \
sim:/processor/E_alu_op \
sim:/processor/E_reg_src \
sim:/processor/E_alu_src_2 \
sim:/processor/E_output_enable \
sim:/processor/E_reg_addr_src \
sim:/processor/E_res_sel \
sim:/processor/E_data_2_sel \
sim:/processor/E_stall_fetch \
sim:/processor/E_sp_en \
sim:/processor/E_sp_add \
sim:/processor/E_mem_addr_src \
sim:/processor/E_pc_src \
sim:/processor/E_call \
sim:/processor/E_ret \
sim:/processor/E_res \
sim:/processor/E_res2 \
sim:/processor/E_ALU_C \
sim:/processor/E_ALU_Z \
sim:/processor/E_ALU_N \
sim:/processor/E_N \
sim:/processor/E_Z \
sim:/processor/E_C \
sim:/processor/E_ALU_operand_2 \
sim:/processor/E_ALU_res \
sim:/processor/WB_write_addr_1 \
sim:/processor/WB_write_addr_2 \
sim:/processor/WB_write_data_1 \
sim:/processor/WB_write_data_2 \
sim:/processor/WB_we_1 \
sim:/processor/WB_we_2
force -freeze sim:/processor/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 1 0
run
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 0  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
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
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 1  Instance: /processor/D_ALU_component
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ns  Iteration: 1  Instance: /processor/D_ALU_component
# ** Warning: NUMERIC_STD.TO_UNSIGNED: vector truncated
#    Time: 0 ns  Iteration: 2  Instance: /processor/D_ALU_component

mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/memory_unit/ram(0)
mem load -filltype value -filldata {0000100000000000 } -fillradix binary /processor/memory_unit/ram(1)
mem load -filltype value -filldata {0001000000000000 } -fillradix binary /processor/memory_unit/ram(2)

mem load -filltype value -filldata {0001100000000000 } -fillradix binary /processor/memory_unit/ram(3)

mem load -filltype value -filldata {0010000100000000 } -fillradix binary /processor/memory_unit/ram(4)
mem load -filltype value -filldata {0010101000000000 } -fillradix binary /processor/memory_unit/ram(5)
mem load -filltype value -filldata {0011000100000000 } -fillradix binary /processor/memory_unit/ram(6)
mem load -filltype value -filldata {001111100000000 } -fillradix binary /processor/memory_unit/ram(7)


mem load -filltype value -filldata 1 -fillradix hexadecimal /processor/register_file_unit/reg_read_data(0)
mem load -filltype value -filldata 2 -fillradix hexadecimal /processor/register_file_unit/reg_read_data(1)
mem load -filltype value -filldata 1 -fillradix hexadecimal /processor/register_file_unit/reg_read_data(2)

run
force -freeze sim:/processor/reset 0 0
run

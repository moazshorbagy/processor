vsim -gui work.processor
# vsim -gui work.processor 
# Start time: 10:15:46 on Apr 26,2019
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
vsim -gui work.processor
# vsim 
# Start time: 00:23:48 on May 05,2019
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
# ** Warning: Design size of 13442 statements or 131 leaf instances exceeds ModelSim PE Student Edition recommended capacity.
# Expect performance to be quite adversely affected.
add wave -position insertpoint  \
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
sim:/processor/sp_en \
sim:/processor/D_pc_plus_one \
sim:/processor/D_eff_addr \
sim:/processor/D_port \
sim:/processor/D_mem_data \
sim:/processor/D_read_data_1 \
sim:/processor/D_read_data_2 \
sim:/processor/D_data_2 \
sim:/processor/D_instr \
sim:/processor/D_op_code \
sim:/processor/D_before_NOP_mux_op_code \
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
sim:/processor/Fwd_Mem_WB_1 \
sim:/processor/Fwd_Ex_Mem_1 \
sim:/processor/Fwd_Mem_WB_2 \
sim:/processor/Fwd_Ex_Mem_2 \
sim:/processor/HDU_LD_use \
sim:/processor/M_LD_use \
sim:/processor/WB_LD_use \
sim:/processor/fetch_decode_buffer_enable \
sim:/processor/decode_execute_buffer_enable \
sim:/processor/id_ex_enable \
sim:/processor/ex_mem_enable \
sim:/processor/mem_wb_enable \
sim:/processor/ex_mem_rst \
sim:/processor/decode_execute_buffer_reset \
sim:/processor/buffered_decode_exexute_buffer_reset \
sim:/processor/flags_regs_enable \
sim:/processor/D_wb \
sim:/processor/D_wb2 \
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
sim:/processor/D_opcode \
sim:/processor/D_first_data1 \
sim:/processor/D_final_data1 \
sim:/processor/D_first_data2 \
sim:/processor/D_final_data2 \
sim:/processor/D_final_data2_temp \
sim:/processor/E_wb \
sim:/processor/E_wb2 \
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
sim:/processor/E_opcode \
sim:/processor/E_Rsrc \
sim:/processor/M_wb \
sim:/processor/M_wb2 \
sim:/processor/M_mem_wr \
sim:/processor/M_reg_src \
sim:/processor/M_output_enable \
sim:/processor/M_reg_addr_src \
sim:/processor/M_res_sel \
sim:/processor/M_data_2_sel \
sim:/processor/M_stall_fetch \
sim:/processor/M_sp_en \
sim:/processor/M_sp_add \
sim:/processor/M_mem_addr_src \
sim:/processor/M_call \
sim:/processor/M_ret \
sim:/processor/M_res \
sim:/processor/M_res_muxed \
sim:/processor/M_res2 \
sim:/processor/M_read_addr_2 \
sim:/processor/M_reg_addr \
sim:/processor/M_eff_addr \
sim:/processor/M_pc_plus_one_flags \
sim:/processor/M_write_data \
sim:/processor/M_res_extended \
sim:/processor/temp_data1_extended \
sim:/processor/M_Opcode \
sim:/processor/WB_write_addr_1 \
sim:/processor/WB_write_addr_2 \
sim:/processor/WB_write_data_1 \
sim:/processor/WB_write_data_2 \
sim:/processor/WB_we_1 \
sim:/processor/WB_we_2 \
sim:/processor/WB_NOP \
sim:/processor/WB_reg_src \
sim:/processor/WB_output_enable \
sim:/processor/WB_res2 \
sim:/processor/WB_res \
sim:/processor/WB_reg_addr \
sim:/processor/WB_reg_addr2 \
sim:/processor/WB_memory_data

mem load -filltype value -filldata A000 -fillradix hexadecimal /processor/memory_unit/ram(0)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /processor/memory_unit/ram(1)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /processor/memory_unit/ram(2)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /processor/memory_unit/ram(3)

mem load -filltype value -filldata 0000 -fillradix hexadecimal /processor/memory_unit/ram(4)

mem load -filltype value -filldata 0000 -fillradix hexadecimal /processor/memory_unit/ram(5)

mem load -filltype value -filldata 0000 -fillradix hexadecimal /processor/memory_unit/ram(6)

mem load -filltype value -filldata A901 -fillradix hexadecimal /processor/memory_unit/ram(7)

mem load -filltype value -filldata 0000 -fillradix hexadecimal /processor/memory_unit/ram(8)
mem load -filltype value -filldata BA00 -fillradix hexadecimal /processor/memory_unit/ram(9)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /processor/memory_unit/ram(10)
mem load -filltype value -filldata C300 -fillradix hexadecimal /processor/memory_unit/ram(11)
mem load -filltype value -filldata 0000 -fillradix hexadecimal /processor/memory_unit/ram(12)


mem load -filltype value -filldata 0007 -fillradix hexadecimal /processor/register_file_unit/reg_read_data(0)
mem load -filltype value -filldata 0009 -fillradix hexadecimal /processor/register_file_unit/reg_read_data(1)
mem load -filltype value -filldata 000B -fillradix hexadecimal /processor/register_file_unit/reg_read_data(2)
mem load -filltype value -filldata 0005 -fillradix hexadecimal /processor/register_file_unit/reg_read_data(3)
force -freeze sim:/processor/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/ExecuteMemoryBuffer/enable 1 0
force -freeze sim:/processor/E_C 1 0
force -freeze sim:/processor/E_Z 1 0
force -freeze sim:/processor/E_N 1 0
run 
mem load -filltype value -filldata 0007 -fillradix hexadecimal /processor/register_file_unit/reg_read_data(0)
mem load -filltype value -filldata 0009 -fillradix hexadecimal /processor/register_file_unit/reg_read_data(1)
mem load -filltype value -filldata 000B -fillradix hexadecimal /processor/register_file_unit/reg_read_data(2)
mem load -filltype value -filldata 0005 -fillradix hexadecimal /processor/register_file_unit/reg_read_data(3)

force -freeze sim:/processor/reset 0 0
run

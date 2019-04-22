
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

--ALL REGISTERS ARE **Falling**

ENTITY MemWBBuffer IS
PORT(

--Input wires

	PC_plus1_prev,EA_prev:	IN std_logic_vector (19 downto 0);
	PC_src_prev,RET_prev,ZN_prev,setC_prev,clc_prev,mem_write_prev: IN std_logic;
	WB_prev, NOP_prev, spadd_prev, spen_prev : IN std_logic;	
	mem_addr_src_prev,res_sel_prev: IN std_logic_vector(1 downto 0);
	flags_prev,addr2_prev,reg_addr_prev,alu_op_prev: In std_logic_vector ( 2 downto 0);
	data1_prev,data2_prev,port_prev: IN std_logic_vector (15 downto 0);
	reg_src_prev,alu_src2_prev,out_enable_prev,call_prev: IN std_logic;

--Output wires
	PC_plus1_next,EA_next:	OUT std_logic_vector (19 downto 0);
	PC_src_next, RET_next,ZN_next,setC_next,clc_next,mem_write_next: OUT std_logic;
	WB_next, NOP_next, spadd_next, spen_next : OUT std_logic;	
	mem_addr_src_next,res_sel_next: OUT std_logic_vector(1 downto 0);
	flags_next,addr2_next,reg_addr_next,alu_op_next: OUT std_logic_vector ( 2 downto 0);
	data1_next,data2_next,port_next: OUT std_logic_vector (15 downto 0);
	reg_src_next,alu_src2_next,out_enable_next,call_next: OUT std_logic;

	clk, rst, enable : IN std_logic
);

END ENTITY;


ARCHITECTURE arch of MemWBBuffer  IS

COMPONENT fallingReg1Bit is

  port(
    clk, rst, enable: in std_logic;
    d: in std_logic;
    q: out std_logic
  );
end COMPONENT;

COMPONENT fallingReg is
generic(n: integer:=16);
  port(
    clk, rst, enable: in std_logic;
    d: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
  );
end COMPONENT;

BEGIN

PC_src_buffer : fallingReg1Bit  port map (clk, rst, enable, PC_src_prev, PC_src_next);
PC_plus1_buffer :fallingReg generic map (19)  port map (clk, rst, enable, PC_plus1_prev, PC_plus1_next);
EA_buffer : 	fallingReg generic map (19)  port map (clk, rst, enable, EA_prev, EA_next);
RET_buffer :    fallingReg1Bit  port map (clk, rst, enable, RET_prev, RET_next);
ZN_buffer : fallingReg1Bit  port map (clk, rst, enable, ZN_prev, ZN_next);
setc_buffer : fallingReg1Bit  port map (clk, rst, enable, setc_prev, setc_next);
clc_buffer : fallingReg1Bit  port map (clk, rst, enable, clc_prev, clc_next);
mem_write_buffer : fallingReg1Bit  port map (clk, rst, enable, mem_write_prev, mem_write_next);
WB_buffer : fallingReg1Bit  port map (clk, rst, enable, WB_prev, WB_next);
NOP_buffer : fallingReg1Bit  port map (clk, rst, enable, NOP_prev, NOP_next);
spadd_buffer : fallingReg1Bit  port map (clk, rst, enable, spadd_prev, spadd_next);
spen_buffer : fallingReg1Bit  port map (clk, rst, enable, spen_prev, spen_next);
mem_addr_src_buffer : fallingReg generic map (2)  port map (clk, rst, enable, mem_addr_src_prev, mem_addr_src_next);
res_sel_buffer : fallingReg generic map (2) port map (clk, rst, enable, res_sel_prev, res_sel_next);
flags_buffer : fallingReg generic map (3) port map (clk, rst, enable, flags_prev, flags_next);
addr2_buffer : fallingReg generic map (3) port map (clk, rst, enable, addr2_prev, addr2_next);
reg_addr_buffer : fallingReg generic map (3) port map (clk, rst, enable, reg_addr_prev, reg_addr_next);
alu_op_buffer : fallingReg generic map (3) port map (clk, rst, enable, alu_op_prev, alu_op_next);
data1_buffer : fallingReg generic map (16) port map (clk, rst, enable, data1_prev, data1_next);
data2_buffer : fallingReg generic map (16) port map (clk, rst, enable, data2_prev, data2_next);
reg_src_buffer : fallingReg1Bit  port map (clk, rst, enable, reg_src_prev, reg_src_next);
alu_src2_buffer : fallingReg1Bit  port map (clk, rst, enable, alu_src2_prev, alu_src2_next);
out_enable_buffer : fallingReg1Bit  port map (clk, rst, enable, out_enable_prev, out_enable_next);
call_buffer : fallingReg1Bit  port map (clk, rst, enable, call_prev, call_next);


END arch;
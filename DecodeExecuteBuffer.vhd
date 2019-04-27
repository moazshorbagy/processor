
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY DecodeExBuffer IS
PORT(
	PCSrc_prev, RET_prev, ZN_prev, setC_prev, clC_prev, MemW_prev, WB_prev, WB2_prev, stallFetch_prev, SPEn_prev, call_prev, regSrc_prev, ALUSrc2_prev, outEnable_prev : IN std_logic;
	PCSrc_next, RET_next, ZN_next, setC_next, clC_next, MemW_next, WB_next, WB2_next, stallFetch_next, SPEn_next, call_next, regSrc_next, ALUSrc2_next, outEnable_next : OUT std_logic;
	memAddrSrc_prev,  SPAdd_prev, resSel_prev : IN std_logic_vector (1 downto 0 );
	memAddrSrc_next,  SPAdd_next, resSel_next : OUT std_logic_vector (1 downto 0 );
	Data1_prev, Data2_prev, Port_prev : IN std_logic_vector (15 downto 0);
	Data1_next, Data2_next, Port_next : OUT std_logic_vector (15 downto 0);
	addr2_prev, RegAddr_prev, ALUOP_prev : IN std_logic_vector ( 2 downto 0);
	addr2_next, RegAddr_next, ALUOP_next : OUT std_logic_vector ( 2 downto 0);
	EA_prev : IN std_logic_vector ( 19 downto 0);
	EA_next : OUT std_logic_vector ( 19 downto 0);
	PC_flags_prev : IN std_logic_vector (31 downto 0);
	PC_flags_next : OUT std_logic_vector (31 downto 0);
	opCode_prev:	IN std_logic_vector (4 downto 0);
	opCode_next: 	Out std_logic_vector (4 downto 0);
	clk, rst, enable : IN std_logic
);

END ENTITY;


ARCHITECTURE arch of DecodeExBuffer  IS

COMPONENT fallingReg is
generic(n: integer:=16);
  port(
    clk, rst, enable: in std_logic;
    d: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
  );
end COMPONENT;

COMPONENT fallingReg1Bit is

  port(
    clk, rst, enable: in std_logic;
    d: in std_logic;
    q: out std_logic
  );
end COMPONENT;

BEGIN

PCSrc_reg : fallingReg1bit  port map (clk, rst, enable, PCSrc_prev, PCSrc_next);
RET_reg : fallingReg1bit  port map (clk, rst, enable, RET_prev, RET_next);
ZN_reg : fallingReg1bit  port map (clk, rst, enable, ZN_prev, ZN_next);
setC_reg : fallingReg1bit  port map (clk, rst, enable, setC_prev, setC_next);
clC_reg : fallingReg1bit  port map (clk, rst, enable, clC_prev, clC_next);
MemW_reg : fallingReg1bit  port map (clk, rst, enable, MemW_prev, MemW_next);
WB_reg : fallingReg1bit  port map (clk, rst, enable, WB_prev, WB_next);
WB2_reg : fallingReg1bit  port map (clk, rst, enable, WB2_prev, WB2_next);
stallFetch_reg : fallingReg1bit  port map (clk, rst, enable, stallFetch_prev, stallFetch_next);
SPEn_reg : fallingReg1bit  port map (clk, rst, enable, SPEn_prev, SPEn_next);
call_reg : fallingReg1bit  port map (clk, rst, enable, call_prev, call_next);
regSrc_reg : fallingReg1bit  port map (clk, rst, enable, regSrc_prev, regSrc_next);
ALUSrc2_reg : fallingReg1bit  port map (clk, rst, enable, ALUSrc2_prev, ALUSrc2_next);
outEnable_reg : fallingReg1bit  port map (clk, rst, enable, outEnable_prev, outEnable_next);

memAddrSrc_reg : fallingReg  generic map (2) port map (clk, rst, enable, memAddrSrc_prev, memAddrSrc_next);
SPAdd_reg : fallingReg  generic map (2) port map (clk, rst, enable, SPAdd_prev, SPAdd_next);
resSel_reg : fallingReg  generic map (2) port map (clk, rst, enable, resSel_prev, resSel_next);

Data1_reg : fallingReg  generic map (16) port map (clk, rst, enable, Data1_prev, Data1_next);
Data2_reg : fallingReg  generic map (16) port map (clk, rst, enable, Data2_prev, Data2_next);
Port_reg : fallingReg  generic map (16) port map (clk, rst, enable, Port_prev, Port_next);

addr2_reg : fallingReg  generic map (3) port map (clk, rst, enable, addr2_prev, addr2_next);
RegAddr_reg : fallingReg  generic map (3) port map (clk, rst, enable, RegAddr_prev, RegAddr_next);
ALUOP_reg : fallingReg  generic map (3) port map (clk, rst, enable, ALUOP_prev, ALUOP_next);

EA_reg : fallingReg  generic map (20) port map (clk, rst, enable, EA_prev, EA_next);

PC_flags_reg : fallingReg  generic map (32) port map (clk, rst, enable, PC_flags_prev, PC_flags_next);

OP_code_reg  : fallingReg  generic map (5) port map (clk, rst, enable, opcode_prev, opcode_next);

END arch;
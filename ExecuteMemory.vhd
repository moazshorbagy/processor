LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ExecuteMemBuffer IS
PORT(

	RET_prev, MemW_prev, WB_prev, WB2_prev, stallFetch_prev, SPEn_prev, call_prev, regSrc_prev, outEnable_prev : IN std_logic;
	RET_next, MemW_next, WB_next, WB2_next, stallFetch_next, SPEn_next, call_next, regSrc_next, outEnable_next : OUT std_logic;
	memAddrSrc_prev,  SPAdd_prev : IN std_logic_vector (1 downto 0 );
	memAddrSrc_next,  SPAdd_next : OUT std_logic_vector (1 downto 0 );
	res1_prev, res2_prev : IN std_logic_vector (15 downto 0);
	res1_next, res2_next : OUT std_logic_vector (15 downto 0);
	addr2_prev, RegAddr_prev : IN std_logic_vector ( 2 downto 0);
	addr2_next, RegAddr_next : OUT std_logic_vector ( 2 downto 0);
	EA_prev : IN std_logic_vector ( 19 downto 0);
	EA_next : OUT std_logic_vector ( 19 downto 0);
	PC_flags_prev : IN std_logic_vector (31 downto 0);	--PC+1 & flags
	PC_flags_next : OUT std_logic_vector (31 downto 0);
	opcode_prev   : In std_logic_vector (4 downto 0);
	opcode_next   : Out std_logic_vector (4 downto 0);
	LD_use_prev   : IN std_logic;
	LD_use_next   : OUT std_logic;
	clk, rst, enable : IN std_logic
);

END ENTITY;


ARCHITECTURE arch of ExecuteMemBuffer  IS

COMPONENT Reg is
generic(n: integer:=16);
  port(
    clk, rst, enable: in std_logic;
    d: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
  );
end COMPONENT;

COMPONENT Reg1Bit is

  port(
    clk, rst, enable: in std_logic;
    d: in std_logic;
    q: out std_logic
  );
end COMPONENT;

BEGIN

RET_reg : Reg1bit  port map (clk, rst, enable, RET_prev, RET_next);
MemW_reg : Reg1bit  port map (clk, rst, enable, MemW_prev, MemW_next);
WB_reg : Reg1bit  port map (clk, rst, enable, WB_prev, WB_next);
WB2_reg : Reg1bit  port map (clk, rst, enable, WB2_prev, WB2_next);
stallFetch_reg : Reg1bit  port map (clk, rst, enable, stallFetch_prev, stallFetch_next);
SPEn_reg : Reg1bit  port map (clk, rst, enable, SPEn_prev, SPEn_next);
call_reg : Reg1bit  port map (clk, rst, enable, call_prev, call_next);
regSrc_reg : Reg1bit  port map (clk, rst, enable, regSrc_prev, regSrc_next);
outEnable_reg : Reg1bit  port map (clk, rst, enable, outEnable_prev, outEnable_next);

memAddrSrc_reg : Reg  generic map (2) port map (clk, rst, enable, memAddrSrc_prev, memAddrSrc_next);
SPAdd_reg : Reg  generic map (2) port map (clk, rst, enable, SPAdd_prev, SPAdd_next);

res1_reg : Reg  generic map (16) port map (clk, rst, enable, res1_prev, res1_next);
res2_reg : Reg  generic map (16) port map (clk, rst, enable, res2_prev, res2_next);

addr2_reg : Reg  generic map (3) port map (clk, rst, enable, addr2_prev, addr2_next);
RegAddr_reg : Reg  generic map (3) port map (clk, rst, enable, RegAddr_prev, RegAddr_next);

EA_reg : Reg  generic map (20) port map (clk, rst, enable, EA_prev, EA_next);

PC_flags_reg : Reg  generic map (32) port map (clk, rst, enable, PC_flags_prev, PC_flags_next);

opcode_reg : Reg  generic map (5) port map (clk, rst, enable, opcode_prev, opcode_next);

LD_use_reg:  Reg1bit port map (clk, rst, enable, LD_use_prev, LD_use_next);



END arch;
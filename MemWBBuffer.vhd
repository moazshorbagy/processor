LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY MemWBBuffer IS
PORT(
	WB_prev, WB2_prev, NOP_prev, RegSrc_prev, outEnable_prev : IN std_logic;
	WB_next, WB2_next, NOP_next, RegSrc_next, outEnable_next : OUT std_logic;
	res2_prev, res_prev : IN std_logic_vector(15 downto 0);
	res2_next, res_next : OUT std_logic_vector(15 downto 0);
	RegAddr_prev, RegAddr2_prev : IN std_logic_vector ( 2 downto 0);
	RegAddr_next, RegAddr2_next : OUT std_logic_vector ( 2 downto 0);
	memory_out_prev : IN std_logic_vector (15 downto 0);
	memory_out_next : OUT std_logic_vector (15 downto 0);
	LD_use_prev:in std_logic;
	LD_use_next: out std_logic;
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

WB_buffer : fallingReg1Bit  port map (clk, rst, enable, WB_prev, WB_next);
WB2_buffer : fallingReg1Bit  port map (clk, rst, enable, WB2_prev, WB2_next);
NOP_buffer : fallingReg1Bit port map (clk, rst, enable, NOP_prev, NOP_next);
RegSrc_buffer : fallingReg1Bit port map (clk, rst, enable, RegSrc_prev, RegSrc_next);
outEnable_buffer : fallingReg1Bit port map (clk, rst, enable, outEnable_prev, outEnable_next);

res2_buffer : fallingReg generic map (16) port map (clk, rst, enable, res2_prev, res2_next);
res_buffer : fallingReg generic map (16) port map (clk, rst, enable, res_prev, res_next);
RegAddr_buffer : fallingReg generic map (3) port map (clk, rst, enable, RegAddr_prev, RegAddr_next);
RegAddr2_buffer : fallingReg generic map (3) port map (clk, rst, enable, RegAddr2_prev, RegAddr2_next);
LD_Use_buffer :   fallingReg1bit port map (clk, rst, enable, LD_Use_prev, LD_Use_next);

mem_buffer : fallingReg generic map (16) port map (clk, rst, enable, memory_out_prev, memory_out_next);

END arch;


Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Address_Module is
port(
	stall_fetch:in std_logic;				--Selector for mux before PC... to increment PC or to keep it as it is (stall)
	FAT:in std_logic;					--For FAT instructions (Multiplication) which will be used to increment pc by 2
	address: out std_logic_vector(19 downto 0);		--PC value or SP value or EA or SP+1..
	clk,rst: in std_logic;
	pc_plus_one: out std_logic_vector(19 downto 0)
);
end entity;

Architecture address of Address_module is

component  Reg is
generic(n: integer:=16);
  port(
    clk, rst, enable: in std_logic;
    d: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
  );
end component;

component Mux2 is
	generic (n: integer:=16);
	port (
    in_0, in_1: in std_logic_vector (n-1 downto 0);
    sel: in std_logic;
		out_1: out std_logic_vector (n-1 downto 0));
end component;

component Mux4 is 
generic (n : integer:=16);
port(
in0, in1, in2, in3: in std_logic_vector (n-1 downto 0);
sel : in  std_logic_vector (1 downto 0);
out1 : out std_logic_vector (n-1 downto 0));
end component;

signal mux_fat_op: std_logic_vector (1 downto 0);							--Output of mux that selects between PC +1 or +2
signal mux_stall_fetch_op: std_logic_vector (1 downto 0);						--Output of mux that selects between PC +1/+2 or +0 .
Signal added_to_PC: Integer;
signal PC: std_logic_vector (19 downto 0);								--Program counter
signal PC_after_add:std_logic_vector (19 downto 0);							--Program counter after incrementing it or not..
begin
--Combinational part (Adding + Muxes)..

mux_fat_sel: Mux2 generic map(2) port map ("01","10",FAT,mux_fat_op);					--Choosing to add 1 or 2 for the next PC value 
mux_stall_fetch_sel: Mux2 generic map (2) port map(mux_fat_op,"00",stall_fetch,mux_stall_fetch_op);	--Choosing between stall or PC increment	
added_to_pc<=to_integer(unsigned(mux_stall_fetch_op))+to_integer(unsigned(PC));
PC_after_add<=std_logic_vector(to_unsigned(added_to_pc,20));
address<=PC;

--Sequential part (Assigning to PC it's new value)
PC_register: Reg generic map(20) port map(clk,rst,'1',PC_after_add,PC);					--Setting the PC to its new value after the CLK
pc_plus_one <= PC_after_add;

end Architecture; 

Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity Address_Module is
port(
	stall_fetch:in std_logic;				--Selector for mux before PC... to increment PC or to keep it as it is (stall)
	FAT:in std_logic;					--For FAT instructions (Multiplication) which will be used to increment pc by 2

	clk,rst: in std_logic;
	
	--Iteration 2...
	spadd: in std_logic_vector(1 downto 0);
	EA: in std_logic_vector (19 downto 0);
	mem_addr_src: in std_logic_vector (1 downto 0);
	spen: in std_logic;
	pc_src:in std_logic;
	RET: in std_logic;
	memory_out: in std_logic_vector (19 downto 0);
	data1_extended: in std_logic_vector (19 downto 0);
	address: out std_logic_vector(19 downto 0)	;	--PC value or SP value or EA or SP+1..

	PC_plus_one : out std_logic_vector ( 19 downto 0)
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
component  FallingReg is
generic(n: integer:=16);
  port(
    clk, rst, enable: in std_logic;
    d: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
  );

end component;
component SPreg is
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

signal current_address:std_logic_vector (19 downto 0);							--Current address that will be accessed in memory
signal mux_fat_op,sel_pc_src_RET: std_logic_vector (1 downto 0);							--Output of mux that selects between PC +1 or +2
signal mux_stall_fetch_op: std_logic_vector (1 downto 0);						--Output of mux that selects between PC +1/+2 or +0 .
Signal added_to_PC,SP_plus1,SP_plus2,SP_minus1,SP_minus2: Integer;
signal PC,SP: std_logic_vector (19 downto 0);								--Program counter
signal PC_after_add,final_PC, f_pc,SP_after_add,SP_after_add1,SP_after_addm1,SP_after_add2,SP_after_addm2:std_logic_vector (19 downto 0);							--Program counter after incrementing it or not..
begin
--Combinational part (Adding + Muxes)..

sel_pc_src_RET<=RET&pc_src;
mux_fat_sel: Mux2 generic map(2) port map ("01","10",FAT,mux_fat_op);					--Choosing to add 1 or 2 for the next PC value 

mux_stall_fetch_sel: Mux2 generic map (2) port map(mux_fat_op,"00",stall_fetch,mux_stall_fetch_op);	--Choosing between stall or PC increment
added_to_pc<=to_integer(unsigned(mux_stall_fetch_op))+to_integer(unsigned(PC));
PC_after_add<=std_logic_vector(to_unsigned(added_to_pc,20));

PC_plus_one <= PC_after_add ;

SP_plus1<=to_integer(unsigned(SP)+1);
SP_after_add1<=std_logic_vector(to_unsigned(SP_plus1,20));

SP_minus1<=to_integer(unsigned(SP)-1);
SP_after_addm1<=std_logic_vector(to_unsigned(SP_minus1,20));

SP_plus2<=to_integer(unsigned(SP)+2);
SP_after_add2<=std_logic_vector(to_unsigned(SP_plus2,20));

SP_minus2<=to_integer(unsigned(SP)-2);
SP_after_addm2<=std_logic_vector(to_unsigned(SP_minus2,20));


mux_address_select: Mux4 generic map(20) port map (PC,SP,EA,SP_after_add1,mem_addr_src,address);
mux_SP_select: Mux4 generic map(20) port map (SP_after_addm1,SP_after_add1,SP_after_addm2,SP_after_add2,spadd,SP_after_add);

mux_pc_src_RET_select: Mux4 generic map (20) port map (PC_after_add,data1_extended,memory_out,"00000000000000000000",sel_pc_src_RET,final_PC);

f_pc <= memory_out when rst = '1'
	else final_pc;

PC_register: fallingReg generic map(20) port map(clk,'0','1',f_pc,PC);					--Setting the PC to its new value after the CLK
SP_register: SPreg generic map(20) port map(clk,rst,spen,SP_after_add,SP);

end Architecture; 
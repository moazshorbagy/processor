library ieee;
use ieee.std_logic_1164.all;

ENTITY flags is 

PORT(
	-- ALUC, ALUZ, ALUN : flags coming from the ALU
	-- setC, clC, ZN : signals coming from the control unit
	-- C, Z, N : Output flags
	ALUC, ALUZ, ALUN, setC, clC, ZN, clk, rst: IN std_logic;
	C, Z, N : OUT std_logic
);


END ENTITY;

ARCHITECTURE flags_arch OF flags IS

COMPONENT fallingReg is
generic(n: integer:=16);
  port(
    clk, rst, enable: in std_logic;
    d: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
  );
end COMPONENT;



COMPONENT mux41bit is 

port(
in0, in1, in2, in3: in std_logic;
sel : in  std_logic_vector (1 downto 0);
out1 : out std_logic );
end COMPONENT;

COMPONENT Mux2 is
	generic (n: integer:=16);
	port (
   	 in_0, in_1: in std_logic_vector (n-1 downto 0);
   	 sel: in std_logic;
		out_1: out std_logic_vector (n-1 downto 0));
end COMPONENT;

-- The input to the register
signal C_in, Z_in, N_in : std_logic;
signal flag_reg_output, flag_reg_input : std_logic_vector (3 downto 0);
signal C_input_mux_sel : std_logic_vector (1 downto 0);
signal temp1, temp2 , temp3, temp4 : std_logic;

BEGIN

-- Evaluate the flags
C_input_mux_sel <= setC & clC; 
C_input_mux : Mux41bit port map ( temp1,'0','1',ALUC,C_input_mux_sel,C_in);

N_in <= temp2 when ZN = '0'
	else ALUN;

Z_in <= temp3 when ZN = '0'
	else ALUZ;

-- Concatenate the input flags
flag_reg_input <= '0' & C_in & N_in & Z_in;

-- Assign the output flags
C <= flag_reg_output(2);
N <= flag_reg_output(1);
Z <= flag_reg_output(0);

temp1 <= flag_reg_output(2);
temp2 <= flag_reg_output(1);
temp3 <= flag_reg_output(0);

flags_reg : fallingReg generic map (4) port map (clk, rst, '1', flag_reg_input ,flag_reg_output);

END flags_arch;
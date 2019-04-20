
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity mux41bit is 

port(
in0, in1, in2, in3: in std_logic;
sel : in  std_logic_vector (1 downto 0);
out1 : out std_logic );
end entity;


ARCHITECTURE when_else_mux OF mux41bit is
BEGIN
		
  out1 <= 	in0 when sel = "00"
	else	in1 when sel = "01"
	else	in2 when sel = "10"
	else 	in3; 
END when_else_mux;


ARCHITECTURE with_select_mux OF mux41bit is
BEGIN
		
with Sel select
	out1 <= in0 when "00",
		in1 when "01",
		in2 when "10",
		in3 when others;
END with_select_mux;

 --SIGNAL bus : bit_vector(0 TO 7) := (4=>'1', OTHERS=>'0');  -- default value 
		-- of "bus" is B"0000_1000"
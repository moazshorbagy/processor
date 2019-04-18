Library ieee;
use ieee.std_logic_1164.all;

entity Mux2 is
	generic (n: integer:=16);
	port (
    in_0, in_1: in std_logic_vector (n-1 downto 0);
    sel: in std_logic;
		out_1: out std_logic_vector (n-1 downto 0));
end entity;

architecture when_else_mux of Mux2 is
begin
  out_1 <= 	in_0 when sel = '0'
	else in_1;
end architecture;

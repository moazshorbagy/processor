
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.Numeric_std.all;
ENTITY counter_proj IS
generic (n:integer:=3);
	PORT( clk : IN std_logic;
		en:in std_logic;
		rst:in std_logic;
		  z : OUT std_logic_vector(n-1 downto 0));
END counter_proj;


ARCHITECTURE count OF counter_proj IS

	signal counting: std_logic_vector(n-1 downto 0);

BEGIN

process(clk)
Begin 
if (rst='1') then 
counting<="000";
z<="000";
else
	if (clk'event and clk='1' and en='1') then
		counting<="100";

	elsif (clk'event and clk='1' and (counting /="000")) then

		counting<=std_logic_vector(unsigned(counting)-1);
		z<=std_logic_vector(unsigned(counting)-1);
end if;
end if;
end process;
END count;
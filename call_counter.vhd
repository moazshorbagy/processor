LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.Numeric_std.all;

ENTITY call_counter IS

	PORT( clk : IN std_logic;
		en:in std_logic;
		rst:in std_logic;
		  z : OUT std_logic_vector(1 downto 0));
END call_counter;


ARCHITECTURE count OF call_counter IS

	signal counting: std_logic_vector(1 downto 0);

BEGIN

process(clk)
Begin 
if (rst='1') then 
counting<="00";
z<="00";
else
	if (clk'event and clk='1' and en='1') then
		counting<="11";

	elsif (clk'event and clk='1' and (counting /= "00")) then

		counting<=std_logic_vector(unsigned(counting)-1);
		z<=std_logic_vector(unsigned(counting)-1);
end if;
end if;
end process;
END count;
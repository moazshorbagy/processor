LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;



ENTITY memory IS
	
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		w32 : IN std_logic;
		address : IN  std_logic_vector(20 DOWNTO 0);
		datain  : IN  std_logic_vector(31 DOWNTO 0);
		dataout : OUT std_logic_vector(31 DOWNTO 0));
END ENTITY memory;

ARCHITECTURE memory_architecture OF memory IS

	TYPE ram_type IS ARRAY(0 TO (2**20)-1) OF std_logic_vector(15 DOWNTO 0);
	SIGNAL ram : ram_type ;
	SIGNAL data1, data2 : std_logic_vector(15 downto 0);
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF we = '1' THEN
						IF w32 = '1' THEN
							ram(to_integer(unsigned(address))) <= datain ( 31 downto 16);
							ram(to_integer(unsigned(address)+1)) <= datain ( 15 downto 0);
						ELSE
							ram(to_integer(unsigned(address))) <= datain ( 15 downto 0);
						END IF;
					END IF;
				END IF;
			data1 <= ram(to_integer(unsigned(address)));
			data2 <= ram(to_integer(unsigned(address)+1));
			dataout <= data1 & data2;
		END PROCESS;
		
END memory_architecture;

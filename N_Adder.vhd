Library ieee;
use ieee.std_logic_1164.all;
entity my_adder is 
PORT (a,b,cin : IN  std_logic;
	sum: out std_logic; 
 	cout : OUT std_logic );
END my_adder;

ARCHITECTURE a_my_adder OF my_adder IS
	BEGIN
		
		sum <= a XOR b XOR cin;
		cout <= (a AND b) OR (cin AND (a XOR b));
		
END a_my_adder;
Library ieee;
use ieee.std_logic_1164.all;
entity nbitfulladder is
generic (n: integer :=16);
port (a,b: in std_logic_vector (n-1 downto 0);
	sum: out std_logic_vector(n-1 downto 0);
	cin: in std_logic ;
	cout: out std_logic);
end entity;
architecture theAdder of nbitfulladder is
 component my_adder is
port (a,b,cin:in std_logic;
       sum,cout: out std_logic);
end component;

signal coutwires: std_logic_vector (n downto 0);
signal sumwires:std_logic_vector (n-1 downto 0);
begin
coutwires(0)<=cin;
loop1:for i in 0 to n-1 generate
Fx: my_adder port map(a(i),b(i),coutwires(i),sumwires(i),coutwires(i+1));
end generate;
sum<=sumwires;
cout<=coutwires(n);
end architecture;
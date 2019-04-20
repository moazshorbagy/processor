Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ALU is
generic (m: integer:=16);   		   		--Made it generic incase we changed something in design
port (Data1,Data2:in std_logic_vector(m-1 downto 0);	--Based on ALU_OP we might not use both of the data in ports	
alu_op:in std_logic_vector(2 downto 0);			--8 Operations
Res1,Res2: out std_logic_vector (m-1 downto 0); 	--Res2 is only used for multiplication, else it will be set to don't care
C,N,Z:out std_logic);					--Carry, Negative,Zero
end entity;

Architecture Operations of ALU is 

signal add_out:std_logic_vector 	(m downto 0);
signal sub_out:std_logic_vector 	(m downto 0);
signal cout: std_logic;
signal not_data2:std_logic_vector(m-1 downto 0);
signal zeros16:std_logic_vector (m-1 downto 0);
Signal result1:std_logic_vector (m-1 downto 0);
Signal result2:std_logic_vector (m-1 downto 0);
Signal mult:Std_Logic_vector 	(2*m-1 downto 0);

begin 


zeros16<=(others=>'0');
not_data2 <= std_logic_vector(to_unsigned(to_integer(unsigned(not data2))+1,m));

add_out<=('0'&data1)+('0'&data2);
sub_out<=('0'&data1)-('0'&data2);
mult<=data1*data2;

res1<=(Not data1) when (alu_op="000")
else (add_out(15 downto 0)) when (alu_op="001")
else (sub_out(15 downto 0)) when (alu_op="010")
else (data1 AND data2) when (alu_op="011")
else (data1 OR data2) when (alu_op="100")
else (data1(m-1-to_integer(unsigned(data2)) downto 0) & zeros16(to_integer(unsigned(data2))-1 downto 0)) when (alu_op="101") --SHL
else (zeros16(m-1 downto m-1-to_integer(unsigned(data2))+1)&data1(m-1 downto to_integer(unsigned(data2)))) when (alu_op="110")	--SHR
else (mult(m-1 downto 0)) when (alu_op="111");


result1<=(Not data1) when (alu_op="000")
else (add_out(15 downto 0)) when (alu_op="001")
else (sub_out(15 downto 0)) when (alu_op="010")
else (data1 AND data2) when (alu_op="011")
else (data1 OR data2) when (alu_op="100")
else (data1(m-1-to_integer(unsigned(data2)) downto 0) & zeros16(to_integer(unsigned(data2))-1 downto 0)) when (alu_op="101") --SHL
else (zeros16(m-1 downto m-1-to_integer(unsigned(data2))+1)&data1(m-1 downto to_integer(unsigned(data2)))) when (alu_op="110")	--SHR
else (mult(m-1 downto 0)) when (alu_op="111");

res2<=mult(2*m-1 downto m) when (alu_op="111")
else (others=>'0');

result2<=mult(2*m-1 downto m) when (alu_op="111")
else (others=>'0');

C <= add_out(m) when (alu_op="001")
else sub_out(m) when (alu_op="010")
else data1(m-1-to_integer(unsigned(data2))-1) when (alu_op="101")
else data1(to_integer(unsigned(data2))-1) when (alu_op="110")
else '0';

Z<='1' when ((result1="0000000000000000") AND ((alu_op="000")OR(alu_op="001") OR (alu_op="010")OR (alu_op="011")OR(alu_op="100")OR (alu_op="101")OR (alu_op="110")))OR ((result1="0000000000000000")AND (result2="0000000000000000")AND (alu_op=111))
else '0';

N<='1' when (result1(m-1)='1') AND ((alu_op="000") OR (alu_op="001") OR (alu_op="010")OR (alu_op="011")OR(alu_op="100")OR (alu_op="101")OR (alu_op="110"))
else '1' when (result2(m-1)='1')And (alu_op="111")
else '0';
end Architecture; 
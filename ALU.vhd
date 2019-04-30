Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

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
Signal sum_Int,sub_Int,shAmt,data1_Int,data2_Int,mult_Int:Integer;
begin 

mult_Int<=to_integer(unsigned(data1))*to_integer(unsigned(data2));
not_data2 <= std_logic_vector(to_unsigned(to_integer(unsigned(not data2))+1,m));
sum_Int<=to_integer(unsigned(data1))+to_integer(unsigned(data2));
sub_Int<=to_integer(unsigned(data1))-to_integer(unsigned(data2));
add_out<=std_logic_vector(to_unsigned(sum_Int,17));
sub_out<=std_logic_vector(to_unsigned(sub_Int,17));

mult<=std_logic_vector(to_unsigned(mult_Int,32));

res1<=(Not data1) when (alu_op="000")
else (add_out(15 downto 0)) when (alu_op="001")
else (sub_out(15 downto 0)) when (alu_op="010")
else (data1 AND data2) when (alu_op="011")
else (data1 OR data2) when (alu_op="100")
else (std_logic_vector(unsigned(data1) SLL  to_integer(unsigned(data2(3 downto 0)))) ) when (alu_op="101")
else (std_logic_vector(unsigned(data1) SRL  to_integer(unsigned(data2(3 downto 0)))) ) when (alu_op="110")
else (mult(2*m-1 downto m)) when (alu_op="111");


result1<=(Not data1) when (alu_op="000")
else (add_out(15 downto 0)) when (alu_op="001")
else (sub_out(15 downto 0)) when (alu_op="010")
else (data1 AND data2) when (alu_op="011")
else (data1 OR data2) when (alu_op="100")
else (std_logic_vector(unsigned(data1) SLL  to_integer(unsigned(data2(3 downto 0)))) ) when (alu_op="101")	--SHL
else (std_logic_vector(unsigned(data1) SRL  to_integer(unsigned(data2(3 downto 0)))) ) when (alu_op="110")	--SHR
else (mult(2*m-1 downto m)) when (alu_op="111");

res2<=mult(m-1 downto 0) when (alu_op="111")
else (others=>'0');

result2<=mult(m-1 downto 0) when (alu_op="111")
else (others=>'0');

C <= add_out(m) when (alu_op="001")
else sub_out(m) when (alu_op="010")
else data1(16-to_integer(unsigned(data2(3 downto 0)))) when (alu_op="101" AND to_integer(unsigned(data2(3 downto 0)))/=0)
else data1(to_integer(unsigned(data2(3 downto 0)))-1) when (alu_op="110" AND to_integer(unsigned(data2(3 downto 0)))/=0)
else '0';

Z<='1' when ((result1="0000000000000000") AND ((alu_op="000")OR(alu_op="001") OR (alu_op="010")OR (alu_op="011")OR(alu_op="100")OR (alu_op="101")OR (alu_op="110")))OR ((result1="0000000000000000")AND (result2="0000000000000000")AND (alu_op="111"))
else '0';

N<='1' when (result1(m-1)='1') AND ((alu_op="000") OR (alu_op="001") OR (alu_op="010")OR (alu_op="011")OR(alu_op="100")OR (alu_op="101")OR (alu_op="110") OR (alu_op="111"))
--else '1' when (result2(m-1)='1')And (alu_op="111")
else '0';
end Architecture; 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.Numeric_std.all;
Entity TB_ALU is 

end entity;
architecture ProjTB of TB_ALU is
component ALU is 

generic (m: integer:=16);   		   		--Made it generic incase we changed something in design
port (Data1,Data2:in std_logic_vector(m-1 downto 0);	--Based on ALU_OP we might not use both of the data in ports	
ALU_OP:in std_logic_vector(2 downto 0);			--8 Operations
Res1,Res2: out std_logic_vector (m-1 downto 0); 	--Res2 is only used for multiplication, else it will be set to don't care
C,N,Z:out std_logic);					--Carry, Negative,Zero
END component;

--signal clk: std_logic;
signal DataIn1,DataIn2:std_logic_vector(15 downto 0);
Signal AluOp:std_logic_vector (2 downto 0);
signal DataOut1,DataOut2:std_logic_vector(15 downto 0);
signal Cout,Zout,Nout:std_logic;
begin
testing: ALU port map (DataIn1,DataIn2,AluOp,DataOut1,DataOut2,Cout,Nout,Zout);
process
begin
wait for 10 ns;
DataIn1<="0000000011111010";
DataIn2<="0000000000010010";
AluOp<="000";
wait for 20 ns;
AluOp<="001";
wait for 20 ns;
AluOp<="010";
wait;
end process;
end architecture;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity AddressControlTB is 
end entity;
architecture TB of AddressControlTB is
component Address_Module is
port(
	stall_fetch:in std_logic;				--Selector for mux before PC... to increment PC or to keep it as it is (stall)
	FAT:in std_logic;					--For FAT instructions (Multiplication) which will be used to increment pc by 2
	address: out std_logic_vector(19 downto 0);		--PC value or SP value or EA or SP+1..
	clk,rst: in std_logic
);
end component;

signal clk_sig,test_rst,test_stall_fetch,test_fat: std_logic;
signal test_addr:std_logic_vector(19 downto 0);

begin

testing: Address_Module port map(test_stall_fetch,test_fat,test_addr,clk_sig,test_rst);

process
begin
clk_sig<='1';
wait for 5 ns;
clk_sig<='0';
wait for 5 ns;
end process;

process
begin 
test_stall_fetch<='0';
test_fat<='0';test_rst<='1';
wait for 10 ns;
wait for 10 ns;
test_rst<='0';
assert(test_addr="00000000000000000000") report "PC didn't start with zero" Severity Error;
wait for 10 ns;
assert(test_addr="00000000000000000001") report "Failed to increment PC to 1" Severity Error;
wait for 10 ns;
assert(test_addr="00000000000000000010") report "Failed to increment PC to 2" Severity Error;
wait for 10 ns;
test_stall_fetch<='1';
wait for 10 ns;
assert(test_addr="00000000000000000011") report "Failed to increment PC to 3" Severity Error;
wait for 10 ns;
assert(test_addr="00000000000000000011") report "PC shouldn't be incremented now" Severity Error;
wait for 10 ns;
assert(test_addr="00000000000000000011") report "PC shouldn't be incremented now" Severity Error;
test_fat<='1';
wait for 10 ns;
assert(test_addr="00000000000000000011") report "PC shouldn't be incremented now" Severity Error;
test_stall_fetch<='0';
wait for 10 ns;
assert(test_addr="00000000000000000101") report "Failed to increment PC to 5" Severity Error;

wait;
end process;
end architecture;

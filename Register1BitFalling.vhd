
library ieee;
use ieee.std_logic_1164.all;

entity fallingReg1Bit is

  port(
    clk, rst, enable: in std_logic;
    d: in std_logic;
    q: out std_logic
  );
end entity;

architecture behavioral of fallingReg1Bit is begin
  process(clk, rst) begin
    if rst = '1' then
      q <= '0';
    elsif (enable = '1' and rising_edge(clk)) then
      q <= d;
    end if;
  end process;
end architecture;

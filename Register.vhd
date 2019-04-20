library ieee;
use ieee.std_logic_1164.all;

entity Reg is
generic(n: integer:=16);
  port(
    clk, rst, enable: in std_logic;
    d: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
  );
end entity;

architecture behavioral of Reg is begin
  process(clk, rst) begin
    if rst = '1' then
      q <= (others=>'0');
    elsif (enable = '1' and rising_edge(clk)) then
      q <= d;
    end if;
  end process;
end architecture;

-- A7a
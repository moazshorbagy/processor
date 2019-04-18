library ieee;
use ieee.std_logic_1164.all;

entity TriStateBuffer is
  generic(n: integer:=16);
  port(
    enable: in std_logic;
    d: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
  );
end entity;

architecture dataflow of TriStateBuffer is begin
  q <= d when enable = '1'
  else (others=>'Z');
end architecture;



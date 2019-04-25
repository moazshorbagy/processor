library ieee;
use ieee.std_logic_1164.all;

entity ResolveInstr is
  port(
    instr: in std_logic_vector(31 downto 0);
    op_code: out std_logic_vector(4 downto 0);
    addr_1: out std_logic_vector(2 downto 0);
    addr_2: out std_logic_vector(2 downto 0);
    mem_data: out std_logic_vector(15 downto 0); 
    eff_addr: out std_logic_vector(19 downto 0);
    shift_val: out std_logic_vector(15 downto 0)
  );
end entity;

architecture dataflow of ResolveInstr is
begin
  op_code <= instr(31 downto 27);
  addr_1 <= instr(26 downto 24);
  addr_2 <= instr(23 downto 21);
  mem_data <= instr(31 downto 16);
  eff_addr <= instr(23 downto 20)&instr(15 downto 0);
  shift_val <= ("000000000000")&instr(23 downto 20);
end architecture;

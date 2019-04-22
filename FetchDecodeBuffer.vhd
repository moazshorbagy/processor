LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FetchDecodeBuffer IS
PORT(
	pc_plus_one_prev : IN std_logic_vector (19 downto 0);
	pc_plus_one_next : OUT std_logic_vector (19 downto 0);
	port_prev : IN std_logic_vector (15 downto 0);
	port_next : OUT std_logic_vector (15 downto 0);
	instr_prev : IN std_logic_vector (  31 downto 0); 
	instr_next : OUT std_logic_vector (  31 downto 0); 
	clk, rst, enable : IN std_logic
);

END ENTITY;


ARCHITECTURE arch of FetchDecodeBuffer IS

COMPONENT fallingReg is
generic(n: integer:=16);
  port(
    clk, rst, enable: in std_logic;
    d: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
  );
end COMPONENT;

BEGIN

instr_buffer : fallingReg generic map (32) port map (clk, rst, enable, instr_prev, instr_next);

pc_plus_one_buffer : fallingReg generic map (20) port map (clk, rst, enable, pc_plus_one_prev, pc_plus_one_next);

port_buffer : fallingReg generic map (16) port map (clk, rst, enable, port_prev, port_next);

END arch;
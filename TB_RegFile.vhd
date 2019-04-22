library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_RegFile is
end entity;

architecture testbench of TB_RegFile is
  
  component RegFile is
  generic(n: integer:=16);
    port(
      clk, rst: in std_logic;
      write_addr_1, write_addr_2: in std_logic_vector(2 downto 0);
      write_data_1, write_data_2: in std_logic_vector(n-1 downto 0);
      we_1, we_2: in std_logic;
      read_addr_1, read_addr_2: in std_logic_vector(2 downto 0);
      read_data_1, read_data_2: out std_logic_vector(n-1 downto 0)
    );
  end component;
  
  signal clk, rst, we_1, we_2: std_logic;
  signal read_addr_1, read_addr_2, write_addr_1, write_addr_2: std_logic_vector(2 downto 0);
  signal read_data_1, read_data_2, write_data_1, write_data_2: std_logic_vector(15 downto 0);
  
begin
  
    reg_file_unit: RegFile generic map(16) port map(clk, rst, write_addr_1, write_addr_2, write_data_1, write_data_2, we_1, we_2, read_addr_1, read_addr_2, read_data_1, read_data_2);
    
    process begin
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
    end process;
    
    process begin
      --wait for 2 ns;
      
      rst <= '1';
      wait for 20 ns;
      
      rst <= '0';
      
      we_1 <= '1';
      we_1 <= '0';
      
      read_addr_1 <= "010";
      read_addr_2 <= "110";
      write_addr_1 <= "010";
      write_addr_2 <= "110";
      write_data_1 <= "1100110011001100";
      write_data_2 <= "0101010101010101";
      wait for 20 ns;

      we_1 <= '0';

      assert (read_data_1 = "1100110011001100")
      report "Value read from R(010) is incorrect"
      severity error;

      assert (read_data_2 = "0000000000000000")
      report "Value is written to R(110) while we_1 was 0"
      severity error;
            
      wait;
      
    end process;
  
end architecture;

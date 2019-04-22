library ieee;
use ieee.std_logic_1164.all;

entity RegFile is
generic(n: integer:=16);
  port(
    clk, rst: in std_logic;
    write_addr_1, write_addr_2: in std_logic_vector(2 downto 0);
    write_data_1, write_data_2: in std_logic_vector(n-1 downto 0);
    we_1, we_2: in std_logic;
    read_addr_1, read_addr_2: in std_logic_vector(2 downto 0);
    read_data_1, read_data_2: out std_logic_vector(n-1 downto 0)
  );
end entity;

architecture structural of RegFile is

-- including components --

  component Reg is
  generic(n: integer:=16);
    port(
      clk, rst, enable: in std_logic;
      d: in std_logic_vector(n-1 downto 0);
      q: out std_logic_vector(n-1 downto 0)
    );
  end component;

  component decoder is
    port(
      enable: in std_logic;
      sel: in std_logic_vector(2 downto 0);
      o: out std_logic_vector(7 downto 0)
    );
  end component;

  component Mux2 is
    generic (n: integer:=16);
    port (
      in_0, in_1: in std_logic_vector (n-1 downto 0);
      sel : in  std_logic;
      out_1 : out std_logic_vector (n-1 downto 0));
  end component;

  component TriStateBuffer is
    generic(n: integer:=16);
    port(
      enable: in std_logic;
      d: in std_logic_vector(n-1 downto 0);
      q: out std_logic_vector(n-1 downto 0)
    );
  end component;

  signal write_dec_1_out, write_dec_2_out, read_dec_1_out, read_dec_2_out: std_logic_vector(7 downto 0);
  signal reg_write_enable, mux_sel, reg_enable: std_logic_vector(7 downto 0);

  type array_type is array(7 downto 0) of std_logic_vector (n-1 downto 0);
  signal reg_write_data, reg_read_data: array_type;

-- begin architecture --

begin
  
  write_dec_1: Decoder port map (we_1, write_addr_1, write_dec_1_out);
  write_dec_2: Decoder port map (we_2, write_addr_2, write_dec_2_out);
    
  read_dec_1: Decoder port map ('1', read_addr_1, read_dec_1_out);
  read_dec_2: Decoder port map ('1', read_addr_2, read_dec_2_out);
  
  loop1: for i in 0 to 7 generate
    reg_write_enable(i) <= write_dec_1_out(i) or write_dec_2_out(i);
    mux_sel(i) <= (write_dec_2_out(i) or (not write_dec_1_out(i)));
    mx: Mux2 generic map (n) port map (write_data_1, write_data_2, mux_sel(i), reg_write_data(i));
    reg_enable(i) <= (write_dec_1_out(i) or write_dec_2_out(i));
    rx: Reg generic map (n) port map (clk, rst, reg_enable(i), reg_write_data(i), reg_read_data(i));
    tsb1: TriStateBuffer generic map (n) port map (read_dec_1_out(i), reg_read_data(i), read_data_1);
    tsb2: TriStateBuffer generic map (n) port map (read_dec_2_out(i), reg_read_data(i), read_data_2);
  end generate;
  
end architecture;

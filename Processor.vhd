library ieee;
use ieee.std_logic_1164.all;

entity Processor is
  port(
    in_port: in std_logic_vector(15 downto 0);
    interrupt: in std_logic;
    reset, clk: in std_logic;
    out_port: out std_logic_vector(15 downto 0)
  );
end entity;

architecture structural of Processor is
  
-- components declaration --

  component memory is
    port(
      clk : IN std_logic;
		  we  : IN std_logic;
		  w32 : IN std_logic;
		  address : IN  std_logic_vector(19 DOWNTO 0);
		  datain  : IN  std_logic_vector(31 DOWNTO 0);
		  dataout : OUT std_logic_vector(31 DOWNTO 0)
		  );
  end component memory;
  
  component Address_Module is
    port(
      stall_fetch: in std_logic;				--Selector for mux before PC... to increment PC or to keep it as it is (stall)
      FAT: in std_logic;					--For FAT instructions (Multiplication) which will be used to increment pc by 2
      address: out std_logic_vector(19 downto 0);		--PC value or SP value or EA or SP+1..
      clk, rst: in std_logic;
      pc_plus_one: out std_logic_vector(19 downto 0)
    );
  end component;
  
  component ResolveInstr is
    port(
      instr: in std_logic_vector(31 downto 0);
      op_code: out std_logic_vector(4 downto 0);
      addr_1: out std_logic_vector(2 downto 0);
      addr_2: out std_logic_vector(2 downto 0);
      mem_data: out std_logic_vector(15 downto 0); 
      eff_addr: out std_logic_vector(19 downto 0);
      shift_val: out std_logic_vector(3 downto 0)
    );
  end component;

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
  
  -- buffers --
  
  component FetchDecodeBuffer IS
    PORT(
      pc_plus_one_prev : IN std_logic_vector (19 downto 0);
      pc_plus_one_next : OUT std_logic_vector (19 downto 0);
      port_prev : IN std_logic_vector (15 downto 0);
      port_next : OUT std_logic_vector (15 downto 0);
      instr_prev : IN std_logic_vector (  31 downto 0); 
      instr_next : OUT std_logic_vector (  31 downto 0); 
      clk, rst, enable : IN std_logic
    );
  end component;
  
  component DecodeExBuffer IS
PORT(
	PCSrc_prev, RET_prev, ZN_prev, setC_prev, clC_prev, MemW_prev, WB_prev, stallFetch_prev, SPEn_prev, call_prev, regSrc_prev, ALUSrc2_prev, outEnable_prev : IN std_logic;
	PCSrc_next, RET_next, ZN_next, setC_next, clC_next, MemW_next, WB_next, stallFetch_next, SPEn_next, call_next, regSrc_next, ALUSrc2_next, outEnable_next : OUT std_logic;
	memAddrSrc_prev,  SPAdd_prev, resSel_prev : IN std_logic_vector (1 downto 0 );
	memAddrSrc_next,  SPAdd_next, resSel_next : OUT std_logic_vector (1 downto 0 );
	Data1_prev, Data2_prev, Port_prev : IN std_logic_vector (15 downto 0);
	Data1_next, Data2_next, Port_next : OUT std_logic_vector (15 downto 0);
	addr2_prev, RegAddr_prev, ALUOP_prev : IN std_logic_vector ( 2 downto 0);
	addr2_next, RegAddr_next, ALUOP_next : OUT std_logic_vector ( 2 downto 0);
	EA_prev : IN std_logic_vector ( 19 downto 0);
	EA_next : OUT std_logic_vector ( 19 downto 0);
	PC_flags_prev : IN std_logic_vector (31 downto 0);
	PC_flags_next : OUT std_logic_vector (31 downto 0);
	clk, rst, enable : IN std_logic
);

END component;

-- types declaration --

  
-- signals declaration --

  -- Fetch stage signals --
  signal address, F_pc_plus_one: std_logic_vector (19 downto 0);
  signal write_data, mem_out : std_logic_vector (31 downto 0);
  signal W32, M_write_enable, stall_fetch, FAT: std_logic ;
  
  -- Decode stage signals --
  signal D_pc_plus_one, D_eff_addr: std_logic_vector (19 downto 0);
  signal D_port, D_mem_data, D_read_data_1, D_read_data_2 : std_logic_vector (15 downto 0);
  signal D_instr: std_logic_vector (31 downto 0);
  signal D_op_code: std_logic_vector (4 downto 0);
  signal D_shift_val:  std_logic_vector (3 downto 0);
  signal D_read_addr_1, D_read_addr_2, D_write_addr_1, D_write_addr_2, D_reg_addr : std_logic_vector (2 downto 0);
  signal D_we_1, D_we_2: std_logic;
  signal D_pc_plus_one_flags: std_logic_vector (31 downto 0);
  
  -- Execute stage signals --
  signal  E_port, E_read_data_1, E_read_data_2 : std_logic_vector (15 downto 0);
  signal E_read_addr_2,	E_reg_addr : std_logic_vector (2 downto 0);
  signal E_eff_addr : std_logic_vector (19 downto 0);
   signal E_pc_plus_one_flags: std_logic_vector (31 downto 0);




  
  -- Buffer enables --
  signal fetch_decode_buffer_enable: std_logic;
  signal decode_execute_buffer_enable: std_logic;
  signal id_ex_enable: std_logic;
  signal ex_mem_enable: std_logic;
  signal mem_wb_enable: std_logic;  
  
  -- Control Unit Lines --
  
signal	D_wb	: std_logic;
signal	D_mem_wr	: std_logic;
signal	D_setc	: std_logic;
signal	D_clc	: std_logic;
signal	D_zn	: std_logic;
signal	D_alu_op	: std_logic_vector (2 downto 0);
signal	D_reg_src	: std_logic;
signal	D_alu_src_2	: std_logic;
signal	D_output_enable	: std_logic;
signal	D_reg_addr_src	: std_logic;
signal	D_res_sel	: std_logic_vector (1 downto 0);
signal	D_data_2_sel	: std_logic;
signal	D_stall_fetch	: std_logic;
signal	D_sp_en	: std_logic;
signal	D_sp_add	: std_logic_vector (1 downto 0);
signal	D_mem_addr_src	: std_logic_vector (1 downto 0);
signal	D_pc_src	: std_logic;
signal	D_call	: std_logic;
signal	D_ret	: std_logic;


 -- Execute Stage Lines --

signal	E_wb	: std_logic;
signal	E_mem_wr	: std_logic;
signal	E_setc	: std_logic;
signal	E_clc	: std_logic;
signal	E_zn	: std_logic;
signal	E_alu_op	: std_logic_vector (2 downto 0);
signal	E_reg_src	: std_logic;
signal	E_alu_src_2	: std_logic;
signal	E_output_enable	: std_logic;
signal	E_reg_addr_src	: std_logic;
signal	E_res_sel	: std_logic_vector (1 downto 0);
signal	E_data_2_sel	: std_logic;
signal	E_stall_fetch	: std_logic;
signal	E_sp_en	: std_logic;
signal	E_sp_add	: std_logic_vector (1 downto 0);
signal	E_mem_addr_src	: std_logic_vector (1 downto 0);
signal	E_pc_src	: std_logic;
signal	E_call	: std_logic;
signal	E_ret	: std_logic;


 -- Write back signals --
 
 signal WB_write_addr_1, WB_write_addr_2: STD_LOGIC_VECTOR (2 downto 0);
 signal WB_write_data_1, WB_write_data_2: STD_LOGIC_VECTOR (15 downto 0);
 signal WB_we_1, WB_we_2 : STD_LOGIC; 


-- begin architecture definition --
begin
  
  -- FETCH STAGE
  M_write_enable <= '0';
  stall_fetch <= '0';
  W32 <= '0';
  FAT <= mem_out(31) and mem_out(30) and mem_out(29);
  address_control_unit : Address_Module port map(stall_fetch, FAT, address, clk, reset, F_pc_plus_one);
  memory_unit : Memory port map(clk, M_write_enable, W32, address, write_data, mem_out);
    
  -- IF/ID Buffer --
  fetch_decode_buffer_enable <= '1';
  if_id_buff: FetchDecodeBuffer port map(F_pc_plus_one, D_pc_plus_one, in_port, D_port, mem_out, D_instr, clk, reset, fetch_decode_buffer_enable);


 
  

  
  -- DECODE STAGE --

  WB_write_addr_1 <= "000";
  WB_write_addr_2 <= "001";
  WB_write_data_1 <= "0000000000000001";
  WB_write_data_2 <= "0000000000000010";
  WB_we_1<='1';
  WB_we_2 <='1';
 
  splitter: ResolveInstr port map(D_instr, D_op_code, D_read_addr_1, D_read_addr_2, D_mem_data, D_eff_addr, D_shift_val);
  register_file_unit: RegFile port map(clk, reset, WB_write_addr_1, WB_write_addr_2, WB_write_data_1, WB_write_data_2, WB_we_1, WB_we_2, D_read_addr_1, D_read_addr_2, D_read_data_1, D_read_data_2);
  
  
   -- ID/Ex Buffer --
  decode_execute_buffer_enable <= '1';
  id_ex_buff: DecodeExBuffer port map(
D_pc_src,
D_ret,
D_zn,
D_setc,
D_clc,
D_mem_wr,
D_wb,
D_stall_fetch,
D_sp_en,
D_call,
D_reg_src,
D_alu_src_2,
D_output_enable,
E_pc_src,
E_ret,
E_zn,
E_setc,
E_clc,
E_mem_wr,
E_wb,
E_stall_fetch,
E_sp_en,
E_call,
E_reg_src,
E_alu_src_2,
E_output_enable,
D_mem_addr_src,	
D_sp_add,	
D_res_sel,
E_mem_addr_src,	
E_sp_add,	
E_res_sel,
D_read_data_1,	
D_read_data_2,
D_port,
E_read_data_1,	
E_read_data_2,
E_port,
D_read_addr_2,
D_reg_addr,	
D_alu_op,
E_read_addr_2,	
E_reg_addr,	
E_alu_op,
D_eff_addr,
E_eff_addr,
D_pc_plus_one_flags,		
E_pc_plus_one_flags,	
clk,
reset,
decode_execute_buffer_enable
  );
end architecture;



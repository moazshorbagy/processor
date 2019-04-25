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

  component ALU is	
    generic (m: integer:=16);   		   			--Made it generic incase we changed something in design
    port (
      Data1,Data2:in std_logic_vector(m-1 downto 0);		--Based on ALU_OP we might not use both of the data in ports	
      alu_op:in std_logic_vector(2 downto 0);			--8 Operations
      Res1,Res2: out std_logic_vector (m-1 downto 0); 	--Res2 is only used for multiplication, else it will be set to don't care
      C,N,Z:out std_logic);					--Carry, Negative,Zero
  end component;
  
  
  -- Buffers --
  
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
	PCSrc_prev, RET_prev, ZN_prev, setC_prev, clC_prev, MemW_prev, WB_prev, WB2_prev, stallFetch_prev, SPEn_prev, call_prev, regSrc_prev, ALUSrc2_prev, outEnable_prev : IN std_logic;
	PCSrc_next, RET_next, ZN_next, setC_next, clC_next, MemW_next, WB_next, WB2_next, stallFetch_next, SPEn_next, call_next, regSrc_next, ALUSrc2_next, outEnable_next : OUT std_logic;
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
  
  COMPONENT ExecuteMemBuffer IS
    PORT(

	RET_prev, MemW_prev, WB_prev, WB2_prev, stallFetch_prev, SPEn_prev, call_prev, regSrc_prev, outEnable_prev : IN std_logic;
	RET_next, MemW_next, WB_next, WB2_next, stallFetch_next, SPEn_next, call_next, regSrc_next, outEnable_next : OUT std_logic;
	memAddrSrc_prev,  SPAdd_prev : IN std_logic_vector (1 downto 0 );
	memAddrSrc_next,  SPAdd_next : OUT std_logic_vector (1 downto 0 );
	res1_prev, res2_prev : IN std_logic_vector (15 downto 0);
	res1_next, res2_next : OUT std_logic_vector (15 downto 0);
	addr2_prev, RegAddr_prev : IN std_logic_vector ( 2 downto 0);
	addr2_next, RegAddr_next : OUT std_logic_vector ( 2 downto 0);
	EA_prev : IN std_logic_vector ( 19 downto 0);
	EA_next : OUT std_logic_vector ( 19 downto 0);
	PC_flags_prev : IN std_logic_vector (31 downto 0);	--PC+1 & flags
	PC_flags_next : OUT std_logic_vector (31 downto 0);
	clk, rst, enable : IN std_logic
);
  END COMPONENT;

  COMPONENT MemWBBuffer IS
    PORT(
	WB_prev, WB2_prev, NOP_prev, RegSrc_prev, outEnable_prev : IN std_logic;
	WB_next, WB2_next, NOP_next, RegSrc_next, outEnable_next : OUT std_logic;
	res2_prev, res_prev : IN std_logic_vector(15 downto 0);
	res2_next, res_next : OUT std_logic_vector(15 downto 0);
	RegAddr_prev, RegAddr2_prev : IN std_logic_vector ( 2 downto 0);
	RegAddr_next, RegAddr2_next : OUT std_logic_vector ( 2 downto 0);
	clk, rst, enable : IN std_logic
);

  END COMPONENT;

-- Extra components --


component ControlUnit IS
PORT   (
		 wb, mem_wr , setc , clc , zn : OUT std_logic;
		
		 alu_op : OUT std_logic_vector( 2 DOWNTO 0);
		 
		 reg_src , alu_src_2 , output_enable , reg_addr_src : OUT std_logic; 
		 
		 res_sel : OUT std_logic_vector( 1 DOWNTO 0);

		 data_2_sel , stall_fetch , SPEN  : OUT std_logic;
		 
		 sp_add , mem_addr_src : OUT std_logic_vector( 1 DOWNTO 0);
		 
		 pc_src ,call,ret: OUT std_logic;
		
		 c_flag, n_flag, z_flag: IN std_logic;
		
	 	 opcode : IN std_logic_vector( 4 DOWNTO 0)
		 
	);

END component;


  component  Address_Module is
port(
	stall_fetch:in std_logic;				--Selector for mux before PC... to increment PC or to keep it as it is (stall)
	FAT:in std_logic;					--For FAT instructions (Multiplication) which will be used to increment pc by 2

	clk,rst: in std_logic;
	
	--Iteration 2...
	spadd: in std_logic_vector(1 downto 0);
	EA: in std_logic_vector (19 downto 0);
	mem_addr_src: in std_logic_vector (1 downto 0);
	spen: in std_logic;
	address: out std_logic_vector(19 downto 0)		--PC value or SP value or EA or SP+1..

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
      shift_val: out std_logic_vector(15 downto 0)
    );
  end component;

  component flags is 
    PORT(
      -- ALUC, ALUZ, ALUN : flags coming from the ALU
      -- setC, clC, ZN : signals coming from the control unit
      -- C, Z, N : Output flags
      ALUC, ALUZ, ALUN, setC, clC, ZN, clk, rst, enable: IN std_logic;
      C, Z, N : OUT std_logic
    );
  END component;

  COMPONENT mux4 is 
    generic (n : integer:=16);
    port(
    in0, in1, in2, in3: in std_logic_vector (n-1 downto 0);
    sel : in  std_logic_vector (1 downto 0);
    out1 : out std_logic_vector (n-1 downto 0));
  end COMPONENT;

  COMPONENT Mux2 is
    generic (n: integer:=16);
    port (
      in_0, in_1: in std_logic_vector (n-1 downto 0);
      sel: in std_logic;
      out_1: out std_logic_vector (n-1 downto 0));
  end COMPONENT;


-- types declaration --

  
-- signals declaration --

  -- Fetch stage signals --
  signal address, F_pc_plus_one: std_logic_vector (19 downto 0);
  signal write_data, mem_out : std_logic_vector (31 downto 0);
  signal W32, M_write_enable, stall_fetch, FAT,sp_en: std_logic ;
  
  -- Decode stage signals --
  signal D_pc_plus_one, D_eff_addr: std_logic_vector (19 downto 0);
  signal D_port, D_mem_data, D_read_data_1, D_read_data_2, D_data_2: std_logic_vector (15 downto 0);
  signal D_instr: std_logic_vector (31 downto 0);
  signal D_op_code: std_logic_vector (4 downto 0);
  signal D_shift_val:  std_logic_vector (15 downto 0);
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

  signal flags_regs_enable : std_logic;
  
  -- Control Unit Lines --
  
  signal	D_wb	: std_logic;
  signal	D_wb2	: std_logic;
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
  signal	E_wb2	: std_logic;
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
  signal E_res : std_logic_vector (15 downto 0);
  signal E_res2 : std_logic_vector ( 15 downto 0);
  signal E_ALU_C: std_logic;
  signal E_ALU_Z : std_logic;
  signal E_ALU_N : std_logic;
  signal E_N : std_logic;
  signal E_Z : std_logic;
  signal E_C : std_logic;
  signal E_ALU_operand_2 : std_logic_vector(15 downto 0);
  signal E_ALU_res : std_logic_vector(15 downto 0);


  -- Memory Stage Lines --

  signal	M_wb	: std_logic;
  signal	M_wb2	: std_logic;
  signal	M_mem_wr	: std_logic;
  signal	M_reg_src	: std_logic;
  signal	M_output_enable	: std_logic;
  signal	M_reg_addr_src	: std_logic;
  signal	M_res_sel	: std_logic_vector (1 downto 0);
  signal	M_data_2_sel	: std_logic;
  signal	M_stall_fetch	: std_logic;
  signal	M_sp_en	: std_logic;
  signal	M_sp_add	: std_logic_vector (1 downto 0);
  signal	M_mem_addr_src	: std_logic_vector (1 downto 0);
  signal	M_call	: std_logic;
  signal	M_ret	: std_logic;
  signal 	M_res : std_logic_vector (15 downto 0);
  signal 	M_res2 : std_logic_vector ( 15 downto 0);
  signal 	M_read_addr_2 : std_logic_vector (2 downto 0);
  signal 	M_reg_addr : std_logic_vector (2 downto 0);
  signal 	M_eff_addr : std_logic_vector (19 downto 0);
  signal	M_pc_plus_one_flags: std_logic_vector (31 downto 0);
  signal 	M_write_data : std_logic_vector ( 31 downto 0);
  signal 	M_res_extended : std_logic_vector ( 31 downto 0);

 -- Write back signals --
 
  signal WB_write_addr_1, WB_write_addr_2: STD_LOGIC_VECTOR (2 downto 0);
  signal WB_write_data_1, WB_write_data_2: STD_LOGIC_VECTOR (15 downto 0);
  signal WB_we_1: STD_LOGIC; 
  signal WB_we_2 : STD_LOGIC; 

  signal WB_NOP : std_logic ;
  signal WB_reg_src : std_logic;
  signal WB_output_enable : std_logic;
  signal WB_res2 : std_logic_vector (15 downto 0);
  signal WB_res : std_logic_vector (15 downto 0);
  signal WB_reg_addr : std_logic_vector (2 downto 0);
  signal WB_reg_addr2 : std_logic_vector (2 downto 0);


-- begin architecture definition --
begin
  
  ----------------------------------- FETCH STAGE -----------------------------------
  M_write_enable <= '0';
  stall_fetch <= '0';
  W32 <= M_call;
  FAT <= mem_out(31) and mem_out(30) and mem_out(29);
  M_res_extended <= "0000000000000000" & M_res;
  Mux_M_write_data : Mux2 generic map (32) port map (M_res_extended, M_pc_plus_one_flags, M_call, M_write_data );

  address_control_unit : Address_Module port map(M_stall_fetch, FAT, clk, reset, M_sp_add , M_eff_addr, M_mem_addr_src, M_sp_en,address);
  memory_unit : Memory port map(clk, M_write_enable, W32, address, M_write_data, mem_out);
    
  ----------------------------------- IF/ID Buffer -----------------------------------
  fetch_decode_buffer_enable <= '1';
  if_id_buff: FetchDecodeBuffer port map(F_pc_plus_one, D_pc_plus_one, in_port, D_port, mem_out, D_instr, clk, reset, fetch_decode_buffer_enable);


 
  

  
  ----------------------------------- DECODE STAGE -----------------------------------

  
  splitter: ResolveInstr port map(D_instr, D_op_code, D_read_addr_1, D_read_addr_2, D_mem_data, D_eff_addr, D_shift_val);

  D_wb2 <= '0';

  reg_src_mux: Mux2 generic map (16) port map(D_mem_data, WB_res, D_reg_src, WB_write_data_1);
  reg_addr_src_mux: Mux2 generic map (3) port map(D_read_addr_1, D_read_addr_2, D_reg_addr_src, D_reg_addr);
  data_2_mux: Mux2 generic map (16) port map(D_read_data_2, D_shift_val, D_data_2_sel, D_data_2);

  register_file_unit: RegFile port map(clk, reset, WB_write_addr_1, WB_write_addr_2, WB_write_data_1, WB_write_data_2, WB_we_1, WB_we_2, D_read_addr_1, D_read_addr_2, D_read_data_1, D_read_data_2);
  
  
   ----------------------------------- ID/Ex Buffer -----------------------------------
  decode_execute_buffer_enable <= '1';
  id_ex_buff: DecodeExBuffer port map(
    D_pc_src,
    D_ret,
    D_zn,
    D_setc,
    D_clc,
    D_mem_wr,
    D_wb,
    D_wb2,
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
    E_wb2,
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
    D_data_2,
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
  
  

----------------------------------- Execute Stage -----------------------------------
 
  ALU_src_2_mux : Mux2 generic map (16) port map(E_read_data_2, "0000000000000001",E_alu_src_2, E_ALU_operand_2);
  D_ALU_component :  ALU generic map (16) port map (E_read_data_1, E_ALU_operand_2, E_alu_op, E_ALU_res, E_res2, E_ALU_C, E_ALU_N, E_ALU_Z);

  -- The flags module getting input from the ALU and the control unit
  flags_regs_enable <= '1';
  D_flags_component : flags port map (E_ALU_C, E_ALU_Z, E_ALU_N, E_setc, E_clc, E_zn, clk, reset, flags_regs_enable, E_C, E_Z, E_N);

  -- The mux selecting res from ALU, DATA1, PORT, and Immediate data
  res_mux : mux4 generic map (16) port map (E_ALU_res, E_read_data_1, E_port, E_eff_addr(15 downto 0), E_res_sel, E_res);
  
      control_unit : ControlUnit port map (D_wb, D_mem_wr , D_setc , D_clc , D_zn ,	D_alu_op , D_reg_src , D_alu_src_2 , D_output_enable , D_reg_addr_src , D_res_sel, D_data_2_sel , D_stall_fetch , D_sp_en, D_sp_add , 
	D_mem_addr_src,	 D_pc_src ,D_call,D_ret, E_C, E_N, E_Z, D_op_code);

--------------------------------- Execute Memory Buffer ----------------------------
 ExecuteMemoryBuffer :  ExecuteMemBuffer port map (	E_ret, E_mem_wr, E_wb, E_wb2, E_stall_fetch, E_sp_en, E_call, E_reg_src, E_output_enable,
							M_ret, M_mem_wr, M_wb, M_wb2, M_stall_fetch, M_sp_en, M_call, M_reg_src, M_output_enable,
							E_mem_addr_src, E_sp_add,
							M_mem_addr_src, M_sp_add,
							E_res, E_res2,
							M_res, M_res2,
							E_read_addr_2, E_reg_addr,
							M_read_addr_2, M_reg_addr,
							E_eff_addr,
							M_eff_addr,
							E_pc_plus_one_flags,
							M_pc_plus_one_flags,
							clk, reset, ex_mem_enable);

--------------------------------- Memory Write-Back Buffer ----------------------------  
  mem_wb_enable <= '1';
  Mem_WB_Buffer : MemWBBuffer port map (M_wb, M_wb2,  M_stall_fetch, M_reg_src, M_output_enable,
					WB_we_1, WB_we_2, WB_NOP, WB_reg_src, WB_output_enable,
					M_res2, M_res,
					WB_res2, WB_res,
					M_reg_addr, M_read_addr_2,
					WB_reg_addr, WB_reg_addr2,
					clk, reset, mem_wb_enable);

  WB_write_data_1 <= WB_res;
  WB_write_data_2 <= WB_res2;
  WB_write_addr_1 <= WB_reg_addr;
  WB_write_addr_2 <= WB_reg_addr2;




end architecture;

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
 

COMPONENT DecodeExBuffer IS
PORT(
	PCSrc_prev, RET_prev, ZN_prev, setC_prev, clC_prev,clN_prev,clZ_prev, MemW_prev, WB_prev, WB2_prev, stallFetch_prev, SPEn_prev, call_prev, regSrc_prev, ALUSrc2_prev, outEnable_prev : IN std_logic;
	PCSrc_next, RET_next, ZN_next, setC_next, clC_next,clN_next,clZ_next, MemW_next, WB_next, WB2_next, stallFetch_next, SPEn_next, call_next, regSrc_next, ALUSrc2_next, outEnable_next : OUT std_logic;
	memAddrSrc_prev,  SPAdd_prev, resSel_prev : IN std_logic_vector (1 downto 0 );
	memAddrSrc_next,  SPAdd_next, resSel_next : OUT std_logic_vector (1 downto 0 );
	Data1_prev, Data2_prev, Port_prev : IN std_logic_vector (15 downto 0);
	Data1_next, Data2_next, Port_next : OUT std_logic_vector (15 downto 0);
	addr2_prev, RegAddr_prev,Rsrc_prev, ALUOP_prev : IN std_logic_vector ( 2 downto 0);
	addr2_next, RegAddr_next,Rsrc_next, ALUOP_next : OUT std_logic_vector ( 2 downto 0);
	EA_prev : IN std_logic_vector ( 19 downto 0);
	EA_next : OUT std_logic_vector ( 19 downto 0);
	PC_flags_prev : IN std_logic_vector (31 downto 0);
	PC_flags_next : OUT std_logic_vector (31 downto 0);
	opCode_prev:	IN std_logic_vector (4 downto 0);
	opCode_next: 	Out std_logic_vector (4 downto 0);
	buffered_decode_exexute_buffer_reset_prev : in std_logic;
	buffered_decode_exexute_buffer_reset_next : out std_logic;
	clk, rst, enable : IN std_logic
);

END COMPONENT;
  
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
	opcode_prev   : In std_logic_vector (4 downto 0);
	opcode_next   : Out std_logic_vector (4 downto 0);
	LD_use_prev   : IN std_logic;
	LD_use_next   : OUT std_logic;
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
	memory_out_prev : IN std_logic_vector (15 downto 0);
	memory_out_next : OUT std_logic_vector (15 downto 0);
	LD_use_prev:in std_logic;
	LD_use_next: out std_logic;
	clk, rst, enable : IN std_logic
);

  END COMPONENT;

-- Extra components --


component ControlUnit IS
PORT   (
		 wb,wb2, mem_wr , setc , clc ,cln,clz, zn : OUT std_logic;
		
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

Component ForwardUnit IS
PORT(
									--WB1 is for normal operations that have only 1 Rdst, WB2 is for mult which 
	Ex_Mem_WB_reg:	in std_logic;					--writes back in 2 registers (2 Rdst)
	Mem_WB_WB_reg: 	in std_logic;
	Ex_Mem_WB2_reg:	in std_logic;
	Mem_WB_WB2_reg:	in std_logic;
	Id_Ex_Rsrc:	in std_logic_vector (2 downto 0);		--Rsrc in OP Code
	Id_Ex_addr2:	in std_logic_vector (2 downto 0);		--Rdst in OP Code 
	Id_Ex_OpCode:	in std_logic_vector (4 downto 0);		--For operations that have 2 Rsrc, i.e : AND, OR, ADD, SUB, MUL.
	Ex_Mem_regAddr:	in std_logic_vector (2 downto 0);
	Mem_WB_regAddr:	in std_logic_vector (2 downto 0);
	Ex_Mem_addr2: 	in std_logic_vector (2 downto 0);	
	Mem_WB_addr2:	in std_logic_vector (2 downto 0);
	Ex_Mem_OpCode:	in std_logic_vector (4 downto 0);		--For load use case only, to stall incase of load

			
	Fwd_Mem_WB1:	out std_logic_vector(1 downto 0);		--Muxes Selectors
	Fwd_Ex_Mem1:	out std_logic_vector(1 downto 0);
	Fwd_Mem_WB2:	out std_logic_vector(1 downto 0);
	Fwd_Ex_Mem2:	out std_logic_vector(1 downto 0);

	
	LD_use:		out std_logic					--For load use case forwarding and stalling

);
END Component;

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
	pc_src:in std_logic;
	RET: in std_logic;
	memory_out: in std_logic_vector (19 downto 0);
	data1_extended: in std_logic_vector (19 downto 0);
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


  COMPONENT call_counter IS

	PORT( clk : IN std_logic;
		en:in std_logic;
		rst:in std_logic;
		  z : OUT std_logic_vector(1 downto 0));
  END COMPONENT ;

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
  signal D_before_NOP_mux_op_code: std_logic_vector (4 downto 0);
  signal D_shift_val:  std_logic_vector (15 downto 0);
  signal D_read_addr_1, D_read_addr_2, D_write_addr_1, D_write_addr_2, D_reg_addr : std_logic_vector (2 downto 0);
  signal D_we_1, D_we_2: std_logic;
  signal D_pc_plus_one_flags: std_logic_vector (31 downto 0);

  signal NOP_mux_selector : std_logic ;
  signal call_counter_out : std_logic_vector ( 1 downto 0);


  -- Execute stage signals --
  signal  E_port, E_read_data_1, E_read_data_2 : std_logic_vector (15 downto 0);
  signal E_read_addr_2,	E_reg_addr : std_logic_vector (2 downto 0);
  signal E_eff_addr : std_logic_vector (19 downto 0);
  signal E_pc_plus_one_flags: std_logic_vector (31 downto 0);


  -- Signal for forwarding...muxes' slectors--

  signal Fwd_Mem_WB_1:   std_logic_vector(1 downto 0);		--Muxes Selectors
  signal Fwd_Ex_Mem_1:	std_logic_vector(1 downto 0);
  signal Fwd_Mem_WB_2:	std_logic_vector(1 downto 0);
  signal Fwd_Ex_Mem_2:	std_logic_vector(1 downto 0);


  -- Signal for load/use case forwarding and stalling--
  signal HDU_LD_use: std_logic;				--Used to directly stall for 1 cycle
  signal M_LD_use:std_logic;				--Used to forward from mem to ALU
  signal WB_LD_use:std_logic;



  -- Buffer enables --
  signal fetch_decode_buffer_enable: std_logic;
  signal decode_execute_buffer_enable: std_logic;
  signal id_ex_enable: std_logic;
  signal ex_mem_enable: std_logic;
  signal mem_wb_enable: std_logic;  

  signal ex_mem_rst : std_logic;
  signal decode_execute_buffer_reset : std_logic;
  signal buffered_decode_exexute_buffer_reset : std_logic;
  

  signal flags_regs_enable : std_logic;
  
  -- Control Unit Lines --
  
  signal	D_wb	: std_logic;
  signal	D_wb2	: std_logic;
  signal	D_mem_wr	: std_logic;
  signal	D_setc	: std_logic;
  signal	D_clc	: std_logic;
    signal	D_cln	: std_logic;
	  signal	D_clz	: std_logic;
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
  signal 	D_opcode:  std_logic_vector (4 downto 0);
  signal 	D_first_data1:std_logic_vector(15 downto 0);  
  signal 	D_final_data1:std_logic_vector(15 downto 0);  
  signal 	D_first_data2:std_logic_vector(15 downto 0);  
  signal 	D_final_data2:std_logic_vector(15 downto 0); 
  signal 	D_final_data2_temp:std_logic_vector(15 downto 0); 
 -- Execute Stage Lines --

  signal	E_wb	: std_logic;
  signal	E_wb2	: std_logic;
  signal	E_mem_wr	: std_logic;
  signal	E_setc	: std_logic;
  signal	E_clc	: std_logic;
    signal	E_cln	: std_logic;
	  signal	E_clz	: std_logic;
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
  signal 	E_res : std_logic_vector (15 downto 0);
  signal 	E_res2 : std_logic_vector ( 15 downto 0);
  signal 	E_ALU_C: std_logic;
  signal 	E_ALU_Z : std_logic;
  signal 	E_ALU_N : std_logic;
  signal 	E_N : std_logic;
  signal 	E_Z : std_logic;
  signal 	E_C : std_logic;
  signal 	E_ALU_operand_2 : std_logic_vector(15 downto 0);
  signal 	E_ALU_res : std_logic_vector(15 downto 0);
  signal 	E_opcode:  std_logic_vector (4 downto 0);
  signal 	E_Rsrc:    std_logic_vector (2 downto 0);

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
  signal 	M_res_muxed : std_logic_vector (15 downto 0);
  signal 	M_res2 : std_logic_vector ( 15 downto 0);
  signal 	M_read_addr_2 : std_logic_vector (2 downto 0);
  signal 	M_reg_addr : std_logic_vector (2 downto 0);
  signal 	M_eff_addr : std_logic_vector (19 downto 0);
  signal	M_pc_plus_one_flags: std_logic_vector (31 downto 0);
  signal 	M_write_data : std_logic_vector ( 31 downto 0);
  signal 	M_res_extended : std_logic_vector ( 31 downto 0);
  signal 	temp_data1_extended: std_logic_vector (19 downto 0);
  signal        M_Opcode:std_logic_vector (4 downto 0);

  
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

  signal WB_memory_data : std_logic_vector (15 downto 0);


-- begin architecture definition --
begin
  
  ----------------------------------- FETCH STAGE -----------------------------------
  M_write_enable <= '0';
  stall_fetch <= M_stall_fetch OR HDU_LD_use;
  W32 <= M_call;
  FAT <= mem_out(31) and mem_out(30) and mem_out(29);
  M_res_extended <= "0000000000000000" & M_res;
  Mux_M_write_data : Mux2 generic map (32) port map (M_res_extended, M_pc_plus_one_flags, M_call, M_write_data );
  temp_data1_extended<="0000"&D_final_Data1;
  address_control_unit : Address_Module port map(stall_fetch, FAT, clk, reset, M_sp_add , M_eff_addr, M_mem_addr_src, M_sp_en, D_pc_src, M_ret, mem_out(31 downto 12), temp_data1_extended, address);
  memory_unit : Memory port map(clk, M_mem_wr, W32, address, M_write_data, mem_out);
    

  memory_reg_src_mux: Mux2 generic map (16) port map(mem_out (31 downto 16) , M_res, M_reg_src, M_res_muxed);

  ----------------------------------- IF/ID Buffer -----------------------------------
  fetch_decode_buffer_enable <= NOT HDU_LD_use;
  if_id_buff: FetchDecodeBuffer port map(F_pc_plus_one, D_pc_plus_one, in_port, D_port, mem_out, D_instr, clk, reset, fetch_decode_buffer_enable);


 
  

  
  ----------------------------------- DECODE STAGE -----------------------------------
 
  call_counter_comp : call_counter port map(clk, D_call, reset,call_counter_out);

  
  splitter: ResolveInstr port map(D_instr, D_before_NOP_mux_op_code, D_read_addr_1, D_read_addr_2, D_mem_data, D_eff_addr, D_shift_val);
  

  NOP_mux_selector <= WB_NOP OR E_pc_src OR call_counter_out (0) OR call_counter_out(1) ;
  NOP_MUX: Mux2 generic map (5) port map(D_before_NOP_mux_op_code,"00000", NOP_mux_selector, D_op_code);
	

  reg_src_mux: Mux2 generic map (16) port map(WB_memory_data, WB_res, WB_reg_src, WB_write_data_1);
  reg_addr_src_mux: Mux2 generic map (3) port map(D_read_addr_1, D_read_addr_2, D_reg_addr_src, D_reg_addr);
  

  register_file_unit: RegFile port map(clk, reset, WB_write_addr_1, WB_write_addr_2, WB_write_data_1, WB_write_data_2, WB_we_1, WB_we_2, D_read_addr_1, D_read_addr_2, D_read_data_1, D_read_data_2);
  
  control_unit : ControlUnit port map (D_wb,D_wb2 ,D_mem_wr , D_setc , D_clc,D_cln,D_clz , D_zn ,	D_alu_op , D_reg_src , D_alu_src_2 , D_output_enable , D_reg_addr_src , D_res_sel, D_data_2_sel , D_stall_fetch , D_sp_en, D_sp_add , 
	D_mem_addr_src,	 D_pc_src ,D_call,D_ret, E_C, E_N, E_Z, D_op_code);
  

  ------------------------------------ Forwarding Muxes Area --------------------------
  Fwd_Mem_Wb1_Mux: Mux4 generic map (16) port map (D_read_data_1, M_res_muxed, M_res2,"0000000000000000", Fwd_Mem_Wb_1,D_first_Data1);
  Fwd_Ex_Mem_Mux: Mux4 generic map (16) port map (D_first_Data1, E_res, E_res2,"0000000000000000", Fwd_Ex_Mem_1,D_final_Data1);
  Fwd_Mem_Wb2_Mux: Mux4 generic map (16) port map (D_read_data_2, M_res_muxed, M_res2,"0000000000000000", Fwd_Mem_Wb_2,D_first_Data2);
  Fwd_Ex_Mem2_Mux: Mux4 generic map (16) port map (D_first_Data2, E_res, E_res2,"0000000000000000", Fwd_Ex_Mem_2,D_final_Data2_temp);

  data_2_mux: Mux2 generic map (16) port map(D_final_Data2_temp, D_shift_val, D_data_2_sel, D_final_Data2);
  ------------------------------------ ID/Ex Buffer -----------------------------------
  
  decode_execute_buffer_enable <= '1';--NOT HDU_LD_use;
  --decode_execute_buffer_reset <= buffered_decode_exexute_buffer_reset; --reset OR (HDU_LD_use AND (NOT  clk)) ;
id_ex_buff: DecodeExBuffer port map(
    D_pc_src,
    D_ret,
    D_zn,
    D_setc,
    D_clc,
	D_cln,
	D_clz,
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
	E_cln,
	E_clz,
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
    D_final_Data1,	
    D_final_Data2,
    D_port,
    E_read_data_1,	
    E_read_data_2,
    E_port,
    D_read_addr_2,
    D_reg_addr,	
    D_read_addr_1,
    D_alu_op,
    E_read_addr_2,	
    E_reg_addr,	
    E_Rsrc,
    E_alu_op,
    D_eff_addr,
    E_eff_addr,
    D_pc_plus_one_flags,		
    E_pc_plus_one_flags,	
    D_op_code,	--D_Opcode,			---------------------------------------------
    E_Opcode,
    HDU_LD_use,
    decode_execute_buffer_reset,
    clk,
    decode_execute_buffer_reset,
    decode_execute_buffer_enable
  );
  
  
----------------------------------- Forwarding Unit----------------------------------D_read_addr_1

HDU: ForwardUnit port map (	E_wb,
				M_wb,
			  	E_wb2,
				M_wb2,
				D_read_addr_1,
				D_Read_addr_2,
				D_op_code,
				E_reg_addr,
				M_reg_addr,
				E_read_addr_2,
				M_read_addr_2,
				E_Opcode,
				Fwd_Mem_WB_1,
				Fwd_Ex_Mem_1,
				Fwd_Mem_WB_2,
				Fwd_Ex_Mem_2,
				HDU_LD_use);




----------------------------------- Execute Stage -----------------------------------
 
  ALU_src_2_mux : Mux2 generic map (16) port map(E_read_data_2, "0000000000000001",E_alu_src_2, E_ALU_operand_2);
  D_ALU_component :  ALU generic map (16) port map (E_read_data_1, E_ALU_operand_2, E_alu_op, E_ALU_res, E_res2, E_ALU_C, E_ALU_N, E_ALU_Z);

  -- The flags module getting input from the ALU and the control unit
  flags_regs_enable <= '1';
  D_flags_component : flags port map (E_ALU_C, E_ALU_Z, E_ALU_N, E_setc, E_clc, E_zn, clk, reset, flags_regs_enable, E_C, E_Z, E_N);

  -- The mux selecting res from ALU, DATA1, PORT, and Immediate data
  res_mux : mux4 generic map (16) port map (E_ALU_res, E_read_data_1, E_port, E_eff_addr(15 downto 0), E_res_sel, E_res);
  
      

--------------------------------- Execute Memory Buffer ----------------------------
ex_mem_enable <= '1';
ex_mem_rst <= reset;--OR (HDU_LD_use AND clk) ;
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
							E_Opcode,
							M_Opcode,
							HDU_LD_use,
							M_LD_Use,
							clk, ex_mem_rst, ex_mem_enable);

--------------------------------- Memory Write-Back Buffer ----------------------------  
  mem_wb_enable <= '1';
  Mem_WB_Buffer : MemWBBuffer port map (M_wb, M_wb2,  M_stall_fetch, M_reg_src, M_output_enable,
					WB_we_1, WB_we_2, WB_NOP, WB_reg_src, WB_output_enable,
					M_res2, M_res,
					WB_res2, WB_res,
					M_reg_addr, M_read_addr_2,
					WB_reg_addr, WB_reg_addr2,
					mem_out(31 downto 16),
					WB_memory_data,
					M_LD_Use, WB_LD_Use,
					clk, reset, mem_wb_enable);

  --WB_write_data_1 <= WB_res;
  WB_write_data_2 <= WB_res2;
  WB_write_addr_1 <= WB_reg_addr;
  WB_write_addr_2 <= WB_reg_addr2;
	-------- I guess it will be changed but leve it for now -------------
  out_port <= WB_res when WB_output_enable = '1'
		else "0000000000000000";




end architecture;

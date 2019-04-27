library ieee;
use ieee.std_logic_1164.all;

ENTITY ForwardUnit IS
PORT(
									--1 is for normal operations that have only 1 Rdst, 2 is for mult which 
	Ex_Mem_WB_reg:	in std_logic;					--writes back in 2 registers (2 Rdst)
	Mem_WB_WB_reg: 	in std_logic;
	Ex_Mem_WB2_reg:	in std_logic;
	Mem_WB_WB2_reg:	in std_logic;
	Id_Ex_regSrc:	in std_logic_vector (2 downto 0);
	Ex_Mem_regAddr:	in std_logic_vector (2 downto 0);
	Mem_WB_regAddr:	in std_logic_vector (2 downto 0);
	Ex_Mem_addr2: 	in std_logic_vector (2 downto 0);	
	Mem_WB_addr2:	in std_logic_vector (2 downto 0);
	OpCode:		in std_logic_vector (4 downto 0);		--For load use case only, to stall incase of load
			
	Fwd_Mem_WB1:	out std_logic;					--Muxes Selectors
	Fwd_Ex_Mem1:	out std_logic;
	Fwd_Mem_WB2:	out std_logic;
	Fwd_Ex_Mem2:	out std_logic;
	
	LD_use:		out std_logic;					--For load use case forwarding
	stall:		out std_logic					--For load use case stalling
);

--Note that LDM is not a special case because it loads via the immediate register not the memory. And the immediate value is available in the 
--res register of the EX/Mem buffer. 

END ENTITY;
ARCHITECTURE arch OF ForwardUnit  IS
BEGIN

stall<='1' when OpCode="11101"						--General Farag asked for it specifically 
else '0';

Fwd_Mem_WB1<='1' when (Mem_WB_regAddr=Id_Ex_regSrc) AND (Mem_WB_WB_reg='1')
else '0';
Fwd_Mem_WB2<='1' when (Mem_Wb_addr2=Id_Ex_regSrc)   AND (Mem_WB_WB2_reg='1')
else '0';
Fwd_Ex_Mem1<='1' when (Ex_mem_regAddr=ID_Ex_regSrc) AND	(Ex_Mem_WB_reg='1')
else '0';
Fwd_Ex_Mem2<='1' when (Ex_mem_addr2=ID_Ex_regSrc)   AND (Ex_Mem_WB2_reg='1')
else '0';

END ARCHITECTURE;

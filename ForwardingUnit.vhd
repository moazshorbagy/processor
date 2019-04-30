library ieee;
use ieee.std_logic_1164.all;

ENTITY ForwardUnit IS
PORT(
									--1 is for normal operations that have only 1 Rdst, 2 is for mult which 
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

--Note that LDM is not a special case because it loads via the immediate register not the memory. And the immediate value is available in the 
--res register of the EX/Mem buffer. 

END ENTITY;
ARCHITECTURE arch OF ForwardUnit  IS
constant ADDop : std_logic_vector(4 downto 0):= "01001"; 
constant MULop : std_logic_vector(4 downto 0):= "01010"; 
constant SUBop : std_logic_vector(4 downto 0):= "01011";
constant ANDop : std_logic_vector(4 downto 0):= "01100"; 
constant ORop  : std_logic_vector(4 downto 0):= "01101"; 

BEGIN

LD_use<='1' when EX_Mem_OpCode="11101" and ((Ex_mem_regAddr=ID_Ex_Rsrc) OR ((Ex_mem_regAddr=ID_Ex_addr2) AND (Id_Ex_Opcode=ANDop OR Id_Ex_Opcode=ORop OR Id_Ex_Opcode=SUBop OR Id_Ex_Opcode=ADDop OR Id_Ex_Opcode=MULOp)))					
else '0';

Fwd_Ex_Mem1<=	"01" when ((Ex_mem_regAddr=ID_Ex_Rsrc) AND (Ex_Mem_WB_reg='1'))	--For res  forwarding in most cases (WB='1')
else 		"10" when (Ex_mem_addr2=ID_Ex_Rsrc) AND (Ex_Mem_WB2_reg='1')  --For res2 forwarding in case of multiplication (WB2='1') 
else "00";

Fwd_Mem_WB1<=	"01" when ((Mem_WB_regAddr=Id_Ex_Rsrc) AND (Mem_WB_WB_reg='1'))   --For res  forwarding in most cases (WB='1')
else 	     	"10" when (Mem_WB_addr2=Id_Ex_Rsrc)    AND (Mem_WB_WB2_reg='1')  --For res2 forwarding in case of multiplication (WB2='1')
else 		"00";

---Fwd_Ex_Mem2<=   "01" when (Ex_mem_regAddr=ID_Ex_addr2)     AND (Ex_Mem_WB2_reg='1') AND (Id_Ex_Opcode=ANDop OR Id_Ex_Opcode=ORop OR Id_Ex_Opcode=SUBop OR Id_Ex_Opcode=ADDop OR Id_Ex_Opcode=MULOp)
---else 		"10" when (Ex_mem_addr2=ID_Ex_Rsrc) AND (Ex_Mem_WB2_reg='1') AND (Id_Ex_Opcode=ANDop OR Id_Ex_Opcode=ORop OR Id_Ex_Opcode=SUBop OR Id_Ex_Opcode=ADDop OR Id_Ex_Opcode=MULOp) --For res2 forwarding in case of multiplication (WB2='1') 
---else 		"00";

---Fwd_Mem_WB2<=   "01" when (Mem_WB_regAddr=ID_Ex_addr2)     AND (Ex_Mem_WB2_reg='1') AND (Id_Ex_Opcode=ANDop OR Id_Ex_Opcode=ORop OR Id_Ex_Opcode=SUBop OR Id_Ex_Opcode=ADDop OR Id_Ex_Opcode=MULOp)
---else 		"10" when (Mem_WB_addr2=ID_Ex_Rsrc) AND (Ex_Mem_WB2_reg='1') AND (Id_Ex_Opcode=ANDop OR Id_Ex_Opcode=ORop OR Id_Ex_Opcode=SUBop OR Id_Ex_Opcode=ADDop OR Id_Ex_Opcode=MULOp) --For res2 forwarding in case of multiplication (WB2='1') 
---else 		"00";

Fwd_Ex_Mem2<=	"01" when ((Ex_mem_regAddr=Id_Ex_addr2) AND (Ex_Mem_WB_reg='1'))	--For res  forwarding in most cases (WB='1')
else 		"10" when (Ex_mem_addr2=ID_Ex_Rsrc) AND (Ex_Mem_WB2_reg='1')  --For res2 forwarding in case of multiplication (WB2='1') 
else "00";

Fwd_Mem_WB2<=	"01" when ((Mem_WB_regAddr=Id_Ex_addr2) AND (Mem_WB_WB_reg='1'))   --For res  forwarding in most cases (WB='1')
else 	     	"10" when (Mem_WB_addr2=Id_Ex_Rsrc)    AND (Mem_WB_WB2_reg='1')  --For res2 forwarding in case of multiplication (WB2='1')
else 		"00";

END ARCHITECTURE;

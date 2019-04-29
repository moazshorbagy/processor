Library ieee;
use ieee.std_logic_1164.all;

ENTITY ControlUnit IS
PORT   (
		 wb, wb2 ,mem_wr , setc , clc , zn : OUT std_logic;
		
		 alu_op : OUT std_logic_vector( 2 DOWNTO 0);
		 
		 reg_src , alu_src_2 , output_enable , reg_addr_src : OUT std_logic; 
		 
		 res_sel : OUT std_logic_vector( 1 DOWNTO 0);

		 data_2_sel , stall_fetch , SPEN  : OUT std_logic;
		 
		 sp_add , mem_addr_src : OUT std_logic_vector( 1 DOWNTO 0);
		 
		 pc_src ,call,ret: OUT std_logic;
		
		 c_flag, n_flag, z_flag: IN std_logic;
		
	 	 opcode : IN std_logic_vector( 4 DOWNTO 0);
		
	 	 opcode_out: out std_logic_vector (4 downto 0)
		
	);

END ControlUnit;

--NOP   00000
--setc  00001
--CLRC	00010
--NOT	00011
--INC	00100
--DEC	00101
--OUT	00110
--IN	00111
--MOV	01000
--ADD	01001
--MUL	01010
--SUB	01011
--AND	01100
--OR	01101
--SHL	01110
--SHR	01111
--PUSH	10000
--POP	10001
--JZ	10101
--JN	10110
--JC	10111
--JMP	11000
--CALL	11001
--RET	11010
--RTI	11011
--LDM	11100
--LDD	11101
--STD	11110

ARCHITECTURE CU OF ControlUnit IS
constant NOPop : std_logic_vector(4 downto 0):= "00000"; 
constant SETCop : std_logic_vector(4 downto 0):= "00001"; 
constant CLRCop : std_logic_vector(4 downto 0):= "00010"; 
constant NOTop : std_logic_vector(4 downto 0):= "00011"; 
constant INCop : std_logic_vector(4 downto 0):= "00100"; 
constant DECop : std_logic_vector(4 downto 0):= "00101";
constant OUTop : std_logic_vector(4 downto 0):= "00110"; 
constant INop : std_logic_vector(4 downto 0):= "00111"; 
constant MOVop : std_logic_vector(4 downto 0):= "01000"; 
constant ADDop : std_logic_vector(4 downto 0):= "01001"; 
constant MULop : std_logic_vector(4 downto 0):= "01010"; 
constant SUBop : std_logic_vector(4 downto 0):= "01011";
constant ANDop : std_logic_vector(4 downto 0):= "01100"; 
constant ORop : std_logic_vector(4 downto 0):= "01101"; 
constant SHLop : std_logic_vector(4 downto 0):= "01110"; 
constant SHRop : std_logic_vector(4 downto 0):= "01111"; 
constant PUSHop : std_logic_vector(4 downto 0):= "10000"; 
constant POPop : std_logic_vector(4 downto 0):= "10001"; 
constant JZop : std_logic_vector(4 downto 0):= "10101"; 
constant JNop : std_logic_vector(4 downto 0):= "10110"; 
constant JCop : std_logic_vector(4 downto 0):= "10111"; 
constant JMPop : std_logic_vector(4 downto 0):= "11000"; 
constant CALLop : std_logic_vector(4 downto 0):= "11001"; 
constant RETop : std_logic_vector(4 downto 0):= "11010"; 
constant RTIop : std_logic_vector(4 downto 0):= "11011"; 
constant LDMop : std_logic_vector(4 downto 0):= "11100"; 
constant LDDop : std_logic_vector(4 downto 0):= "11101"; 
constant STDop : std_logic_vector(4 downto 0):= "11110"; 

signal  jz , jn ,jc ,j,callsig  :  std_logic;

BEGIN
wb<= '0' When opcode = NOPop OR opcode = SETCop OR opcode = CLRCop OR opcode = OUTop OR opcode = PUSHop OR opcode = STDop OR opcode = JZop OR opcode = JNop OR opcode = JCop OR opcode = JMPop OR opcode = CALLop OR opcode = RETop OR opcode = RTIop
Else '1' ;

wb2<= '1' When opcode = MULop 
Else '0' ;

mem_wr<= '1' When opcode = PUSHop OR opcode = STDop OR opcode = CALLop
Else '0';

setc <= '1' When opcode = SETCop OR opcode = ADDop OR opcode = MULop OR opcode = SUBop OR opcode = SHLop OR opcode = SHRop OR opcode = NOTop OR opcode = INCop OR opcode = DECop
Else '0';

clc <= '1' When opcode = CLRCop OR opcode = ADDop OR opcode = MULop OR opcode = SUBop OR opcode = SHLop OR opcode = SHRop OR opcode = NOTop OR opcode = INCop OR opcode = DECop
Else '0';

zn <= '1' When opcode = NOTop OR opcode = INCop OR opcode = DECop OR opcode = ADDop OR opcode = MULop OR opcode = SUBop OR opcode = ANDop OR opcode = ORop  OR opcode = SHLop OR opcode = SHRop
Else '0' ;


alu_op <= "000" When opcode = NOTop
Else "001" When opcode = INCop OR opcode = ADDop 
Else "010" When opcode = SUBop OR opcode = DECop
Else "011" When opcode = ANDop
Else "100" When opcode = ORop
Else "101" When opcode = SHLop
Else "110" When opcode = SHRop
Else "111" When opcode = MULop
Else "XXX";	

reg_src <= '1' When opcode = NOTop OR opcode = INCop OR opcode = DECop OR opcode = OUTop OR opcode = INop OR opcode = MOVop OR opcode = ADDop OR opcode = MULop OR opcode = SUBop OR opcode = ANDop OR opcode = ORop OR opcode = SHLop OR opcode = SHRop OR opcode = LDMop
Else '0' When opcode = POPop OR opcode = LDDop
Else 'X';
 
alu_src_2 <= '1' When opcode = INCop OR opcode = DECop
Else '0' When opcode = ADDop OR opcode = MULop OR opcode = SUBop OR opcode = ANDop OR opcode = ORop OR opcode = SHLop OR opcode = SHRop
Else 'X';

output_enable <= '1' When opCode = OUTop
Else '0';


reg_addr_src <= '1' When opCode = MOVop OR opcode = ADDop OR opcode = MULop OR opcode = SUBop  OR opcode = ANDop  OR opcode = ORop
Else '0' When opCode = NOTop OR opcode = INCop OR opcode = DECop OR opcode = OUTop OR opcode = INop OR opcode = SHLop OR opcode = SHRop OR opcode = POPop OR opcode = LDMop OR opcode = LDDop OR opcode = STDop
Else 'X';

res_sel <= "00" When opcode = NOTop  OR opcode = INCop  OR opcode = DECop OR opcode = ADDop OR opcode = MULop OR opcode = SUBop OR opcode = ANDop OR opcode = ORop OR opcode = SHLop OR opcode = SHRop
Else "01" When opcode = OUTop OR opcode = MOVop OR opcode = PUSHop  OR opcode = STDop
Else "10" When opcode = INop
Else "11" When opcode = LDMop
Else "XX";

data_2_sel <= '1' When opcode = SHLop OR opcode = SHRop
Else '0' When opcode = ADDop OR opcode = MULop  OR opcode = SUBop OR opcode = ANDop OR opcode = ORop
Else 'X';
 
stall_fetch<= '1' When opcode = PUSHop OR opcode = POPop OR opcode = LDDop OR opcode = STDop OR opcode = CALLop OR opcode = RETop OR opcode = RTIop
Else '0' ;

SPEN <= '1' When opcode = PUSHop OR  opcode = POPop OR  opcode = CALLop OR  opcode = RETop OR  opcode = RTIop
Else '0';

sp_add <= "00" When opcode = PUSHop
Else "01" When opcode = POPop
Else "10" When opcode = CALLop
Else "11" When opcode = RETop OR  opcode = RTIop
Else "XX";

mem_addr_src <= "01" When opcode = PUSHop OR  opcode = CALLop 
Else "10" When opcode = LDDop OR  opcode = STDop 
Else "11" When opcode = POPop OR  opcode = RETop OR  opcode = RTIop
Else "00" ;

callsig <= '1' When opcode = CALLop
Else '0';

jz <= '1' When opcode = JZop
Else '0' ; 

jn <= '1' When opcode = JNop
Else '0' ;

jc <= '1' When opcode = JCop
Else '0' ;

j<= '1' When opcode = JMPop
Else '0';
 
ret<= '1' When opcode = RETop OR opcode = RTIop
Else '0' ;


pc_src <= callsig or j or (z_flag and jz) or (n_flag and jn) or (c_flag and jc);

call <= callsig;
opCode_out<=opcode;

END CU;
Library ieee;
use ieee.std_logic_1164.all;

ENTITY ControlUnit IS
PORT   (
		 WB, MEMWR , SETC , CLC , Z , N : OUT std_logic;
		
		 UNKNOWN1 : OUT std_logic_vector( 2 DOWNTO 0);
		 
		 REGSRC , ALUSRC2 , OUTPUTENABLE , UNKNOWN2 : OUT std_logic; 
		 
		 RESSEL : OUT std_logic_vector( 1 DOWNTO 0);

		 DATA2SEL , STALLFETCH , SPEN  : OUT std_logic;
		 
		 SPADD , UNKNOWN3 : OUT std_logic_vector( 1 DOWNTO 0);
		 
		 CALL , JZ , JN ,JC ,J ,RET : OUT std_logic;
		
		 OpCode : IN std_logic_vector( 4 DOWNTO 0)
	);

END ControlUnit;

--NOP   00000
--SETC  00001
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
constant ANDop : std_logic_vector(4 downto 0):= "01011"; 
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


BEGIN
WB<= '0' When OpCode = NOPop OR OpCode = SETCop OR OpCode = CLRCop OR OpCode = OUTop OR OpCode = PUSHop OR OpCode = STDop OR OpCode = JZop OR OpCode = JNop OR OpCode = JCop OR OpCode = JMPop OR OpCode = CALLop OR OpCode = RETop OR OpCode = RTIop
Else '1' ;

MEMWR<= '1' When OpCode = PUSHop OR OpCode = STDop OR OpCode = CALLop
Else '0';

SETC <= '1' When OpCode = SETCop OR OpCode = ADDop OR OpCode = MULop OR OpCode = SUBop OR OpCode = SHLop OR OpCode = SHRop
Else '0';

CLC <= '1' When OpCode = CLRCop OR OpCode = ADDop OR OpCode = MULop OR OpCode = SUBop OR OpCode = SHLop OR OpCode = SHRop
Else '0';

Z <= '1' When OpCode = NOTop OR OpCode = INCop OR OpCode = DECop OR OpCode = ADDop OR OpCode = MULop OR OpCode = SUBop OR OpCode = ANDop OR OpCode = ORop  OR OpCode = SHLop OR OpCode = SHRop
Else '0' ;

N <= '1' When OpCode = NOTop OR OpCode = INCop OR OpCode = DECop OR OpCode = ADDop OR OpCode = MULop OR OpCode = SUBop OR OpCode = ANDop OR OpCode = ORop  OR OpCode = SHLop OR OpCode = SHRop
Else '0' ;

UNKNOWN1 <= "000" When OpCode = NOTop
Else "001" When OpCode = INCop OR OpCode = ADDop OR OpCode = MULop
Else "010" When OpCode = SUBop OR OpCode = DECop
Else "011" When OpCode = ANDop
Else "100" When OpCode = ORop
Else "101" When OpCode = SHLop
Else "110" When OpCode = SHRop
Else "XXX";

REGSRC <= '1' When OpCode = NOTop OR OpCode = INCop OR OpCode = DECop OR OpCode = OUTop OR OpCode = INop OR OpCode = MOVop OR OpCode = ADDop OR OpCode = MULop OR OpCode = SUBop OR OpCode = ANDop OR OpCode = ORop OR OpCode = SHLop OR OpCode = SHRop OR OpCode = LDMop
Else '0' When OpCode = POPop OR OpCode = LDDop
Else 'X';
 
ALUSRC2 <= '1' When OpCode = INCop OR OpCode = DECop
Else '0' When OpCode = ADDop OR OpCode = MULop OR OpCode = SUBop OR OpCode = ANDop OR OpCode = ORop OR OpCode = SHLop OR OpCode = SHRop
Else 'X';

OUTPUTENABLE <= '1' When opCode = OUTop
Else '0';


UNKNOWN2 <= '1' When opCode = MOVop OR OpCode = ADDop OR OpCode = MULop OR OpCode = SUBop  OR OpCode = ANDop  OR OpCode = ORop
Else '0' When opCode = NOTop OR OpCode = INCop OR OpCode = DECop OR OpCode = OUTop OR OpCode = INop OR OpCode = SHLop OR OpCode = SHRop OR OpCode = POPop OR OpCode = LDMop OR OpCode = LDDop OR OpCode = STDop
Else 'X';

RESSEL <= "00" When OpCode = NOTop  OR OpCode = INCop  OR OpCode = DECop OR OpCode = ADDop OR OpCode = MULop OR OpCode = SUBop OR OpCode = ANDop OR OpCode = ORop OR OpCode = SHLop OR OpCode = SHRop
Else "01" When OpCode = OUTop OR OpCode = MOVop OR OpCode = PUSHop  OR OpCode = STDop
Else "10" When OpCode = INop
Else "11" When OpCode = LDMop
Else "XX";

DATA2SEL <= '1' When OpCode = SHLop OR OpCode = SHRop
Else '0' When OpCode = ADDop OR OpCode = MULop  OR OpCode = SUBop OR OpCode = ANDop OR OpCode = ORop
Else 'X';
 
STALLFETCH<= '1' When OpCode = PUSHop OR OpCode = POPop OR OpCode = LDDop OR OpCode = STDop OR OpCode = CALLop OR OpCode = RETop OR OpCode = RTIop
Else '0' ;

SPEN <= '1' When OpCode = PUSHop OR  OpCode = POPop OR  OpCode = CALLop OR  OpCode = RETop OR  OpCode = RTIop
Else '0';

SPADD <= "00" When OpCode = PUSHop
Else "01" When OpCode = POPop
Else "10" When OpCode = CALLop
Else "11" When OpCode = RETop OR  OpCode = RTIop
Else "XX";

UNKNOWN3 <= "01" When OpCode = PUSHop OR  OpCode = CALLop 
Else "10" When OpCode = LDDop OR  OpCode = STDop 
Else "11" When OpCode = POPop OR  OpCode = RETop OR  OpCode = RTIop
Else "00" ;

CALL <= '1' When OpCode = CALLop
Else '0';

JZ <= '1' When OpCode = JZop
Else '0' ; 

JN <= '1' When OpCode = JNop
Else '0' ;

JC <= '1' When OpCode = JCop
Else '0' ;

J<= '1' When OpCode = JMPop
Else '0';
 
RET<= '1' When OpCode = RETop OR OpCode = RTIop
Else '0' ;

END CU;
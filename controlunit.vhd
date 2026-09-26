library ieee;
use ieee.std_logic_1164.all;

entity control_unit is 
   port(
	   --in
	   clk:in std_logic;
		reset:in std_logic;
		opcode:in std_logic_vector(5 downto 0);
		--out
		RegDst:out std_logic;
		RegWrite:out std_logic;
		ALUsrcA:out std_logic;
		ALUsrcB:out std_logic_vector(1 downto 0);
		ALUop:out std_logic_vector(1 downto 0);
		PCsource:out std_logic_vector(1 downto 0);
		PCWriteCond:out std_logic;
		PCWrite:out std_logic;
		IorD:out std_logic;
		MemRead:out std_logic;
		MemWrite:out std_logic;
		MemtoReg:out std_logic;
		IRWrite:out std_logic);
end control_unit;
		
architecture arch of control_unit is
type state_type is (Fetch,Decode,Execute,Writememory,Writeback);
signal current_state:state_type;
signal controlunit_out:std_logic_vector(15 downto 0);
begin 
    process(clk,reset) is
	 begin
	    if(reset='1') then 
		    current_state<=Fetch;
		elsif(rising_edge(clk)) then
		    case current_state is
			     when Fetch => current_state<=Decode;
				  when Decode =>if(opcode="000010") then current_state<=Fetch;
				                else                     current_state<=Execute;
									 end if;
				  when Execute => if (opcode="000100") then --beq
				                                          current_state<=Fetch;
										elsif (opcode="101011") then  --sw               
									                     	   current_state<=Writememory;
										elsif (opcode="100011") then  --lw               
									                     	   current_state<=Writememory;
													
										else 
										                        current_state<=Writeback;
										end if;
				 when Writememory =>if (opcode="101011") then
				                                          current_state<=Fetch;--sw
											else     
											                     current_state<=Writeback;--lw
											end if;
				 when Writeback => current_state<=Fetch;
				 when others => current_state<=Fetch;
			  end case;
		end if;
	end process;
	
	controlunit_out<="1001010000001000" when current_state=Fetch else
	                 "0000000000011000" when (current_state=Decode AND opcode/="000010") else
						  --jump
						  "0000010100011000" when (current_state=Decode AND opcode="000010") else
						  --addi
						  "0000000000010100" when (current_state=Execute AND opcode="001000") else
						  "0000000000000010" when (current_state=Writeback AND opcode="001000") else
						  --R type
						  "0000000001000100" when (current_state=Execute AND opcode="000000") else
						  "0000000000000011" when (current_state=Writeback AND opcode="000000") else
						  --beq
						  "0000001010100100" when (current_state=Execute AND opcode="000100") else
						  --sw
						  "0000000000010100" when (current_state=Execute AND opcode="101011") else
						  "0010100000000000" when (current_state=Writememory AND opcode="101011") else
						  --lw
						  "0000000000010100" when (current_state=Execute AND opcode="100011") else
						  "0001100000000000" when (current_state=Writememory AND opcode="100011") else
						  "0100000000000010" when (current_state=Writeback AND opcode="100011") else
						  "0000000000000000" ;
	
	RegDst<=controlunit_out(0);
	RegWrite<=controlunit_out(1);
	ALUsrcA<=controlunit_out(2);
	ALUsrcB<=controlunit_out(4 downto 3);
	ALUop<=controlunit_out(6 downto 5);
	PCsource<=controlunit_out(8 downto 7);
	PCWriteCond<=controlunit_out(9);
	PCWrite<=controlunit_out(10);
	IorD<=controlunit_out(11);
	MemRead<=controlunit_out(12);
	MemWrite<=controlunit_out(13);
	MemtoReg<=controlunit_out(14);
	IRWrite<=controlunit_out(15);
	
end arch;	

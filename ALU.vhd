library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
   port(
	     operand1: in std_logic_vector(31 downto 0);
		  operand2: in std_logic_vector(31 downto 0);
		  ALU_control: in std_logic_vector(3 downto 0);
		  ALU_out:out std_logic_vector(31 downto 0);
		  zero:out std_logic);
end ALU;

architecture arch of ALU is
signal result:std_logic_vector(31 downto 0);
begin
   process(ALU_control,operand1,operand2)
	begin
	   case ALU_control is
		    when "0000"=>result<=std_logic_vector(unsigned(operand1) + unsigned(operand2));--add
			 when "0001"=>result<=std_logic_vector(unsigned(operand1) - unsigned(operand2));--sub
			 when "0010"=>result<=operand1 AND operand2;--AND
			 when "0011"=>result<=operand1 OR operand2;--OR
			 when "0100"=>result<=operand1 NOR operand2;--NOR
			 when "0101"=>result<=operand1 NAND operand2;--NAND
			 when "0110"=>result<=operand1 XOR operand2;--XOR
			 when "0111"=>result<=std_logic_vector(shift_left(unsigned(operand1),to_integer(unsigned(operand2(10 downto 6)))));--sll
			 when "1000"=>result<=std_logic_vector(shift_right(unsigned(operand1),to_integer(unsigned(operand2(10 downto 6)))));--srl
			 when "1001"=> if (unsigned(operand1) - unsigned(operand2)< 0) then 
			                       result<="00000000000000000000000000000001" ;
								else    
								        result<="00000000000000000000000000000000" ;
								end if;
			 when others=>result<=(others=>'0');
		end case;
		ALU_out<=result;
	end process;
	zero <= '1' when result = "00000000000000000000000000000000" else '0';
	
end arch;
		
			 

library ieee;
use ieee.std_logic_1164.all;

entity signextend is
   port(
	   --in
	   input:in std_logic_vector(15 downto 0);
		--out
		output:out std_logic_vector(31 downto 0));
		
end signextend;

architecture arch of signextend is
begin
   output<="0000000000000000" & input when input(15)='0' else
	         "1111111111111111" & input when input(15)='1';
end arch;
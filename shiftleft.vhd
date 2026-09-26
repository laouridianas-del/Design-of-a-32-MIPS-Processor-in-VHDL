library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftleft is 
   port(
	   input:in std_logic_vector(31 downto 0);
		output:out std_logic_vector(31 downto 0)
	);
end shiftleft;

architecture arch of shiftleft is
begin 
   output<=std_logic_vector(unsigned(input) sll 2);
end arch;


	
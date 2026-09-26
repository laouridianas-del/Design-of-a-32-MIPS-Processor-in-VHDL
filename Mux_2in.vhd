library ieee;
use ieee.std_logic_1164.all;

entity Mux_2in is
   port(
	   --in
	   input1:in std_logic_vector(31 downto 0);
		input2:in std_logic_vector(31 downto 0);
		Mux_select:in std_logic;
		--out
		output:out std_logic_vector(31 downto 0) 
		);
end Mux_2in;

architecture arch of Mux_2in is
begin
   with Mux_select select
	   output<=input1 when '0',
		        input2 when '1';
end arch;

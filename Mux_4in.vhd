library ieee;
use ieee.std_logic_1164.all;

entity Mux_4in is
   port(
	   --in
	   input1:in std_logic_vector(31 downto 0);
		input2:in std_logic_vector(31 downto 0);
		input3:in std_logic_vector(31 downto 0);
		input4:in std_logic_vector(31 downto 0);
		mux_select:in std_logic_vector(1 downto 0);
		--out
		output:out std_logic_vector(31 downto 0));
end Mux_4in;

architecture arch of Mux_4in is
begin
   with mux_select select 
	   output<=input1 when "00",
		        input2 when "01",
				  input3 when "10",
				  input4 when "11",
				  "00000000000000000000000000000000" when others;
end arch;
				  

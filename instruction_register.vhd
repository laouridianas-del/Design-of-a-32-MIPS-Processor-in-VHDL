library ieee;
use ieee.std_logic_1164.all;

entity instruction_register is 
   port(
	   --in
	   instruction_in:in std_logic_vector(31 downto 0);
		clk:in std_logic;
		reset:in std_logic;
		IRW:in std_logic;
		--out
		instruction_out:out std_logic_vector(31 downto 0));
end instruction_register;

architecture arch of instruction_register is
signal instruction_sig:std_logic_vector(31 downto 0);
begin
   process(clk,reset) is
	begin
	   if(reset='1') then
		
		   instruction_sig<=(others=>'0');
			
		elsif(rising_edge(clk) AND IRW='1') then
		
		   instruction_sig<=instruction_in;
			
		end if;
	end process;
	instruction_out<=instruction_sig;
end arch;
   
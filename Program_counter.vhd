library ieee;
use ieee.std_logic_1164.all;

entity PC is
   port(
	   PC_previous:in std_logic_vector(31 downto 0);
		PC_En:in std_logic;
		clk:in std_logic;
		reset:in std_logic;
		PC_Next:out std_logic_vector(31 downto 0)
		);
end PC;

architecture arch of PC is 
begin
   process(clk) is 
	begin
	   if (reset='1') then
	      PC_Next<=(others=>'0');
	   elsif(rising_edge(clk) AND (PC_En='1')) then
	      PC_Next<=PC_previous;
		end if;
	end process;
end arch;
	
	   
	
	
	   
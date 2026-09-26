library ieee;
use ieee.std_logic_1164.all;

entity Tempregisters is
   port(
	   --in
		clk:in std_logic;
		reset:in std_logic;
		regA_in:in std_logic_vector(31 downto 0);
		regB_in:in std_logic_vector(31 downto 0);
		ALUOut_in:in std_logic_vector(31 downto 0);
		--out
		regA_out:out std_logic_vector(31 downto 0);
		regB_out:out std_logic_vector(31 downto 0);
		ALUOut_out:out std_logic_vector(31 downto 0));
end Tempregisters;

architecture arch of Tempregisters is
type registers is array(0 to 2) of std_logic_vector(31 downto 0);
signal data:registers :=(others=>(others=>'0'));
begin
   process(clk,reset) is
	begin
	   if(reset='1') then 
		   data<=(others=>(others=>'0'));
		elsif(rising_edge(clk)) then 
		   data(0)<=regA_in;
			data(1)<=regB_in;
			data(2)<=ALUOut_in;
		end if;
	end process;
	regA_out<=data(0);
	regB_out<=data(1);
	ALUOut_out<=data(2);
end arch;
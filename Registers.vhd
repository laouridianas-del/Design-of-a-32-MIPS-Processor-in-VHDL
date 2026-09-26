library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registersfile is
   port(
	   --in
	   Read_register1:in std_logic_vector(4 downto 0);
		Read_register2:in std_logic_vector(4 downto 0);
		Write_register:in std_logic_vector(4 downto 0);
		write_data:in std_logic_vector(31 downto 0);
		Regwrite:in std_logic;
		clk:in std_logic;
		reset:in std_logic;
		--out
		Read_data1:out std_logic_vector(31 downto 0);
		Read_data2:out std_logic_vector(31 downto 0));
end Registersfile;

architecture arch of Registersfile is
type tableau is array(0 to 31) of std_logic_vector(31 downto 0);
signal Registers:tableau:=(others => (others=>'0'));
begin
   process(clk,reset) is
	begin
	   if(reset='1') then
		   Registers<=(others => (others=>'0'));
		elsif(rising_edge(clk) AND Regwrite='1') then
		   Registers(to_integer(unsigned(Write_register)))<=write_data;
		end if;
	end process;
	Read_data1<=Registers(to_integer(unsigned(Read_register1)));
	Read_data2<=Registers(to_integer(unsigned(Read_register2)));
end arch;
		   
		   
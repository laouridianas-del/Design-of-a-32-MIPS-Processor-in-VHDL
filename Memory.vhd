library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory is
   port(
	   --in
	   Address:in std_logic_vector(31 downto 0);
		Writedata:in std_logic_vector(31 downto 0);
		Memread:in std_logic;
		Memwrite:in std_logic;
		clk:in std_logic;
		reset:in std_logic;
		--out
		Memdata:out std_logic_vector(31 downto 0)
		);
end Memory;

architecture arch of Memory is

type Tableau is array (0 to 63) of std_logic_vector(7 downto 0);
signal Mem: Tableau := (
      
		--addi $R2,$R0,1
	   0=>"00100000",
		1=>"00000010",
		2=>"00000000",
		3=>"00000001",
		--addi $R1,$R0,2
	   4=>"00100000",
		5=>"00000001",
		6=>"00000000",
		7=>"00000010",
	   --add $R3,$R1,$R2
	   8=>"00000000",
		9=>"00100010",
		10=>"00011000",
		11=>"00100000",
		--sub $R4,$R3,$R2
	   12=>"00000000",
		13=>"01100010",
		14=>"00100000",
		15=>"00100010",
		--beq $R4,$R1,1
	   16=>"00010000",
		17=>"10000001",
		18=>"00000000",
		19=>"00000001",
		-- j 6
	   20=>"00001000",
		21=>"00000000",
		22=>"00000000",
		23=>"00000110",
		--sw $R2,0($R0)
	   24=>"10101100",
		25=>"00000010",
		26=>"00000000",
		27=>"00000000",
		--lw $R4,0($R0)
	   28=>"10001100",
		29=>"00000100",
		30=>"00000000",
		31=>"00000000",
		--sub $R5,$R4,$R2
	   32=>"00000000",
		33=>"10000010",
		34=>"00101000",
		35=>"00100010",
		-- j 6
	   36=>"00001000",
		37=>"00000000",
		38=>"00000000",
		39=>"00000110",
		others=>"00000000");
begin
   process(clk,reset) is
	begin
	   --if (reset='1') then
		  -- mem<=(others=>(others=>'0'));
		if(rising_edge(clk) AND (Memwrite='1')) then
		   mem(to_integer(unsigned(Address)))<=Writedata(31 downto 24);
			mem(to_integer(unsigned(Address)) + 1)<=Writedata(23 downto 16);
			mem(to_integer(unsigned(Address)) + 2)<=Writedata(15 downto 8);
			mem(to_integer(unsigned(Address)) + 3)<=Writedata(7 downto 0);
		end if;
	end process ;
	Memdata <= mem(to_integer(unsigned(Address))) &
	           mem(to_integer(unsigned(Address)) + 1) &
				  mem(to_integer(unsigned(Address)) + 2) &
				  mem(to_integer(unsigned(Address)) + 3) when Memread = '1';
end arch;
	
			


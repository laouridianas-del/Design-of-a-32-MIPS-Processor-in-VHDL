library ieee;
use ieee.std_logic_1164.all;

entity mips32_multicycle is 
    port(
	 clk:in std_logic;
	 reset:in std_logic;
	 P_Count:out std_logic_vector(31 downto 0);
	 SRC1:out std_logic_vector(31 downto 0);
	 SRC2:out std_logic_vector(31 downto 0);
	 ALU_result:out std_logic_vector(31 downto 0);
	 Memoryoutput:out std_logic_vector(31 downto 0)
	 );
end mips32_multicycle;

architecture arch of mips32_multicycle is

component ALU is
   port(
	     operand1: in std_logic_vector(31 downto 0);
		  operand2: in std_logic_vector(31 downto 0);
		  ALU_control: in std_logic_vector(3 downto 0);
		  ALU_out:out std_logic_vector(31 downto 0);
		  zero:out std_logic);
end component;

component ALUControl is
  port( 
        -- input
        ALUOp   : in std_logic_vector(1 downto 0);
        instr   : in std_logic_vector(5 downto 0);

        -- output
        result      : out std_logic_vector(3 downto 0) );
end component;

component control_unit is 
   port(
	   --in
	   clk:in std_logic;
		reset:in std_logic;
		opcode:in std_logic_vector(5 downto 0);
		--out
		RegDst:out std_logic;
		RegWrite:out std_logic;
		ALUsrcA:out std_logic;
		ALUsrcB:out std_logic_vector(1 downto 0);
		ALUop:out std_logic_vector(1 downto 0);
		PCsource:out std_logic_vector(1 downto 0);
		PCWriteCond:out std_logic;
		PCWrite:out std_logic;
		IorD:out std_logic;
		MemRead:out std_logic;
		MemWrite:out std_logic;
		MemtoReg:out std_logic;
		IRWrite:out std_logic);
end component;

component instruction_register is 
   port(
	   --in
	   instruction_in:in std_logic_vector(31 downto 0);
		clk:in std_logic;
		reset:in std_logic;
		IRW:in std_logic;
		--out
		instruction_out:out std_logic_vector(31 downto 0));
end component;

component Memory is
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
end component;

component Memorydataregister is 
   port(
	   --in
	   data_in:in std_logic_vector(31 downto 0);
		clk:in std_logic;
		reset:in std_logic;
		--out
      data_out:out std_logic_vector(31 downto 0));
end component;

component Mux_2in is
   port(
	   --in
	   input1:in std_logic_vector(31 downto 0);
		input2:in std_logic_vector(31 downto 0);
		Mux_select:in std_logic;
		--out
		output:out std_logic_vector(31 downto 0) 
		);
end component;

component Mux_2in5 is
   port(
	   --in
	   input1:in std_logic_vector(4 downto 0);
		input2:in std_logic_vector(4 downto 0);
		Mux_select:in std_logic;
		--out
		output:out std_logic_vector(4 downto 0) 
		);
end component;

component Mux_3in is
   port(
	   --in
	   input1:in std_logic_vector(31 downto 0);
		input2:in std_logic_vector(31 downto 0);
		input3:in std_logic_vector(31 downto 0);
		mux_select:in std_logic_vector(1 downto 0);
		--out
		output:out std_logic_vector(31 downto 0));
end component;

component Mux_4in is
   port(
	   --in
	   input1:in std_logic_vector(31 downto 0);
		input2:in std_logic_vector(31 downto 0);
		input3:in std_logic_vector(31 downto 0);
		input4:in std_logic_vector(31 downto 0);
		mux_select:in std_logic_vector(1 downto 0);
		--out
		output:out std_logic_vector(31 downto 0));
end component;

component PC is
   port(
	   PC_previous:in std_logic_vector(31 downto 0);
		PC_En:in std_logic;
		clk:in std_logic;
		reset:in std_logic;
		PC_Next:out std_logic_vector(31 downto 0)
		);
end component;

component Registersfile is
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
end component;

component shiftleft is 
   port(
	   input:in std_logic_vector(31 downto 0);
		output:out std_logic_vector(31 downto 0)
	);
end component;

component shiftleft2 is 
   port(
	   input:in std_logic_vector(25 downto 0);
		output:out std_logic_vector(27 downto 0)
	);
end component;

component signextend is
   port(
	   --in
	   input:in std_logic_vector(15 downto 0);
		--out
		output:out std_logic_vector(31 downto 0));
		
end component;

component Tempregisters is
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
end component;
--constant
constant PC_increment:std_logic_vector(31 downto 0) :="00000000000000000000000000000100";
--signals
signal PC_out,MuxtoPC,ALUout_tomux,regA_in,regA_out,regB_in,regB_out,MemDataout,instructionRegout,signextend_out,shiftleft_out,Jumpaddress,ALUin1,ALUin2,ALUresult,Memdatareg_out,muxtomemory,muxtowriteData:std_logic_vector(31 downto 0);
signal IoD_TL,IRWrite_TL,MemtoReg_TL,MemWrite_TL,MemRead_TL,PCWrite_TL,PCWrite_Cond_TL,ALUsrcA_TL,RegWrite_TL,RegDst_TL:std_logic;
signal Zero_TL,ANDtoOR,ORtoPC:std_logic;
signal ALUsrcB_TL,ALUop_TL,PCSource_TL:std_logic_vector(1 downto 0);
signal ALUControltoALU : std_logic_vector(3 downto 0);
signal muxtowriteregister : std_logic_vector(4 downto 0);

begin
   jumpaddress(31 downto 28)<=PC_out(31 downto 28);
   ANDtoOR<= Zero_TL AND PCWrite_Cond_TL;
   ORtoPC<= ANDtoOR OR PCWrite_TL;
	--
	ArithLOgunit:ALU port map(ALUin1,ALUin2,ALUControltoALU,ALUresult,Zero_TL);
	ArithLOgControl:ALUControl port map(ALUop_TL,instructionRegout(5 downto 0),ALUControltoALU);
	Ctrl_unit:control_unit port map(clk,reset,instructionRegout(31 downto 26),RegDst_TL,RegWrite_TL,ALUsrcA_TL,ALUsrcB_TL,ALUop_TL,PCSource_TL,PCWrite_Cond_TL,PCWrite_TL,IoD_TL,MemRead_TL,MemWrite_TL,MemtoReg_TL,IRWrite_TL);
	instr_reg:instruction_register port map(MemDataout,clk,reset,IRWrite_TL,instructionRegout);
	Mem:Memory port map(muxtomemory,regB_out,MemRead_TL,MemWrite_TL,clk,reset,MemDataout);
	MemdataReg:Memorydataregister port map(MemDataout,clk,reset,Memdatareg_out);
	Muxtomem:Mux_2in port map(PC_out,ALUout_tomux,IoD_TL,muxtomemory);
	Mux_toWritedata:Mux_2in port map(ALUout_tomux,Memdatareg_out,MemtoReg_TL,muxtowriteData);
	Mux_toALUinput1:Mux_2in port map(PC_out,regA_out,ALUsrcA_TL,ALUin1);
	Mux_towriteregister:Mux_2in5 port map(instructionRegout(20 downto 16),instructionRegout(15 downto 11),RegDst_TL,muxtowriteregister);
	Mux_toPC:Mux_3in port map(ALUresult,ALUout_tomux,Jumpaddress,PCSource_TL,MuxtoPC);
	Mux4_inputs:Mux_4in port map(regB_out,PC_increment,signextend_out,shiftleft_out,ALUsrcB_TL,ALUin2);
	ProCounter:PC port map(MuxtoPC,ORtoPC,clk,reset,PC_out);
	Registers:Registersfile port map(instructionRegout(25 downto 21),instructionRegout(20 downto 16),muxtowriteregister,muxtowriteData,RegWrite_TL,clk,reset,regA_in,regB_in);
	shiftll:shiftleft port map(signextend_out,shiftleft_out);
	shiftll2:shiftleft2 port map(instructionRegout(25 downto 0),Jumpaddress(27 downto 0));
	sign_extend:signextend port map(instructionRegout(15 downto 0),signextend_out);
	Temp_registers:Tempregisters port map(clk,reset,regA_in,regB_in,ALUresult,regA_out,regB_out,ALUout_tomux);
	
	P_Count<=PC_out;
	SRC1<= ALUin1;
	SRC2<=ALUin2;
	ALU_result<=ALUresult;
	Memoryoutput<=MemDataout;
	
end arch;
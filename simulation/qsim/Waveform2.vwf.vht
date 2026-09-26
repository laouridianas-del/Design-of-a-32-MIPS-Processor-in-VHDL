-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "09/23/2026 23:50:15"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          mips32_multicycle
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY mips32_multicycle_vhd_vec_tst IS
END mips32_multicycle_vhd_vec_tst;
ARCHITECTURE mips32_multicycle_arch OF mips32_multicycle_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL ALUSOURCEB : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL instruction_TLL : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Memoryoutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Pro_counter : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL Resultat : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL shiftoutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL signEXtendoutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL SRC1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL SRC2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
COMPONENT mips32_multicycle
	PORT (
	ALUSOURCEB : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
	clk : IN STD_LOGIC;
	instruction_TLL : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	Memoryoutput : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	Pro_counter : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	reset : IN STD_LOGIC;
	Resultat : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	shiftoutput : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	signEXtendoutput : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	SRC1 : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	SRC2 : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : mips32_multicycle
	PORT MAP (
-- list connections between master ports and signals
	ALUSOURCEB => ALUSOURCEB,
	clk => clk,
	instruction_TLL => instruction_TLL,
	Memoryoutput => Memoryoutput,
	Pro_counter => Pro_counter,
	reset => reset,
	Resultat => Resultat,
	shiftoutput => shiftoutput,
	signEXtendoutput => signEXtendoutput,
	SRC1 => SRC1,
	SRC2 => SRC2
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
LOOP
	clk <= '0';
	WAIT FOR 50000 ps;
	clk <= '1';
	WAIT FOR 50000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clk;

-- reset
t_prcs_reset: PROCESS
BEGIN
	reset <= '1';
	WAIT FOR 70000 ps;
	reset <= '0';
WAIT;
END PROCESS t_prcs_reset;
END mips32_multicycle_arch;

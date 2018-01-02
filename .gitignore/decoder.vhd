LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

Entity decoder is
  Port(
    opcode: out std_logic_vector(4 downto 0);
    Instruction :in std_logic_vector(15 downto 0);
    RegSrc1: out std_logic_vector(2 downto 0);
    RegSrc2: out std_logic_vector(2 downto 0);
    RegDst: out std_logic_vector(2 downto 0)
  );
end decoder;

Architecture A_decoder of decoder is
Begin

opcode <= (Instruction(15 downto 11));


RegSrc1 <= Instruction(10 downto 8);


with Instruction(15 downto 11) select
RegSrc2 <= Instruction(7 downto 5) when "00001",
           Instruction(7 downto 5) when "00010",
	   Instruction(7 downto 5) when "00011",	
           Instruction(7 downto 5) when "00100",
           Instruction(7 downto 5) when "00101",
           "000"  when others;

with Instruction(15 downto 11) select
RegDst <=  "000" when "00000",
           Instruction(10 downto 8) when "01000",
	   Instruction(10 downto 8) when "01001",	
           Instruction(10 downto 8) when "11011",
           Instruction(10 downto 8) when "11100",
           Instruction(5 downto 3) when others;

    
end A_decoder;

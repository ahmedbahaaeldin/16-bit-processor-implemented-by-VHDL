LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

Entity FullAdder is 
port (
   A,B : in std_logic_vector(15 downto 0);
   Cin, Enable : in std_logic;
   Sum : out std_logic_vector(15 downto 0);
   Co : out std_logic);
end FullAdder;

Architecture Arch of FullAdder is 
Component BitAdder is 
port (
   A, B, Cin, Enable: in std_logic;
   Sum, Co : out std_logic);
end Component;
Signal C: std_logic_vector(15 downto 0);
begin
      Bit_0: BitAdder port map(A(0) , B(0) , Cin, Enable, Sum(0), C(0));
	G_1 : for I in 1 to 15 generate
          Bit_N :BitAdder port map(A(I) , B(I) , C(I-1), Enable, Sum(I), C(I));
        end generate;
      Co <= C(15);
end Arch;

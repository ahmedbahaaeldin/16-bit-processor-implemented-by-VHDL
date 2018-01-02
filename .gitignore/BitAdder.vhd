LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

Entity BitAdder is 
port (
   A, B, Cin, Enable : in std_logic;
   Sum, Co : out std_logic);
end BitAdder;

Architecture Arch of BitAdder is 
begin
Sum<=A xor B xor Cin;
Co<= (A and B) or (Cin and (A xor B));
end Arch;
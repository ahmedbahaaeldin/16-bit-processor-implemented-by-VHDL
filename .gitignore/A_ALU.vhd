Library ieee;
use ieee.std_logic_1164.all;

-- S   Cin=0  Cin=1
-- 00  A      Inc
-- 01  Add    Add+1
-- 10  Sub-1  Sub
-- 11  Dec    Clear

Entity a_ALU is
Port(A,B   :in std_logic_vector(15 downto 0);
         S :in std_logic_vector(1 downto 0);
Cin,Enable :in std_logic;
      Cout :out std_logic;
         F :out std_logic_vector(15 downto 0));
end Entity a_ALU;

Architecture ALSU of a_ALU is 
Component FullAdder is
port (
   A,B : in std_logic_vector(15 downto 0);
   Cin, Enable : in std_logic;
   Sum : out std_logic_vector(15 downto 0);
   Co : out std_logic);
end Component FullAdder;

signal sCin,sCout:std_logic;
signal sA,sB:std_logic_vector(15 downto 0);
begin 

sB <=  "0000000000000000" when (S="00") or(S="11"and Cin='1') else
      not B when S="10" else
      "1111111111111110" when S="11" else
      B;

sCin <= not Cin when S="11"else
     '0' when (S="11"and Cin='1') else
     Cin;

sA<="0000000000000000" when (S="11"and Cin='1') else
     A;

u:FullAdder port map(sA,sB,sCin,Enable,F,sCout);

Cout <= (not sCout) when S(1)='1' else 
        sCout;

end Architecture ALSU;

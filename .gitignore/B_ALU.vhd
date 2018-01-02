Library ieee;
use ieee.std_logic_1164.all;

-- S   
-- 00  SHR
-- 01  SHL  
-- 10  RRC
-- 11  RLC

Entity b_ALU is
Port(A,B    :in std_logic_vector(15 downto 0);
       S    :in std_logic_vector(1 downto 0);
       CIN  :in std_logic;
       COUT :out std_logic;
       F    :out std_logic_vector(15 downto 0));
end Entity b_ALU;

Architecture CompC of b_ALU is 
signal  X,Y,Z,N :std_logic_vector(15 downto 0);
begin 
X <= ('0'& A(15 downto 1)); --SHR
Y <= (A(14 downto 0) & '0');--SHL
Z <= (CIN & A(15 downto 1));--RRC
N <= (A(14 downto 0) & CIN);--RLC

COUT<= A(0);

with S Select
F <= X when "00",  --SHR
     Y when "01",  --SHL
     Z when "10",  --RRC
     N when others;--RLC


end Architecture CompC;
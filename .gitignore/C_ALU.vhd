
Library ieee;
use ieee.std_logic_1164.all;

-- S   
-- 00  And
-- 01  Or 
-- 10  Not
-- 11  Cout = Cin

Entity c_ALU is
Port(A,B    :in std_logic_vector(15 downto 0);
       S    :in std_logic_vector(1 downto 0);
       CIN  :in std_logic;
       COUT :out std_logic;
       F    :out std_logic_vector(15 downto 0));
end Entity c_ALU;

Architecture CompC of c_ALU is 
signal  L,M,N :std_logic_vector(15 downto 0);
begin 
L <= (A and B); --And
M <= (A or  B); --Or
N <=(Not A);    --Not

with S Select
F <= L when "00", --And
     M when "01", --Or
     N when "10", --NOT
     "XXXXXXXXXXXXXXXX" when others;


COUT <= CIN;

end Architecture CompC;

Library ieee;
use ieee.std_logic_1164.all;

-- S   
-- 00  And
-- 01  Or 
-- 10  RTC
-- 11  STC

Entity c_ALU is
Port(A,B    :in std_logic_vector(15 downto 0);
       S    :in std_logic_vector(1 downto 0);
       CIN  :in std_logic;
       COUT :out std_logic;
       F    :out std_logic_vector(15 downto 0));
end Entity c_ALU;

Architecture CompC of c_ALU is 
signal  X,Y :std_logic_vector(15 downto 0);
begin 
X <= (Not A);    --NOT
Y <= (A or  B);             --Or

with S Select
F <= X when "00",  --And
     Y when "01",  --Or
     "XXXXXXXXXXXXXXXX" when others;
with S Select
COUT <= '0' when "10",  --RTC
        '1' when "11",  --STC
        CIN when others;

end Architecture CompC;

Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fetch is
port(
clk:in std_logic;
PC:out integer range 0 to 1023;
instruction:out std_logic_vector(13 downto 0);
immvalue:out std_logic_vector(15 downto 0);
rst:in std_logic


);
end fetch;
Architecture fetchd of fetch is
component InstructionMem is
port ( clk : in std_logic;
we : in std_logic;
address : in integer range 0 to 1024;
immv:out std_logic_vector(15 downto 0);
datain : in std_logic_vector(15 downto 0);
dataout : out std_logic_vector(15 downto 0)
);
end component;
signal we:std_logic;
signal pcpass:integer range 0 to 1023;
signal datain1,instructions,immvv,dataout1:std_logic_vector(15 downto 0);
begin

u0: InstructionMem port map(clk,we,pcpass,immvv(15 downto 0),datain1(15 downto 0),instructions(15 downto 0));
Process (Clk)

begin

if(rst='1') then
pcpass<=0;


elsif rising_edge(clk) then

if(instructions(15 downto 11)="01000") or (instructions(15 downto 11)="01001") or (instructions(15 downto 11)="11011") then
pcpass<=pcpass+2;
instruction<=instructions(15 downto 2);
immvalue<=immvv(15 downto 0);

elsif(instructions(15 downto 11)="00001") or (instructions(15 downto 11)="00010") or (instructions(15 downto 11)="00011") or (instructions(15 downto 11)="00100") or (instructions(15 downto 11)="00101") or (instructions(15 downto 11)="00110") or (instructions(15 downto 11)="00111") or (instructions(15 downto 11)="01010") or (instructions(15 downto 11)="01010") or (instructions(15 downto 11)="01011") or (instructions(15 downto 11)="01100") or (instructions(15 downto 11)="01101") or (instructions(15 downto 11)="01110") or (instructions(15 downto 11)="01111") or (instructions(15 downto 11)="10000") or (instructions(15 downto 11)="10001") or (instructions(15 downto 11)="10010") or (instructions(15 downto 11)="10011") or (instructions(15 downto 11)="10100") or (instructions(15 downto 11)="10101") or (instructions(15 downto 11)="10110") or (instructions(15 downto 11)="10111") or (instructions(15 downto 11)="11000") or (instructions(15 downto 11)="11001") or (instructions(15 downto 11)="11010") 
 then
pcpass<=pcpass+1;
instruction<=instructions(15 downto 2);

end if;
end if;
end process;

PC<=pcpass;


end fetchd;
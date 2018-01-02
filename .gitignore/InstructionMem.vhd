library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
Entity InstructionMem is
port ( clk : in std_logic;
we : in std_logic;
address : in integer range 0 to 1023;
immv:out std_logic_vector(15 downto 0);
datain : in std_logic_vector(15 downto 0);
dataout : out std_logic_vector(15 downto 0) );
end entity InstructionMem;

architecture syncrama of InstructionMem is
type ram_type is array (0 to 1023) of std_logic_vector(15 downto 0);
signal ram : ram_type;
begin
process(clk) is
begin
if rising_edge(clk) then
    if we = '1' then
	ram(address) <= datain;
    end if;
end if;
end process;
dataout <= ram(address);
immv<=ram(address+1);
end architecture syncrama;



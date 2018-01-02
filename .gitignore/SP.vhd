library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all; 
 https://drive.google.com/drive/u/0/folders/0B_5qL7Itx9HGV0w0NlpiblZJVjQ
Entity SP is
port ( 
CLK ,RESET: in std_logic;
SIGPOP,SIGPUSH: in std_logic;
SP : out std_logic_vector(15 downto 0)
 );
end entity SP;

architecture ARCH of SP is
signal CURRENT: std_logic_vector(9 downto 0):="1111111111";
begin

process(CLK,RESET) is
begin

IF RESET='1' THEN
	CURRENT <=(OTHERS=> '0');
ELSIF (RESET='0' AND SIGPOP='1' AND rising_edge(clk)) THEN
        CURRENT <= CURRENT -1 ;
	ELSIF 
       (RESET='0' AND SIGPUSH='1'AND rising_edge(clk)) THEN
        CURRENT <= CURRENT +1 ; 
end if;

end process;
SP <= "000000"&CURRENT;
end architecture ARCH;

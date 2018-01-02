Library ieee;
Use ieee.std_logic_1164.all;

Entity my_nreg is
Generic ( n : integer := 8);
port( Clk,Rst,enable : in std_logic;
d : in std_logic_vector(n-1 downto 0);
q : out std_logic_vector(n-1 downto 0));
end my_nreg;

Architecture a_my_nDFF of my_nreg is
begin
Process (Clk,Rst,enable)
begin
if Rst = '1' then
q <= (others=>'0');
elsif rising_edge(Clk) then
if (enable='1') then 
q <= d;
end if;
end if;
end process;
end a_my_nDFF;


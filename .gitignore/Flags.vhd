Library ieee;
Use ieee.std_logic_1164.all;

Entity Flags is
Port 
( 
  clk, reset: in std_logic;
  FlagsIn: in std_logic_vector(3 downto 0);
  FlagsOut: out std_logic_vector(3 downto 0)
  );
end entity Flags;

architecture Flags_arch of Flags is
component my_nreg is
Generic ( n : integer := 16);
port( Clk,Rst,enable : in std_logic;
d : in std_logic_vector(n-1 downto 0);
q : out std_logic_vector(n-1 downto 0));
end component;
begin
FlagsReg: my_nreg generic map (n => 4) port map (clk,reset,'1',FlagsIn,FlagsOut);
end architecture Flags_arch;

Library ieee;
Use ieee.std_logic_1164.all;

Entity Register_File is
Port 
( 
  clk, reset: in std_logic;
  Read1, Read2, DSTselect: in std_logic_vector(2 downto 0);
  RegWrite: in std_logic;
  WB: in std_logic_vector(15 downto 0);
  Data1, Data2: out std_logic_vector(15 downto 0)
  );
end entity Register_File;

architecture RegFile_arch of Register_File is
component my_nreg is
Generic ( n : integer := 16);
port( Clk,Rst,enable : in std_logic;
d : in std_logic_vector(n-1 downto 0);
q : out std_logic_vector(n-1 downto 0));
end component;
SIGNAL sig1,sig2,sig3,sig4,sig5,sig6,sig7,sig8,sig9 : std_logic_vector(15 downto 0);
SIGNAL enable1,enable2,enable3,enable4,enable5,enable6,enable7,enable8,enable9 : std_logic;
SIGNAL O: std_logic_vector(2 downto 0);
begin
REG1: my_nreg generic map (n => 16) port map (clk,reset,enable1,WB,sig1);
REG2: my_nreg generic map (n => 16) port map (clk,reset,enable2,WB,sig2);
REG3: my_nreg generic map (n => 16) port map (clk,reset,enable3,WB,sig3);
REG4: my_nreg generic map (n => 16) port map (clk,reset,enable4,WB,sig4);
REG5: my_nreg generic map (n => 16) port map (clk,reset,enable5,WB,sig5);
REG6: my_nreg generic map (n => 16) port map (clk,reset,enable6,WB,sig6);
REG7: my_nreg generic map (n => 16) port map (clk,reset,enable7,WB,sig7);
REG8: my_nreg generic map (n => 16) port map (clk,reset,enable8,WB,sig8);


O <= DSTselect;

enable1 <= '1' when (RegWrite = '1' and O="000") else '0';
enable2 <= '1' when (RegWrite = '1' and O="001") else '0';
enable3 <= '1' when (RegWrite = '1' and O="010") else '0';
enable4 <= '1' when (RegWrite = '1' and O="011") else '0';
enable5 <= '1' when (RegWrite = '1' and O="100") else '0';
enable6 <= '1' when (RegWrite = '1' and O="101") else '0';
enable7 <= '1' when (RegWrite = '1' and O="110") else '0';
enable8 <= '1' when (RegWrite = '1' and O="111") else '0';

Data1 <= sig1 when Read1="000" else
         sig2 when Read1="001" else
         sig3 when Read1="010" else
	 sig4 when Read1="011" else
         sig5 when Read1="100" else
         sig6 when Read1="101" else
         sig7 when Read1="110" else
         sig8 when Read1="111" ;

Data2 <= sig1 when Read2="000" else
         sig2 when Read2="001" else
         sig3 when Read2="010" else
	 sig4 when Read2="011" else
         sig5 when Read2="100" else
         sig6 when Read2="101" else
         sig7 when Read2="110" else
         sig8 when Read2="111";
end architecture RegFile_arch;
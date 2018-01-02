LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

Entity CExe is
  Port(
    Clk, Reset, Enable, Oin, Cin, Zin, Nin, No_Op, Load, WriteB, Store, LImm, Add, Sub, Nand_0, RLC, RRC, Push, Pop, Out_0, In_0, Move: In std_logic;
    Reg_No1: In std_logic_vector(1 downto 0);
    Inst_In, RegData1, RegData2: In std_logic_vector(7 downto 0);
    --Out Control Signals
    Oout, Cout, Zout, Nout, No_Op_O, Load_O, WriteB_O, Store_O, LImm_O, Push_O, Pop_O, Out_0_O, In_0_O, Move_O: Out std_logic;
    Reg_No1_O: Out std_logic_vector(1 downto 0);
    Inst_Out, Result :Out std_logic_vector(7 downto 0)
  );
end CExe;

Architecture A_Execute of CExe is
Component FullAdder is 
port (
   A,B : in std_logic_vector(7 downto 0);
   Cin, Enable: in std_logic;
   Sum : out std_logic_vector(7 downto 0);
   Co : out std_logic);
end Component;
Component Nand_1 is
  Port(
    A, B : in std_logic_vector(7 downto 0);
    Result : out std_logic_vector(7 downto 0)
  );
end Component;
Component RRC_Entity is
  Port(
    A : in std_logic_vector(7 downto 0);
    Cin : in std_logic;
    Result : out std_logic_vector(7 downto 0);
    Cout : out std_logic
  );
end Component;
Component RLC_Entity is
  Port(
    A : in std_logic_vector(7 downto 0);
    Cin : in std_logic;
    Result : out std_logic_vector(7 downto 0);
    Cout : out std_logic
  );
end Component;
  Signal Reg_Data2_N, Result_Adder, Result_Subtractor, Result_Nand, Result_RRC, Result_RLC : std_logic_vector(7 downto 0);
  Signal Cout_Adder, Cout_Subtractor, Cout_RRC, Cout_RLC, Is_Z, Is_N : std_logic;
Begin
    No_Op_O <= No_Op;
    Load_O <= Load;
    WriteB_O <= WriteB;
    Store_O <= Store;
    LImm_O <= LImm;
    Push_O <= Push;
    Pop_O <= Pop;
    Out_0_O <= Out_0;
    In_0_O <= In_0;
    Move_O <= Move;
    Reg_No1_O <= Reg_No1 when Load = '1' or WriteB = '1' or Store = '1' or LImm = '1' or Add = '1' or Sub = '1' or Nand_0 = '1' or 
                  RLC = '1' or RRC = '1' or Push = '1' or Pop = '1' or Out_0 = '1' or In_0 = '1' or Move = '1' else "XX";
    Inst_Out <= Inst_In;
    Reg_Data2_N <= not RegData2;
    
    
    Adder: FullAdder Port Map(RegData1, RegData2, Cin, Add, Result_Adder, Cout_Adder);
    Subtractor: FullAdder Port Map(RegData1, Reg_Data2_N, '1', Sub, Result_Subtractor, Cout_Subtractor);
    Nand_Instance: Nand_1 Port Map(RegData1, RegData2, Result_Nand);
    RRC_Instance: RRC_Entity Port Map(RegData1, Cin, Result_RRC, Cout_RRC);
    RLC_Instance: RLC_Entity Port Map(RegData1, Cin, Result_RLC, Cout_RLC);
      
    Result <= Result_Adder when Add = '1' else
              Result_Subtractor when Sub = '1' else
              Result_Nand when Nand_0 = '1' else
              Result_RRC when RRC = '1' else
              Result_RLC when RLC = '1' else RegData1;
              
    Cout <= Cout_Adder when Add = '1' else
            Cout_Subtractor when Sub = '1' else
            Cin when Nand_0 = '1' else
            Cout_RRC when RRC = '1' else
            Cout_RLC when RLC = '1' else 
            '0' when Reset = '1' else Cin;
    
    Is_N <= '1' when Result_Adder(7) = '1' and Add = '1' else
            '1' when Result_Subtractor(7) = '1' and Sub = '1' else
            '1' when Result_Nand(7) = '1' and Nand_0 = '1' else
            '1' when Result_RRC(7) = '1' and RRC = '1' else
            '1' when Result_RLC(7) = '1' and RLC = '1' else '0';
            
    Nout <= '1' when Is_N = '1' and (Add = '1' or Sub = '1' or Nand_0 = '1' or RRC = '1' or RLC = '1') else
            '0' when Is_N = '0' and (Add = '1' or Sub = '1' or Nand_0 = '1' or RRC = '1' or RLC = '1') else Nin;
    
    Is_Z <= '1' when Result_Adder = "00000000" and Add = '1' else
            '1' when Result_Subtractor = "00000000" and Sub = '1' else
            '1' when Result_Nand = "00000000" and Nand_0 = '1' else
            '1' when Result_RRC = "00000000" and RRC = '1' else
            '1' when Result_RLC = "00000000" and RLC = '1' else '0';
            
    Zout <= '1' when Is_Z = '1' and (Add = '1' or Sub = '1' or Nand_0 = '1' or RRC = '1' or RLC = '1') else
            '0' when Is_Z = '0' and (Add = '1' or Sub = '1' or Nand_0 = '1' or RRC = '1' or RLC = '1') else Zin;
    
end A_Execute;




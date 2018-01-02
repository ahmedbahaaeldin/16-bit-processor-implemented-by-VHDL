LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;

Entity Execute is
  Port(
    Clk, Reset, Enable, Cin, Zin, Nin : In std_logic;
    Reg_No1: In std_logic_vector(2 downto 0);
         Si: In std_logic_vector(4 downto 0);
    --Inst_In, 
    RegData1, RegData2,ImmIn,InPort: In std_logic_vector(15 downto 0);
    --Out Control Signals
    Cout, Zout, Nout: Out std_logic;
    So: Out std_logic_vector(4 downto 0);
    Reg_No1_O: Out std_logic_vector(2 downto 0);
    EXE_PC: Out std_logic_vector(9 downto 0);
    --Inst_Out, 
    Result,OutPort:Out std_logic_vector(15 downto 0)
  );
end Execute;
--============================================================================================================================--
Architecture A_Execute of Execute is
Component a_ALU is
Port(A,B   :in std_logic_vector(15 downto 0);
         S :in std_logic_vector(1 downto 0);
Cin,Enable :in std_logic;
      Cout :out std_logic;
         F :out std_logic_vector(15 downto 0));
end Component a_ALU;
Component b_ALU is
Port(A,B    :in std_logic_vector(15 downto 0);
       S    :in std_logic_vector(1 downto 0);
       CIN  :in std_logic;
       COUT :out std_logic;
       F    :out std_logic_vector(15 downto 0));
end Component b_ALU;
Component c_ALU is
Port(A,B    :in std_logic_vector(15 downto 0);
       S    :in std_logic_vector(1 downto 0);
       CIN  :in std_logic;
       COUT :out std_logic;
       F    :out std_logic_vector(15 downto 0));
end Component c_ALU;

  
  Signal Result_A, Result_B, Result_C: std_logic_vector(15 downto 0);
  Signal C_in, Cout_A, Cout_B, Cout_C, Is_Z, Is_N : std_logic;
  Signal SL :std_logic_vector(1 downto 0);

Begin

    So<=Si;

      Reg_No1_O <= Reg_No1;
--    Inst_Out <= Inst_In;
    

     SL <= "00" when (Si="00001" or Si="01100" or Si="00100" or Si="01001" or Si="10010" or Si="01101"or Si="11001" or Si="11010")else --Mov--Push--And--SHR--Inc--Pop--Ret--Reti
           "01" when (Si="00010" or Si="00101" or Si="01000")else               --Add--Or --SHL
           "10" when (Si="00011" or Si="00111" or Si="10000")else               --Sub--RRC--Not
           "11" when (Si="00110" or Si="01010" or Si="01011" or Si="10011")else --RLC--STC--RTC--Dec
           "XX";

     C_in <= '0' when (Si="01011" or Si="00001" or Si="01100" or Si="00010" or Si="10011")else 
             '1' when (Si="01010" or Si="10010" or Si="01101" or Si="11001" or Si="11010" or Si="00011")else
             Cin;

    ALU_A: a_ALU Port Map(RegData1, RegData2, SL, C_in, Enable, Cout_A, Result_A);--Add--Sub--Inc--Dec--Clear--Transfer
    ALU_B: b_ALU Port Map(RegData1, RegData2, SL, C_in, Cout_B, Result_B);        --Shift--Rotate
    ALU_C: c_ALU Port Map(RegData1, RegData2, SL, C_in, Cout_C, Result_C);        --And--Or--Not--STC--RTC   
  
     Result <= Result_A when (Si="00001" or Si="00010" or Si="00011" or Si="10010" or Si="10011"or Si="01101"or Si="01100")else
               Result_B when (Si="00110" or Si="00111" or Si="01000" or Si="01001")else
               Result_C when (Si="00100" or Si="00101" or Si="01010" or Si="01011" or Si="10000")else 
               InPort   when (Si="01111")else 
               ((Not RegData1)+'1') when (Si="10001")else
               ImmIn    when (Si="11011" or Si="11100" or Si="11101")else
               RegData1;
     OutPort<= RegData1 when (Si="01110")else "XXXXXXXXXXXXXXXX";

     EXE_PC <= RegData1(9 downto 0) when (Si="11000" or Si="10111" or (Si="10101" and Nin='1')or (Si="10110" and Cin='1') or(Si="10100" and Zin='1'))else
               "0000000000" when (Si="11110")else --Reset
               "0000000001" when (Si="11111")else --Interrupt
               Result_A(9 downto 0) when (Si="11001" or Si="11010")else "XXXXXXXXXX";


--Set Flags--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++            

     Cout   <= Cout_A when (Si="00001" or Si="00010" or Si="00011" or Si="10010" or Si="10011")else
               Cout_B when (Si="00110" or Si="00111" or Si="01000" or Si="01001")else  
               Cout_C when (Si="00100" or Si="00101" or Si="01010" or Si="01011" or Si="10000")else   
               Cin;

    Is_N <= '1' when Result_A(15) = '1' and (Si="00001" or Si="00010" or Si="00011" or Si="10010" or Si="10011")else
            '1' when Result_B(15) = '1' and (Si="00110" or Si="00111" or Si="01000" or Si="01001")else
            '1' when Result_C(15) = '1' and (Si="00100" or Si="00101" or Si="01010" or Si="01011" or Si="10000")else '0';

    Nout <= '1' when Is_N= '1' else
            '0' when Is_N= '0' else Nin;
            
    Is_Z <= '1' when Result_A = "0000000000000000" and (Si="00001" or Si="00010" or Si="00011" or Si="10010" or Si="10011")else
            '1' when Result_B = "0000000000000000" and (Si="00110" or Si="00111" or Si="01000" or Si="01001")else
            '1' when Result_C = "0000000000000000" and (Si="00100" or Si="00101" or Si="01010" or Si="01011" or Si="10000")else '0';

    Zout <= '1' when Is_Z= '1' else
            '0' when Is_Z= '0' else Zin;
    

end A_Execute;



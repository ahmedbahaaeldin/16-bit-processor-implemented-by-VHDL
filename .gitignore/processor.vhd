LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

entity processor is
port (
instruction,InPort:in std_logic_vector(15 downto 0);
immediatevalue:in std_logic_vector(15 downto 0);
clk,RST,INT:in std_logic;
result,OutPort:out std_logic_vector(15 downto 0)
);
end processor;


architecture processor_arch of processor is
component SP is
port ( 
CLK ,RESET: in std_logic;
SIGPOP,SIGPUSH: in std_logic;
SP : out std_logic_vector(15 downto 0)
 );
end component;
component Flags is
Port 
( 
  clk, reset: in std_logic;
  FlagsIn: in std_logic_vector(3 downto 0);
  FlagsOut: out std_logic_vector(3 downto 0)
  );
end component;
component decoder is
  Port(
    opcode: out std_logic_vector(4 downto 0);
    Instruction :in std_logic_vector(15 downto 0);
    RegSrc1: out std_logic_vector(2 downto 0);
    RegSrc2: out std_logic_vector(2 downto 0);
    RegDst: out std_logic_vector(2 downto 0)
  );
end component;
component Control_unit is
    port( 
	  OP_Code : in std_logic_vector(4 downto 0);
          SIG_INTTRUPT : in std_logic;
          Out_Op_code : out std_logic_vector(4 downto 0);
          SIG_WB_IN : out std_logic_vector(1 downto 0);
          SIG_SEL_DST : out std_logic;
          SIG_Branch : out std_logic;
          SIG_W_Mem : out std_logic;
          SIG_R_Mem : out std_logic;
          SIG_IF_Ret: out std_logic;
          SIG_Reg_W: out std_logic;
          SIG_PUSH: out std_logic;
          SIG_POP : out std_logic;
          SIG_WD  : out std_logic           
); 
end component; 
component Register_File is
Port 
( 
  clk, reset: in std_logic;
  Read1, Read2, DSTselect: in std_logic_vector(2 downto 0);
  RegWrite: in std_logic;
  WB: in std_logic_vector(15 downto 0);
  Data1, Data2: out std_logic_vector(15 downto 0)
  );
end component;
component Execute is
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
end component;

signal WB,SP_sig,Data1,Data2 :std_logic_vector(15 downto 0);
signal WB_sig:std_logic_vector(1 downto 0);
signal RSrc1,RSrc2,RDst,EXPREGOUT:std_logic_vector(2 downto 0);
signal FlagsIn,FlagsOut:std_logic_vector(3 downto 0);
signal EXE_PCOut: std_logic_vector(9 downto 0);
signal opcode,out_op_code,EXOPOUT:std_logic_vector(4 downto 0);
signal SEL_DST,Branch,W_Mem,R_Mem,IF_Ret,Reg_W,Push,Pop,WD,Cin,Zin,Nin,Cout,Zout,Nout:std_logic;
begin

Decoder_comp: decoder port map (opcode,instruction,RSrc1,RSrc2,RDst);
ControlUnit: Control_unit port map (opcode,INT,out_op_code,WB_sig,SEL_DST,Branch,W_Mem,R_Mem,IF_Ret,Reg_W,Push,Pop,WD);
Register_File_comp:Register_File port map (clk,RST,Rsrc1,Rsrc2,RDst,'1',WB,Data1,Data2);
SP_comp : SP port map (clk,RST,Pop,Push,SP_sig);
Execute_comp : Execute port map (clk,RST,'1',Cin,Zin,Nin,"000",out_op_code,Data1,Data2,immediatevalue,Inport,Cout,Zout,Nout,EXOPOUT,EXPREGOUT,EXE_PCOut,result,OutPort);
Flags_comp:Flags port map(clk,RST,FlagsIn,FlagsOut);


process(clk,RST,INT)
begin

Cin<=FlagsOut(0);
Zin<=FlagsOut(1);
Nin<=FlagsOut(2);

FlagsIn(0)<=Cout;
FlagsIn(1)<=Zout;
FlagsIn(2)<=Nout;


end process;
end processor_arch;
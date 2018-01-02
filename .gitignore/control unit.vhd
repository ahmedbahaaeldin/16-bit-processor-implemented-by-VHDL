Library ieee;
Use ieee.std_logic_1164.all;
Entity Control_unit is
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
end Control_unit; 
Architecture archi of Control_unit is
begin
  Out_Op_code <= OP_Code;
  
--control signals
SIG_WB_IN <= "01" when  (OP_Code="00001") or (OP_Code="00010") --ALU out and need to WB
                    or (OP_Code="00011") or (OP_Code="00100") 
                    or (OP_Code="00101") or (OP_Code="00110") 
                    or (OP_Code="00111") or (OP_Code="01000")
                    or (OP_Code="01001") or (OP_Code="01010") 
                    or (OP_Code="01011") or (OP_Code="10000") 
                    or (OP_Code="10001") or (OP_Code="10010")
                    or (OP_Code="10011")					else
             "10" when (OP_Code="01101") or (OP_Code="11100") else --pop and LDD memory out and need to WB
             "11" when (OP_Code="01111") else -- IN instruction 
             "00"; --NOP
    
 
 SIG_SEL_DST <= '1' when (OP_Code="01000") or (OP_Code="01001") --SHL,SHR
                      or (OP_Code="11011") or (OP_Code="11100") --LDM,LDD  
                      else '0';

 SIG_Branch <= '1' when  (OP_Code="10111")  --JMP
                      else '0';
                      
 SIG_W_Mem <= '1' when    (OP_Code="01100") or (OP_Code="01111") or  (SIG_INTTRUPT='1')  --PUSH,IN
                  else '0';

 SIG_R_Mem <= '1' when    (OP_Code="01011") or (OP_Code="11100") or  (OP_Code="11001") or (OP_Code="11010")   --RTC,LDD,RET,RTI
                 else '0';
				 
 SIG_IF_Ret <= '1' when SIG_INTTRUPT='1'   
                 else '0';
				 
 SIG_WD <= '0' when  (SIG_INTTRUPT='1') or (OP_Code="11000")or (OP_Code="00000")     -- CALL and interrupt signal and NOP
                 else '1'  ;
				 
 SIG_Reg_W <='1' when
                   (OP_Code="00001") or (OP_Code="00010") --ALU out and need to WB
                    or (OP_Code="00011") or (OP_Code="00100") 
                    or (OP_Code="00101") or (OP_Code="00110") 
                    or (OP_Code="00111") or (OP_Code="01000")
                    or (OP_Code="01001") or (OP_Code="01010") 
                    or (OP_Code="01011") or (OP_Code="10000") 
                    or (OP_Code="10001") or (OP_Code="10010")
                    or (OP_Code="10011") 
					or (OP_Code="01101") or (OP_Code="11100") --pop and LDD
                    or (OP_Code="01111") -- IN instruction 
                     else '0';

 SIG_PUSH <= '1' when  OP_Code="01100" else '0';
 SIG_POP  <= '1' when  OP_Code="01101" else '0';
end Architecture archi;
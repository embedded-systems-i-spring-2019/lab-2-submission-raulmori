--Basically what we do here is we make a Main circuit, and we create a "structure model" then we use port-maps to connect four single "ALU's"

--Remember the way this works is, we will first set up the "SWITCHES" for out 4-bit number then press the "BUTTON" for "A"
--We will then do the same for "B"
--we will then set up the "OPCODE" code using the "SWITCHES" then we will press the "OPCODE" button which will give us the final OUTPUT results on the "LED's


--Remember the same registers work for both the "BUTTONS" and "SWITCHES"
--In here we assign the "OUTPUTS" of the ALU to the "LED's"
--Also, here we assign the "A", "B", "OPCODE" and "RESET" to the BUTTONS
--we assign the 4-bit number to the "SWITCHES"


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity alu_tester is
        Port ( sw, btn : in std_logic_vector(3 downto 0);       --The button values will be loaded into the "my_alu" component values for each bit
               clk: in std_logic;                               --Notice we created a clock for the debounced buttons
               led : out std_logic_vector(3 downto 0));  --Notice these are four 1-bit outputs of this "Main"
end alu_tester;


architecture Behavioral of alu_tester is         --We will use structural behavior

            signal db_btn : std_logic_vector(3 downto 0);
            signal inA, inB, OP, led_out : std_logic_vector(3 downto 0);    --This is the TEMPORARY of the 4 "BUTTONS"
            signal tempA, tempB, tempOP : std_logic_vector(3 downto 0);     --this is the TEMPORARY for the 4-bit number of the "SWITCHES"
            signal test : integer;
            
------------------------------------------------------------------------
            component my_alu         --This calls the individual "my_alu"'s 
              Port (A, B, Opcode: in std_logic_vector(3 downto 0);      --Notice that because we have 4-bit inputs and outputs we will call "my_alu" four times
                    output: out std_logic_vector(3 downto 0) );
            end component;
------------------------------------------------------------------------
            component debounce          --This is the debounced clock
              Port (clk: in std_logic;
                    btn: in std_logic;
                    dbnc: out std_logic );
            end component;
------------------------------------------------------------------------

            begin                   --portmap
                    process(clk)              --This is the process for making the switches work
                        begin
                            if(rising_edge(clk)) then           --on rising edge clock     
                                if(db_btn(2) = '1') then         --check if logic true then, declare respective loads
                                    tempOP <= sw;               --load opcode  
                                end if;
                                ------------------
                                if(db_btn(1) = '1') then          --loadA
                                    tempA <= sw;                 --report "in A";
                                end if;
                                -----------------
                                if(db_btn(0) = '1') then         --loadB    
                                    tempB <= sw;                    --report "in B";
                                end if;
                                 -----------------
                                if(db_btn(3) = '1') then             --reset values. This is Mainly used to Starts setting up everything all over Again. 
                                    tempA <= "0000";                --This just sets all the inputs to "0"
                                    tempB <= "0000";
                                    tempOP <= "0000";
                                end if;    
                            end if;
                   end process;
                   
                   inA <= tempA;        --Here we just connect a temporary "inA" into another temporary "tempA"
                   inB <= tempB;
                   OP <= tempOP;     
  
  
                    --opcode                
                    Button2: debounce port map(clk => clk,      --We just connect the component-entity with the corresponding temporary signal (small to big)
                                               btn => btn(2),       --Here we combine the "BUTTON" from "DEBOUNCE" to the BUTTON of the Top_Design's ENTITY
                                               dbnc => db_btn(2));  --Here we combine the "OUTPUT" of DEBOUNCE to the TEMPORARY "OUTPUT" of this Top_Design
                                         
                     --A                
                    Button1: debounce port map(clk => clk,
                                               btn => btn(1),
                                               dbnc => db_btn(1));                  
                    
                    --B               
                    Button0: debounce port map(clk => clk,
                                               btn => btn(0),
                                               dbnc => db_btn(0));
                    
                    
                    --reset                
                    Button3: debounce port map(clk => clk,
                                               btn => btn(3),
                                               dbnc => db_btn(3));
                                               
                                               
                    ALU: my_alu port map(A => inA,              --We just connect the component-entity with the corresponding temporary signal (small to big)
                                         B => inB,
                                         Opcode => OP,
                                         output => led);                                       
end Behavioral;

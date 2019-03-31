
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_TB is
--  Port ( );
end ripple_TB;


architecture Behavioral of ripple_TB is

        signal A, B, S : std_logic_vector(3 downto 0) := (others => '0');       --create intermediate signals/initialize them
        signal Cin, Cout : std_logic := '0';
----------------------------------------------------------------------------------
       
        component ripple_adder                              --declare ripple adder component
              Port (
                      A, B: in std_logic_vector(3 downto 0);
                      Cin: std_logic;
                      Cout: out std_logic;
                      S: out std_logic_vector(3 downto 0));
        end component;
----------------------------------------------------------------------------------

        begin
            process                                         --declare process for sim
                    begin
                            A <= "0011";
                            B <= "0100";
                            Cin <= '1';
                        
                            wait for 1ms;   --note: expect S = "1000" = 8
                            
                            Cin <= '0';
                            A <= "0101";
                            B <= "1010";
                    
                            wait for 1ms;            --note: expect S = "1111" = 15 -> f
    
                                                   
                            A <= "0111";
                            B <= "0001";
                    
                            wait for 1ms;                       --note: expect S = "1000" = 8
    
                            
                            A <= "1000";
                            B <= "0010";
                    
                            wait for 1ms;           --note: expect S = "1010" = 10 -> a
    
                            
                             A <= "1111";                          --lets try to overload
                             B <= "0011";
                           
                             --note: expect S = 15 + 3 = 18 -> 2 
                             --this happens because it cycles back through the set 0 to 15
                             -- carry out should be 1 at this point
                             wait for 1ms;
                            
                            --do nothing/ reset
                            A <= "0000";
                            B <= "0000";
                            wait;
                
                end process;
                
                dut: ripple_adder port map(A => A,              --set signals from ENTITY-COMPONENT (Design) to MAIN-TEMPORARY (Testbench)
        
                           B => B,
                           Cin => Cin,
                           Cout => Cout,
                           S => S);
end Behavioral;

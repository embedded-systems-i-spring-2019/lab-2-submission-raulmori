
--Notice that in this code. We are just connecting ports

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_adder is
      Port (A, B: in std_logic_vector(3 downto 0); --This made up 4-bit Entity of "A" is to help us save the component 1-bit Entity of "A"
            Cin: in std_logic;
            Cout: out std_logic;
            S: out std_logic_vector(3 downto 0));   
end ripple_adder;



architecture Behavioral of ripple_adder is

        signal C_out: std_logic_vector(3 downto 0) := (others => '0');          --Remember the semi-colon at the end of a temporary signal
        
    
        component adder             --declare component
              Port (A, B, Cin: in std_logic;
                     S, Cout: out std_logic );
        end component;
    
    
        begin
                        --When working with STRUCTURAL DESIGN,it is just about the hieracchy of connecting Entity-Component values to Main-Entitty values (Regardless of logical order)
                         --Since this is not about order calculation, it does not matter if the Full Adder's calculation is done first, before the values are transfered
                        --Remember we assign something small into something bigger (Component-Entity to Main-Entity)bookie216
                        
        
            Adder_1 : adder port map(A => A(0),         --Here we pass the Ripple Adder's Entity 0th-bit "A" in the Entity-Component "A"
                                     B => B(0),         --Here we pass the Ripple Adder's Entity 0th-bit "B" in the Entity-Component "B"
                                     Cin => Cin,        --Remember this is  the Ripple Adder's "Cin" being put into the Entity-Component "Cin" 
                                     Cout => C_out(0),      --Here we pass the Entity 4-bit "Cout" into the temporary 1-bit "Cout" for the 0-bit position
                                     S => S(0));        --This just means that the entity 4-bit "S" will be qual to temporary 0th bit "S"
                                
                                     
            Adder_2 : adder port map(A => A(1),     --Notice here that we take the 1th bit of Entity "A"
                                     B => B(1),
                                     Cin => C_out(0),   --This just connects he 0th-bit "Cout" of the Full-Adder#1 in the "Cin" of Full-Adder#2
                                     Cout => C_out(1),  --Here we saved the Entity "Cout" obtained from the Full-Adder calculaton into temporary "1th bit Cout"
                                     S => S(1));                        
            
            Adder_3 : adder port map(A => A(2),
                                     B => B(2),
                                     Cin => C_out(1),
                                     Cout => C_out(2),  --Remember the "Cout" on the left is from the -Entity-component
                                     S => S(2));
            
            
            Adder_4 : adder port map(A => A(3),
                                     B => B(3),
                                     Cin => C_out(2),
                                     Cout => C_out(3),      --Here We assigned the entity-component of Full-Adder#4 into Ripple-Carry Entity's 3rd bit "C_out(3)
                                     S => S(3));
        
        
        Cout <= C_out(3);    --In this case since we dont need any more Full-Adders, we simply pass the temporary "Cout(3)" into the Main-Entity "Cout"
    

end Behavioral;

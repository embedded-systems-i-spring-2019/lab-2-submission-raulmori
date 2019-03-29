--Notice that in this code we use the BEHVAIORAL MODEL". This is why we call a "process" instead of "component-portmap"

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu is
        Port (A, B, Opcode: in std_logic_vector(3 downto 0);  --Remember that we were given an input template. We use this template to make out 4-bt ALU
             output: out std_logic_vector(3 downto 0) );
end my_alu;


architecture Behavioral of my_alu is

        signal inputA, inputB, alu_out : unsigned(3 downto 0);  --Here we create three temporaries (intermediate signals). Remember that when dealing with "temporary" signals we don't need to label them as "input" or "output"
        
            begin
              
                    inputA <= unsigned(A);      --Here we put the entity values into the "temporary" values
                    inputB <= unsigned(B);      --Notice, we don't use portmaps to assign signals in this case (We don't use portmaps because this is not structural design)
              
                    ALU:   process(inputA, inputB, Opcode)     --Here we use the new-temporary "inputA" and new-temporary "inputB" and Entity "opcode"
            
                                begin   --Notice that we are creating a 4bit input multiplexer, where we manually enter its logic on the right
                                
                                case Opcode is                          --In this case Entity "Opcode" is just the left 4-bit binary value on the left 
                                
                                        when "0000" => alu_out <= inputA + inputB;      --This is the first output. We created a 4-bit artifical number 
                                        when "0001" => alu_out <= inputA - inputB;      --Notice in this case the Entity "opcode" is "0001". Also this subtraction

                                        when "0010" => alu_out <= inputA + "0001";       -- Notice that in this case we add a "1", but, it is not in integer form, it is in binary form
                                        when "0011" => alu_out <= inputA - "0001";      -- We add a "1" here in binary form as well
                                        when "0100" => alu_out <= "0000" - inputA;     -- Subtracts "A" from 0. The "0" is in binary form

                                        when "0101" => -- A > B comparison         --Note: sll, srl, sra are deemed as incorrect
                                                    if(A > B) then                        --Checks if "A" is greater than "B"
                                                        alu_out <= "0001";                -- Outputs an output of "1" in binary form
                                                    else
                                                        alu_out <= "0000";                -- Outputs an output of "0" in binary form
                                                    end if;


                                        -- they have been replaced by functions
                                        -- unsigned performs logical shift
                                        -- signed performs arithmetic shifts
                                        when "0110" => alu_out <= shift_left(inputA, 1);                --Here we use a "shift left logical" special function
                                        when "0111" => alu_out <= shift_right(inputA, 1);               --Here we use a "shift right logical" special function
                                        when "1000" => alu_out <= unsigned(shift_right(signed(inputA), 1));     --Here we use "right shift arithmetic" special function but we add "unsigned" and "signed"

                                        when "1001" => alu_out <= NOT inputA;                            --This just inverts "A"
                                        when "1010" => alu_out <= inputA AND inputB;                     --This just checks to see if "A and B" is true, then prints an output. Notice a shorcut "AND" function already exists
                                        when "1011" => alu_out <= inputA OR inputB;                      --Same but with  "OR", where we have "A or B"
                                        when "1100" => alu_out <= inputA XOR inputB;                    --Same but with "XOR", for "A" and "B"
                                        when "1101" => alu_out <= inputA XNOR inputB;                    --Same but with "XNOR"
                                        when "1110" => alu_out <= inputA NAND inputB;                   --Same with "NAND"
                                        when "1111" => alu_out <= inputA NOR inputB;                     --SAME with "NOR"

                                        when others => alu_out <= "0000";       --This is just a part of the multiplexer that always has to be there.For everyhing else the output defaults to "0"
                                end case;
                                
                                
                                --output <= std_logic_vector(alu_out);          --this is the 4-bit temporary "alu_out" (we added a "std_logic_vector" to it to change it from binary to 1-bit) being put into the entity "out" 

                   end process;
    
                   output <= std_logic_vector(alu_out);         --This is the line just above  except that we put it outside the "Behavioral process"

           
end Behavioral;

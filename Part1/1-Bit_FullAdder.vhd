library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity adder is     --declare adder
      Port (A, B, Cin: in std_logic;
            S, Cout: out std_logic );
end adder;

architecture Behavioral of adder is

        begin
        
            S <= (A XOR B) XOR Cin;
            Cout <= ((A XOR B) AND Cin) OR (A AND B);

end Behavioral;

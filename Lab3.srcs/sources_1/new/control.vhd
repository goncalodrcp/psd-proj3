library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
port (
    clk : in std_logic;
    reset : in std_logic;
    mem_addr : out std_logic_vector (6 downto 0)
);
end control;

architecture Behavioral of control is
    -- Signals
    signal counter : std_logic_vector(6 downto 0) := "0000000";

begin

    -- Clocking data to registers
    process (clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                -- Reset counter
                counter <= "0000000";
            else
                -- Update counter
                counter <= counter + 1;
            end if;
        end if;
    end process;


    -- Outputs
    mem_addr <= counter;

end Behavioral;
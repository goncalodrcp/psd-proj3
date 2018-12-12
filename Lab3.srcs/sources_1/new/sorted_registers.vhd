library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sorted_registers is
port (
    clk : in std_logic;
    reset : in std_logic;
    difference : in std_logic_vector (31 downto 0);
    class : in std_logic_vector (1 downto 0)
);
end sorted_registers;

architecture Behavioral of sorted_registers is
    -- Signals
    signal distance_1 : std_logic_vector(31 downto 0) := X"00000000";
    signal class_1 : std_logic_vector(1 downto 0) := "11";

    signal distance_2 : std_logic_vector(31 downto 0) := X"00000000";
    signal class_2 : std_logic_vector(1 downto 0) := "11";

    signal distance_3 : std_logic_vector(31 downto 0) := X"00000000";
    signal class_3 : std_logic_vector(1 downto 0) := "11";

    signal distance_4 : std_logic_vector(31 downto 0) := X"00000000";
    signal class_4 : std_logic_vector(1 downto 0) := "11";
    
    signal distance_5 : std_logic_vector(31 downto 0) := X"00000000";
    signal class_5 : std_logic_vector(1 downto 0) := "11";
begin
    -- Clocking data to registers
    process (clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                -- Reset counter
                distance_1 <= X"00000000";
                distance_2 <= X"00000000";
                distance_3 <= X"00000000";
                distance_4 <= X"00000000";
                class_1 <= "11";
                class_2 <= "11";
                class_3 <= "11";
                class_4 <= "11";
            else
                -- Check all registers
            end if;
        end if;
end process;

end Behavioral;

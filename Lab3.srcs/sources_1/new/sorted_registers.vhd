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
    -- Signals/component

    -- Register 1
    signal r1_difference : std_logic_vector (31 downto 0) := X"00000000";
    signal r1_class : std_logic_vector (1 downto 0) := "11";
    signal r1_comparator : std_logic := '0';
    signal r1_enable : std_logic := '0';

    -- Register 2
    signal r2_difference : std_logic_vector (31 downto 0) := X"00000000";
    signal r2_class : std_logic_vector (1 downto 0) := "11";
    signal r2_comparator : std_logic := '0';
    signal r2_enable : std_logic := '0';

    -- Register 3
    signal r3_difference : std_logic_vector (31 downto 0) := X"00000000";
    signal r3_class : std_logic_vector (1 downto 0) := "11";
    -- signal r3_comparator : std_logic := '0';
    -- signal r3_enable : std_logic := '0';

    -- Register 4
    signal r4_difference : std_logic_vector (31 downto 0) := X"00000000";
    signal r4_class : std_logic_vector (1 downto 0) := "11";
    -- signal r4_comparator : std_logic := '0';
    -- signal r4_enable : std_logic := '0';

    -- Register 5
    signal r5_difference : std_logic_vector (31 downto 0) := X"00000000";
    signal r5_class : std_logic_vector (1 downto 0) := "11";
    -- signal r5_comparator : std_logic := '0';
    -- signal r5_enable : std_logic := '0';

begin

    -- Comparator signals
    r1_comparator <= '1' when difference < r1_difference else '0';
    r2_comparator <= '1' when difference < r2_difference else '0';
    -- r3_comparator <= '1' when difference < r3_difference else '0';
    -- r4_comparator <= '1' when difference < r4_difference else '0';
    -- r5_comparator <= '1' when difference < r5_difference else '0';

    -- Register enable
    r1_enable <= '1' when r1_class = "11" else r1_comparator;
    r2_enable <= '1' when r2_class = "11" else r2_comparator;
    

    -- Clocking data to registers
    process (clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                -- Reset counter
                r1_difference <= X"00000000";
                r1_class <= "11"; -- Not used                
            else
                if r1_enable = '1' then
                    r1_difference <= difference;
                    r1_class <= class;
                end if;
                if r2_enable = '1' then
                    r2_difference <= r1_difference;
                    r2_class <= r1_class;
                end if;

            end if;
        end if;
    end process;



end Behavioral;

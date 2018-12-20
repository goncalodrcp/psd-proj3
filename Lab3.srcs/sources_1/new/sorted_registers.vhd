library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sorted_registers is
port (
    clk : in std_logic;
    reset : in std_logic;
    difference : in std_logic_vector (31 downto 0);
    class : in std_logic_vector (1 downto 0);
    enable : in std_logic;
    k: in std_logic_vector (2 downto 0);
    done : in std_logic;
    pred : out std_logic_vector (1 downto 0)
);
end sorted_registers;

architecture Behavioral of sorted_registers is
    -- Signals/component

    -- Register 1
    signal r1_difference : std_logic_vector (31 downto 0) := X"FFFFFFFF";
    signal r1_class : std_logic_vector (1 downto 0) := "11";
    signal r1_comparator : std_logic := '0';
    signal r1_enable : std_logic := '0';

    -- Register 2
    signal r2_difference : std_logic_vector (31 downto 0) := X"FFFFFFFF";
    signal r2_class : std_logic_vector (1 downto 0) := "11";
    signal r2_comparator : std_logic := '0';
    signal r2_enable : std_logic := '0';
    signal r2_diff_entry : std_logic_vector (31 downto 0) := X"FFFFFFFF";
    signal r2_class_entry : std_logic_vector (1 downto 0) := "11";

    -- Register 3
    signal r3_difference : std_logic_vector (31 downto 0) := X"FFFFFFFF";
    signal r3_class : std_logic_vector (1 downto 0) := "11";
    signal r3_comparator : std_logic := '0';
    signal r3_enable : std_logic := '0';
    signal r3_diff_entry : std_logic_vector (31 downto 0) := X"FFFFFFFF";
    signal r3_class_entry : std_logic_vector (1 downto 0) := "11";

    -- Register 4
    signal r4_difference : std_logic_vector (31 downto 0) := X"FFFFFFFF";
    signal r4_class : std_logic_vector (1 downto 0) := "11";
    signal r4_comparator : std_logic := '0';
    signal r4_enable : std_logic := '0';
    signal r4_diff_entry : std_logic_vector (31 downto 0) := X"FFFFFFFF";
    signal r4_class_entry : std_logic_vector (1 downto 0) := "11";


    -- Register 5
    signal r5_difference : std_logic_vector (31 downto 0) := X"FFFFFFFF";
    signal r5_class : std_logic_vector (1 downto 0) := "11";
    signal r5_comparator : std_logic := '0';
    signal r5_enable : std_logic := '0';
    signal r5_diff_entry : std_logic_vector (31 downto 0) := X"FFFFFFFF";
    signal r5_class_entry : std_logic_vector (1 downto 0) := "11";
    
    -- Mux selector signals
    signal sel2 : std_logic := '0';
    signal sel3 : std_logic := '0';
    signal sel4 : std_logic := '0';
    signal sel5 : std_logic := '0';
    
    -- Class counters
    signal class1_counter : std_logic_vector (2 downto 0) := "000";
    signal class2_counter : std_logic_vector (2 downto 0) := "000";
    signal class3_counter : std_logic_vector (2 downto 0) := "000";

    signal class1_adder_entry_1 : std_logic := '0';
    signal class1_adder_entry_2 : std_logic := '0';
    signal class1_adder_entry_3 : std_logic := '0';
    signal class1_adder_entry_4 : std_logic := '0';
    signal class1_adder_entry_5 : std_logic := '0';

    signal class2_adder_entry_1 : std_logic := '0';
    signal class2_adder_entry_2 : std_logic := '0';
    signal class2_adder_entry_3 : std_logic := '0';
    signal class2_adder_entry_4 : std_logic := '0';
    signal class2_adder_entry_5 : std_logic := '0';

    signal class3_adder_entry_1 : std_logic := '0';
    signal class3_adder_entry_2 : std_logic := '0';
    signal class3_adder_entry_3 : std_logic := '0';
    signal class3_adder_entry_4 : std_logic := '0';
    signal class3_adder_entry_5 : std_logic := '0';
    
    signal k_ext : std_logic_vector (2 downto 0);
    
    signal comp_c1_c2 : std_logic := '0';
    signal comp_c2_c3 : std_logic := '0';
    
begin

    k_ext <= k(2) & k(2) & k(2);

    -- Comparator signals
    r1_comparator <= '1' when difference < r1_difference else '0';
    r2_comparator <= '1' when difference < r2_difference else '0';
    r3_comparator <= '1' when difference < r3_difference else '0';
    r4_comparator <= '1' when difference < r4_difference else '0';
    r5_comparator <= '1' when difference < r5_difference else '0';

    -- Register enable
    r1_enable <= r1_comparator and enable;
    r2_enable <= r2_comparator and enable;
    r3_enable <= r3_comparator and enable;
    r4_enable <= r4_comparator and enable;
    r5_enable <= r5_comparator and enable;

    -- Mux selector
    sel2 <= not(r1_comparator);
    sel3 <= not(r2_comparator);
    sel4 <= not(r3_comparator);
    sel5 <= not(r4_comparator);

    r2_diff_entry <= r1_difference when sel2 = '0' else difference;
    r3_diff_entry <= r2_difference when sel3 = '0' else difference;
    r4_diff_entry <= r3_difference when sel4 = '0' else difference;
    r5_diff_entry <= r4_difference when sel5 = '0' else difference;

    r2_class_entry <= r1_class when sel2 = '0' else class;
    r3_class_entry <= r2_class when sel3 = '0' else class;
    r4_class_entry <= r3_class when sel4 = '0' else class;
    r5_class_entry <= r4_class when sel5 = '0' else class;
    
    class1_adder_entry_1 <= '1' when r1_class = "00" else '0';
    class1_adder_entry_2 <= '1' when r2_class = "00" else '0';
    class1_adder_entry_3 <= '1' when r3_class = "00" else '0';
    class1_adder_entry_4 <= '1' when r4_class = "00" else '0';
    class1_adder_entry_5 <= '1' when r5_class = "00" else '0';

    class2_adder_entry_1 <= '1' when r1_class = "01" else '0';
    class2_adder_entry_2 <= '1' when r2_class = "01" else '0';
    class2_adder_entry_3 <= '1' when r3_class = "01" else '0';
    class2_adder_entry_4 <= '1' when r4_class = "01" else '0';
    class2_adder_entry_5 <= '1' when r5_class = "01" else '0';

    class3_adder_entry_1 <= '1' when r1_class = "10" else '0';
    class3_adder_entry_2 <= '1' when r2_class = "10" else '0';
    class3_adder_entry_3 <= '1' when r3_class = "10" else '0';
    class3_adder_entry_4 <= '1' when r4_class = "10" else '0';
    class3_adder_entry_5 <= '1' when r5_class = "10" else '0';
    
    class1_counter <= ("00" & class1_adder_entry_1) + ("00" & class1_adder_entry_2) + ("00" & class1_adder_entry_3) + (("00" & class1_adder_entry_4) and k_ext) + (("00" & class1_adder_entry_5) and k_ext);
    class2_counter <= ("00" & class2_adder_entry_1) + ("00" & class2_adder_entry_2) + ("00" & class2_adder_entry_3) + (("00" & class2_adder_entry_4) and k_ext) + (("00" & class2_adder_entry_5) and k_ext);
    class3_counter <= ("00" & class3_adder_entry_1) + ("00" & class3_adder_entry_2) + ("00" & class3_adder_entry_3) + (("00" & class3_adder_entry_4) and k_ext) + (("00" & class3_adder_entry_5) and k_ext);
    
    comp_c1_c2 <= '1' when class1_counter > class2_counter else '0';
    comp_c2_c3 <= '1' when class2_counter > class3_counter else '0';
    
    pred <= r1_class when (done = '1' and k = "001") else 
            "00" when (done = '1' and comp_c1_c2 = '1' and comp_c2_c3 = '1') else
            "01" when (done = '1' and comp_c1_c2 = '0' and comp_c2_c3 = '1') else
            "10" when (done = '1' and comp_c1_c2 = '0' and comp_c2_c3 = '0') else
            "11";

    -- Clocking data to registers
    process (clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                r1_difference <= X"FFFFFFFF"; -- Max value
                r1_class <= "11"; -- Not used
                r2_difference <= X"FFFFFFFF"; -- Max value
                r2_class <= "11"; -- Not used
                r3_difference <= X"FFFFFFFF"; -- Max value
                r3_class <= "11"; -- Not used
                r4_difference <= X"FFFFFFFF"; -- Max value
                r4_class <= "11"; -- Not used
                r5_difference <= X"FFFFFFFF"; -- Max value
                r5_class <= "11"; -- Not used

                -- class1_counter <= "000";
            else
                if r1_enable = '1' then
                    r1_difference <= difference;
                    r1_class <= class;
                end if;
                if r2_enable = '1' then
                    r2_difference <= r2_diff_entry;
                    r2_class <= r2_class_entry;
                end if;
                if r3_enable = '1' then
                    r3_difference <= r3_diff_entry;
                    r3_class <= r3_class_entry;
                end if;

                if r4_enable = '1' then
                    r4_difference <= r4_diff_entry;
                    r4_class <= r4_class_entry;
                end if;
                if r5_enable = '1' then
                    r5_difference <= r5_diff_entry;
                    r5_class <= r5_class_entry;
                end if;
            end if;
        end if;
    end process;

end Behavioral;

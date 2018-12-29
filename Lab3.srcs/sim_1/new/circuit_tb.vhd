library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity circuit_tb is
end circuit_tb;

architecture Behavioral of circuit_tb is
    component circuit is
    port (
        clk : in std_logic;
        reset : in std_logic;
        data_in : in std_logic_vector (15 downto 0);
        k : in std_logic_vector (2 downto 0);
        pred : out std_logic_vector (1 downto 0);
        btn_input : in std_logic_vector(3 downto 0);
        leds_output : out std_logic_vector (15 downto 0);
        done : out std_logic

    );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal data : std_logic_vector (15 downto 0) := X"0000";
    signal k : std_logic_vector (2 downto 0) := "101";
    signal btn_input : std_logic_vector (3 downto 0) := "0000";

    -- Outputs
    signal pred : std_logic_vector (1 downto 0);
    signal leds_output : std_logic_vector (15 downto 0);
    signal done : std_logic;

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: circuit
    port map (
        clk => clk,
        reset => reset,
        data_in => data,
        k => k,
        pred => pred,
        btn_input => btn_input
    );

    -- Clock definition
    clk <= not clk after clk_period/2;

    -- Stimulus process
    stim_proc: process
    begin

    -- hold reset state for 10 clock cycles
    reset <= '0' after 97.5 ns,
             '1' after 1900 ns,
             '0' after 1907.5 ns;

    btn_input <= "1000" after 200 ns, -- Change to input f1
                 "0000" after 210 ns,
                 "0100" after 300 ns, -- Change to input f2
                 "0000" after 310 ns,
                 "0010" after 400 ns, -- Change to input f3
                 "0000" after 410 ns,
                 "0001" after 500 ns, -- Change to input f4
                 "0000" after 510 ns,
                 "1000" after 600 ns, -- Change to calc
                 "0000" after 610 ns,
                 "1000" after 2200 ns, -- Change to input f1
                 "0000" after 2210 ns,
                 "0100" after 2300 ns, -- Change to input f2
                 "0000" after 2310 ns,
                 "0010" after 2400 ns, -- Change to input f3
                 "0000" after 2410 ns,
                 "0001" after 2500 ns, -- Change to input f4
                 "0000" after 2510 ns,
                 "1000" after 2600 ns, -- Change to calc
                 "0000" after 2610 ns;
           
    
    k <= "011" after 160 ns;
    
    -- Class2
    data <= X"c99a" after 240 ns,
            X"6ccd" after 340 ns,
            X"b333" after 440 ns,
            X"4ccd" after 540 ns,
            X"A666" after 2240 ns,
            X"7000" after 2340 ns,
            X"3000" after 2440 ns,
            X"0666" after 2540 ns;
    wait;

end process;
end;

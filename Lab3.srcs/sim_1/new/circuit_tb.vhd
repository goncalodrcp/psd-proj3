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
        test_instance : in std_logic_vector (63 downto 0)
    );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal test_instance : std_logic_vector (63 downto 0) := X"c99a699a96663333";

    -- Outputs
    -- TBD

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: circuit
    port map (
        clk => clk,
        reset => reset,
        test_instance => test_instance
    );

    -- Clock definition
    clk <= not clk after clk_period/2;

    -- Stimulus process
    stim_proc: process
    begin

    -- hold reset state for 10 clock cycles
    reset <= '1';
    wait for 10*clk_period;

    -- return reset to low
    reset <= '0';
    wait for 150*clk_period;

    reset <= '1';
    wait for 5*clk_period;

    reset <= '0';
    wait;

end process;
end;

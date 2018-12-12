library IEEE;
use IEEE.std_logic_1164.ALL;

entity control_tb is
end control_tb;

architecture Behavioral of control_tb is
    component control is
    port (
        clk : in std_logic;
        reset : in std_logic
    );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';

    -- Outputs

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: control
    port map (
        clk => clk,
        reset => reset
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
    wait for 50*clk_period;

    reset <= '1';
    wait for 5*clk_period;

    reset <= '0';
    wait;

end process;
end;


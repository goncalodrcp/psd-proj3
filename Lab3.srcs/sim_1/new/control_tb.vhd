library IEEE;
use IEEE.std_logic_1164.ALL;

entity control_tb is
end control_tb;

architecture Behavioral of control_tb is
    component control is
    port (
        clk : in std_logic;
        reset : in std_logic;
        mem_addr : out std_logic_vector (6 downto 0);
        enable : out std_logic;
        done : out std_logic;
        btn_input : in std_logic_vector (3 downto 0); 
        input_controller : out std_logic_vector (4 downto 0)
    );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal btn_input : std_logic_vector (3 downto 0) := "0000";

    -- Outputs
    signal mem_addr : std_logic_vector (6 downto 0);
    signal enable : std_logic;
    signal done : std_logic;
    signal input_controller : std_logic_vector (4 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: control
    port map (
        clk => clk,
        reset => reset,
        mem_addr => mem_addr,
        enable => enable,
        done => done,
        btn_input => btn_input,
        input_controller => input_controller
    );

    -- Clock definition
    clk <= not clk after clk_period/2;

    -- Stimulus process
    stim_proc: process
    begin

    -- hold reset state for 10 clock cycles
    reset <= '0' after 97.5 ns;

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

    wait;

end process;
end;


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
        btn_input : in std_logic 
    );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal btn_input : std_logic := '0';

    -- Outputs
    signal mem_addr : std_logic_vector (6 downto 0);
    signal enable : std_logic;
    signal done : std_logic;

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
        btn_input => btn_input        
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
    
    btn_input <= '1' after 200 ns, -- Change to input K
                 '0' after 210 ns,
                 '1' after 300 ns, -- Change to input f1
                 '0' after 310 ns,
                 '1' after 400 ns, -- Change to input f2
                 '0' after 410 ns,
                 '1' after 500 ns, -- Change to input f3
                 '0' after 510 ns,
                 '1' after 600 ns, -- Change to input f4
                 '0' after 610 ns,
                 '1' after 700 ns, -- Change to calc
                 '0' after 710 ns;


    wait;

end process;
end;


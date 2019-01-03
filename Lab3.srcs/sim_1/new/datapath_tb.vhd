library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_tb is
end datapath_tb;

architecture Behavioral of datapath_tb is
    component datapath is
    port (
        clk : in std_logic;
        reset : in std_logic;
        train_instance_features : in std_logic_vector (63 downto 0);
        train_instance_class : in std_logic_vector (1 downto 0);
        test_instance_features : in std_logic_vector (63 downto 0);
        enable : in std_logic;
        k: in std_logic_vector(2 downto 0);
        done : in std_logic;
        pred: out std_logic_vector(1 downto 0)
    );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal train_instance_features : std_logic_vector (63 downto 0) := X"96666666299A0666";
    signal train_instance_class : std_logic_vector (1 downto 0) := "00";
    signal test_instance_features : std_logic_vector (63 downto 0) := X"999A60002CCD0333";
    signal enable : std_logic := '0';
    signal k : std_logic_vector (2 downto 0) := "101";
    signal done : std_logic := '0';

    -- Outputs
    signal pred : std_logic_vector (1 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: datapath
    port map (
        clk => clk,
        reset => reset,
        train_instance_features => train_instance_features,
        train_instance_class => train_instance_class,
        test_instance_features => test_instance_features,
        enable => enable,
        k => k,
        done => done,
        pred => pred
    );

    -- Clock definition
    clk <= not clk after clk_period/2;

    -- Stimulus process
    stim_proc: process
    begin

    -- hold reset state for 10 clock cycles
    reset <= '0' after 97.5 ns;
    wait;

end process;
end;
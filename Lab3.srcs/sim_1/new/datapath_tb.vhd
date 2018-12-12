library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath_tb is
end datapath_tb;

architecture Behavioral of datapath_tb is
    component datapath is
    port (
        train_instance_features : in std_logic_vector (63 downto 0);
        train_instance_class : in std_logic_vector (1 downto 0);
        test_instance_features : in std_logic_vector (63 downto 0)
    );
    end component;

    -- Inputs
    signal train_instance_class : std_logic_vector (1 downto 0) := "00";
    -- signal train_instance_features : std_logic_vector (63 downto 0) := X"9CCD60002CCD0666";
    -- signal test_instance_features : std_logic_vector (63 downto 0) := X"96666666299A0666";
    
    signal train_instance_features : std_logic_vector (63 downto 0) := X"96666666299A0666";
    signal test_instance_features : std_logic_vector (63 downto 0) := X"9CCD60002CCD0666";

    -- signal train_instance_features : std_logic_vector (63 downto 0) := X"0000000000000000";
    -- signal test_instance_features : std_logic_vector (63 downto 0) := X"FFFFFFFFFFFFFFFF";

    -- signal train_instance_features : std_logic_vector (63 downto 0) := X"FFFFFFFFFFFFFFFF";
    -- signal test_instance_features : std_logic_vector (63 downto 0) := X"0000000000000000";


    -- Outputs
    --TBD

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: datapath
    port map (
        train_instance_features => train_instance_features,
        train_instance_class => train_instance_class,
        test_instance_features => test_instance_features
    );
end;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
port (
    train_instance_features : in std_logic_vector (63 downto 0);
    train_instance_class : in std_logic_vector (1 downto 0);
    test_instance_features : in std_logic_vector (63 downto 0)
);
end datapath;

architecture Behavioral of datapath is
    -- Components
    component feature_comparator is
    port (
        train_feature : in std_logic_vector (15 downto 0);
        test_feature : in std_logic_vector (15 downto 0);
        difference : out std_logic_vector (31 downto 0)
    );
    end component;

    -- Signals
    -- Decompose features into individual signals
    signal train_instance_f1 : std_logic_vector (15 downto 0);
    signal train_instance_f2 : std_logic_vector (15 downto 0);
    signal train_instance_f3 : std_logic_vector (15 downto 0);
    signal train_instance_f4 : std_logic_vector (15 downto 0);

    signal test_instance_f1 : std_logic_vector (15 downto 0);
    signal test_instance_f2 : std_logic_vector (15 downto 0);
    signal test_instance_f3 : std_logic_vector (15 downto 0);
    signal test_instance_f4 : std_logic_vector (15 downto 0);

    signal difference_f1 : std_logic_vector (31 downto 0);
    signal difference_f2 : std_logic_vector (31 downto 0);
    signal difference_f3 : std_logic_vector (31 downto 0);
    signal difference_f4 : std_logic_vector (31 downto 0);
    
    signal total_difference : std_logic_vector (31 downto 0);
    

begin
    train_instance_f1 <= train_instance_features(63 downto 48);
    train_instance_f2 <= train_instance_features(47 downto 32);
    train_instance_f3 <= train_instance_features(31 downto 16);
    train_instance_f4 <= train_instance_features(15 downto 0);

    test_instance_f1 <= test_instance_features(63 downto 48);
    test_instance_f2 <= test_instance_features(47 downto 32);
    test_instance_f3 <= test_instance_features(31 downto 16);
    test_instance_f4 <= test_instance_features(15 downto 0);

    feature_comparator_1 : feature_comparator
    port map (
        train_feature => train_instance_f1,
        test_feature => test_instance_f1,
        difference => difference_f1
    );

    feature_comparator_2 : feature_comparator
    port map (
        train_feature => train_instance_f2,
        test_feature => test_instance_f2,
        difference => difference_f2
    );

    feature_comparator_3 : feature_comparator
    port map (
        train_feature => train_instance_f3,
        test_feature => test_instance_f3,
        difference => difference_f3
    );

    feature_comparator_4 : feature_comparator
    port map (
        train_feature => train_instance_f4,
        test_feature => test_instance_f4,
        difference => difference_f4
    );
    
    total_difference <= difference_f1 + difference_f2 + difference_f3 + difference_f4;
    
    

end Behavioral;

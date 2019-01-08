library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.STD_LOGIC_UNSIGNED.ALL;

entity feature_comparator is
port (
    train_feature : in std_logic_vector (15 downto 0);
    test_feature : in std_logic_vector (15 downto 0);
    difference : out std_logic_vector (31 downto 0)
);
end feature_comparator;

architecture Behavioral of feature_comparator is
    signal diff : signed (16 downto 0);
    signal sqr_diff : std_logic_vector (33 downto 0);

begin
    diff <= signed('0' & test_feature) - signed('0' & train_feature);
    sqr_diff <= std_logic_vector(diff * diff);
    difference <= sqr_diff(31 downto 0);
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity circuit is
port (
    clk : in std_logic;
    reset : in std_logic;
    test_instance : in std_logic_vector (63 downto 0)
);
end circuit;

architecture Behavioral of circuit is
    component train_classes
    port (
        a : in std_logic_vector (6 downto 0);
        d : in std_logic_vector (1 downto 0);
        clk : in std_logic;
        we : in std_logic;
        qspo : out std_logic_vector (1 downto 0)
    );
    end component;

    component train_features
    port (
        clka : in std_logic;
        wea : in std_logic_vector (0 downto 0);
        addra : in std_logic_vector (6 downto 0);
        dina : in std_logic_vector (63 downto 0);
        douta : out std_logic_vector (63 downto 0);
        clkb : in std_logic;
        web : in std_logic_vector (0 downto 0);
        addrb : in std_logic_vector (6 downto 0);
        dinb : in std_logic_vector (63 downto 0);
        doutb : out std_logic_vector (63 downto 0)
    );
    end component;
    
    component datapath
    port (
        clk : in std_logic;
        reset : in std_logic;
        train_instance_features : in std_logic_vector (63 downto 0);
        train_instance_class : in std_logic_vector (1 downto 0);
        test_instance_features : in std_logic_vector (63 downto 0)
    );
    end component;
    
    component control
    port (
        clk : in std_logic;
        reset : in std_logic;
        mem_addr : out std_logic_vector (6 downto 0)
    );
    end component;
    
    -- Extra signals!
    signal zeros : std_logic_vector (63 downto 0);
    signal mem_address: std_logic_vector (6 downto 0);
    signal train_instance_class : std_logic_vector (1 downto 0);
    signal train_instance_features : std_logic_vector (63 downto 0);
    signal tmp_doutb : std_logic_vector (63 downto 0);

begin
    zeros <= (others => '0');
    
    inst_train_classes : train_classes
    port map (
        a => mem_address,
        d => zeros (1 downto 0),
        clk => clk,
        we => zeros(0),
        qspo => train_instance_class
    );

    inst_train_features : train_features
    port map (
        clka => clk,
        wea => zeros (0 downto 0),
        addra => mem_address,
        dina => zeros (63 downto 0),
        douta => train_instance_features,
        clkb => clk,
        web => zeros (0 downto 0),
        addrb => mem_address,
        dinb => zeros (63 downto 0),
        doutb => tmp_doutb
    );

    inst_datapath : datapath
    port map (
        clk => clk,
        reset => reset,
        train_instance_features => train_instance_features,
        train_instance_class => train_instance_class,
        test_instance_features => test_instance
    );
    
    inst_control : control
    port map (
        clk => clk,
        reset => reset,
        mem_addr => mem_address
    );
    

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit is
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
        test_instance_features : in std_logic_vector (63 downto 0);
        enable : in std_logic;
        k : in  std_logic_vector (2 downto 0);
        done : in std_logic;
        pred: out std_logic_vector(1 downto 0)
    );
    end component;
    
    component control
    port (
        clk : in std_logic;
        reset : in std_logic;
        mem_addr : out std_logic_vector (6 downto 0);
        enable : out std_logic;
        done: out std_logic;
        btn_input : in std_logic_vector(3 downto 0);
        input_controller : out std_logic_vector (4 downto 0)

    );
    end component;
    
    -- Extra signals!
    signal enable : std_logic;
    signal done_signal: std_logic;
    signal zeros : std_logic_vector (63 downto 0);
    signal mem_address: std_logic_vector (6 downto 0);
    signal train_instance_class : std_logic_vector (1 downto 0);
    signal train_instance_features : std_logic_vector (63 downto 0);
    signal tmp_doutb : std_logic_vector (63 downto 0);
    signal input_controller : std_logic_vector (4 downto 0);
    signal test_instance : std_logic_vector (63 downto 0);
    signal k_reg : std_logic_vector (2 downto 0);
    signal f1, f2, f3, f4 : std_logic_vector (15 downto 0);

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
        test_instance_features => test_instance,
        enable => enable,
        k => k_reg,
        done => done_signal,
        pred => pred
    );
    
    inst_control : control
    port map (
        clk => clk,
        reset => reset,
        mem_addr => mem_address,
        enable => enable,
        done => done_signal,
        btn_input => btn_input,
        input_controller => input_controller
    );
    
    test_instance <= f1 & f2 & f3 & f4;
    
    leds_output(15 downto 11) <= input_controller;
    leds_output(10 downto 3) <= "00000000";
    leds_output(2 downto 0) <= k_reg;
    
    done <= done_signal;

    process (clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                f1 <= X"0000";
                f2 <= X"0000";
                f3 <= X"0000";
                f4 <= X"0000";
                k_reg <= "000";
            else
                if input_controller(4) = '1' then
                    k_reg <= k;
                end if;
                if input_controller(3) = '1' then
                    f1 <= data_in;
                end if;
                if input_controller(2) = '1' then
                    f2 <= data_in;
                end if;
                if input_controller(1) = '1' then
                    f3 <= data_in;
                end if;
                if input_controller(0) = '1' then
                    f4 <= data_in;
                end if;
            end if;
        end if;
    end process;
    

end Behavioral;
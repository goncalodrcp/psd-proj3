library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.STD_LOGIC_ARITH.ALL;
-- use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fpga_basicIO is
  port (
    clk: in std_logic;                            -- 100MHz clock
    btnC, btnU, btnL, btnR, btnD: in std_logic;   -- buttons
    sw: in std_logic_vector(15 downto 0);         -- switches
    led: out std_logic_vector(15 downto 0);       -- leds
    an: out std_logic_vector(3 downto 0);         -- display selectors
    seg: out std_logic_vector(6 downto 0);        -- display 7-segments
    dp: out std_logic                             -- display point
  );
end fpga_basicIO;

architecture Behavioral of fpga_basicIO is
  signal dd3, dd2, dd1, dd0 : std_logic_vector(6 downto 0);
  signal result : std_logic_vector(16 downto 0);
  signal dact : std_logic_vector(3 downto 0);
  signal btnInstr : std_logic_vector(4 downto 0);
  signal clk10hz, clk_disp : std_logic;
  signal btnCreg, btnUreg, btnLreg, btnRreg, btnDreg: std_logic;   -- registered input buttons
  signal sw_reg : std_logic_vector(15 downto 0);  -- registered input switches
  signal leds : std_logic_vector (15 downto 0);
  signal pred : std_logic_vector (1 downto 0);
  signal pred_ext : std_logic_vector (3 downto 0);
  signal b_input : std_logic_vector (3 downto 0);
  signal done : std_logic;
  signal display_0 : std_logic_vector (3 downto 0);

  component disp7
  port (
   disp3, disp2, disp1, disp0 : in std_logic_vector(6 downto 0);
   dp3, dp2, dp1, dp0 : in std_logic;
   dclk : in std_logic;
   dactive : in std_logic_vector(3 downto 0);
   en_disp_l : out std_logic_vector(3 downto 0);
   segm_l : out std_logic_vector(6 downto 0);
   dp_l : out std_logic);
  end component;
  component hex2disp
    port (
      sw : in std_logic_vector(3 downto 0);
      seg : out std_logic_vector(6 downto 0));
  end component;
  component clkdiv
    port(
      clk100M : in std_logic;          
      clk10Hz : out std_logic;
      clk_disp : out std_logic);
  end component;
  component circuit
    port(
        clk : in std_logic;
        reset : in std_logic;
        data_in : in std_logic_vector (15 downto 0);
        k : in std_logic_vector (2 downto 0);
        pred : out std_logic_vector (1 downto 0);
        btn_input : in std_logic_vector(3 downto 0);
        leds_output : out std_logic_vector (15 downto 0);
        done : out std_logic
      );
  end component;

begin
    
  dact <= "1111" when done = '0' else "0001";
  led <= leds;

  inst_disp7: disp7 port map(
      disp3 => dd3, disp2 => dd2, disp1 => dd1, disp0 => dd0,
      dp3 => '0', dp2 => '0', dp1 => '0', dp0 => '0',
      dclk => clk_disp,
      dactive => dact,
      en_disp_l => an,
      segm_l => seg,
      dp_l => dp);

  pred_ext <= "00" & pred;
  display_0 <= sw_reg(3 downto 0) when done = '0' else pred_ext;

  inst_hex0: hex2disp port map(sw => display_0, seg => dd0);
  inst_hex1: hex2disp port map(sw => sw_reg(7 downto 4), seg => dd1);
  inst_hex2: hex2disp port map(sw => sw_reg(11 downto 8), seg => dd2);
  inst_hex3: hex2disp port map(sw => sw_reg(15 downto 12), seg => dd3);
  
  inst_clkdiv: clkdiv port map(
    clk100M => clk,
    clk10hz => clk10hz,
    clk_disp => clk_disp); 
  
  
  b_input <= btnUreg & btnLreg & btnDreg & btnRreg;
  
  inst_circuit: circuit port map(
    clk => clk,
    reset => btnCreg,
    data_in => sw_reg,
    k => sw_reg(2 downto 0),
    pred => pred,
    btn_input => b_input,
    leds_output => leds,
    done => done
   );
      
  process (clk10hz)
    begin
       if rising_edge(clk10hz) then
          btnCreg <= btnC; btnUreg <= btnU; btnLreg <= btnL; 
          btnRreg <= btnR; btnDreg <= btnD;
          sw_reg <= sw;
      end if; 
    end process;    
end Behavioral;

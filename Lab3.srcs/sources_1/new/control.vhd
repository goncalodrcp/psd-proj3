library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
port (
    clk : in std_logic;
    reset : in std_logic;
    mem_addr : out std_logic_vector (6 downto 0);
    enable : out std_logic;
    done: out std_logic;
    btn_input : in std_logic_vector(3 downto 0);
    input_controller : out std_logic_vector (4 downto 0)
);

end control;

architecture Behavioral of control is
    -- Signals
    type fsm_states is (s_input_k, s_input_f1, s_input_f2, s_input_f3, s_input_f4, s_calc, s_done);
    signal currstate, nextstate: fsm_states;

    signal counter : std_logic_vector(6 downto 0) := "0000000";
    signal halt: std_logic := '0';

begin

    process (clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                -- Reset counter
                counter <= "0000000";
                currstate <= s_input_k;
            else
                currstate <= nextstate;
               if halt = '0' then
                     -- Update counter
                     counter <= counter + 1;     
                 end if;
             end if;
        end if;
    end process;

    state_comb: process (currstate, btn_input, counter)
    begin
        nextstate <= currstate; -- by default, does not change the state.
    
        case currstate is
            when s_input_k =>
                if btn_input(3) = '1' then
                    nextstate <= s_input_f1;
                end if;
                enable <= '0';
                done <= '0';
                halt <= '1';
                input_controller <= "10000";
            when s_input_f1 =>
                if btn_input(2) = '1' then
                    nextstate <= s_input_f2;
                end if;
                enable <= '0';
                done <= '0';
                halt <= '1';
                input_controller <= "01000";
            when s_input_f2 =>
                if btn_input(1) = '1' then
                    nextstate <= s_input_f3;
                end if;
                enable <= '0';
                done <= '0';
                halt <= '1';
                input_controller <= "00100";
            when s_input_f3 =>
                if btn_input(0) = '1' then
                    nextstate <= s_input_f4;
                end if;
                enable <= '0';
                done <= '0';
                halt <= '1';
                input_controller <= "00010";
            when s_input_f4 =>
                if btn_input(3) = '1' then
                    nextstate <= s_calc;
                end if;
                enable <= '0';
                done <= '0';
                halt <= '1';
                input_controller <= "00001";
            when s_calc =>
                -- if counter = "1101011" then
                if counter = "1101100" then
                    nextstate <= s_done;
                end if;
                enable <= '1';
                done <= '0';
                halt <= '0';
                input_controller <= "00000";
            when s_done =>
                enable <= '0';
                done <= '1';
                halt <= '1';
                input_controller <= "00000";
        end case;
    end process;

    -- Outputs
    mem_addr <= counter;
    -- enable <= '0' when counter = "0000000" else '1';
    -- halt <= '1' when counter = "1101011" else '0';
    -- done <= halt;
    
end Behavioral;

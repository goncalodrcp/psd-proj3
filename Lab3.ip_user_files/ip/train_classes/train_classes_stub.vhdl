-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Wed Dec 12 14:24:24 2018
-- Host        : coelhopc running 64-bit Ubuntu 18.10
-- Command     : write_vhdl -force -mode synth_stub
--               /home/josecoelho/Documents/IST/PSD/Labs/Lab3/psd-proj3/Lab3.srcs/sources_1/ip/train_classes/train_classes_stub.vhdl
-- Design      : train_classes
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity train_classes is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 6 downto 0 );
    d : in STD_LOGIC_VECTOR ( 1 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    qspo : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );

end train_classes;

architecture stub of train_classes is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[6:0],d[1:0],clk,we,qspo[1:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_12,Vivado 2018.2";
begin
end;

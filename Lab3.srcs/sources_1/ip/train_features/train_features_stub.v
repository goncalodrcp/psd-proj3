// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Mon Dec 17 15:20:53 2018
// Host        : coelhopc running 64-bit Ubuntu 18.10
// Command     : write_verilog -force -mode synth_stub
//               /home/josecoelho/Documents/IST/PSD/Labs/Lab3/psd-proj3/Lab3.srcs/sources_1/ip/train_features/train_features_stub.v
// Design      : train_features
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module train_features(clka, wea, addra, dina, douta, clkb, web, addrb, dinb, 
  doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[6:0],dina[63:0],douta[63:0],clkb,web[0:0],addrb[6:0],dinb[63:0],doutb[63:0]" */;
  input clka;
  input [0:0]wea;
  input [6:0]addra;
  input [63:0]dina;
  output [63:0]douta;
  input clkb;
  input [0:0]web;
  input [6:0]addrb;
  input [63:0]dinb;
  output [63:0]doutb;
endmodule

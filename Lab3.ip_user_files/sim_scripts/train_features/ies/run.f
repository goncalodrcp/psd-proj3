-makelib ies_lib/xil_defaultlib -sv \
  "/home/josecoelho/xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/home/josecoelho/xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../Lab3.srcs/sources_1/ip/train_features/sim/train_features.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib


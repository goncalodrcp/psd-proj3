onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+train_classes -L dist_mem_gen_v8_0_12 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.train_classes xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {train_classes.udo}

run -all

endsim

quit -force

onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib train_features_opt

do {wave.do}

view wave
view structure
view signals

do {train_features.udo}

run -all

quit -force

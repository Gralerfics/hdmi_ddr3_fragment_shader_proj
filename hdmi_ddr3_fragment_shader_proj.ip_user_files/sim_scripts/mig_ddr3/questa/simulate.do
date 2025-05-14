onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib mig_ddr3_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {mig_ddr3.udo}

run -all

quit -force

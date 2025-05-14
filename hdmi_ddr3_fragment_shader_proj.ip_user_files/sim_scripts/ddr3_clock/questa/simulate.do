onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib ddr3_clock_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {ddr3_clock.udo}

run 1000ns

quit -force

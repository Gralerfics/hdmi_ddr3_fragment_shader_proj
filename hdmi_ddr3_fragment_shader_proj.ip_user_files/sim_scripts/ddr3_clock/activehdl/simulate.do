transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+ddr3_clock  -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ddr3_clock xil_defaultlib.glbl

do {ddr3_clock.udo}

run 1000ns

endsim

quit -force

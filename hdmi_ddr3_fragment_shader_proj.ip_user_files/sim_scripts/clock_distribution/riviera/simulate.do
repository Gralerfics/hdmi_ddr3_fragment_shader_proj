transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+clock_distribution  -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.clock_distribution xil_defaultlib.glbl

do {clock_distribution.udo}

run 1000ns

endsim

quit -force

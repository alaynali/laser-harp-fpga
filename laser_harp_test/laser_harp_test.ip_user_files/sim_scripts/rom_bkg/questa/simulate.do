onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib rom_bkg_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {rom_bkg.udo}

run 1000ns

quit -force

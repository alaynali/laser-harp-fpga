onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+rom_bkg  -L xpm -L blk_mem_gen_v8_4_5 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.rom_bkg xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {rom_bkg.udo}

run 1000ns

endsim

quit -force

######################################################################
#
# File name : multiply_tb_simulate.do
# Created on: Thu Apr 17 09:30:30 EDT 2025
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vsim -lib xil_defaultlib multiply_tb_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {multiply_tb_wave.do}

view wave
view structure
view signals

do {multiply_tb.udo}

run 1000ns

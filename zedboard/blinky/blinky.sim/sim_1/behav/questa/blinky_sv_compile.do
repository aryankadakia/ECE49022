######################################################################
#
# File name : blinky_sv_compile.do
# Created on: Mon Mar 31 17:42:42 EDT 2025
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -64 -incr -mfcu -sv -work xil_defaultlib  \
"../../../../blinky.srcs/sources_1/new/clock_divider.sv" \
"../../../../blinky.srcs/sources_1/new/blinky_sv.sv" \


# compile glbl module
vlog -work xil_defaultlib "glbl.v"


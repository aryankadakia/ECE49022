######################################################################
#
# File name : blinky_compile.do
# Created on: Thu Mar 27 10:55:03 EDT 2025
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -64 -incr -mfcu -work xil_defaultlib  \
"../../../../blinky.srcs/sources_1/new/blinky.v" \


# compile glbl module
vlog -work xil_defaultlib "glbl.v"


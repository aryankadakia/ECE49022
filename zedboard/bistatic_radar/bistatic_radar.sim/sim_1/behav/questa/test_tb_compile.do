######################################################################
#
# File name : test_tb_compile.do
# Created on: Wed Apr 02 18:46:31 EDT 2025
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -64 -incr -mfcu -sv -work xil_defaultlib  \
"../../../../bistatic_radar.srcs/sources_1/new/test.sv" \
"../../../../bistatic_radar.srcs/sources_1/new/test_tb.sv" \


# compile glbl module
vlog -work xil_defaultlib "glbl.v"


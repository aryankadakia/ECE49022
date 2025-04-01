# Makefile

TOP_MODULE = new/test_tb
SRC_DIR = new
QUESTA_DIR = ../../bistatic_radar.sim/sim_1/behav/questa
WORKLIB = new/work 

VLOG = vlog -sv
VSIM = vsim 

SRC_FILES = $(wildcard $(SRC_DIR)/*.sv)
DO_FILE = $(QUESTA_DIR)/run.do 

compile:
	@echo "Compiling design and testbench"
	cd $(QUESTA_DIR) && \
	vlib $(WORKLIB) && \
	vmap $(WORKLIB) $(WORKLIB) && \
	$(VLOG) ../../$(SRC_DIR)/*.sv

simulate: compile 
	cd $(QUESTA_DIR) && \
	$(VSIM) work.$(TOP_MODULE)
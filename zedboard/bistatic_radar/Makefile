# Makefile for simulation from bistatic_radar/
DESIGN_DIR = bistatic_radar.srcs/sources_1/new
TB_DIR = bistatic_radar.srcs/sim_1/new
SRC_FILES = $(wildcard $(DESIGN_DIR)/*.sv)
TB_FILES = $(wildcard $(TB_DIR)/*.sv)
WORK_LIB = work

# Default target
all: sim

# Create fresh work library
$(WORK_LIB):
	vlib $(WORK_LIB)

# Compile design + testbench
compile: $(WORK_LIB)
	vlog -work $(WORK_LIB) $(SRC_FILES)

# Run simulation in terminal mode
sim: compile
	vsim -c work.test_tb -do "run -all; quit"

# Clean up generated files
clean:
	rm -rf $(WORK_LIB) transcript vsim.wlf
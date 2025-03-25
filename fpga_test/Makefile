# Quartus Project Name
PROJECT = system
QSF_FILE = $(PROJECT).qsf

# Define Quartus tools
QUARTUS_MAP = quartus_map $(PROJECT)
QUARTUS_FIT = quartus_fit $(PROJECT)
QUARTUS_STA = quartus_sta $(PROJECT)
QUARTUS_EDA = quartus_eda --simulation --tool=questasim --format=verilog $(PROJECT)

# Define QuestaSim tools
QUESTA_SIM_DIR = simulation/questa
QUESTA_RUN = vsim -do $(QUESTA_SIM_DIR)/system_run_msim_rtl_verilog.do

# Define FPGA deployment 
QUARTUS_ASM = quartus_asm $(PROJECT)
QUARTUS_PGM = quartus_pgm --mode=jtag -o "p;output_files/$(PROJECT).sof"


# Define Make targets

# Add new file to be recognized by quartus
touch: 
	@echo "set_global_assignment -name SYSTEMVERILOG_FILE $(FILE)" >> $(QSF_FILE)

# Run full Quartus synthesis, fitting, and timing analysis
# cd simulation/questa && vlog -sv ../../source/*.sv ../../testbench/*.sv -work work
compile:
	cd simulation/questa && vlog -sv ../../source/*.sv -work work
	
synthesize:
	@echo "Running Quartus Synthesis, Fitting, and Timing Analysis..."
	$(QUARTUS_MAP)
	$(QUARTUS_FIT)
	$(QUARTUS_STA)
	@echo "Synthesis completed."

# Generate simulation files for QuestaSim
# wave:
# 	@echo "Generating QuestaSim files..."
# 	$(QUARTUS_EDA)
# 	@echo "Simulation files generated."

# Run QuestaSim
simulate:
	@echo "Launching QuestaSim..."
	$(QUARTUS_EDA)
	$(QUESTA_RUN)
	@echo "QuestaSim completed."

fpga:
	@echo "Deploying FPGA"
	$(QUARTUS_ASM)
	$(QUARTUS_PGM)
	@echo "FPGA completed"

# Clean Quartus intermediate files
clean:
	@echo "Cleaning Quartus output files..."
	quartus_sh --clean $(PROJECT)
	@echo "Clean completed."


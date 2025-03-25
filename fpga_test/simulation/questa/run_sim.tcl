
# Load the compiled testbench module 
vsim -L work -L altera_mf_ver -L altera_ver -L cycloneive_ver -L lpm_ver -L sgate_ver work.system_tb 

# Add all signals to the waveform 
add wave -r * 

# Run the simulation indefinitely (or for a fixed duration) 
run -all

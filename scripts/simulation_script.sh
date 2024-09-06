# Navigate to the simulation directory
cd sim

# Assuming Icarus Verilog for simulation
iverilog -o tb_output tb_top_module.v ../src/top_module.v ../src/data_collector.v ../src/power_converter.v
vvp tb_output

# For viewing waveforms
gtkwave tb_top_module.vcd

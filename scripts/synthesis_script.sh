#!/bin/bash

# Navigate to the source directory where your Verilog files are located
cd src

# Run Yosys synthesis, targeting an ASIC flow
yosys -p "synth -top tt_um_vedm_industries -json tt_um_vedm_industries.json" *.v

# Run OpenLane for place and route (adjust the paths to OpenLane tool if necessary)
cd ../openlane
flow.tcl -design ../src -tag my_design -init_design_flow_only

# Note: OpenLane typically has a configuration for GDS generation.
# Make sure the configuration is set for ASIC design flow, not FPGA.

# Include testbench path in simulation
cd ../sims
iverilog -o tb_sim.vvp -s tb_top_module -I ../src tb_top_module.v

# Run the simulation using your testbench
vvp tb_sim.vvp

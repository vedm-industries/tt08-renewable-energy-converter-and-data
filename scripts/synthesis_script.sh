#!/bin/bash

# Navigate to the source directory where your Verilog files are located
cd src

# Run Yosys synthesis, specifying the correct top module and output file types
# The following command synthesizes the design to a JSON format, which is common for next steps in FPGA workflows
yosys -p "synth_ice40 -top tt_um_vedm_industries -json tt_um_vedm_industries.json" *.v

# If you use nextpnr for place and route, you can convert JSON to an ASIC or FPGA specific format
# For example, nextpnr-ice40 uses the JSON file to generate a placement and routing file (.asc)
nextpnr-ice40 --json tt_um_vedm_industries.json --pcf pins.pcf --asc tt_um_vedm_industries.asc

# use icepack to generate the binary configuration file for the FPGA
icepack tt_um_vedm_industries.asc tt_um_vedm_industries.bin

# Note: Ensure you have the necessary .pcf (pin constraint file) for your specific FPGA board

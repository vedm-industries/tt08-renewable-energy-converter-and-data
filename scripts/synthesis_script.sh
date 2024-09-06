# Navigate to the source directory
cd src

# Run Yosys synthesis commands
yosys -p "synth_ice40 -top top_module -json top_module.json" *.v

# Follow up with place and route, etc., if necessary
nextpnr-ice40 --json top_module.json --pcf pins.pcf --asc top_module.asc

# Icepack to generate the final binary
icepack top_module.asc top_module.bin

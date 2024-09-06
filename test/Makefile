# Makefile for testing the TT08 project

TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES = ../src/tt_um_vedm_industries.v ../src/power_converter.v ../src/data_collector.v
TOPLEVEL = tt_um_vedm_industries

MODULE = tb_top_module

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

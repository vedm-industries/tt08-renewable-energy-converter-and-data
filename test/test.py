# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Set the input values you want to test
    dut.ui_in.value = 25  # Set ui_in to 25 (input), expecting uo_out to be doubled
    dut.uio_in.value = 30  # Example value for uio_in

    # Wait for one clock cycle to see the output values
    await ClockCycles(dut.clk, 1)

    # Debug output to see current state
    dut._log.info(f"ui_in = {dut.ui_in.value}, uo_out = {dut.uo_out.value}")

    # Assert that the output matches the expected value
    assert dut.uo_out.value == 50, f"Expected uo_out to be 50, but got {dut.uo_out.value}. Input was {dut.ui_in.value}"

    # You can continue testing by changing inputs and adding more assertions if needed
    dut.ui_in.value = 45  # Set another input value for further testing
    await ClockCycles(dut.clk, 1)

    dut._log.info(f"ui_in = {dut.ui_in.value}, uo_out = {dut.uo_out.value}")
    assert dut.uo_out.value == 90, f"Expected uo_out to be 90, but got {dut.uo_out.value}. Input was {dut.ui_in.value}"

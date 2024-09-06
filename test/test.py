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
    dut.ui_in.value = 25  # Should result in uo_out being 50
    await ClockCycles(dut.clk, 1)
    expected_output = 50
    dut._log.info(f"ui_in = {dut.ui_in.value}, uo_out = {dut.uo_out.value}")
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}. Input was {dut.ui_in.value}"

    # Test with another value
    dut.ui_in.value = 45  # Should result in uo_out being 90
    await ClockCycles(dut.clk, 1)
    expected_output = 90
    dut._log.info(f"ui_in = {dut.ui_in.value}, uo_out = {dut.uo_out.value}")
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}. Input was {dut.ui_in.value}"

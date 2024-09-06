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

    # Set the input values
    dut.ui_in.value = 25  # Set ui_in to 25, expecting uo_out to be 50
    dut.uio_in.value = 30

    # Wait for one clock cycle
    await ClockCycles(dut.clk, 1)

    # Debug output for intermediate values
    dut._log.info(f"ui_in = {dut.ui_in.value}, uo_out = {dut.uo_out.value}")

    # Assert the expected output based on the design
    expected_output = dut.ui_in.value * 2
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}. Input was {dut.ui_in.value}"

    # Additional test for a different input
    dut.ui_in.value = 45  # Expect uo_out to be 90
    await ClockCycles(dut.clk, 1)
    expected_output = dut.ui_in.value * 2
    dut._log.info(f"ui_in = {dut.ui_in.value}, uo_out = {dut.uo_out.value}")
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}. Input was {dut.ui_in.value}"

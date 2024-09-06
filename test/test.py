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
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    # Apply test values
    dut.ui_in.value = 25  # Should result in uo_out being 50
    await ClockCycles(dut.clk, 1)
    expected_output = 50

    # Log the converted_voltage and uo_out
    dut._log.info(f"ui_in = {dut.ui_in.value}, converted_voltage = {dut.converted_voltage.value}, uo_out = {dut.uo_out.value}")
    
    # Check the result
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}. Input was {dut.ui_in.value}"


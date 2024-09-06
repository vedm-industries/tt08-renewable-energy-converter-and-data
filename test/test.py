import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    """Test the simple multiplier module."""

    # Start clock
    clock = Clock(dut.clk, 10, units="ns")  # 100 MHz
    cocotb.start_soon(clock.start())

    # Reset
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    # Test input 25 -> Expect output 50
    dut.ui_in.value = 25
    await ClockCycles(dut.clk, 1)
    expected_output = 50
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}"

    # Test input 45 -> Expect output 90
    dut.ui_in.value = 45
    await ClockCycles(dut.clk, 1)
    expected_output = 90
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}"

    # Test input 100 -> Expect output 200, which is truncated to fit in 8 bits (200 in 8 bits is fine)
    dut.ui_in.value = 100
    await ClockCycles(dut.clk, 1)
    expected_output = 200
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}"

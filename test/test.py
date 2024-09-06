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
    assert dut.uo_out.value == 50, f"Expected uo_out to be 50, but got {dut.uo_out.value}."

    # Test input 45 -> Expect output 90
    dut.ui_in.value = 45
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 90, f"Expected uo_out to be 90, but got {dut.uo_out.value}."

    # Test input 100 -> Expect output 200
    dut.ui_in.value = 100
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 200, f"Expected uo_out to be 200, but got {dut.uo_out.value}."

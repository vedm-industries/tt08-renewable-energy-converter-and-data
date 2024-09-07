import cocotb
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_project(dut):
    """Test the simple multiplier module."""

    # Initialize signals
    dut.rst_n.value = 0  # Start with reset active
    dut.ena.value = 0    # Set ena to 0 initially

    await RisingEdge(dut.clk)  # Wait for a rising edge on the clock
    dut.rst_n.value = 1        # Release reset
    dut.ena.value = 1          # Set ena to 1

    await RisingEdge(dut.clk)  # Wait for another clock cycle

    # Apply test stimulus
    dut.ui_in.value = 150      # Apply input value
    await RisingEdge(dut.clk)  # Wait for one clock cycle

    assert dut.uo_out.value == 150, f"Expected uo_out to be 150, but got {dut.uo_out.value}"

    dut.ui_in.value = 45       # Apply another input value
    await RisingEdge(dut.clk)  # Wait for one clock cycle

    assert dut.uo_out.value == 45, f"Expected uo_out to be 45, but got {dut.uo_out.value}"

    # You can add more assertions here if needed to check the functionality.

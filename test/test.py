import cocotb
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_project(dut):
    """Test the simple multiplier module."""

    # Remove or comment out the ena signal, since it doesn't exist in your design
    # dut.ena.value = 0  # Set ena to 0 initially (no need for this line)

    dut.ui_in.value = 0  # Set initial input value
    await RisingEdge(dut.clk)  # Wait for clock edge

    dut.ui_in.value = 150  # Apply stimulus to ui_in
    await RisingEdge(dut.clk)  # Wait for clock edge

    # Monitor uo_out to verify the output values
    expected_output = 150  # Example expected output, adjust based on your logic
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}"

    # Apply more stimulus to ui_in and verify output
    dut.ui_in.value = 45
    await RisingEdge(dut.clk)  # Wait for clock edge

    expected_output = 45  # Update expected output
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}"

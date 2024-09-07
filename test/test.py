import cocotb
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_project(dut):
    """Test the simple multiplier module."""

    dut.ui_in.value = 0  # Set initial input value
    await RisingEdge(dut.clk)  # Wait for one clock edge

    dut.ui_in.value = 150  # Apply stimulus to ui_in
    await RisingEdge(dut.clk)  # Wait for clock edge

    # Wait for a few clock cycles to give the DUT time to update the output
    for _ in range(2):
        await RisingEdge(dut.clk)

    # Now check the output
    expected_output = 150  # Update based on your expected behavior
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}"

    # Apply more stimulus to ui_in and verify output
    dut.ui_in.value = 45
    await RisingEdge(dut.clk)  # Wait for clock edge
    for _ in range(2):
        await RisingEdge(dut.clk)

    expected_output = 45  # Update expected output
    assert dut.uo_out.value == expected_output, f"Expected uo_out to be {expected_output}, but got {dut.uo_out.value}"

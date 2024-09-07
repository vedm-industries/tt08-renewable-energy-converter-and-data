import cocotb
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_project(dut):
    # Remove or comment out the line related to 'ena' as it's not a valid signal in your module
    # dut.ena.value = 0

    dut.rst_n.value = 0
    await RisingEdge(dut.clk)  # Wait for the rising edge of the clock
    dut.rst_n.value = 1

    # Stimulate inputs and check outputs
    dut.ui_in.value = 0x19  # Set input to some value
    await RisingEdge(dut.clk)  # Wait for clock

    dut.ui_in.value = 0x2D  # Set input to another value
    await RisingEdge(dut.clk)  # Wait for clock

    # Monitor outputs or perform assertions here
    assert dut.uo_out.value == 0x00, f"Expected uo_out to be 0x00, but got {dut.uo_out.value}"


`timescale 1ns / 1ps
`default_nettype none
module tb_top_module;
    reg clk;
    reg rst_n;
    reg ena;              // Include 'ena' signal here
    reg [7:0] ui_in;
    wire [7:0] uo_out;

    // Instantiate the design under test (DUT)
    tt_um_vedm_industries dut (
        .clk(clk),
        .rst_n(rst_n),
        .ena(ena),        // Connect 'ena' to the DUT
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(),
        .uio_out(),
        .uio_oe()
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period
    end

    // Test sequence
    initial begin
        // Initial values
        rst_n = 0;
        ena = 0;
        ui_in = 8'b0;

        // Reset
        #10;
        rst_n = 1;
        
        // Test with 'ena' disabled (output should not change)
        #10;
        ena = 0;
        ui_in = 8'b10101010;    // Some input
        #10;
        $display("With ena=0, uo_out=%b (should be 00000000)", uo_out);

        // Enable signal (output should now follow input)
        ena = 1;
        #10;
        ui_in = 8'b11001100;    // Change input
        #10;
        $display("With ena=1, uo_out=%b (should be 11001100)", uo_out);

        // Disable again (output should freeze)
        ena = 0;
        ui_in = 8'b11110000;    // Change input again
        #10;
        $display("With ena=0, uo_out=%b (should still be 11001100)", uo_out);

        $finish;
    end
endmodule
